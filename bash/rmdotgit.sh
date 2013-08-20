#!/bin/bash
#=============================================================================
#     FileName: rmdotgit.sh
#         Desc: Image such case:
#               You got your own vim dotfiles via vundle, now you want to
#               push them to your own github, I bet you have to delete the
#               dot git directory of each plugin if you wanna download them
#       Author: Mocker
#        Email: Zuckerwooo@gmail.com
#     HomePage: zuckonit.github.com
#      Version: 0.0.1
#   LastChange: 2013-08-21 02:16:02
#      History:
#=============================================================================

PRODIR=$1
CONFIRM=$2
TYPE=.git

[ ! -e $CONFIRM ] && $CONFIRM="-i"
for d in `ls $PRODIR`; do
    if [ "$CONFIRM" == "-i"  ]; then
        rm -ri $PRODIR/$d/$TYPE
    elif [ "$CONFIRM" == "-f" ]
        rm -rf $PRODIR/$d/$TYPE
    fi
done
