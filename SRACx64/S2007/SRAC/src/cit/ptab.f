CPTAB --142 ***CITATION*** POINT NEUTRON ABSOR. FOR 1,2-D/ CF-OUTC
C
      SUBROUTINE PTAB(P2 ,UTIL ,NRGN ,NCOMP,PVOL, SS1,SS2,SS4,CONC,MJJR,
     & SOURE,IVX,JVX,KBVX,KVX,LVX,MVX,NVX,NSETVX,NND,NNXTRA,SS5)
C
CDEL  INTEGER RGX , MSX , ZNEX , ZDX , WZX
CDEL  PARAMETER ( RGX=100, MSX=211, ZDX=200, ZNEX=1000, WZX=100 )
      INCLUDE  'CITPMINC'
C
      REAL*8 P2
C
      COMMON/ALSUB/BLSUB(30),TITL1(18),TITL2(18),IMAX,JMAX,KBMAX,KMAX,
     & LMAX,MMAX, NMAX,IMXP1,JMXP1,KBMXP1,NSETMX,NTO,MM1VX,KM1VX,IOIN,
     & IOUT,IOSIG,IOFLX,IO1,IO2,IO3,IO4,IO7,NER(100), IX(200),INNO(100),
     &  NGC(24),IEDG(24),ITMX(24),TIMX(6), GLIM(6),NDPL(24),IEDP1(24),
     & IEDP2(24),IEDP3(24), DPLH(6),NUAC(24),EPI(6),XMIS(6),NSRH(24),
     & XSRH1(6), XTR1(WZX),XTR2(WZX),NXTR1(WZX),NXTR2(WZX),SPARE(200),
     & IXPUT(200),XPUT(200)
      COMMON/ABURN/BBURN(30),NSIG1(50),NSIG2(50),NSIG3(50),N1N2R(2,ZDX),
     &  NSIG4(50),NSIG5(50),NSIG6(50),NJM(50),NJMM(50),NJNQ(50),NCH(50),
     &  NZON(ZDX),NXSET(ZDX),NXODR(ZDX),IDXSET(ZDX),NCLASS(ZDX),NDP(ZDX)
     & , XNAME(3,ZDX)
C
      DIMENSION P2 (JVX,IVX, KVX),UTIL (JVX,IVX ), NRGN (JVX,IVX ),
     & NCOMP(LVX),PVOL(LVX), SS1(KVX,NVX,NSETVX),SS2(KVX,NVX,NSETVX),
     & SS4(KVX,NVX,NSETVX), CONC(NVX,MVX),MJJR(200,NSETVX),SOURE(JVX,
     & IVX,KBVX)
      DIMENSION NNXTRA(NVX,NSETVX),SS5(KVX,NVX,NSETVX)
C
      IF (NND.EQ.0) GO TO 107
      DO 101 I = 1,IMAX
      DO 100 J = 1,JMAX
      UTIL(J,I) = 0.0
  100 CONTINUE
  101 CONTINUE
      DO 106 NUD = 1,200
      NFLAG = 0
      DO 105 NSET = 1,NSETVX
      N = MJJR(NUD,NSET)
      IF (NNXTRA(N,NSET).NE.5) GO TO 105
      NFLAG = 1
      DO 104 I = 1,IMAX
      DO 103 J = 1,JMAX
      L = NRGN (J,I)
      M = NCOMP(L)
      NACT = NXSET(M)
      NSEET = NXODR(NACT)
      IF (NSET.NE.NSEET) GO TO 103
      T1 = CONC(N,M)
      IF (T1.EQ.0.0) GO TO 103
      DO 102 K = 1,KMAX
      UTIL (J,I ) = UTIL (J,I )+SS5(K,N,NSET)*P2 (J,I,K)
  102 CONTINUE
      UTIL (J,I ) = UTIL (J,I )*T1
  103 CONTINUE
  104 CONTINUE
  105 CONTINUE
      IF (NFLAG.EQ.0) GO TO 106
      IND = 10
      IX(165) = NUD
      CALL POUT(P2 ,UTIL ,IND,SOURE,IVX,JVX,KBVX,KVX)
  106 CONTINUE
      GO TO 111
  107 NUD = IX(117)
      DO 110 I = 1,IMAX
      DO 109 J = 1,JMAX
      UTIL (J,I ) = 0.0
      L = NRGN (J,I )
      M = NCOMP(L)
      NACT = NXSET(M)
      NSET = NXODR(NACT)
      JM = NJM(NSET)
      NUC = MJJR(NUD,NSET)
      IF ((NUC.LE.0).OR.(NUC.GT.JM)) GO TO 109
      IF (CONC(NUC,M).EQ.0.0) GO TO 109
      T1 = CONC(NUC,M)
      DO 108 K = 1,KMAX
      UTIL (J,I ) = UTIL (J,I )+SS1(K,NUC,NSET)* P2 (J,I, K)*T1
  108 CONTINUE
  109 CONTINUE
  110 CONTINUE
      IND = 3
      CALL POUT(P2,UTIL,IND,SOURE,IVX,JVX,KBVX,KVX)
  111 CONTINUE
      RETURN
      END
