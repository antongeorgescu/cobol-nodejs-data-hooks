#line 1 "studentwrite.cbl"
IDENTIFICATION DIVISION.
PROGRAM-ID. StudentWrite.







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
 88 EndOfStudentFile VALUE HIGH-VALUES.
 02 StudentID PIC X(7).
 02 FILLER PIC X(39).

FD TransRecords.
01 TransRecord.
 88 EndOfTransFile VALUE HIGH-VALUES.
 02 TransStudentID PIC X(7).
 02 FILLER PIC X(39).

FD NewStudentRecords.
01 NewStudentRecord PIC X(46).

WORKING-STORAGE SECTION. 
01 LOGLINE pic X(70). 



01 ACTION pic X(7).
01 WS-CONCAT-LOG pic X(54).












 













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
 DISPLAY "Insert - " TransStudentId " new record:      " TransRecord 
 WRITE NewStudentRecord FROM TransRecord
 

 MOVE NewStudentRecord TO LOGLINE
 MOVE 'INSERT' TO ACTION 
 STRING ACTION,LOGLINE DELIMITED BY SIZE
 INTO WS-CONCAT-LOG
 END-STRING 
 
 CALL "logger2" USING BY REFERENCE WS-CONCAT-LOG
 
 READ TransRecords
 AT END SET EndOfTransFile TO TRUE
 END-READ
 
 WHEN (StudentID = TransStudentID)
 DISPLAY "Update - " TransStudentId " existing record: " TransRecord
 WRITE NewStudentRecord FROM TransRecord
 

 MOVE NewStudentRecord TO LOGLINE
 MOVE 'UPDATE' TO ACTION 
 STRING ACTION,LOGLINE DELIMITED BY SIZE
 INTO WS-CONCAT-LOG
 END-STRING 
 DISPLAY 'Data after concatenate: ' WS-CONCAT-LOG 
 CALL "logger2" USING BY REFERENCE WS-CONCAT-LOG
 





 
 READ TransRecords
 AT END SET EndOfTransFile TO TRUE
 END-READ
 






 END-EVALUATE
 END-PERFORM
 
 CLOSE StudentRecords
 CLOSE TransRecords
 CLOSE NewStudentRecords
 

 
 STOP RUN.
 





























