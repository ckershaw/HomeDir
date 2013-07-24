

#include <ros/ros.h>
#include <geometry_msgs/Twist.h>
#include <std_msgs/Empty.h>
#include <ardrone_autonomy/Navdata.h>
#include <image_transport/image_transport.h>
#include <std_srvs/Empty.h>

#include <stdio.h>
#include <vector>
#include <pthread.h>
#include <lcm/lcm-cpp.hpp>
#include <perls-lcmtypes++/perllcm/ardrone_drive_t.hpp>
#include <perls-lcmtypes++/perllcm/ardrone_cmd_t.hpp>
#include <perls-lcmtypes++/perllcm/ardrone_state_t.hpp>
#include <perls-lcmtypes++/bot_core/image_t.hpp>

#define PI 3.1415926
#define DTOR PI/180
#define MMTOM 0.001
#define CMTOM 0.01

int drone_state; //to determine if flying
lcm::LCM outgoing_lcm;

class Drone_Handler 
{
    private:        
        ros::NodeHandle n;
        ros::Publisher twist_pub;
        ros::Publisher takeoff_pub;
        ros::Publisher land_pub;
        ros::Publisher reset_pub;
        ros::ServiceClient cam_client;

        geometry_msgs::Twist twist_msg;
        std_msgs::Empty empty_msg;
        std_srvs::Empty cam_srv;
    public:
        Drone_Handler ()
        {
            twist_pub = n.advertise<geometry_msgs::Twist> ("cmd_vel", 1);
            takeoff_pub = n.advertise<std_msgs::Empty> ("ardrone/takeoff", 1);
            land_pub = n.advertise<std_msgs::Empty> ("ardrone/land", 1);
            reset_pub = n.advertise<std_msgs::Empty> ("ardrone/reset", 1);
            cam_client = n.serviceClient<std_srvs::Empty>("ardrone/togglecam");
        }
        
        ~Drone_Handler() {}

        void drive_handleMessage(const lcm::ReceiveBuffer* rbuf,
                const std::string& chan, 
                const perllcm::ardrone_drive_t* drive_msg)
        {
            twist_msg.linear.x  = -drive_msg->vx; //X convention is backwards
            twist_msg.linear.y  = -drive_msg->vy; //Y convention is backwards
            twist_msg.linear.z  = drive_msg->vz;
            twist_msg.angular.x = 0;
            twist_msg.angular.y = 0;
            twist_msg.angular.z = -drive_msg->vr;
            
            twist_pub.publish (twist_msg);
        }
        
        void cmd_handleMessage(const lcm::ReceiveBuffer* rbuf,
                const std::string& chan,
                const perllcm::ardrone_cmd_t* cmd_msg)
        {
            if (cmd_msg->takeoff == true)
            {
                if (drone_state == 1 || drone_state == 2) //if inited or landed
                {
                    takeoff_pub.publish (empty_msg);
                    ROS_INFO("Drone takeoff command sent");
                }
                    
                else if (drone_state == 3 || drone_state == 7 || drone_state == 4) //if flying or hovering
                {
                    land_pub.publish (empty_msg);
                    ROS_INFO("Drone land command sent");
                }
            }
            if (cmd_msg->emergency == true)
            {
                reset_pub.publish (empty_msg);
                ROS_INFO("DRONE EMERGENCY MESSAGE SENT");
            }
            
            if (cmd_msg->hover == true)
            {
                twist_msg.linear.x  = 0;
                twist_msg.linear.y  = 0;
                twist_msg.linear.z  = 0;
                twist_msg.angular.x = 0;
                twist_msg.angular.y = 0;
                twist_msg.angular.z = 0;
                twist_pub.publish (twist_msg);
            }
            if (cmd_msg->camera == true)
            {
                if (cam_client.call (cam_srv))
                    ROS_INFO("Service: AR.Drone camera toggled");
            }
        }          
};


void 
navdataCallback (const ardrone_autonomy::Navdata::ConstPtr& navdata_msg)
{
    drone_state = navdata_msg->state;
    perllcm::ardrone_state_t state_msg;
       
    state_msg.utime     = ros::Time::now().toNSec()/1000;
    state_msg.roll      = navdata_msg->rotX*DTOR;
    state_msg.pitch     = -navdata_msg->rotY*DTOR;
    state_msg.yaw       = -navdata_msg->rotZ*DTOR;
    state_msg.altitude  = navdata_msg->altd*MMTOM;
    state_msg.vx        = navdata_msg->vx*MMTOM;
    state_msg.vy        = -navdata_msg->vy*MMTOM;
    state_msg.vz        = navdata_msg->vz*MMTOM;
    state_msg.battery   = navdata_msg->batteryPercent;
    
    if (drone_state == 3 || drone_state == 7 || drone_state == 4)
        state_msg.flying = true;
    else
        state_msg.flying = false;  
    
    // coms is not given by Navdata
    state_msg.coms      = true;
    // publish over outgoing lcm
    outgoing_lcm.publish ("ARDRONE_STATE", &state_msg);
}

void
imageCallback (const sensor_msgs::Image::ConstPtr& image_msg)
{
    // read in the image
    bot_core::image_t img;
    
    img.utime       = ros::Time::now().toNSec()/1000;
    img.width       = image_msg->width;
    img.height      = image_msg->height;
    img.row_stride  = image_msg->step;
    img.pixelformat = img.PIXEL_FORMAT_RGB;
    img.size        = img.row_stride*img.height;
    img.data = std::vector <unsigned char>(image_msg->data);
    
    img.nmetadata = 0;
    
    //ROS_INFO("width = [%d]", img.width);
    //ROS_INFO("height = [%d]", img.height);
    //ROS_INFO("row_stride = [%d]", img.row_stride);
    //ROS_INFO("pixelformat = [%d]", img.pixelformat);
    //ROS_INFO("size = [%d]", img.size);
    
    // publish over outgoing lcm
    outgoing_lcm.publish ("ARDRONE_CAM", &img);
}


void*
lcm_incoming_thread (void *data)
{            
    lcm::LCM incoming_lcm;
    if (!incoming_lcm.good())
        return (int *) 1;
    
    Drone_Handler droneHandler;
    // ADD LCM SUBSCRIBERS HERE   
    incoming_lcm.subscribe ("ARDRONE_DRIVE", &Drone_Handler::drive_handleMessage, &droneHandler);
    incoming_lcm.subscribe ("ARDRONE_CMD", &Drone_Handler::cmd_handleMessage, &droneHandler);

    while (!ros::isShuttingDown ()) {
        incoming_lcm.handle ();
        //ros::Duration(1).sleep();
    }
    return (void *) NULL;
}


int 
main (int argc, char **argv)
{

    ros::init (argc, argv, "lcm_ardrone");
    ros::NodeHandle n;
    
    // ADD ROS SUBSCRIBERS HERE
    ros::Subscriber navdata_sub = n.subscribe ("ardrone/navdata", 1, navdataCallback);
    image_transport::ImageTransport it(n);
    image_transport::Subscriber image_sub = it.subscribe ("ardrone/image_raw", 1, imageCallback);
    
    
    if (!outgoing_lcm.good())
        return 1;
   
    // start incoming lcm handle thread
    pthread_t inc_thread;
    pthread_create (&inc_thread, 0, &lcm_incoming_thread, NULL);
    ROS_INFO("LCM thread created ...");
        
    ROS_INFO("... lcm_ardrone Running");
    /*while (ros::ok()) {
        ros::spinOnce ();
        //ros::Duration(1).sleep();
    }*/
    ros::spin();
    
    // kill lcm handle thread
    ROS_INFO("ROS shutdown ...");
    ros::shutdown ();
    
    return 0;
}


