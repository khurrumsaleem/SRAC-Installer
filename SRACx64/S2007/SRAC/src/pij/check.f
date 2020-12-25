      SUBROUTINE CHECK ( RX,TY,RDP,RPP,NPIN,ATHETA,ISW )
C
C     CHECK GEOMETRIC INFORMATION : CALLED BY PIJIN
C
      DIMENSION RX(1),RDP(NDPIN1,1),RPP(1),NPIN(1),ATHETA(1),TY(1)
C
      COMMON / PIJ1C / NX,NY,NTPIN,NAPIN,NCELL,NM,NGR,NGA,NDPIN,
     1                 IDIVP,BETM,NX1,NY1,IDUM(6),NDPIN1,
     2                 NDR,NDA
      COMMON / PIJ2C / IGT,NZ,NR,NRR,NXR,IBOUND,IDRECT,LCOUNT,IEDPIJ,
     1                 IFORM,NTTAB,NUTAB,SZ,LOCAL(5),
     2                 IEDFLX,ITMINN,ITMOUT,ITBG,LCMX,ITDM,JPT,
     3                 EPSI,EPSO,EPSG,RELC,OVERX,FACTOR,NO1(9),
     4                 LCNREG,LCIRR,LCIXR,LCMAR,LCMAT,LCVOL,
     5                 LCVOLR,LCVOLX,LCVOLM,NO2,AA(950)
      ISW=0
C     ***** RX CHECK *****
C
      LEN=NX1
      IF((IGT.GE.4.AND.IGT.LE.7).OR.IGT.EQ.12) LEN=NX
      CALL ASCEND(RX,LEN,0,'RX  ',0,IERR)
      ISW=ISW+IERR
      IF(IGT.LE.8) RETURN
C
C     ***** TY CHECK *****
      IF(NY.EQ.0 .OR. NY.EQ.1) GO TO 5
      LEN=NY1
      IF(IGT.EQ.11.OR.IGT.EQ.12) LEN=NY
      CALL ASCEND(TY,LEN,1,'TY  ',0,IERR)
      ISW=ISW+IERR
C
C
C     ***** RPP CHECK *****
    5 IF(NDPIN.EQ.0  ) GO TO 10
      IF(IGT.EQ.9 .OR. IGT.EQ.10 .OR. IGT.EQ.14)
     *      CALL ASCEND(RPP,NAPIN,1,'RPP ',0,IERR)
      ISW=ISW+IERR
      IF(IGT.EQ.11.OR. IGT.EQ.12)
     *      CALL ASCEND(RPP,NTPIN,1,'RPP ',0,IERR)
      ISW=ISW+IERR
C
C     ***** PIN RADII (ONE-DIMENSIONAL) CHECK  *****
      IF(IGT.GT.9 ) THEN
      IF(IGT.EQ.10   .OR. IGT.EQ.14            ) THEN
      CALL ASCEND(RDP,NDPIN1,0,'RDP ',0,IERR)
      ISW=ISW+IERR
                                                 ELSE
      DO 6 I=1,NTPIN
      CALL ASCEND(RDP(1,I),NDPIN1,0,'RDP ',0,IERR)
      ISW=ISW+IERR
   6  CONTINUE
                                                 ENDIF
                    ENDIF
C
C     ***** PIN + RX OVERLAP CHECK FOR IGT=10  CLUP
C
   10 IF(IGT.EQ.9 ) RETURN
      IF(IGT.NE.10) GO TO 90
      DO 50 I=1,NAPIN
      R1 = RPP(I) - RDP(NDPIN1,1)
      R2 = RPP(I) + RDP(NDPIN1,1)
      DO 35 J=1,NX1
      IF( RX(J).LT.R1.OR.RX(J).GT.R2) GO TO 35
      IF(I.EQ.1 .AND. J.EQ.1 .AND. RPP(1).EQ.0) GO TO 35
      WRITE(6,6040) I,J,RPP(I),RX(J)
      ISW=ISW+1
   35 CONTINUE
C
C     ***** PIN + RPP OVERLAP CHECK *****
      IF(IDIVP.EQ.0) GO TO 50
      DO 40 K=1,NAPIN
      IF(I.EQ.K) GO TO 40
      IF( RPP(K).LT.R1.OR.RPP(K).GT.R2) GO TO 40
      WRITE(6,6050) I,K,RPP(I),RPP(K)
      ISW=ISW+1
   40 CONTINUE
C
C     ***** PIN + PIN OVERLAP CHECK *****
C     ( CLUP77 )
   50 IF(IGT.GE.10) GO TO 55
      IF(NAPIN.EQ.1) RETURN
      DO 51 I=2,NAPIN
      R1 = RPP(I) - RPP(I-1)
      IF( R1.GT.2*RDP(NDPIN1,1) ) GO TO 51
      I1 = I-1
      WRITE(6,6055) I1,I,RPP(I1),RPP(I)
      ISW=ISW+1
   51 CONTINUE
      RETURN
C
C     **** PIN-PIN OVERLAPPING FOR CLUP : IGT=10
C
   55 I1=0
      I2=0
      DO 80 I=1,NAPIN
      DO 75 II=1,NPIN(I)
      I1=I1+1
      J1=I1
      JS=I
      IF(II.EQ.NPIN(I)) JS=I+1
      IF(I.EQ.NAPIN .AND. II.EQ.NPIN(I)) GO TO 80
      DO 65 J=JS,NAPIN
      JJ1=I1-I2+1
      IF(J.GT.I) JJ1=1
      DO 60 JJ=JJ1,NPIN(J)
      J1=J1+1
      D2 = RPP(I)**2.+ RPP(J)**2 - 2*RPP(I)*RPP(J)
     1    *COS(ATHETA(I1) - ATHETA(J1) )
      IF( 2*RDP(NDPIN1,1).LT.SQRT(D2) ) GO TO 60
      WRITE(6,6090) I1,I,JJ1,J,RPP(I),ATHETA(I1),RPP(J),ATHETA(J1)
 6090 FORMAT(1H ,'***** ERRER ****  PIN  ',I3,'  ON RING ',I3,
     *           '  ACROSSED BY PIN ',
     *              I3,'  ON RING ',I3
     */10X,'RPP(I),THETA(I),RPP(J),THETA(J)=',4E12.5)
      ISW=ISW+1
   60 CONTINUE
   65 CONTINUE
   75 CONTINUE
      I2=I1
   80 CONTINUE
      RETURN
C     **** PIN-PIN OVERLAPPING
C     FOR IGT=11,12,13   CLUPH CLUPH PATHXY
   90 IF(NTPIN.EQ.0) RETURN
      IF(IGT.EQ.14) GO TO 140
C
      DO 130 I=1,NTPIN-1
      R1 = RPP(I) - RDP(NDPIN1,I)
      R2 = RPP(I) + RDP(NDPIN1,I)
      CALL ASCEND(RDP(1,I),NDPIN1,0,'RDP ',I,IERR)
      ISW=ISW+IERR
CK100 IF(IGT.EQ.13 .OR.IGT.EQ.15) GO TO 120
  100 IF(IGT.EQ.13 .OR.IGT.EQ.15 .OR. IGT.EQ.16) GO TO 120
C
C     ***** PIN + RPP OVERLAP CHECK (CLUPH) *****
C
      IF(IDIVP.EQ.0 ) GO TO 120
      DO 110 J=I+1,NTPIN
      IF(RPP(I).EQ.RPP(J)) GO TO 110
      IF( RPP(J).GT.R2) GO TO 110
      WRITE(6,6050) I,J,RPP(I),RPP(J)
      ISW=ISW+1
  110 CONTINUE
C
C     ***** PIN + PIN OVERLAP CHECK IGT=11,12,13,16***
C
  120 DO 125 J=I+1,NTPIN
CKO   IF(IGT.NE.13 .AND.IGT.NE.15)
      IF(IGT.NE.13 .AND.IGT.NE.15 .AND. IGT.NE.16)
     *D2 = RPP(I)**2 + RPP(J)**2 - 2*RPP(I)*RPP(J)
     *    *COS(ATHETA(I) - ATHETA(J) )
CKO   IF(IGT.EQ.13 .OR.IGT.EQ.15)
      IF(IGT.EQ.13 .OR.IGT.EQ.15 .OR. IGT.EQ.16)
     *D2 = (RPP(I)-RPP(J))**2 + (ATHETA(I)-ATHETA(J))**2
      RR = RDP(NDPIN1,I) + RDP(NDPIN1,J)
      IF ( RR .LT. SQRT(D2) ) GO TO 125
      WRITE(6,6060) I,J,RPP(I),ATHETA(I),RPP(J),ATHETA(J)
 6060 FORMAT(1H ,'***** ERRER ****  PIN  ',I3,'  ACROSSED BY PIN ',I3
     1/10X,'RPP(I),THETA(I),RPP(J),THETA(J)=',4E12.5)
      ISW=ISW+1
  125 CONTINUE
  130 CONTINUE
      RETURN
C
C *** PIN + RPP OVERLAPPING FOR IGT=14
C
  140 DO 150 I=2,NAPIN
      R1 = RPP(I) - RDP(NDPIN1,1)
      R2 = RPP(I) + RDP(NDPIN1,1)
      IF(RPP(I-1).GT.R1) THEN
      WRITE(6,6050) I,I-1,RPP(I),RPP(I-1)
      ISW=ISW+1
                         ENDIF
      IF(I.LT.NAPIN .AND. RPP(I+1).LT.R2) THEN
      WRITE(6,6050) I,I+1,RPP(I),RPP(I+1)
      ISW=ISW+1
      ENDIF
  150 CONTINUE
      RETURN
C
 6000 FORMAT(1H ,'***** ERRER-RX(1) MUST BE PUNCHED ZERO ---',E12.5)
 6010 FORMAT(1H ,'***** ERRER-RX(',I3,') MUST BE LESS THAN RX(',I3,
     1      ') ---',E12.5,5X,E12.5 )
 6020 FORMAT(1H ,'***** ERRER-RDP(1,1) MUST BE PUNCHED ZERO ---',E12.5)
 6030 FORMAT(1H ,'***** ERRER-RDP(1',I3,') MUST BE LESS THAN RDP(1',
     1      I3,') ---',E12.5,5X,E12.5 )
 6040 FORMAT(1H ,'***** ERRER-PIN(ON RPP(',I3,')) ACROSSED BY RX(',I3,
     1              ') ---',E12.5,5X,E12.5)
 6050 FORMAT(1H ,'*****ERRER-PIN(ON RPP(',I3,'))  ACROSSED BY RPP(',I3,
     1              ') ---',E12.5,5X,E12.5)
 6055 FORMAT(1H ,'***** ERRER-PIN(ON RPP(',I3,')) ACROSSED BY PIN(ON',
     1      'RPP(',I3, ')) ---',E12.5,5X,E12.5)
 6065 FORMAT(1H ,'***** ERRER-RDP(1,',I3,') MUST BE PUNCHED ZERO ---',
     1      E12.5)
 6070 FORMAT(1H ,'***** ERRER-RDP(',I3,',',I3,') MUST BE LESS THAN RDP('
     1      ,I3,',',I3,')---',E12.5,5X,E12.5 )
      END
