IDENTIFICATION DIVISION.
PROGRAM-ID. logger2.
AUTHOR. Anton Georgescu.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
      SELECT LogStudentRecords ASSIGN "C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\data\logs.dat"
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL.
             
DATA DIVISION.
FILE SECTION.      
FD LogStudentRecords.
01 LogStudentRecord        PIC X(70).
01 LOGLINE pic X(70).           

01 WS-CURRENT-DATE-DATA.
   05  WS-CURRENT-DATE.
       10  WS-CURRENT-YEAR         PIC 9(04).
       10  WS-CURRENT-MONTH        PIC 9(02).
       10  WS-CURRENT-DAY          PIC 9(02).
   05  WS-CURRENT-TIME.
       10  WS-CURRENT-HOURS        PIC 9(02).
       10  WS-CURRENT-MINUTE       PIC 9(02).
       10  WS-CURRENT-SECOND       PIC 9(02).
       10  WS-CURRENT-MILLISECONDS PIC 9(02).    
01    WS-CONCAT PIC X(70) VALUE SPACES. 


LINKAGE SECTION.
01 parm1 pic X(56).                                                             

PROCEDURE DIVISION USING parm1.
Begin.
    DISPLAY ">>>>>>>>>>>>>>>>> In the sub-program"
    DISPLAY parm1
    
    OPEN EXTEND LogStudentRecords.  
                                             
    MOVE parm1 TO LOGLINE                     
    DISPLAY "external caller program passed: " LOGLINE. 
    MOVE FUNCTION CURRENT-DATE to WS-CURRENT-DATE-DATA
    STRING WS-CURRENT-DATE-DATA DELIMITED BY SPACE
           ' '   DELIMITED BY SIZE
           LOGLINE
       INTO WS-CONCAT
    END-STRING  
    WRITE LogStudentRecord FROM WS-CONCAT. 
    CLOSE LogStudentRecords. 

    DISPLAY "<<<<<<<<<<<<<< Leaving sub-program now".
    EXIT PROGRAM.
