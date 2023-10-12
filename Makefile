### Makefile 
###
### Create:   2009-12-17
### Updated:  2012-06-21
### 

ifeq ($(OS), Windows_NT)
	ifeq '$(findstring ;,$(PATH))' ';'
    	UNAME := Windows
	else
		ifeq ($(USE_MINGW_W64),1)
			UNAME := MINGW_W64
		else
			UNAME := Cygwin
		endif
	endif
else
    UNAME := $(shell uname -s)
	UNAME := $(patsubst CYGWIN%,Cygwin,$(UNAME))
	# TODO: MSYS, MINGW
endif

CC=gcc
CFLAGS=-DSOCKLEN_T=unsigned
LDLIBS=

## for Mac OS X environment, use one of options
ifeq ($(UNAME), Darwin)
	CFLAGS=-DBIND_8_COMPAT=1 -DSOCKLEN_T=socklen_t
	LDLIBS=-lresolv
endif

## for Solaris
ifeq ($(UNAME), SunOS)
	LDLIBS=-lresolv -lsocket -lnsl
endif

## for Microsoft Windows native
ifeq ($(UNAME), Windows)
    ifeq (${CC}, clang)
	CFLAGS+=-ccc-gcc-name llvm-gcc.exe
	LDLIBS+=-ccc-gcc-name llvm-gcc.exe
    endif
    LDLIBS := ${LDLIBS} -lws2_32 -liphlpapi
    CFLAGS := ${CFLAGS} -DPREVENT_SIGINT
endif 	

ifeq ($(UNAME), MINGW_W64)
	CC := x86_64-w64-mingw32-gcc
	LDLIBS := ${LDLIBS} -lws2_32 -liphlpapi
	CFLAGS := ${CFLAGS} -DPREVENT_SIGINT
endif

all: connect

connect: connect.o
connect.o: connect.c

##

clean:
	rm -f connect.o *~
veryclean: clean
	rm -f connect connect.exe
rebuild: veryclean all

### End of Makefile
