      SUBROUTINE UDATE(ADATE)
C     for SX3(Monte-4) 
C     DATE IS FACOM BUILTIN SERVICE ROUTINE TO RETURN CURRENT DATE
C     ADATE(OUTPUT) : CURRENT DATE IN 8-BYTE
C                     EX. '95-02-09' IF WRITE ADATE IN A8 FORMAT
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
      REAL*4      BDATE
      CALL DATIM(ADATE,BDATE,1)
      RETURN
      END
