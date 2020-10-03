
PROG = simple
CFLAGS = -O3 -I. -fpermissive
SCANNER = scanner
GRAMMAR = grammar
FLEX = flex
BISON = bison
SRCS = driver.c lex.yy.c $(PROG).c
BIN = $(PROG).exe
CC = g++

all: grammar scanner bin 

bin: $(SRCS)
	$(CC) $(CFLAGS) -o $(BIN) $(SRCS) 

scanner: $(SCANNER).yy
	$(FLEX) $(SCANNER).yy

grammar: $(GRAMMAR).y
	$(BISON) $(GRAMMAR).y -o $(PROG).c

grammar02: 
	$(BISON) grammar02.y -o $(PROG).c
	$(FLEX) $(SCANNER).yy
	$(CC) $(CFLAGS) -o $(BIN) $(SRCS) 

clean: 
	rm *.exe lex.yy.c $(PROG).? *.o
