#!/bin/sh

echo '

Cygwin version is the only recommend version on Windows with Cygwin installed. (works in conhost+ssh, wez/mintty+ssh/sftp; conhost+sftp wont work)

'

(
set -x
# gcc -DPREVENT_SIGINT -DSOCKLEN_T=unsigned connect.c -o connect-proxy-1-105-fix-5-cygwin -lwsock32 -liphlpapi
#gcc -DPREVENT_SIGINT -DSOCKLEN_T=unsigned connect.c -o connect-proxy-1-105-fix-5-cygwin
gcc -DSOCKLEN_T=unsigned connect.c -o connect-proxy-1-105-fix-5-cygwin

)

echo 'Then:

cp -v connect-proxy-1-105-fix-5-cygwin.exe /usr/bin/

and set ProxyCommand to C:/cygwin64/bin/connect-proxy-1-105-fix-5-cygwin.exe in ssh config. '

# MinGW w64 version

(
# set -x

x86_64-w64-mingw32-gcc -DPREVENT_SIGINT -DSOCKLEN_T=unsigned connect.c -o connect-proxy-1-105-fix-5-ONLY_FOR_WITHOUT_CYGWIN-mingw-w64 -lwsock32 -liphlpapi

)
