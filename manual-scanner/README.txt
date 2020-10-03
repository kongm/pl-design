To build the scanner simply run:
gcc manual-scanner.c

A binary and executable program named a.out will be generated.

You can test the scanner with the provided input file, in a command line (terminal) with:

./a.out < scanner-test.in

In addition, you can also compile the scanner with the macro DETECT_FLOAT, which will allow to detect floating point numbers.

gcc manual-scanner.c -D DETECT_FLAOT



