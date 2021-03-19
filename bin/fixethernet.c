#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
void main() {
    setuid(0);
    //execl("/usr/sbin/uhubctl", "uhubctl", "-a", "2", "-p", "4", "-l", "2-1", (char *) NULL);
    if (chdir("/sys/bus/usb/drivers/usb")) abort();
    int bind = open("unbind", O_WRONLY);
    if (bind < 0) abort();
    int unbind = open("bind", O_WRONLY);
    if (unbind < 0) abort();
    puts("bind");
    if (write(bind, "usb2\n", 4) != 4) abort();
    puts("unbind");
    if (write(unbind, "usb2\n", 4) != 4) abort();
    puts("done");
}
