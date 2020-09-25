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
01 LOGLINE pic X(70).                                                            
*> 77 STRLEN pic 9(9) VALUE 52. 
*> 77 STRLEN1 pic 9(9) VALUE 45.
*> 77 STRLEN2 pic 9(9) VALUE 7.
01 ACTION pic X(6).
01 WS-CONCAT-LOG pic X(54).

*> 01 WS-DATA pic X(20) VALUE 'Mainframes tech help'.
*> 01 WS-DATA1 pic X(40) VALUE 'is a mainframe community'.
*> 01 WS-OUTPUT-DATA pic X(70).

*> 01 UserNumber         PIC 99.

*> 01 PrnResult          PIC 9(6).
*> * field declared as COMP cannot be DISPLAYed
*> * it is necessary to move it to a DISPLAY field.
*> * DISPLAY is the default value for a field and
*> * need not be declared.
  

*> * Parameters must be either 01-level's or elementry
*> * data-items. 
*> 01 Parameters.
*>    02 Number1         PIC 9(3).
*>    02 Number2         PIC 9(3).
*>    02 FirstString     PIC X(19) VALUE "First parameter  = ".
*>    02 SecondString    PIC X(19) VALUE "Second parameter = ".
*>    02 Result          PIC 9(6) COMP.
*> *  I've made this a COMP field to demonstrate that COMP 
*> *  items can be passed as parameters but a COMP field cannot
*> *  be DISPLAYed and so is moved to a DISPLAY field before DISPLAYing it.

PROCEDURE DIVISION.
BEGIN.
   *>  MOVE ZEROS TO LOGLINE(1:STRLEN1)                                   
   *>  MOVE 46 TO STRLEN1                                                 
   *>  MOVE ZEROS TO ACTION(1:STRLEN2) 
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
              STRING ACTION,'*',LOGLINE DELIMITED BY SIZE
                   INTO WS-CONCAT-LOG
              END-STRING   
              DISPLAY 'Data passed to sub-program: ' WS-CONCAT-LOG                 
              CALL "logger2" USING BY REFERENCE WS-CONCAT-LOG
              
              READ TransRecords
                  AT END SET EndOfTransFile TO TRUE
              END-READ
            
         WHEN (StudentID = TransStudentID)
              DISPLAY "Update - " TransStudentId " existing record: " TransRecord
              WRITE NewStudentRecord FROM TransRecord
              
              *>   Capture updated TransRecord
              MOVE NewStudentRecord TO LOGLINE
              MOVE 'UPDATE' TO ACTION 
              STRING ACTION,'*',LOGLINE
                   INTO WS-CONCAT-LOG
              END-STRING     
              DISPLAY 'Data passed to sub-program: ' WS-CONCAT-LOG                  
              CALL "logger2" USING BY REFERENCE WS-CONCAT-LOG
              
            *>   STRING WS-DATA,WS-DATA1 DELIMITED BY SIZE
            *>        INTO WS-OUTPUT-DATA
            *>   END-STRING
            *>   DISPLAY 'Data after second concatenate: ' WS-OUTPUT-DATA  
            *>   CALL "logger" USING BY REFERENCE WS-OUTPUT-DATA, STRLEN  
              
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
    
   *>  PERFORM CallMultiplyNums.
    
    STOP RUN.
    
*> CallMultiplyNums.
*>     DISPLAY "Input 2 numbers (3 digits each)  to be multiplied"
*>     DISPLAY "First number -  " WITH NO ADVANCING
*>     ACCEPT Number1
*>     DISPLAY "Second number - " WITH NO ADVANCING
*>     ACCEPT Number2.
*>     DISPLAY "The first string  is " FirstString.
*>     DISPLAY "The second string is " SecondString.
*>     DISPLAY ">>>>>>>>> Calling the sub-program now".

*>     CALL "MultiplyNums"
*>          USING BY CONTENT Number1, Number2, FirstString,
*>                BY REFERENCE SecondString, Result.

*> *> *   The USING phrase specifies the parameters to be passed to the
*> *> *   sub-program. The order of the parameters is important as the
*> *> *   sub-program recognizes them by relative location not by name
*> *> *
*> *> *   Parameters should be passed BY CONTENT when you are not expecting
*> *> *   them to get a value from the called program.  We have not passed
*> *> *   SecondString by content and you can see that its value is
*> *> *   overwritten by the called program.

*>     DISPLAY "Back in the main program now <<<<<<<<<<<".
*>     MOVE Result to PrnResult.
*>     DISPLAY Number1 " multiplied by " Number2 " is = " PrnResult.

*>     DISPLAY "The first string is  " FirstString.
*>     DISPLAY "The second string is " SecondString.
