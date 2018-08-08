#include <stdio.h>
#include <stdarg.h>

#include "log.h"

static FILE * stream;

static
void __attribute__((constructor))
init() {
	stream = fopen("/tmp/koku.dbg", "a");
	if (stream)
		setvbuf(stream, NULL, _IONBF, 0);
}

static
void __attribute__((destructor))
fini() {
	if (stream)
		fclose(stream);
}

int
koku_log(const char * format, ...) {
	int ret;
	va_list args;

	if (!stream)
		return 0;

	va_start(args, format);
	ret = vfprintf(stream, format, args);
	va_end(args);
	return ret;
}
