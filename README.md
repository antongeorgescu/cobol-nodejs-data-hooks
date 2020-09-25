# Data Delta Hooks with COBOL programs and NodeJs 

A set of code samples that implement the collection of data changes into an ISAM dataset managed by COBOL programs. 
This mechanism is called "data delta hooks"
Three options are presented:

* Data captured in log files through a dynamically loaded COBOL module; data is then processed by NodeJs (see picture below) 
* Data captured through REST API calls to NodeJs (using a dynamically loaded C library)
* Data captured through an Aspect Oriented Programming (AOP) module reading the compiles versions of the scripts

## Cobol Workspace - Option 1

![Cobol WS - Option 1](https://user-images.githubusercontent.com/6631390/94322567-e9a3f080-ff60-11ea-8f5d-991902b2db8a.png)

## Cobol Workspace - Option 2

![Cobol WS - Option 2](https://user-images.githubusercontent.com/6631390/94322628-02140b00-ff61-11ea-88d9-549e10029dfb.png)

## Cobol Workspace - Option 3

![Cobol WS - Option 3](https://user-images.githubusercontent.com/6631390/94322649-0e986380-ff61-11ea-9c99-5c8adf92fbc0.png)

## Green Screen

![Green Screen](https://user-images.githubusercontent.com/6631390/94322666-1bb55280-ff61-11ea-885e-8daf0f65c4d8.png)

## Service Broker Server

![Service Broker Server](https://user-images.githubusercontent.com/6631390/94322679-25d75100-ff61-11ea-90ad-95a729c116c4.png)
