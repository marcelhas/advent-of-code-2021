       >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. DAY-5b.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT InputFile ASSIGN TO "input.txt"
        ORGANIZATION IS LINE SEQUENTIAL
        ACCESS IS SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD InputFile.
01 REC.
   05 ITEM PIC X(19).
WORKING-STORAGE SECTION.
*> EOF flag.
01 WSEOF PIC A(1).
*> Full input line.
01 WS-REC.
   05 WS-ITEM PIC X(19).
01 WORLD.
   05 X OCCURS 999 TIMES.
      10 Y OCCURS 999 TIMES PIC 9(3) VALUE ZERO.
*> Left- and right-handside of a parsed line.
01 LHS PIC X(7).
01 RHS PIC X(7).
*> Struct to transport points of a line.
01 L.
   05 X1 PIC S9(3).
   05 Y1 PIC S9(3).
   05 X2 PIC S9(3).
   05 Y2 PIC S9(3).
*> Delta to draw lines into WORLD.
01 DX PIC S9(1).
01 DY PIC S9(1).
*> Indexes to index WORLD.
01 X-IDX PIC 9(4).
01 Y-IDX PIC 9(4).
01 RESULT PIC 9(5).

PROCEDURE DIVISION.
OPEN INPUT InputFile.
       PERFORM PROCESS-FILE UNTIL WSEOF='Y'.
CLOSE InputFile.

MOVE 1 TO X-IDX.
MOVE 1 TO Y-IDX.
PERFORM UPDATE-RESULT UNTIL X-IDX = 1000.
DISPLAY RESULT.
STOP RUN.

PROCESS-FILE.
   READ InputFile INTO WS-REC
       AT END MOVE 'Y' TO WSEOF
       NOT AT END PERFORM PROCESS-LINE
   END-READ.

PROCESS-LINE.
   UNSTRING ITEM DELIMITED BY " -> "
   INTO LHS, RHS

   *> Setup x1,y1 and x2,y2.
   PERFORM PROCESS-LHS.
   PERFORM PROCESS-RHS.

   *> Setup delta.
   IF X1 < X2 THEN
       MOVE 1 TO DX
   ELSE IF X1 = X2 THEN
       MOVE 0 TO DX
   ELSE
       MOVE -1 TO DX
   END-IF.

   IF Y1 < Y2 THEN
       MOVE 1 TO DY
   ELSE IF Y1 = Y2 THEN
       MOVE 0 TO DY
   ELSE
       MOVE -1 TO DY
   END-IF.

   *> Draw lines into world.
   PERFORM ADD-TO-WORLD UNTIL (X1 = X2 AND Y1 = Y2).
   *> Draw last point in manually.
   PERFORM UPDATE-INDEXES.
   ADD 1 TO Y(X-IDX, Y-IDX).

PROCESS-LHS.
   UNSTRING LHS DELIMITED BY ","
   INTO X1, Y1.

PROCESS-RHS.
   UNSTRING RHS DELIMITED BY ","
   INTO X2, Y2.

ADD-TO-WORLD.
   PERFORM UPDATE-INDEXES.
   ADD 1 TO Y(X-IDX, Y-IDX).

   IF X1 NOT EQUAL TO X2 THEN
       ADD DX TO X1
   END-IF.

   IF Y1 NOT EQUAL TO Y2 THEN
       ADD DY TO Y1
   END-IF.

*> Matrix starts at index 1.
UPDATE-INDEXES.
   ADD 1 TO X1 GIVING X-IDX.
   ADD 1 TO Y1 GIVING Y-IDX.

UPDATE-RESULT.
   IF Y(X-IDX, Y-IDX) > 1 THEN
       ADD 1 TO RESULT
   END-IF.

   ADD 1 TO Y-IDX.
   IF Y-IDX = 1000 THEN
       MOVE 1 TO Y-IDX
       ADD 1 TO X-IDX
   END-IF.