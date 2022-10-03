CC=clang
CFLAGS=-g -Wall

OBJDIR=obj
SRCDIR=src
TESTDIR=tests
BINDIR=bin
ASMDIR=hex

#Wildcard find all .c-files
SRCS=$(wildcard $(SRCDIR)/*.c) $(wildcard $(SRCDIR)/**/*.c)

#Substitute all .c files with .obj files, from the SRCS-variable
OBJS=$(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.obj, $(SRCS))

#Get and run tests
TESTS=$(wildcard $(TESTDIR)/*.c)
TESTBINS=$(patsubst $(TESTDIR)/%.c, $(TESTDIR)/bin/%, $(TESTS))

#Create Assembly
ASMBINS=$(patsubst $(SRCDIR)/%.c, $(ASMDIR)/%.s, $(SRCS))

BIN = $(BINDIR)/main

all:$(BIN)

#Make release creates a more lean option
release: CFLAGS=-Wall -o2 -DNDEBUG
release: clean
release: $(BIN)

#Makes the binary
$(BIN): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@

#Make .obj files from the .c files
$(OBJDIR)/%.obj: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@ -I $(SRCDIR)

#Make ASM outputs
$(ASMDIR)/%.s: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -S $< -o $@

#Invoke to make ASM outputs
asm: $(ASMBINS)
	@echo "asm"

#Make the tests before running them
$(TESTDIR)/bin/%: $(TESTDIR)/%.c
	$(CC) $(CFLAGS) -c $< $(OBJS) -o $@

#Invoke to run tests (needs a runner)
test: $(BIN) $(TESTDIR)/bin $(TESTBINS)
	for test in $(TESTBINS) ; do ./$$test ; done

clean: 
	$(RM) -r $(OBJDIR)/* $(ASMDIR)/* $(BINDIR)/*

init:
	@mkdir $(OBJDIR) $(BINDIR) $(TESTDIR) $(SRCDIR)
	echo "DONE"

$(ASMDIR):
	mkdir $@

$(TESTDIR)/bin:
	mkdir $@
