IDENTIFICATION DIVISION.
PROGRAM-ID. StudentWrite.
AUTHOR. Michael Coughlan.
*> This program updates the Students.Dat file with insertions
*> taken from the Transins.Dat file to create a new file
*> - Students.New - which contains the inserted records.

*> cobc -x -free studentwrite.cbl

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
      SELECT StudentRecords ASSIGN "C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\data\students.dat"
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL.

      SELECT TransRecords ASSIGN "C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\data\transins.dat"
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL.

      SELECT NewStudentRecords ASSIGN "C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\data\students1.dat"
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

WORKING-STORAGE SECTION.                                               
01 LOGLINE.                                                            
   05 STR pic x occurs 50 to 200 times depending on STRLEN.  
77 STRLEN pic 9(9) VALUE 54. 
77 STRLEN1 pic 9(9) VALUE 46.
77 STRLEN2 pic 9(9) VALUE 7.
01 ACTION pic X(7).
01 WS-CONCAT-LOG pic X(54).

PROCEDURE DIVISION.
BEGIN.
    MOVE ZEROS TO LOGLINE(1:STRLEN1)                                   
   *>  MOVE 46 TO STRLEN1                                                 
    MOVE ZEROS TO ACTION(1:STRLEN2) 
   *>  MOVE 7 TO STRLEN2  

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
              
              *>   Capture insertion TransRecord
              MOVE NewStudentRecord TO LOGLINE
              MOVE 'INSERT' TO ACTION 
              STRING ACTION,LOGLINE DELIMITED BY SPACE
                   INTO WS-CONCAT-LOG
              END-STRING                    
              CALL "logger" USING BY REFERENCE WS-CONCAT-LOG, STRLEN  
              
              READ TransRecords
                  AT END SET EndOfTransFile TO TRUE
              END-READ
            
         WHEN (StudentID = TransStudentID)
              DISPLAY "Update - " TransStudentId " existing record: " TransRecord
              WRITE NewStudentRecord FROM TransRecord
              
              *>   Capture updated TransRecord
              MOVE NewStudentRecord TO LOGLINE
              MOVE 'UPDATE' TO ACTION 
              STRING ACTION,LOGLINE DELIMITED BY SPACE
                   INTO WS-CONCAT-LOG
              END-STRING                      
              CALL "logger" USING BY REFERENCE WS-CONCAT-LOG, STRLEN
              
              READ TransRecords
                  AT END SET EndOfTransFile TO TRUE
              END-READ
          
         *>  *>   Capture insertion TransRecord
         *>  MOVE NewStudentRecord TO LOGLINE
         *>  STRING ACTION,LOGLINE DELIMITED BY SPACE
         *>       INTO WS-CONCAT-LOG
         *>  END-STRING     
         *>  CALL "logger" USING BY REFERENCE WS-CONCAT-LOG, STRLEN      
       END-EVALUATE
    END-PERFORM
    
    CLOSE StudentRecords
    CLOSE TransRecords
    CLOSE NewStudentRecords
    STOP RUN.
