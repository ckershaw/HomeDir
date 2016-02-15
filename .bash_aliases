alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'

function cd-make-dir {
    local dir olddir
    dir=$(pwd)
    olddir=$OLDPWD
    while [ "`pwd`" != "/" ]; do
        if [ -e Makefile ]; then
            break
        fi

        if [ -d build ]; then
            cd build
            break
        fi

        cd ../
    done

    if [ "`pwd`" == "/" ]; then
        cd $dir
        OLDPWD=$olddir
    else
        OLDPWD=$olddir
    fi
}

function make () {
    local dir olddir
    dir=$(pwd)
    olddir=$OLDPWD
    cd-make-dir

    echo "make $@ -C `pwd`"
    if [ -d CMakeFiles ]; then # don't colorize if cmake provided
        /usr/bin/make $@
    else
        /usr/bin/make $@
    fi

    cd $dir
    OLDPWD=$olddir
}

_make() {
    local cur opts
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts=$(cd-make-dir; make -qp 2> /dev/null | sed -n -e 's/^\([^.#[:space:]][^:[:space:]]*\): .*/\1/p' | sed '/%/ d')

    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
}
complete -F _make make

# ALIASES
alias ll='ls -l'
alias lla='ls -al'
alias md=mkdir
alias rd=rmdir
alias clr=clear
alias svnst='svn st | grep -v "^?"'
alias java='java -server -ea'
alias java-prof='java -client -agentlib:hprof=cpu=samples,depth=8,interval=1,thread=y'
alias java-prof-view='java -jar $HOME/Utilities/java/PerfAnal.jar java.hprof.txt'
alias grepPS='clear; grep ''publish\('' * -R; echo ; grep ''subscribe\('' * -R'
alias gitk='gitk --all &'
alias 'cd..'='cd ..'
alias gitst='git status'
alias gd='git diff --color'
alias grep="grep -n --color=auto -I"

alias mc="make clean"
alias mcm="make clean; make"
alias aca="ant clean build"
alias makhe="makeh"
alias mhja="makeh -j; alert"
alias rcp='rsync -av --progress'

cpstat() {
    tar cf - "$1" | pv -s $(du -sb "$1" | awk '{print $1}') | (cd "$2"; tar xf -)
}
cpzstat() {
    tar czf - "$1" | pv -s $(du -sb "$1" | awk '{print $1}') | (cd "$2"; tar xzf -)
}


function _email_job {
    echo $@ | tee /var/tmp/$$.email_job.txt
    $@ 2>&1 | tee -a /var/tmp/$$.email_job.txt

    if [ $? -eq 0 ]; then
        str="[koopa] Success: $@"
        mpack -s "$str" /var/tmp/$$.email_job.txt rwolcott88@gmail.com
    else
        str="[koopa] FAILED: $@"
        mpack -s "$str" /var/tmp/$$.email_job.txt rwolcott88@gmail.com
    fi
}
alias email-job='_email_job'

export LCMTYPES=""
export LCMTYPES="$LCMTYPES $HOME/magic2/lcmtypes/*"
export LCMTYPES="$LCMTYPES $HOME/magic2/april2/lcmtypes/*"
export LCMTYPES="$LCMTYPES $HOME/navboard/lcmtypes/*"
alias spy="$HOME/magic2/bin/lcm-spy-web $LCMTYPES"
alias spy_console="$HOME/magic2/bin/lcm-spy-april $LCMTYPES"
