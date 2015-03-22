#!/bin/sh
######
# core.sh
#
# Should be included in .bashrc
# Should include further scripts as required, and
# instantiate core environment features required by other scripts.
# 
######

function clear_cache_memory {
    sudo sh -c 'free -h && sync && echo 3 > /proc/sys/vm/drop_caches && free -h'
}

function new_vm {
    if [ -z $1 ]; then
	echo "Must give a name to new VM"
	return
    fi
    sudo virt-clone -o Maggie -n $1 -f /projects/VMs/$1.img
}

export EDITOR="emacs -nw"

if [ -f ./projects.sh ]; then
    . ./projects.sh
fi
