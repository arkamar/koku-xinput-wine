
CPPFLAGS += $(shell pkg-config --cflags sdl2)
CPPFLAGS += -I/usr/include/wine/windows
CPPFLAGS += -Dkoku_xinput_wine_EXPORTS

CFLAGS ?= -O2
CFLAGS += -m32
CFLAGS += -pedantic -Wall # -Werror
CFLAGS += -Wno-attributes -Wno-ignored-attributes
CFLAGS += -Wno-unused-parameter -Wno-unused-variable
CFLAGS += -Wno-format

CXXFLAGS = $(CFLAGS)
CXXFLAGS += -Wno-subobject-linkage
CXXFLAGS += -std=gnu++11

LDFLAGS  += -m32
LDLIBS   += $(shell pkg-config --libs sdl2)

TARGET = koku-xinput-wine.so
OBJ = main.o xinput.o device.o log.o

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CXX) $(LDFLAGS) -shared -o $@ $(LDLIBS) $^

device.o: device.cpp main.h jumper.h
main.o: main.cpp main.h jumper.h log.h
xinput.o: xinput.cpp main.h jumper.h
log.o: log.h log.c

clean:
	$(RM) $(TARGET) $(OBJ)
