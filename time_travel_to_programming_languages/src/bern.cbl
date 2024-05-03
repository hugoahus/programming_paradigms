       *> Written by Hugo Larsson Wilhelmsson and Erik Smit

       IDENTIFICATION DIVISION.
       PROGRAM-ID. Bernoulli.

       DATA DIVISION.
       *> Defines variables that the program will use
       WORKING-STORAGE SECTION.
       *> 01 means simple variable, PIC S9(9) menans "picture", format of data, S=sign (tecken), 9=digits
       *> USAGE IS BINARY VALUE means that the storage format is integers in binary
       *> Ändra N om man vill räkna upp till ett annat B[N]
       01 N PIC S9(9) USAGE IS BINARY VALUE 20.
       01 N-ARG PIC S9(9) USAGE IS BINARY VALUE 20.
       01 M PIC S9(9) USAGE IS BINARY VALUE 1.
       01 M-IDX PIC S9(9) USAGE IS BINARY VALUE 1.
       01 K PIC S9(9) USAGE IS BINARY VALUE 1.
       01 K-IDX PIC S9(9) USAGE IS BINARY VALUE 1.
       01 K-ARG PIC S9(9) USAGE IS BINARY VALUE 0.
       01 R PIC S9(9) USAGE IS BINARY VALUE 1.
       01 I PIC S9(9) USAGE IS BINARY VALUE 1.
       01 DISP-INDEX PIC S9(2) USAGE IS BINARY VALUE 0.
       01 DISP-INDEX-OFFSET PIC S9(9) USAGE IS BINARY VALUE 0.
       01 NUMS.
           *> Creates a "list" called NUM with 21 elements that in the beginning are set to 0.0
           *> 02 means group of elements, COMP-2 means binary data type (floating values)
           02 NUM COMP-2 VALUE 0.0 OCCURS 21 TIMES.

       PROCEDURE DIVISION.
           *> Runs BERNOULLI
           PERFORM BERNOULLI
           *> Loop 21 times to print B(0) - B(20)
           PERFORM VARYING DISP-INDEX FROM 0 BY 1 UNTIL DISP-INDEX > N
               COMPUTE DISP-INDEX-OFFSET = DISP-INDEX + 1
               DISPLAY "B[" DISP-INDEX "] = " NUM(DISP-INDEX-OFFSET)
           END-PERFORM
           *> Stop the program
           STOP RUN.

       *> Bernoulli algorithm
       BERNOULLI.
           *> Set B(0) to 1 (First slot in NUM)
           SET NUM(1) TO 1.0
           PERFORM VARYING M FROM 1 BY 1 UNTIL M > N
               PERFORM VARYING K FROM 0 BY 1 UNTIL K = M
                   COMPUTE N-ARG = M + 1
                   COMPUTE K-ARG = K
                   *> Runs BINOM
                   PERFORM BINOM

                   COMPUTE M-IDX = M + 1
                   COMPUTE K-IDX = K + 1
  
                   COMPUTE NUM(M-IDX) = NUM(M-IDX) - R * NUM(K-IDX)
               END-PERFORM

               COMPUTE NUM(M-IDX) = NUM(M-IDX) / (M + 1)
           END-PERFORM.

       *> Binom algorithm
       BINOM.
           SET R TO 1
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > K-ARG
               COMPUTE R = R * (N-ARG - I + 1) / I
           END-PERFORM.
