      SUBROUTINE UTIME(ITIME)
C     for SX3(Monte-4) 
C     TIME IS FACOM BUILTIN SERVICE ROUTINE TO RETURN CURRENT TIME.
C     ITIME(OUTPUT) : CURRENT TIME IN THE CURRENT DATE IN MILI-SECOND
C                     FROM AM 0:00.
C
C     TO
C
C     DATIM(A,B,C)
C     A : 8-BYTE CHARCTER
C     B : 8-BYTE CHARCTER OR REAL
C     C : TYPE SELECTION OF A
C         C=1  YY-MM-DD
C         C=3  MM/DD/YY
C         C=4  DD/MM/YY
C
      CHARACTER*8 ADATE
      REAL*4      BDATE,BDATE1,BDATE2,BDATE3
      REAL*4      TH,   TM,    TS,    TMS,   TIMEMS
      INTEGER*4   ITIME
      CALL DATIM(ADATE,BDATE,1)
      TH = INT(BDATE)
      BDATE1 = (BDATE - TH)*60.0
      TM = INT(BDATE1)
      BDATE2 = (BDATE1- TM)*60.0
      TS = INT(BDATE2)
      BDATE3 = (BDATE2- TS)*1000.0
      TMS= INT(BDATE3)
      TIMEMS = TH*3.6E6 + TM*6.0E4 + TS*1000.0E0 + TMS
      ITIME  = INT(TIMEMS)
      RETURN
      END
