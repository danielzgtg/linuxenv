#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#define target "0000:2a:00.1"
#define parent "0000:21:08.0"

void main() {
	if (setuid(0)) {
		puts("proceeding without setuid");
	}
	char hostname[HOST_NAME_MAX];
	if (gethostname(hostname, HOST_NAME_MAX)) abort();
	if (strcmp(hostname, "daniel-desktop3")) {
		puts("Wrong computer");
		exit(1);
	}
	// Rebinding usb1 via the USB subsystem doesn't work
	// Need to restart the entire USB controller via PCI
	puts("remove");
	int fd;
	if (chdir("/sys/bus/pci/devices/" target)) {
		puts("missing");
	} else {
		fd = open("remove", O_WRONLY);
		if (write(fd, "1\n", 2) != 2) abort();
	}
	puts("sleep");
	sleep(1);
	puts("rescan");
	if (chdir("/sys/bus/pci/devices/" parent)) abort();
	fd = open("rescan", O_WRONLY);
	if (write(fd, "1\n", 2) != 2) abort();
	puts("done");
}
