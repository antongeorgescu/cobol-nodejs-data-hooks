IDENTIFICATION DIVISION.
PROGRAM-ID. InsertRecords.
AUTHOR. Michael Coughlan.
*> This program updates the Students.Dat file with insertions
*> taken from the Transins.Dat file to create a new file
*> - Students.New - which contains the inserted records.

*> cobc -x -free studentwrite.cbl

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
      SELECT StudentRecords ASSIGN "C:\Users\ag4488\Documents\Visual Studio 2019\Projects\COBOL\data\students.dat"
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL.

      SELECT TransRecords ASSIGN "C:\Users\ag4488\Documents\Visual Studio 2019\Projects\COBOL\data\transins.dat"
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL.

      SELECT NewStudentRecords ASSIGN "C:\Users\ag4488\Documents\Visual Studio 2019\Projects\COBOL\data\students1.dat"
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL.


DATA DIVISION.
FILE SECTION.
FD StudentRecords.
01 StudentRecord.
   88 EndOfStudentFile     VALUE HIGH-VALUES.
   02 StudentID            PIC X(7).
   02 FILLER               PIC X(39).

FD TransRecords.
01 TransRecord.
   88 EndOfTransFile       VALUE HIGH-VALUES.
   02 TransStudentID       PIC X(7).
   02 FILLER               PIC X(39).

FD NewStudentRecords.
01 NewStudentRecord        PIC X(46).


PROCEDURE DIVISION.
BEGIN.
    OPEN INPUT StudentRecords
    OPEN INPUT TransRecords
    OPEN OUTPUT NewStudentRecords

    READ StudentRecords
       AT END SET EndOfStudentFile TO TRUE
    END-READ

    READ TransRecords
       AT END SET EndOfTransFile TO TRUE
    END-READ

    PERFORM UNTIL (EndOfStudentFile) AND (EndOfTransFile)
       EVALUATE TRUE
         WHEN (StudentID < TransStudentID)
              WRITE NewStudentRecord FROM StudentRecord
              READ StudentRecords
                 AT END SET EndOfStudentFile TO TRUE
              END-READ

         WHEN (StudentID > TransStudentID)
              DISPLAY "Insert - " TransStudentId " new record:      "  TransRecord   
              WRITE NewStudentRecord FROM TransRecord
              READ TransRecords
                  AT END SET EndOfTransFile TO TRUE
              END-READ
            *>   Capture insertion TransRecord

         WHEN (StudentID = TransStudentID)
              DISPLAY "Update - " TransStudentId " existing record: " TransRecord
              WRITE NewStudentRecord FROM TransRecord
              READ TransRecords
                  AT END SET EndOfTransFile TO TRUE
              END-READ
            *>   Capture update TransRecord
       END-EVALUATE
    END-PERFORM
    
    CLOSE StudentRecords
    CLOSE TransRecords
    CLOSE NewStudentRecords
    STOP RUN.
