CXX = g++
CXXFLAGS = -Wall -O2 $(shell pkg-config --cflags lua5.3) 
LDLIBS = $(shell pkg-config --libs lua5.3)

all: z1 z2

z1: z1.cpp
z2: z2.cpp


clean:
	rm -f z1 z2




