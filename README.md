# TestApp
A minimalist unit testing framework for Clarion. Useful for experimenting and testing classes.

## How to use
It's just an `APP` with a `Tests` source procedure where you code your tests, in `ROUTINE`s or as you prefer. An example is included.  

## Local Procedures
`AssertEqual` is implemented as a local procedure so you can easily modify its output as needed.

*AssertEqual( expected , actual , info )*

    AssertEqual(.03',loc:sum,'1: TestSum')  
    
## Global Procedures

*StringToFile( string , filename )*  

    StringToFile(TestsResult,'TestsResult.txt')  
    
*DebugView( string )*

    DebugView('a:'&loc:a&' b:'&loc:b)
    
    
You can view the result of your tests in a text file (automatically opened at the end) or using any `OutputDebugString` viewer, like [DebugView++](https://github.com/CobaltFusion/DebugViewPP/releases).
    
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
      DebugView('a:'&loc:a&' b:'&loc:b)
      
      !Act
      loc:sum = loc:a + loc:b
      
      !Assert
      AssertEqual('0.03',loc:sum,'1: TestSum')  
