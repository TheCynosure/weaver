# Compiler and standard.
CC = g++ #-std=c99

# Project name.
PROJ = weaver

# Source files.
SRCS = main.c

# Warnings flags.
CFLAGS+= -Wshadow -Wall -Wpedantic -Wextra -Wdouble-promotion

# Debugging flags.
CFLAGS+= -g

# Optimization flags.
CFLAGS+= -Ofast -march=native

# Linker flags.
LDFLAGS = -lm -lSDL2 -lSDL2_gfx

# Linker.
$(PROJ): $(SRCS:.c=.o)
	$(CC) $(CFLAGS) $(SRCS:.c=.o) $(LDFLAGS) -o $(PROJ)

# Compiler template; generates dependency targets.
%.o : %.c
	$(CC) $(CFLAGS) -MMD -MP -MT $@ -MF $*.td -c $<
	@mv -f $*.td $*.d

# All dependency targets.
%.d: ;
-include *.d

clean:
	rm -f vgcore.*
	rm -f cachegrind.out.*
	rm -f callgrind.out.*
	rm -f $(PROJ)
	rm -f $(SRCS:.c=.o)
	rm -f $(SRCS:.c=.d)
