#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#define target "0000:00:0d.0\n"
#define target_sz (sizeof(target)-1)
void main() {
	if (setuid(0)) {
		puts("proceeding without setuid");
	}
	//execl("/usr/sbin/uhubctl", "uhubctl", "-a", "2", "-p", "4", "-l", "2-1", (char *) NULL);
	char hostname[HOST_NAME_MAX];
	if (gethostname(hostname, HOST_NAME_MAX)) abort();
	if (strcmp(hostname, "daniel-tablet1")) {
		puts("Wrong computer");
		exit(1);
	}
	if (chdir("/sys/bus/pci/drivers/xhci_hcd")) abort();
	int bind = open("bind", O_WRONLY);
	if (bind < 0) abort();
	int unbind = open("unbind", O_WRONLY);
	if (unbind < 0) abort();
	puts("unbind");
	int ret = write(unbind, target, target_sz);
	if (ret	!= target_sz && !(ret == -1 && errno == ENODEV)) abort();
	puts("bind");
	if (write(bind, target, target_sz) != target_sz) abort();
	puts("done");
}
