CCNTR --025 ***CITATION*** READS INPUT SECTION 001/ CF-IPTM
C
      SUBROUTINE CNTR(ISTEP)
C
CDEL  INTEGER RGX , MSX , ZNEX , ZDX , WZX
CDEL  PARAMETER ( RGX=100, MSX=211, ZDX=200, ZNEX=1000, WZX=100 )
      INCLUDE  'CITPMINC'
C
      COMMON/ALSUB/BLSUB(30),TITL1(18),TITL2(18),IMAX,JMAX,KBMAX,KMAX,
     & LMAX,MMAX, NMAX,IMXP1,JMXP1,KBMXP1,NSETMX,NTO,MM1VX,KM1VX,IOIN,
     & IOUT,IOSIG,IOFLX,IO1,IO2,IO3,IO4,IO7,NER(100), IX(200),INNO(100),
     &  NGC(24),IEDG(24),ITMX(24),TIMX(6), GLIM(6),NDPL(24),IEDP1(24),
     & IEDP2(24),IEDP3(24), DPLH(6),NUAC(24),EPI(6),XMIS(6),NSRH(24),
     & XSRH1(6), XTR1(WZX),XTR2(WZX),NXTR1(WZX),NXTR2(WZX),SPARE(200),
     & IXPUT(200),XPUT(200)
C
  100 READ(IOIN,1000)(NGC(I),I=1,24)
      READ(IOIN,1000)(IEDG(I),I=1,24)
      ITMX(1) = 200
      ITMX(2) = 100
      ITMX(3) = 10
      ITMX(4) = 2
      ITMX(5) = 3
      ITMX(19) = 60/IX(1)
      ITMX(20) = 30/IX(1)
      ITMX(21) = 60/IX(1)
      ITMX(22) = 30/IX(1)
      ITMX(23) = 60/IX(1)
      ITMX(24) = 120/IX(1)
      DO 101 N = 6,18
      ITMX(N) = 0
  101 CONTINUE
      READ(IOIN,1000)(NXTR1(I),I=1,24)
      DO 103 I = 1,24
      IF (NXTR1(I)) 103,103,102
  102 ITMX(I) = NXTR1(I)
  103 CONTINUE
      GLIM(1) = 1.5
      GLIM(2) = 0.5
      GLIM(3) = 1.0E+10
      GLIM(4) = 1.0E+24
      GLIM(5) = 0.0
      GLIM(6) = 1.0
      READ(IOIN,1001)(XTR1(I),I=1,6)
      DO 105 I = 1,6
      IF (XTR1(I)) 104,105,104
  104 GLIM(I) = XTR1(I)
  105 CONTINUE
      IF(ISTEP .NE. 1) GO TO 110
      WRITE(IOUT,1002)
      WRITE(IOUT,1003)(NGC(I),I=1,24)
      WRITE(IOUT,1004)(IEDG(I),I=1,24)
      WRITE(IOUT,1004)(ITMX(I),I=1,24)
      WRITE(IOUT,1005)(GLIM(I),I=1,6)
  110 CONTINUE
      IF (GLIM(6)) 107,106,107
  106 GLIM(6) = 1.0
  107 IX(5) = NGC(10)
      SPARE(50) = GLIM(6)
      RETURN
 1000 FORMAT(24I3)
 1001 FORMAT(6E12.0)
 1002 FORMAT(1H0/1H0,'GENERAL CONTROL INPUT - SECTION 001')
 1003 FORMAT(1H0,24I4)
 1004 FORMAT(1H ,24I4)
 1005 FORMAT(1H ,1P6E14.6)
      END
