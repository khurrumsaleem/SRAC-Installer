C     MEMBER DELTVP3 FOR IDRECT=1 WITHOUT TAYLOR EXPANSION
C     VECTORIZE BY COLLISION REGION
C
CVP   SUBROUTINE DELT3(NR,III,S,U,X,P,MAT,SIG,LENG)
      SUBROUTINE DELT3B(NR,III,S,U,X,P,MAT,SIG,LENG,PP,IBANK,U00,U0I,T1,
     >                  T2,SUM)
C
C       CALLED AT EVERY ENERGY GROUP FOR CYLINDRICAL COORDINATE
C     L0: NUMBER OF CUTS IN THE SOURCE CELL ON A LINE
C     LLL: TOTAL NUMBER OF CUTS ON A LINE
C     WEIGHT: WEIGHT OF A LINE
C     III(L): REGION IDENTIFICATION NUMBER OF CUT L
C     MAT   : MATERIAL NUMBER
C     SIG :   MACRO CROSS SECTION OF MATERIAL M
C     S(L):   MACRO CROSS SECTION OF CUT L
C     X(L):   LENGTH OF CUT L
C     U(L):   OPTICAL LENGTH OF CUT L
C     N :    CURRENT ENERGY GROUP NUMBER
C     NG:    MAXIMUM NUMBER OF ENERGY GROUPS
C     NR   : TOTAL NUMBER OF REGION
C     IL   : FILE ALLOCATION NUMBER BETWEEN 1,2,3
C     LENG : MAX LLL  USED IN VP 1 VERSION
C
      COMMON / PIJ2C / IDUM(5), IBOUND,IDRECT,LCOUNT,
     1         IDUM2(25),IL
      COMMON /ABC11/ A(5500),B(5500),C(5500)
      REAL *8  A,B,C ,T1,T2,Y,DY,U00,U0I,SUM
      DIMENSION III(*),S(*),U(*),X(*),P(NR,*)
      DIMENSION SIG(*),MAT(*),DUMMY(3)
      EQUIVALENCE(WEIGHT,DUMMY(1))
CVP
      DIMENSION PP(NR,NR+1,IBANK)
CVP
C     ARRAYS FOR VP
      DIMENSION U00(0:LENG),U0I(LENG)
      DIMENSION T1(LENG),T2(LENG),SUM(0:LENG)
C
C     INTEGRATION OF KI FUNCTION
C
      DO 100 I=1,NR
*     VOL(I)=0.
      DO 100 J=1,NR+1
      P(I,J)=0.
  100 CONTINUE
CVP
      DO 101 K=1,IBANK
      DO 101 J=1,NR+1
      DO 101 I=1,NR
      PP(I,J,K)=0.
  101 CONTINUE
      CALL OPNBUF(IL)
      DO 1000 LINE=1,LCOUNT
      CALL RDBUF(LLL,L0,WEIGHT,X(1),III(1),IL)
      DO 120 L=1,LLL
      I       =III(L)
      M=MAT(I)
      S(L) = SIG(M)
      U(L) = S(L)*X(L)
  120 CONTINUE
*     IF(LINE.EQ.10 .AND. N.EQ.1)
*    &WRITE(6,'(A/(8(I4,E12.5)))')' S ALONG LINE',(III(L),S(L),L=1,LLL)
      DO 400 L=1,L0
      I=III(L)
      UI=U(L)
C
      WI=WEIGHT/S(L)
C     U0=-UI
      U00(L-1)=-UI
      SUM(L-1)=WI*UI
C
C    U00,U0I
      DO 140 LD=L,LLL
C     U0=U0+UJ
      LMAX=LD
      U00(LD)=U00(LD-1)+U(LD)
      IF(U00(LD).GT.6.) GO TO 150
  140 CONTINUE
  150 CONTINUE
      DO 160 LD=L,LMAX
      U0I(LD)=U00(LD)+UI
  160 CONTINUE
C     T1=FKIN(3,Y)
      DO 240 LD=L,LMAX
C     Y=U0
      Y=U00(LD)
      JJ=INT(100.*Y)+1
      IF(Y.GE.11.0) JJ=1100
      NN=JJ+2200
      DY=Y-0.01D0*DFLOAT(JJ-1)
C     T3= (B(NN)*DY1A(NN))*DY+C(NN)
      T1(LD) = (B(NN    )*DY    +A(NN    ))*DY    +C(NN    )
  240 CONTINUE
C     T2=FKIN(3,Y)
      DO 260 LD=L,LMAX
C     Y=U0+UI
      Y=U0I(LD)
      JJ=INT(100.*Y)+1
      IF(Y.GE.11.0) JJ=1100
      NN=JJ+2200
      DY=Y-0.01D0*DFLOAT(JJ-1)
C     T4= (B(NN)*DY+A(NN))*DY+C(NN)
      T2(LD) = (B(NN    )*DY    +A(NN    ))*DY    +C(NN    )
 260  CONTINUE
      DO 300 LD=L,LMAX
      SUM(LD)=WI*(T1(LD)-T2(LD))
 300  CONTINUE
CVP   DO 320 LD=L,LMAX
C     J=III(LD)
C     P (I,J)=P (I,J)+(SUM(LD-1)-SUM(LD))/S(LD)
C320  CONTINUE
      DO 320 LD=L,LMAX,IBANK
      LE = MIN(LMAX,LD+IBANK-1)
      L2 = 0
*VOCL LOOP,NOVREC
      DO 320 L1 = LD,LE
      L2 = L2 + 1
      J=III(L1)
      PP (I,J,L2)=PP (I,J,L2)+(SUM(L1-1)-SUM(L1))/S(L1)
  320 CONTINUE
C     IF(U0.GT.6.) GO TO 400
  340 CONTINUE
      IF(LMAX.GE.L0)
     & P (I,NR+1)=P (I,NR+1)+SUM(LMAX)
  400 CONTINUE
 1000 CONTINUE
      DO 500 L1 = 1,IBANK
      DO 500 I = 1,NR+1
      DO 500 J = 1,NR
      P(J,I) = P(J,I) + PP(J,I,L1)
  500 CONTINUE
*     IF(N.EQ.1)
*    &WRITE(6,'(8(I3,E12.5))') ' VOL NUM=',(I,VOL(I),I=1,NR)
      RETURN
      END
