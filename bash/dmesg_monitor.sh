#!/bin/bash
#=============================================================================
#   FileName: dmesg_monitor.sh
#       Desc: monitor the dmesg command output
#             cause no timestamp in dmesg ouput on such server
#             here use double temple file to make a diff as the result
#     Author: Mocker
#      Email: Zuckerwooo@gmail.com
#    Version: 0.0.1
# LastChange: 2013-08-28 05:51:49
#    History:
#=============================================================================


BASE_NAME=`basename $0`
MAIL_SEND_FROM=""  #set the from email before using
MAIL_SEND_TO=""    #set the to email before using
MAIL_SUBJECT="${HOSTNAME}/$BASE_NAME"

DMESG_FILE_OLD="$HOME/.dmesg.message.old"
DMESG_FILE_NEW="$HOME/.dmesg.message.new"

[[ ! -f $DMESG_FILE_OLD ]] && dmesg > $DMESG_FILE_OLD
dmesg > $DMESG_FILE_NEW

DIFF=`diff -w -B -u $DMESG_FILE_OLD $DMESG_FILE_NEW`
function op_diff() {
    case $1 in
        -l|--last-time-diff) #no sure whether this is important info, take as interface
            local last_change=`echo "$2" | grep ^--- | awk '{for(i=3;i<=NF;i++) printf $i" "; printf "\n"}'` 
            local last_date=`date -d "$last_change"` 
            echo "$last_date"
            exit 0 ;; 

        -c|--curr-time-diff) #manybe $(date) is just ok
            local curr_change=`echo "$2" | grep ^+++ | awk '{for(i=3;i<=NF;i++) printf $i" "; printf "\n"}'`
            local curr_date=`date -d "$curr_change"`
            echo "$curr_date"
            exit 0 ;; 

        -a|--content-add)
            local content_add=`echo -e "$2" | grep ^+ | grep -v ^+++`
            echo "$content_add"
            exit 0 ;; 

        -d|--content-del) #interface left
            local content_del=`echo "$2" | grep ^- | grep -v ^--- | sed  's/^-//'`
            echo "$content_del"
            exit 0 ;; 

        *)
            exit 127 ;;
    esac    
}


if [[ ! -z $DIFF ]]; then
    last_monitor_date=`op_diff -l "$DIFF"`
    diff_content=`op_diff -a "$DIFF"`
    mail_content="After: $last_monitor_date"
    mail_content="$mail_content\n""Host: ${HOSTNAME}"
    mail_content="$mail_content\n""Monitored: dmesg"
    mail_content="$mail_content\n""Date/Time: $(date)\n\n\n"
    mail_content="$mail_content\n""============|DMESG|============"
    mail_content="$mail_content\n""============|INFOS|============"
    mail_content="$mail_content\n""$diff_content"
    echo -e "$mail_content"
    echo -e "$mail_content" | mail -s "$MAIL_SUBJECT" "$MAIL_SEND_TO" -- -f "$MAIL_SEND_FROM"
    [[ $? -eq 0 ]] && cat $DMESG_FILE_NEW > $DMESG_FILE_OLD && exit 0
fi
exit 1
