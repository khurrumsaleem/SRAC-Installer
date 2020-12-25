CNMBL --126 ***CITATION*** CALC. NEUTRON BALANCE/ CF-EIGN
C
      SUBROUTINE NMBL(B1,B4,P2,RVOL,NCOMP,SIG,P2E,XL, IVX,JVX,KBVX,KVX,
     & LVX,MVX,JIVX,B2,B5)
C
CDEL  INTEGER RGX , MSX , ZNEX , ZDX , WZX
CDEL  PARAMETER ( RGX=100, MSX=211, ZDX=200, ZNEX=1000, WZX=100 )
      INCLUDE  'CITPMINC'
C
      REAL*8 P2
      REAL*8 B1
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
      COMMON/AFLUX/BFLUX(30),KXMN8,NIT,NIIT,NIIIT,JXP1,KSCT1,KSCT2,
     & ISTART,IEP, VRGP1,VRGP2,VRGP3,VRG1,VRG2,VRGK1,VRGK2,XABS,PROD,
     & XLEK,RMX,RMN,XKEF1,XKEF2,XKEF3,EXFC1,EXFC2,EXFC3, NI3,IEXTR,
     & IRECV,VRGABS,LO3,LO4,XLAMDA,EPI1,EPI2, BETTA,SUMXI,IX25,IX28,I,J,
     &  KB,K,ITMAX,ITIME, BET(MSX),DEL(MSX)
      COMMON/ABURN/BBURN(30),NSIG1(50),NSIG2(50),NSIG3(50),N1N2R(2,ZDX),
     &  NSIG4(50),NSIG5(50),NSIG6(50),NJM(50),NJMM(50),NJNQ(50),NCH(50),
     &  NZON(ZDX),NXSET(ZDX),NXODR(ZDX),IDXSET(ZDX),NCLASS(ZDX),NDP(ZDX)
     & , XNAME(3,ZDX)
C
      DIMENSION XL(6,KVX), B1(MVX,KVX),B4(MVX,KVX),P2(JVX,IVX,KVX),
     & RVOL(LVX), NCOMP(LVX),SIG(KVX,MVX,10),P2E(JIVX,KBVX,KVX)
      DIMENSION B2(MVX,KVX),B5(MVX,KVX)
C
  100 CORPW = SPARE(100)
      RECPRK = XLAMDA
      SPARE(27) = XLAMDA
      IF (IX(5).NE.(-5)) GO TO 101
      SPARE(18) = 1.0
      IF (XLAMDA.GE.0.0) GO TO 102
      XABS = (XABS + XLEK)/XLAMDA
      PROD = PROD/XLAMDA
      WRITE(IOUT,1000) SPARE(88),PROD,XABS
      STOP
  101 CONTINUE
C***************************SEARCH OPTIONS******************************
      IF ((IX(5).EQ.1).OR.(IX(5).LT.0)) RECPRK = 1.0/XKEF1
      SPARE(18) = RECPRK
  102 CONTINUE
      T1 = 0.0
      DO 104 M = 1,MMAX
      ZONVOL(M) = 0.0
      DO 103 K = 1,KMAX
      T1=T1+B1(M,K)*SIG(K,M,7)
  103 CONTINUE
  104 CONTINUE
      DO 105 L=1,LMAX
      M = NCOMP(L)
      ZONVOL(M) = ZONVOL(M)+RVOL(L)
  105 CONTINUE
      IF (IX(5).NE.(-5)) GO TO 106
      XKEF3 = 1.0
      IF (XLAMDA.NE.0.0) XKEF3 = 1.0/XLAMDA
      GO TO 108
  106 CONTINUE
  107 XKEF3 = CORPW*1.0E+6*XMIS(5)/(XMIS(4)*T1)
  108 CONTINUE
      NGC11 = NGC(11)
      DO 125 K = 1,KMAX
      DO 116M=1,MMAX
      B1(M,K)=B1(M,K)*XKEF3
      B5(M,K) = B2(M,K)*XKEF3
      IF (ZONVOL(M)) 109,110,109
  109 B4(M,K) = B1(M,K)/ZONVOL(M)
      GO TO 111
  110 B4(M,K) = B1(M,K)
  111 IF (IX(5).NE.-2) GO TO 115
      IF (NGC11) 112,113,114
  112 IF (M.NE.-NGC11) GO TO 115
  113 SIG(K,M,6) = SIG(K,M,6)*XLAMDA
      GO TO 115
  114 IF (NCLASS(M).EQ.NGC11) GO TO 113
  115 CONTINUE
  116 CONTINUE
      DO 117 N = 1,6
      XL(N,K) = XL(N,K)*XKEF3
  117 CONTINUE
      IF (NUAC(5).LE.10) GO TO 121
      DO 120 KB = 1,KBMAX
      N1 = 0
      DO 119 I = 1,IMAX
      DO 118 J = 1,JMAX
      N1 = N1 + 1
      P2E(N1 ,KB,K) = P2E(N1 ,KB,K)*XKEF3
  118 CONTINUE
  119 CONTINUE
  120 CONTINUE
      GO TO 124
  121 DO 123 I = 1,IMAX
      DO 122 J = 1,JMAX
      P2 (J,I, K) = P2 (J,I, K)*XKEF3
  122 CONTINUE
  123 CONTINUE
  124 CONTINUE
  125 CONTINUE
      XABS = XABS*XKEF3
      PROD = PROD*XKEF3
      XLEK = XLEK*XKEF3
      T2 = T1*XKEF3/XMIS(5)
      TT11 = XLEK+XABS
      SPARE(56) = TT11
      WRITE(IOUT,1001)XLEK,TT11,PROD,T2
  126 CONTINUE
      XLAMDA = RECPRK
      RETURN
 1000 FORMAT(1H0,'THERE IS NO SOLUTION TO THIS FIXED SOURCE PROBLEM, ',
     &' SOURCE',1PE13.5,' PRODUCTIONS',1PE13.5,' LOSSES',1PE13.5)
 1001 FORMAT(1H0,'    LEAKAGE',1PE13.5,2H  ,'TOTAL LOSSES',E13.5,
     & 2H  ,'TOTAL PRODUCTIONS',E13.5,2H  ,'REACTOR POWER(WATTS)',E13.5)
      END
