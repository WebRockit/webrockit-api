#!/bin/sh

# check some pre-reqs before we build

PROBLEMS=0
NEEDPKGS=""
PKGTOOL="rpm --quiet -q"

if [ ! -z "${NEEDPKGS}" ]
then
    for apkg in "${NEEDPKGS}"
    do
        echo "### Verifying pre-req pacakge ${apkg} is installed"
        ${PKGTOOL} ${apkg} 
        if [ $? -ne 0 ]
        then
            echo ERROR, ${apkg} not installed
            PROBLEMS=99
        fi
    done
fi

if [ ${PROBLEMS} -ne 0 ]
then
    echo "Terminating build. I feel bad for you, but I've got ${PROBLEMS} dependency problems, so packaging will not be one."
    exit 1
else 
    exit 0
fi
