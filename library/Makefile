CC=clang
CFLAGS=-g -Wall

OBJDIR=obj
SRCDIR=src
TESTDIR=tests
BINDIR=bin

#Wildcard find all .c-files
SRCS=$(wildcard $(SRCDIR)/*.c) $(wildcard $(SRCDIR)/**/*.c)

#Substitute all .c files with .obj files, from the SRCS-variable
OBJS=$(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.obj, $(SRCS))

TESTS=$(wildcard $(TESTDIR)/*.c)
TESTBINS=$(patsubst $(TESTDIR)/%.c, $(TESTDIR)/bin/%, $(TESTS))

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
	$(CC) $(CFLAGS) -c $< -o $@

#Make the tests before running them
$(TESTDIR)/bin/%: $(TESTDIR)/%.c
	$(CC) $(CFLAGS) -c $< $(OBJS) -o $@

test: $(BIN) $(TESTDIR)/bin $(TESTBINS)
	for test in $(TESTBINS) ; do ./$$test ; done

clean:
	$(RM) -r $(BINDIR)/* $(OBJDIR)/*

init: $(OBJDIR) $(BINDIR) $(TESTDIR) $(SRCDIR)
	@echo "DONE"

$(SRCDIR):
	@mkdir $@

$(BINDIR):
	@mkdir $@

$(OBJDIR):
	@mkdir $@

$(TESTDIR):
	@mkdir $@

$(TESTDIR)/bin:
	@mkdir $@
