#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
int main() {
if(setuid(0))abort();
switch (fork()) {
case 0:
execl("/usr/bin/killall", "killall", "-9", "multitouch", (char*)0);
case -1:
abort();
return 0;
default:
int wstatus;
if (wait(&wstatus)<=0)abort();
if (wstatus)abort();
break;
}
execl("/sbin/service", "service", "ipts_rust_multitouch", "restart", (char*)0);
abort();
return 0;
}
