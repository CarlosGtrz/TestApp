# TestApp
A minimalist unit testing framework for Clarion. Useful for experimenting and testing classes.

## How to use
It's just an `APP` with a source procedure that includes two local procedures:

*AssertEqual( expected , actual , info)*

    AssertEqual(.03',loc:sum,'1: TestSum')  

*StringToFile( string , filename)*

    StringToFile(TestsResult,'TestsResult.txt')  
    
## Example

    CODE
    
      TestsResult = FORMAT(TODAY(),@D10)&' '&FORMAT(CLOCK(),@T04)
    
      DO TestSum
    
      StringToFile(TestsResult,'TestsResult.txt')
      RUN('TestsResult.txt')
       
    TestSum             ROUTINE
      DATA
    loc:a   DECIMAL(15,2)
    loc:b   DECIMAL(15,2)
    loc:sum DECIMAL(15,2)
      CODE  
    
      !Arrange
      loc:a = .01
      loc:b = .02
    
      !Act
      loc:sum = loc:a + loc:b
    
      !Assert
      AssertEqual(.03,loc:sum,'1: TestSum')  
