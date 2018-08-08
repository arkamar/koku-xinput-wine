#include <stdio.h>
#include <stdarg.h>

#include "log.h"

static FILE * stream;

static
void __attribute__((constructor))
init() {
}

static
void __attribute__((destructor))
fini() {
}

int
koku_log(const char * format, ...) {
	int ret;
	va_list args;

	va_start(args, format);
	ret = vfprintf(stream, format, args);
	va_end(args);
	return ret;
}
