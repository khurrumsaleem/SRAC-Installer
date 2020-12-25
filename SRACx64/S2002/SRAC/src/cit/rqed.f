CRQED --004 ***CITATION*** EDIT REQUIRED/ CF-MANY ROUTINES
C                                            RERT
      SUBROUTINE RQED(IXED,IND)
C
C     IXED IS THE EDIT OPTION CYCLE
C     IND=0, YES EDIT          IND.NE.0, NO EDIT
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
  100 IND = 0
      IF (IXED.EQ.0) GO TO 101
      IF (IX(41).GT.0) GO TO 103
      IF (IX(14).EQ.0) GO TO 103
      GO TO 102
  101 IND = 1
      GO TO 103
  102 CONTINUE
      IND = IX(14)-(IX(14)/IXED)*IXED
  103 CONTINUE
      RETURN
      END
