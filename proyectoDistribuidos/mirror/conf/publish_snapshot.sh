#!/usr/bin/expect -f
spawn aptly publish snapshot mirror-snap-xenial
expect "Enter passphrase:"
send -- "password\r"
expect "Enter passphrase:"
send -- "password\r"
expect eof
