      SUBROUTINE IN ( S,F,BH,BV,AL,P,W,U,E,WU,WE,AL1,AL2,A1,A2,A3,A4,CX,
     1FH,FV,ID,NMD,ITD,JTD,MMD,NND,AF,ITPD,
     2 WK,XQT,XAA,XBB,XCC,XT,KK,KM,XL,II,IID,MMAX,
     3 WK1,WK2,TT,TTI,IDD,IDDD,NEG)
C
C****     SUBROUTINES TO BE COMPILED BY FORT77VP
C****     APU001    **   ARGUMENTS SENT   --  IN
C
      COMMON /TW1C/ DDD(1),LIM1,IA(210)
      COMMON /WORK/AAA(1),LIM2,AI(130)
      DIMENSION D(212),A(132)
      EQUIVALENCE (D(1),DDD(1)),(AAA(1),A(1))
C
      EQUIVALENCE (A(3),BA),(A(4),BC),(A(5),J),(A(6),J1),(A(7),J2)
      DIMENSION S(NMD,ITD),F(NMD,ITD),BH(JTD,MMD),BV(ITD,MMD),
     1AL(NND,ITD),P(NMD,MMD),AF(ITPD,MMD)
      DIMENSION W(1),U(1),E(1),WU(1),WE(1),AL1(1),AL2(1),A1(1),A2(1),
     1A3(1),A4(1),CX(1),FH(1),FV(1),ID(1)
C
      EQUIVALENCE (IA(57),MM),(IA(58),NM),(IA(64),IT),(IA(77),ITP),
     1( A(  8),JCONV),( A(33 ),ZZ),( A(34 ),BB),( A(35 ),CC),
     2( A( 36),DD),( A(37 ),T),( A( 38),QT),( A( 39),CT),( D( 83),NN),
     3( A( 42),AA),( A( 43),TI),( A( 44),TJ),( A( 45),TM)
C
C
C****     APU002    **   SETTING APU DIM. --  IN
      DIMENSION  KK(MMAX),KM(MMAX),XL(MMAX),II(IT),IID(IT)
      DIMENSION  WK(IT),XQT(IT),XAA(IT),XBB(IT),XCC(IT),XT(     IT)
      DIMENSION WK1(MMAX,IT),WK2(IT),TT(IT),TTI(IT),IDD(NEG),IDDD(NEG)
C/*
C
C     APU DECLARATION IN IN
C****     APU003    **   APU  SOURCE
C
      DO 1167 M=1,MMAX
      K=KK(M)
      DO 1132 I=1,IT
 1132 XQT(I)=0.
      DO 1100 N=1,NM
      DO 1100 I=1,IT
 1100 XQT(I)=XQT(I)+P(N,M)*S(N,I)
      IF(XL(M).LT.0.5) THEN
      DO 1122 I=1,IT
      XAA(I)=U(M)*A1(I)
      XBB(I)=BA*E(M)*A3(I)
      WK2(I)=XBB(I)*BV(I,M)+XQT(I)
 1122 WK(I)=1.0/(XAA(I)+XBB(I)+CX(I))
         ELSE
      DO 1123 I=1,IT
      XAA(I)=U(M)*A1(I)
      XBB(I)=BA*E(M)*A3(I)
      XCC(I)=(AL1(M)+AL2(M))*A2(I)
      WK2(I)=XBB(I)*BV(I,M)+XCC(I)*AL(K,I)+XQT(I)
 1123 WK(I)=1.0/(XAA(I)+XBB(I)+XCC(I)+CX(I))
        ENDIF
C/*
C SERIAL LOOP (RECURRECE BY BH(J,M))
      DO 1210 IB=1,IT
      I=II(IB)
      T    =( XAA(I)*BH(J,M)+WK2(I)) * WK(I)
      IF(XL(M).LT.0.5) THEN
      TM=T
      ELSE
      TM=2.0*T-AL(K,I)
      ENDIF
      TI=2.0*T-BH(J,M)
      TJ=2.0*T-BV(I,M)
      IF(TI.LT.0.0) GO TO 130
      IF(TJ.LT.0.0)  GO TO 130
      IF(TM.LT.0.0)  GO TO 130
      BH(J,M)=TI
      BV(I,M)=TJ
      AL(K,I)=TM
      GO TO 140
  130 ZZ=U(M)*A4(I+1)
      AA=XAA(I)-ZZ
      BB=0.5*XBB(I)
      CC=A2(I)*AL1(M)
      DD=A2(I)*AL2(M)
      CT=CX(I)
      QT=XQT(I)
      CALL FIXUP(BH(J,M),BV(I,M),AL(K,I))
  140 CONTINUE
      XT(I)=W(M)*T
      WK1(M,I)=BH(J,M)
 1210 CONTINUE
      DO 1150 N=1,NM
      DO 1150 I=1,IT
 1150 F(N,I)=F(N,I)+P(N,M)*XT(I)
C/*
 1167 CONTINUE
      DO 1300 L =1,NEG
      DO 1213 M=1,MMD
 1213 FH(L)=FH(L)+BC*WU(M)*WK1(M,IDD(L))*A4(IDD(L))
 1214 CONTINUE
      IF(JCONV.NE.2) GO TO 1300
C/*
      DO 1200 M=1,MMD
 1200 AF(I,M)=WK1(M,I)
 1300 CONTINUE
C     DO 1300 IB=1,IT
C     I=ITP-IB
C     I1=ID(I)
C     I2=ID(I-1)
C     IF(I2.EQ.I1) GO TO 1214
C     DO 1213 M=1,MMD
C1213 FH(I1)=FH(I1)+BC*WU(M)*WK1(M,I)*A4(I)
C1214 CONTINUE
C     IF(JCONV.NE.2) GO TO 1300
C/*
C     DO 1200 M=1,MMD
C1200 AF(I,M)=WK1(M,I)
C1300 CONTINUE
C/*
      IF(J2.EQ.J1)RETURN
      DO 1220 I=1,IT
      I1=ID(I)
      DO 1220 M=1,MMD
 1220 FV(I1)=FV(I1)+A3(I)*WE(M)*BV(I,M)
      RETURN
      END
