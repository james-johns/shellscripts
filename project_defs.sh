#!/bin/sh

if [[ "$PROJECT" == "FINAL_YEAR" ]]; then
    export ARCH=arm
    export PROJECT_ROOT=/projects/university/final-year-project/
    set_cross_compiler arm-none-eabihf
    export PATH=$ORIG_PATH:/opt/toolchains/arm-cross/bin/
    create_link_to_project_root
elif [[ "$PROJECT" == "MSP430" ]]; then
    export ARCH=msp430
    export PROJECT_ROOT=/projects/
    set_cross_compiler msp430
    create_link_to_project_root
elif [[ "$PROJECT" == "BAPEOS" ]]; then
    export ARCH=arm
    export PROJECT_ROOT=/projects/university/bapeos/XNOR-ESD/
    set_cross_compiler arm-none-eabi
    create_link_to_project_root
elif [[ "$PROJECT" == "IDE" ]]; then
    export ARCH=
    export PROJECT_ROOT=/projects/general/ide/
    set_cross_compiler none
    create_link_to_project_root
else
    echo "none"
    export ARCH=
    export PROJECT_ROOT=/projects/
    set_cross_compiler none
    create_link_to_project_root
fi



