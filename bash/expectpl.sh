#!/usr/bin/env expect

set script [lindex $argv 0]
set password [lindex $argv 1]
set timeout 30

spawn bash $script 
expect "Password:"
send "$password\r"
interact

