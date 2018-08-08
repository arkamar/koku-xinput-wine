TARGET32 = koku-xinput-wine.so
TARGET64 = koku-xinput-wine64.so
OBJ32 = main.o xinput.o device.o log.o
OBJ64 = $(OBJ32:.o=64.o)

CPPFLAGS += $(shell pkg-config --cflags sdl2)
CPPFLAGS += -I/usr/include/wine/windows
CPPFLAGS += -Dkoku_xinput_wine_EXPORTS

CFLAGS ?= -O2
CFLAGS += -fPIC
$(OBJ32): CFLAGS += -m32
CFLAGS += -Wall # -Werror
CFLAGS += -Wno-attributes -Wno-ignored-attributes
CFLAGS += -Wno-unused-parameter -Wno-unused-variable
CFLAGS += -Wno-format

CXXFLAGS = $(CFLAGS)
CXXFLAGS += -Wno-subobject-linkage
CXXFLAGS += -std=gnu++11

$(TARGET32): LDFLAGS  += -m32
LDLIBS   += $(shell pkg-config --libs sdl2)

TARGETS = $(TARGET32) $(TARGET64)

all: $(TARGETS)

%.so:
	$(CXX) $(LDFLAGS) -shared -o $@ $(LDLIBS) $^

%64.o: %.cpp
	$(CXX) -c $(CPPFLAGS) $(CFLAGS) -o $@ $<

%64.o: %.c
	$(CC) -c $(CPPFLAGS) $(CFLAGS) -o $@ $<

$(TARGET32): $(OBJ32)
$(TARGET64): $(OBJ64)
device64.o device.o: device.cpp main.h jumper.h
main64.o main.o: main.cpp main.h jumper.h log.h
xinput64.o xinput.o: xinput.cpp main.h jumper.h
log64.o log.o: log.h log.c

clean:
	$(RM) $(TARGETS) $(OBJ32) $(OBJ64)
