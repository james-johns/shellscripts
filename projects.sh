#!/bin/sh
# project specific environment variables, selected by $PROJECT
#
# $ORIG_PATH is set to $PATH before PATH has been changed.
#
#

function set_project {
    if [ -z $1 ]; then
        echo "set_project requires a parameter"
        return
    fi
    echo "PROJECT=$1" > ~/.project
    source ~/.project
    source ~/.bashrc
}

function set_cross_compiler() {
    if [ -z $1 ]; then
        echo "Please specify the cross compiler target to switch to"
        return
    fi
    if [[ "$1" == "none" ]]; then
	export CROSS_COMPILE=
	export PATH=$ORIG_PATH
    else
	export CROSS_COMPILE=$1-
	export PATH=$ORIG_PATH:/opt/toolchains/$1/bin
    fi
}

function create_link_to_project_root() {
    if [ -z $PROJECT_ROOT ]; then
	echo "PROJECT_ROOT must be set to create link"
	return
    else
	if [ -h ~/projectroot ]; then
	    rm ~/projectroot
	fi
	ln -s $PROJECT_ROOT ~/projectroot
    fi
}

function new_project() {
    echo "Creating new project..."
    if [ -z $1 ]; then
	echo "Failed: Argument 1 must be name of project"
	return
    fi
    sed "/else/ i\elif [[ \"\$PROJECT\" == \"$1\" ]]; then\n    export ARCH=\n    export PROJECT_ROOT=\n    set_cross_compiler none\n    create_link_to_project_root" --in-place=.bak ~/.project_defs
    echo "Success: Now edit ~/.project_defs to modify project variables"
}

# Coloured prompt
PS1='${debian_chroot:+($debian_chroot)}$(jobs | wc -l) $(if [[ $? = 0 ]]; then echo "\[\e[1;32m\]";else echo "\[\e[1;31m\]";fi)\u@\h\[\033[00m\]:\[\033[01;34m\] [\w] \[\033[00m\]\$ '

if [ -f ~/.project ]; then
    . ~/.project
fi

echo -e '\033]2;PROJECT is '$PROJECT'\007'

if [ -f ~/.project_defs ]; then
    . ~/.project_defs
else
# default project_defs
    cp project_defs.sh ~/.project_defs
    . ~/.project_defs
fi

