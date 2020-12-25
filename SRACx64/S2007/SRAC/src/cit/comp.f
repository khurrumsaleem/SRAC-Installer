CCOMP --030 ***CITATION*** READS INPUT SECTION 005 1,2-D/ CF-IPTM
C
      SUBROUTINE COMP(ISTEP,ISK,NRGN,NCOMP, IVX,JVX,LVX)
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
      COMMON/AMESH/BMESH(30),NREGI,NREGJ,NREGKB,XSHI(RGX),XSHJ(RGX),
     & XSHKB(RGX), MSHI(RGX),MSHJ(RGX),MSHKB(RGX),Y(MSX),YY(MSX), X(MSX)
     &  ,XX(MSX),Z(MSX),ZZ(MSX), ZONVOL(ZNEX),AVZPD(ZNEX),PDI(MSX),
     & PDJ(MSX) , PDK(MSX)
      COMMON /CRBNC/ ICONV,ICRBN,NCBSTP,AVZAB(ZNEX)
C     ICRBN IS SET IN CIT1 IF SRAC, OR CRBN IF COREBN
C     ICRBN =0 : SRAC-CITATION, ICRBN=1 : COREBN
C     NCBSTP   : BURNUP STEP IN COREBN
C
      DIMENSION NRGN(JVX,IVX)
      DIMENSION NCOMP(LVX)
C
      IF( NREGJ .GT. WZX ) THEN
      WRITE(6,'(1X,A)')
     &' ** MESSAGE FROM NREGJ IN SUBROUTINE COMP.'
      WRITE(6,'(1X,A,I5)')
     &'INSUFFICIENT ZONE WORKING AREA WZX. CURRENT NUMBER IS ',WZX
      WRITE(6,'(1X,A)')
     &'COULD YOU PLEASE CHECK YOUR NUMBER IN INCLUDE FILE IMMEDIATERY.'
      WRITE(6,'(1X,A)')
     &'I AM WILLING TO YOUR QUICK RESPONCE. THANK YOU.'
       STOP
       ENDIF
C
CKSK
      IF(ICRBN.EQ.0) THEN
        IPRNT = ISTEP
      ELSE
        IPRNT = NCBSTP
      ENDIF
CKSK
      IF (ISK) 100,104,100
  100 IF(IPRNT.EQ.1)WRITE(IOUT,1000)
      NRE = 0
      DO 103 IR = 1,NREGI
CKSK FOR MORE 1000 ZONES IN COREBN
      IF (ICRBN.EQ.1) THEN
        READ(IOIN,1003)(NXTR1(N),N=1,NREGJ)
      ELSE
        READ(IOIN,1001)(NXTR1(N),N=1,NREGJ)
      ENDIF
      DO 102 JR = 1,NREGJ
      NRE = NRE+1
      NCOMP(NRE) = NXTR1(JR)
      IF (NCOMP(NRE)) 101,101,102
  101 NER(14) = 14
  102 CONTINUE
      IF(IPRNT.EQ.1)WRITE(IOUT,1002)(NXTR1(N),N=1,NREGJ)
  103 CONTINUE
  104 CONTINUE
      I = 0
      DO 108 IR = 1,NREGI
      NIPTS = MSHI(IR)
      DO 107 INR = 1,NIPTS
      I = I+1
      J = 0
      NRE = (IR-1)*NREGJ
      DO 106 JR = 1,NREGJ
      NJPTS = MSHJ(JR)
      NREE = NRE+JR
      DO 105 JNR = 1,NJPTS
      J = J+1
      NRGN(J,I) = NREE
  105 CONTINUE
  106 CONTINUE
  107 CONTINUE
  108 CONTINUE
      IF (ISK) 109,112,109
  109 CONTINUE
      MMAX = 0
      DO 110 NR = 1,LMAX
      MMAX = MAX0(MMAX,NCOMP(NR))
  110 CONTINUE
C
      IF( MMAX .GT. ZNEX) THEN
      WRITE(6,'(1X,A)')
     &' ** MESSAGE FROM MMAX IN SUBROUTINE COMP. **'
      WRITE(6,'(1X,A)')
     &'INSUFFICIENT EXPANDED-ZONE AREA NUMBER ZNEX. '
      WRITE(6,'(1X,A,I5)')
     &'CURRENT NUMBER IS ',ZNEX
      WRITE(6,'(1X,A)')
     &'COULD YOU PLEASE CHECK YOUR NUMBER IN INCLUDE FILE IMMEDIATERY.'
      WRITE(6,'(1X,A)')
     &'I AM WILLING TO YOUR QUICK RESPONCE. THANK YOU.'
       STOP
       ENDIF
C
      IF( MMAX .GT. ZDX ) THEN
      WRITE(6,'(1X,A)')
     &' ** MESSAGE FROM MMAX IN SUBROUTINE COMP.'
      WRITE(6,'(1X,A,I5)')
     &'INSUFFICIENT ZONE AREA NUMBER ZDX. CURRENT NUMBER IS ',ZDX
      WRITE(6,'(1X,A)')
     &'COULD YOU PLEASE CHECK YOUR NUMBER IN INCLUDE FILE IMMEDIATERY.'
      WRITE(6,'(1X,A)')
     &'I AM WILLING TO YOUR QUICK RESPONCE. THANK YOU.'
       STOP
       ENDIF
C
  111 CALL CMOT(ISTEP,NRGN ,NCOMP, IVX,JVX,LVX)
  112 CONTINUE
      RETURN
 1000 FORMAT(1H0/1H0,'ZONE INPUT BY REGION')
 1001 FORMAT(24I3)
 1002 FORMAT(1H ,30I4)
 1003 FORMAT(20I4)
      END
