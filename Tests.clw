

   MEMBER('TestApp.clw')                                   ! This is a MEMBER module

                     MAP
                       INCLUDE('TESTS.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
Tests                PROCEDURE                             ! Declare Procedure
  MAP
AssertEqual PROCEDURE(? pExpected,? pActual,STRING pInfo),LONG,PROC
  END  

TestsResult             ANY

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

AssertEqual         PROCEDURE(? pExpected,? pActual,STRING pInfo)!,LONG,PROC
TestResult ANY
  CODE 
  
  TestResult = CHOOSE(pExpected = pActual,'ok','--')&'<9>'& |
      pInfo&'<13,10>' & |
      'Exp: <'&pExpected&'>'&'<13,10>'& |
      'Act: <'&pActual&'>' & |
      '<13,10>'
  
  DebugView(TestResult)
  
  TestsResult =  CHOOSE(TestsResult = '','',TestsResult&'<13,10>')& |         
      TestResult  
  
  RETURN CHOOSE(pExpected = pActual)
    
