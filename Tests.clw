

   MEMBER('TestApp.clw')                                   ! This is a MEMBER module

                     MAP
                       INCLUDE('TESTS.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
Tests                PROCEDURE                             ! Declare Procedure
TestsResult             ANY
  MAP
AssertEqual PROCEDURE(? pExpected,? pActual,STRING pInfo),LONG,PROC
StringToFile    PROCEDURE(STRING pStr,STRING pFileName)
  .

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
  AssertEqual('0.03',loc:sum,'1: TestSum')  
AssertEqual         PROCEDURE(? pExpected,? pActual,STRING pInfo)!,LONG,PROC
  CODE 
  TestsResult =  CHOOSE(TestsResult = '','',CLIP(TestsResult)&'<13,10>')& |         
    CHOOSE(pExpected = pActual,'ok','--')&'<9>'& |
    CLIP(pInfo)&'<13,10>' & |
    'Exp: <'&CLIP(pExpected)&'>'&'<13,10>'& |
    'Act: <'&CLIP(pActual)&'>' & |
    '<13,10>'
  RETURN CHOOSE(pExpected = pActual)
  
StringToFile        PROCEDURE(STRING pStr,STRING pFileName)
bufSize               EQUATE(32768)
dosFile               FILE,DRIVER('DOS'),CREATE
buf                     RECORD;STRING(bufSize).
                      END
pos                   LONG(1)
  CODE
  dosFile{PROP:Name} = pFileName
  CREATE(dosFile)
  IF ERRORCODE() THEN STOP(ERRORCODE()&' '&ERROR()&' '&ERRORFILE());RETURN.
  OPEN(dosFile)
  LOOP UNTIL pos > LEN(pStr)
    dosFile.Buf = pStr[ pos : LEN(pStr) ]
    ADD(dosFile,CHOOSE(pos + bufSize > LEN(pStr), |
      LEN(pStr) - pos + 1, |
      bufSize))
    pos += bufSize
  .
  CLOSE(dosfile)
