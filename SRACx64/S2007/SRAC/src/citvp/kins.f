      SUBROUTINE KINS(P2E,B2,NRGNE,DCONBE,DCONRE,DCONBK,SCAC,XL, IVX,
     & JVX,KBVX,KVX,LVX,JVXP1,KBVXP1,JIVX,JIP1VX,JP1IXZ,IOVX,IOVZ, PVOL,
CNN  &  NCOMP,MVX,IVXP1,WKS,P2W,NRW,NRX)
     &  NCOMP,MVX,IVXP1,P2W,NRW,NRX,WORK1,WORK2,NVPHZ1,NVPHZ2,
     &  NVPHZ3,NVPHZ4,NVPHZ5,NVPHZ6,NVPHZ7,NVPHZ8,NVPHZ,JP5K)
C
CHH   SUBROUTINE KINS(P2E,B2,NRGNE,DCONBE,DCONRE,DCONBK,SCAC,XL, IVX,
C    & JVX,KBVX,KVX,LVX,JVXP1,KBVXP1,JIVX,JIP1VX,JP1IXZ,IOVX,IOVZ, PVOL,
CHH  &  NCOMP,MVX,IVXP1)
C
C
CKINS-VP-115 ***CITATION*** CALC. ROD LOSSES FOR 3D  /CF-KNSD
C
C
CDEL  INTEGER RGX , MSX , ZNEX , ZDX , WZX
CDEL  PARAMETER ( RGX=100, MSX=211, ZDX=200, ZNEX=1000, WZX=100 )
      INCLUDE  'CITPMINC'
C
      REAL*8 SUMXI,TPTSA,XADB,XPDB,XS1DB,XS2DB, TL,XRDB,CS1S,CS2S,XLL1,
     & D8,XADX,YADX, XLL2,XLL3,XLL4,XLL5,XLL6,XLEK,B2LK,B3LK,B4LK,B5LK,
     & D1,D2,D3,D4,D5, D6,D7,YADB,YPDB,YLEK,YS1S,YS2S,YS1DB,YS2DB,YRDB,
     & SPR50,XLAST
C
      COMMON/ADUBP/SUMXI(ZNEX)
     &                  ,TPTSA,XADB,XPDB,XS1DB,XS2DB, TL,XRDB,CS1S,CS2S,
     &  XLL1,D8,XADX,YADX, XLL2,XLL3,XLL4,XLL5,XLL6,XLEK,B2LK,B3LK,B4LK,
     &  B5LK,D1,D2,D3,D4,D5, D6,D7,YADB,YPDB,YLEK,YS1S,YS2S,YS1DB,YS2DB,
     &  YRDB,SPR50,XLAST
      COMMON/ALSUB/BLSUB(30),TITL1(18),TITL2(18),IMAX,JMAX,KBMAX,KMAX,
     & LMAX,MMAX, NMAX,IMXP1,JMXP1,KBMXP1,NSETMX,NTO,MM1VX,KM1VX,IOIN,
     & IOUT,IOSIG,IOFLX,IO1,IO2,IO3,IO4,IO7,NER(100), IX(200),INNO(100),
     &  NGC(24),IEDG(24),ITMX(24),TIMX(6), GLIM(6),NDPL(24),IEDP1(24),
     & IEDP2(24),IEDP3(24), DPLH(6),NUAC(24),EPI(6),XMIS(6),NSRH(24),
     & XSRH1(6), XTR1(WZX),XTR2(WZX),NXTR1(WZX),NXTR2(WZX),SPARE(200),
     & IXPUT(200),XPUT(200)
      COMMON/AFLUX/BFLUX(30),KXMN8,NIT,NIIT,NIIIT,JXP1,KSCT1,KSCT2,
     & ISTART,IEP, VRGP1,VRGP2,VRGP3,VRG1,VRG2,VRGK1,VRGK2,XABS,PROD,
     & XELK,RMX,RMN,XKEF1,XKEF2,XKEF3,EXFC1,EXFC2,EXFC3, NI3,IEXTR,
     & IRECV,VRGABS,LO3,LO4,XLAMDA,EPI1,EPI2, BETTA,SAMXI,IX25,IX28,I,J,
     &  KB,K,ITMAX,ITIME, BET(MSX),DEL(MSX)
CNN
      DIMENSION NVPHZ1(JP5K,3),NVPHZ2(JP5K,3),
     1          NVPHZ3(JP5K,3),NVPHZ4(JP5K,3),
     2          NVPHZ5(JP5K,3),NVPHZ6(JP5K,3),
     3          NVPHZ7(JP5K,3),NVPHZ8(JP5K,3),
     4          NVPHZ(8)
CNN
C
      DIMENSION P2E(JIVX,KBVX,KVX),B2(MVX,KVX),NRGNE(JVX,IVX,KBVX),
CNN  & DCONBE(JIP1VX,KBVX,IOVX),DCONRE(JP1IXZ,KBVX,IOVZ), DCONBK(JIVX,
     & DCONBE(JIP1VX*KBVX,IOVX),DCONRE(JP1IXZ*KBVX,IOVZ), DCONBK(JIVX*
     & KBVXP1,IOVX),SCAC(KVX,MVX,KVX),XL(6,KVX)
      DIMENSION PVOL(LVX),NCOMP(LVX)
C
CHHHH
CNN   REAL    WKS(JIVX*KBVX)
      REAL    P2W(JIVX*KBVX,KVX)
      INTEGER NRW(JIVX*KBVX),NRX(JIVX,KBVX)
CHHHH
CNN
      DIMENSION WORK1(MVX,32),WORK2(MVX*32)
CNN
C
C     INRB = 1  ORDINARY
C     INRB = 2  PERIODIC(REPEATING)
C     INRB = 3  90 DEGREE ROTATIONAL
C     INRB = 4  180 DEGREE ROTATIONAL
C
      INRB = IX(72) + 1
      N = IX(20)
      JIKBXX=JIVX*KBVX
CNN
      I128 = 32
      IZN  = MVX * I128
      DO 1900 IZ=1,IZN
        WORK2(IZ) = 0.0
 1900 CONTINUE
      IF (XMIS(2).LT.0.0) THEN
CNN
C
        DO 1901 KK=1,KVX
        IE = 0
        DO 1902 II=0,(JIKBXX-1)/I128
          IS = IE + 1
          IS1 = IS - 1
          IE = IS1 + I128
          IF(IE.GT.JIKBXX) IE=JIKBXX
*VOCL LOOP,REPEAT(32)
*VOCL LOOP,NOVREC
          DO 1903 JI=IS,IE
            IF(P2W(JI,K).EQ.0.0) THEN
            JA = JI - IS1
            WORK1(NCOMP(NRW(JI)),JA) =
     1        WORK1(NCOMP(NRW(JI)),JA) +
     2        P2W(JI,KK) * SCAC(KK,NCOMP(NRW(JI)),K) * PVOL(NRW(JI))
            ENDIF
 1903     CONTINUE
 1902   CONTINUE
 1901  CONTINUE
      END IF
CNN
CMOD
C
      IF(NVPHZ(1).GT.0) THEN
C
        IE = 0
        DO 2001 II=0,(NVPHZ(1)-1)/I128
          IS = IE + 1
          IS1 = IS - 1
          IE = IS1 + I128
          IF(IE.GT.NVPHZ(1)) IE=NVPHZ(1)
*VOCL LOOP,REPEAT(32)
*VOCL LOOP,NOVREC
          DO 2002 JI=IS,IE
            JA = JI - IS1
            WORK1(NVPHZ1(JI,2),JA) =
     1        WORK1(NVPHZ1(JI,2),JA) +
     1        P2W(NVPHZ1(JI,3),K) * DCONBK(NVPHZ1(JI,1),N)
 2002     CONTINUE
 2001   CONTINUE
      ENDIF
C
C
      IF(NVPHZ(2).GT.0) THEN
        IE = 0
        DO 2011 II=0,(NVPHZ(2)-1)/I128
          IS = IE + 1
          IS1 = IS - 1
          IE = IS1 + I128
          IF(IE.GT.NVPHZ(2)) IE=NVPHZ(2)
*VOCL LOOP,REPEAT(32)
*VOCL LOOP,NOVREC
          DO 2012 JI=IS,IE
            T1 = DCONBK(NVPHZ2(JI,1),N)
            IF (T1 .EQ. 4096.0E-13) T1 = 0.0
            JA = JI - IS1
            WORK1(NVPHZ2(JI,2),JA) =
     1        WORK1(NVPHZ2(JI,2),JA) +
     1        P2W(NVPHZ2(JI,3),K) * T1
 2012     CONTINUE
 2011   CONTINUE
C
      ENDIF
C
C
      IF(NVPHZ(3).GT.0) THEN
        IE = 0
        DO 2021 II=0,(NVPHZ(3)-1)/I128
          IS = IE + 1
          IS1 = IS - 1
          IE = IS1 + I128
          IF(IE.GT.NVPHZ(3)) IE=NVPHZ(3)
*VOCL LOOP,REPEAT(32)
*VOCL LOOP,NOVREC
          DO 2022 JI=IS,IE
            JA = JI - IS1
            WORK1(NVPHZ3(JI,2),JA) =
     1        WORK1(NVPHZ3(JI,2),JA) +
     1        P2W(NVPHZ3(JI,3),K) * DCONBE(NVPHZ3(JI,1),N)
 2022     CONTINUE
 2021   CONTINUE
      ENDIF
C
C
      IF(NVPHZ(4).GT.0) THEN
        IE = 0
        DO 2031 II=0,(NVPHZ(4)-1)/I128
          IS = IE + 1
          IS1 = IS - 1
          IE = IS1 + I128
          IF(IE.GT.NVPHZ(4)) IE=NVPHZ(4)
*VOCL LOOP,REPEAT(32)
*VOCL LOOP,NOVREC
          DO 2032 JI=IS,IE
            T1 = DCONBE(NVPHZ4(JI,1),N)
            IF (T1 .EQ. 4096.0E-13) T1 = 0.0
            JA = JI - IS1
            WORK1(NVPHZ4(JI,2),JA) =
     1        WORK1(NVPHZ4(JI,2),JA) +
     1        P2W(NVPHZ4(JI,3),K) * T1
 2032     CONTINUE
 2031   CONTINUE
      ENDIF
C
C
      IF(NVPHZ(5).GT.0) THEN
        IE = 0
        DO 2041 II=0,(NVPHZ(5)-1)/I128
          IS = IE + 1
          IS1 = IS - 1
          IE = IS1 + I128
          IF(IE.GT.NVPHZ(5)) IE=NVPHZ(5)
*VOCL LOOP,REPEAT(32)
*VOCL LOOP,NOVREC
          DO 2042 JI=IS,IE
            T1 = DCONRE(NVPHZ5(JI,1),N)
            JA = JI - IS1
            WORK1(NVPHZ5(JI,2),JA) =
     1        WORK1(NVPHZ5(JI,2),JA) +
     1        P2W(NVPHZ5(JI,3),K) * T1
 2042     CONTINUE
 2041   CONTINUE
C
      ENDIF
C
C
      IF(NVPHZ(6).GT.0) THEN
        IE = 0
        DO 2051 II=0,(NVPHZ(6)-1)/I128
          IS = IE + 1
          IS1 = IS - 1
          IE = IS1 + I128
          IF(IE.GT.NVPHZ(6)) IE=NVPHZ(6)
*VOCL LOOP,REPEAT(32)
*VOCL LOOP,NOVREC
          DO 2052 JI=IS,IE
            T1 = DCONRE(NVPHZ6(JI,1),N)
            IF (T1 .EQ. 4096.0E-13) T1 = 0.0
            JA = JI - IS1
            WORK1(NVPHZ6(JI,2),JA) =
     1        WORK1(NVPHZ6(JI,2),JA) +
     1        P2W(NVPHZ6(JI,3),K) * T1
 2052     CONTINUE
 2051   CONTINUE
      ENDIF
C
C
       IF (NUAC(5).EQ.13) THEN
       KKK = N + IOVX
      IF(NVPHZ(7).GT.0) THEN
        IE = 0
        DO 2121 II=0,(NVPHZ(7)-1)/I128
          IS = IE + 1
          IS1 = IS - 1
          IE = IS1 + I128
          IF(IE.GT.NVPHZ(7)) IE=NVPHZ(7)
*VOCL LOOP,REPEAT(32)
*VOCL LOOP,NOVREC
          DO 2122 JI=IS,IE
            JA = JI - IS1
            WORK1(NVPHZ7(JI,2),JA) =
     1        WORK1(NVPHZ7(JI,2),JA) +
     1        P2W(NVPHZ7(JI,3),K) * DCONRE(NVPHZ7(JI,1),KKK)
 2122     CONTINUE
 2121   CONTINUE
C
      ENDIF
C
      IF(NVPHZ(8).GT.0) THEN
        IE = 0
        DO 2131 II=0,(NVPHZ(8)-1)/I128
          IS = IE + 1
          IS1 = IS - 1
          IE = IS1 + I128
          IF(IE.GT.NVPHZ(8)) IE=NVPHZ(8)
*VOCL LOOP,REPEAT(32)
*VOCL LOOP,NOVREC
          DO 2132 JI=IS,IE
            T1 = DCONRE(NVPHZ8(JI,1),KKK)
            JA = JI - IS1
            WORK1(NVPHZ8(JI,2),JA) =
     1        WORK1(NVPHZ8(JI,2),JA) +
     1        P2W(NVPHZ8(JI,3),K) * T1
 2132     CONTINUE
 2131   CONTINUE
      ENDIF
       END IF
C
C
        DO 2133 NN=1,I128,4
          DO 2134 I=1,MVX
            B2(I,K) = B2(I,K) + WORK1(I,NN) + WORK1(I,NN+1) +
     1                WORK1(I,NN+2) + WORK1(I,NN+3)
 2134     CONTINUE
 2133   CONTINUE
      IF( NUAC(17).NE.0 ) THEN
        DO 850 M=1,MVX
  850     XRDB=XRDB+B2(M,K)
      ENDIF
C
C
      RETURN
      END
