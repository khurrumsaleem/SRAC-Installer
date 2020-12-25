CC
      SUBROUTINE SWEEP1(IT,JT,MM,IFLSW,
     1 FCENT,FANG1,FANG2,FEDGIP,FEDGIN,FEDGJP,FEDGJN,
     2 B1,YH,CTOT,COSMU,A1,COSETA,A3,A2,A4,AL1D,AL2D,QT1DDD,
     3 AL1,AL2,LSTA,IFIX,JFIX,MFIX,IFLMK,KL,ML,FANG1D,FANG2D,
     4 L,LLL,LLL2,NM)
C
      IMPLICIT REAL*8(A-H,O-Z)
      DIMENSION IFLSW(MM,JT,IT+JT+MM-2)
      DIMENSION FCENT(1)
      DIMENSION FANG1(1),FANG2(1)
      DIMENSION FANG1D(MM,1),FANG2D(MM,1)
      DIMENSION AL1(1),AL2(1)
      DIMENSION FEDGIP(1)
      DIMENSION FEDGIN(1)
      DIMENSION FEDGJP(1)
      DIMENSION FEDGJN(1)
      DIMENSION B1(JT),YH(JT),CTOT(IT,1),COSMU(1),A1(1)
      DIMENSION COSETA(1),A3(1),A2(1),A4(1),AL1D(MM),AL2D(MM)
      DIMENSION QT1DDD(NM,IT,JT,MM)
      DIMENSION IFIX ((JT+1)*MM+100)
      DIMENSION JFIX ((JT+1)*MM+100)
      DIMENSION MFIX ((JT+1)*MM+100)
      DIMENSION IFLMK((JT+1)*MM+100)
      DIMENSION KL (1),ML (1)
C
      IFIXFL=0
      IONSC1= -LSTA
*VOCL LOOP,IONSC1.LE.0
*VOCL LOOP,IONSC2.LE.0
*VOCL LOOP,IONSC2.GE.IONSC1
*VOCL LOOP,NOVREC(FANG1,FANG2)
      DO 3100 MK=1,MM*LLL
        K=KL(MK)
        M=ML(MK)
        KD1=K-IONSC1
        I=L-MM+1-KD1+M
*VOCL STMT,IF(40)
        IF(IFLSW(M,KD1,L).EQ.0) GO TO 3100
          BA=2.0*B1(KD1)
          BC=YH(KD1)
          CT=CTOT(I,KD1)
          AA=COSMU(M)*A1(I)
          BB=BA*COSETA(M)*A3(I)
          CC=A2(I)*(AL1D(M)+AL2D(M))
          FCENT(MK) = (AA*FEDGIP(MK)+
     1                 BB*FEDGJP(MK)+
     2                 CC*FANG1 (MK)+
     3                 QT1DDD(1,I,KD1,M))/(AA+BB+CC+CT)
C
          IF(IFLSW(M,KD1,L).EQ.3 .OR. IFLSW(M,KD1,L).EQ.4) THEN
            FANG2(MK)=FCENT(MK)
          ELSE
            FANG2(MK)=FCENT(MK)+FCENT(MK)-FANG1(MK)
          ENDIF
          TM = FANG2(MK)
          FEDGJN(MK)=FCENT(MK)+FCENT(MK)-FEDGJP(MK)
          FEDGIN(MK)=FCENT(MK)+FCENT(MK)-FEDGIP(MK)
          TJ = FEDGJN(MK)
          TI = FEDGIN(MK)
          IF(TI.GE.0.0.AND.TJ.GE.0.0.AND.TM.GE.0.0) GO TO 3100
            IFIXFL=IFIXFL+1
            IFIX (IFIXFL)=I
            JFIX (IFIXFL)=KD1
            MFIX (IFIXFL)=M
            IFLMK(IFIXFL)=MK
 3100 CONTINUE
      IF(IFIXFL.EQ.0) GO TO 3600
      DO 3500 IFNO=1,IFIXFL
        ZZ=COSMU(MFIX(IFNO))*A4(IFIX(IFNO)+1)
        AA=COSMU(MFIX(IFNO))*A1(IFIX(IFNO))-ZZ
        BB=2.0*B1(JFIX(IFNO))*COSETA(MFIX(IFNO))*
     1     A3(IFIX(IFNO))*0.5
        CT=CTOT(IFIX(IFNO),JFIX(IFNO))
        CC=A2(IFIX(IFNO))*AL1(MFIX(IFNO))
        DD=A2(IFIX(IFNO))*AL2(MFIX(IFNO))
        CALL FIXUP(
     1  FEDGIP(IFLMK(IFNO)),
     2  FEDGJP(IFLMK(IFNO)),
     3  FANG1 (IFLMK(IFNO)),
     4  ZZ,BB,CC,DD,
     5  FCENT (IFLMK(IFNO)),
     6  QT1DDD(1,IFIX(IFNO),JFIX(IFNO),MFIX(IFNO)),
     7  CT,AA,
     8  FEDGIN(IFLMK(IFNO)),
     9  FEDGJN(IFLMK(IFNO)),
     A  FANG2 (IFLMK(IFNO)))
 3500 CONTINUE
 3600 DO 4000 M=1,MM
        DO 4000 K=1,LLL2
          IF(IFLSW(M,LSTA+K-1,L).EQ.1.OR.
     1       IFLSW(M,LSTA+K-1,L).EQ.3) THEN
            FANG1D(M+1,K)=FANG2D(M,K)
          ENDIF
 4000 CONTINUE
      RETURN
      END
