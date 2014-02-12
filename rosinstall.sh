
#!/bin/bash
cd ~/scripts/
cp -r .ssh/ ../
cd
scp -r caen:Private/ros_ws/ ./
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu quantal main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install ros-groovy-desktop python-rosinstall
sudo rosdep init
rosdep update
echo "source /opt/ros/groovy/setup.bash" >> ~/.mybashrc
source ~/.bashrc
rm ros_ws/setup*
rm ros_ws/.rosinstall
rosws init ~/ros_ws /opt/ros/groovy
rosws set ~/ros_ws/sandbox/
source ~/ros_ws/setup.bash
echo "Package path:"
echo "$ROS_PACKAGE_PATH"
rospack profile
cd ~/perls-neec/build
sudo make install
sudo ln -sf /usr/lib/x86_64-linux-gnu/libpython2.7.so.1 /usr/lib/libpython2.7.so
rosmake lcm_bridge

~/ros_ws/sandbox/ardrone_autonomy/build_sdk.sh

sudo cp /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/Managed.conf
sudo mv /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/UnManaged.conf

ln -s UnManaged.conf NetworkManager.conf
echo "modify unmanaged please"
