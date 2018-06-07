CXX = g++
CXXFLAGS = -Wall -O2 $(shell pkg-config --cflags lua5.3) 
LDLIBS = $(shell pkg-config --libs lua5.3)
RM = rm -v -f

all: lab9_lib.so


lab9_lib.so: z1.cpp
	$(CXX) $(CXXFLAGS) $^ $(LDLIBS) -shared -fPIC -o lab9_lib.so

clean:
	@$(RM) example01 example02 lab9_lib.so 
	@$(RM) *~
