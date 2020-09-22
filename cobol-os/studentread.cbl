IDENTIFICATION DIVISION.
PROGRAM-ID.  studentread.
AUTHOR.  Michael Coughlan.
*> An example showing how to read a sequential file without
*> using condition names.
*> See SeqRead.CBL for the definitive example.


ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
       SELECT StudentFile ASSIGN TO "C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\data\students.dat"
           ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD StudentFile.
01 StudentDetails.
       02  StudentId       PIC 9(7).
       02  StudentName.
           03 Surname      PIC X(8).
           03 Initials     PIC XX.
       02  DateOfBirth.
           03 YOBirth      PIC 9(4).
           03 MOBirth      PIC 9(2).
           03 DOBirth      PIC 9(2).
       02  PhoneNo         PIC 9(10).  
       02  ProgramCode     PIC X(4).
       02  Gender          PIC X.
       02  LoanAmount      PIC 9(5).  

PROCEDURE DIVISION.
main.
   OPEN INPUT StudentFile
   READ StudentFile
       AT END MOVE HIGH-VALUES TO StudentDetails
   END-READ
   DISPLAY "Id....." SPACE "Full Name." SPACE "G" SPACE "Code" SPACE "DOB......." SPACE "PhoneNo..." SPACE "$Loan"
   DISPLAY "-----------------------------------------------------"
   PERFORM UNTIL StudentDetails = HIGH-VALUES
        DISPLAY StudentId SPACE StudentName SPACE Gender SPACE ProgramCode SPACE YOBirth "/" MOBirth "/" DOBirth SPACE  PhoneNo SPACE LoanAmount
       READ StudentFile
           AT END MOVE HIGH-VALUES TO StudentDetails
       END-READ
   END-PERFORM
   CLOSE StudentFile
   STOP RUN.
