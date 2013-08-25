#!/usr/bin/env expect
#=============================================================================
#     FileName: expectpl.sh
#         Desc: this is a expect script tmplate
#               install expect at first!!!
#       Author: Mocker
#        Email: Zuckerwooo@gmail.com
#     HomePage: zuckonit.github.com
#      Version: 0.0.1
#   LastChange: 2013-08-26 07:44:50
#      History:
#=============================================================================

set script [lindex $argv 0]
set password [lindex $argv 1]
set timeout 30

spawn bash $script 
expect "Password:"
send "$password\r"
interact

