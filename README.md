"# Data Delta Hooks with COBOL programs and NodeJs" 

A set of code samples that implement the collection of data changes into an ISAM dataset managed by COBOL programs. 
This mechanism is called "data delta hooks"
Three options are presented:

* Data captured in log files through a dynamically loaded COBOL module; data is then processed by NodeJs (see picture below) 
* Data captured through REST API calls to NodeJs (using a dynamically loaded C library)
* Data captured through an Aspect Oriented Programming (AOP) module reading the compiles versions of the scripts

![Option 1 - Delta Hooks with Sequential File](https://user-images.githubusercontent.com/6631390/94273311-3e6c4a80-ff12-11ea-8897-44cad982cdcb.jpg)

