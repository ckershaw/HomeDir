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

alias rcp='rsync -av --progress'
cpstat() {
    tar cf - "$1" | pv -s $(du -sb "$1" | awk '{print $1}') | (cd "$2"; tar xf -)
}
cpzstat() {
    tar czf - "$1" | pv -s $(du -sb "$1" | awk '{print $1}') | (cd "$2"; tar xzf -)
}

alias matlab='/data/MATLAB/2014b/bin/matlab'
