      SUBROUTINE REACIN
C
C     DATA INPUT FOR CALCULATING OF REACTION RATE
C
      COMMON /REACC/ IOPT(4),MREC,ICODE,IXMAX,IYMAX,IZMAX,IDIM,
     1               IGMAX,NGF,NGT,IRANG,IMESHT,IMESH1,IMESH2,IMESH3,
     2               IDUM(3),LMTNM1,LIREC1,LNMSH1,LMTNM2,LIREC2,LNMSH2,
     3               LFG,LNREC,LMPOI,LLU235,LLU238,LFGS,LMESH1,LMESH2,
     4               LMESH3,LNMSH3,LAST,IRALIM,LR1,LR2,LR3,LVOL,LFINAM,
     5               DUM(6),A(3960)
CMOD  COMMON /MAINC/ IOPTC(54),NEF,NET,NERF,NERT,UNUSE2(5),NOUT1,NOUT2,
      COMMON /MAINC/ IOPTC(54),NEF,NET,NERF,NERT,NMAT,
     +                                           UNUSE2(4),NOUT1,NOUT2,
CEND
     1               UNUSE3(12),IMCEF,UNUSE4(17),MEMORY,UNUSE5(6),
     2               TITLE(18),UNUSE6(880)
      COMMON /PIJ2C/ IPIJ2C(1000)
      COMMON /SN1C/ ISN1C(1000)
      COMMON /TW1C/ ITW1C(2000)
      COMMON /TUD1C/ ITUD1C(1550)
      COMMON /ALSUB/ ICITC(300)
      CHARACTER * 8 CODE(5)
      DATA CODE/'PIJ     ','ANISN   ','TWOTRAN ','TUD     ','CITATION'/
C
C ***  START OF PROCESS
C
      CALL ICLEA (  IOPT , 4000 , 0 )
      IRALIM = 4000
C ***  SETTING MESH SIZE
      ICODE = IOPTC(2)
      IF (IOPTC(12).NE.0) ICODE = IOPTC(12)
      GO TO (1,2,3,4,5) , ICODE
      WRITE (NOUT1,6700) ICODE
      STOP
C
    1 CONTINUE
      IXMAX = IPIJ2C(4)
      GO TO 6
C
    2 CONTINUE
      IF (IOPTC(12).EQ.0) THEN
           IXMAX =ISN1C(36)
           ELSE
           IXMAX = ISN1C(37)
           ENDIF
      GO TO 6
C
    3 CONTINUE
      IF (IOPTC(12).EQ.0) THEN
         IXMAX = ITW1C(5)
         IYMAX = ITW1C(6)
         ELSE
           IXMAX = ITW1C(66)
           IYMAX = ITW1C(67)
         ENDIF
         GO TO 6
C
    4 CONTINUE
      IF (IOPTC(12).EQ.0) THEN
         IXMAX = ITUD1C(1)
         ELSE
           IXMAX = ITUD1C(6)
         ENDIF
         GO TO 6
C
    5 CONTINUE
      IF (IOPTC(12).EQ.0) THEN
         IXMAX = ICITC(2)
         IYMAX = 1
         IZMAX = 1
         ELSE
           IXMAX = ICITC(68)
           IYMAX = ICITC(67)
           IZMAX = ICITC(69)
         ENDIF
         IDIM  = ICITC(214)
C
C *** SETTING NO OF ENERGY GROUPS
C
    6 CONTINUE
      IF (IOPTC(10).NE.0.AND.IOPTC(12).GT.0) GO TO 110
      NGF    = NEF
      NGT    = 0
      IF (IOPTC(4).NE.0) NGT = NET
      GO TO 120
  110 CONTINUE
      NGF    = NERF
      NGT    = 0
      IF (IOPTC(4).NE.0) NGT = NERT
  120 CONTINUE
      IGMAX  = NGF + NGT
C
      WRITE(NOUT2,6000)
      WRITE(NOUT2,6010) CODE(ICODE),IXMAX,IYMAX,IZMAX,IDIM,IGMAX,NGF,NGT
      IF (IOPTC(12).EQ.0) WRITE(NOUT2,6020)
      IF (IOPTC(12).NE.0.AND.ICODE.EQ.1) WRITE(NOUT2,6020)
      CALL REAM(DUM,IOPT,DUM,0,4,0)
      WRITE(NOUT2,6100) (IOPT(I),I=1,3)
CADD
      WRITE(NOUT2,6110)  IOPT(4)
C     MREC = IOPT(4)
C     IOPT(4) = 0
C     IF (MREC.LT.0) THEN
      IF (IOPT(4).GT.0) THEN
                     ICVRAT = 1
CDEL                 MREC   = -MREC
CDEL                 IF (IOPT(3).EQ.0) MREC = 0
      IF (ICODE.NE.5)   THEN
      WRITE(NOUT1,'(1H0,A)') ' *** ERROR *** CONVERSION CALCULATION OPTI
     1ON IS PERMITED ONLY MULTI-DIMENSIONAL DIFUSION CODE'
                        STOP
                        ENDIF
                     ENDIF
C
      MREC  = 0
      IF(IOPT(3).GT.0)  MREC = NMAT
CEND
C
CDEL  WRITE(NOUT2,6110) ICVRAT
      IF (IMCEF.EQ.0.AND.IOPT(3).NE.0) GO TO 9100
C
CMOD  DO 100 I=1,3
      DO 100 I=1,4
          IF(IOPT(I).LT.0) GO TO 8000
  100 CONTINUE
C
      LMTNM1 = 1
      LIREC1 = LMTNM1 + IOPT(1)*2
      LNMSH1 = LIREC1 + IOPT(1)
      LMTNM2 = LNMSH1 + IOPT(1)
      LIREC2 = LMTNM2 + IOPT(2)*2
      LNMSH2 = LIREC2 + IOPT(2)
      LFG    = LNMSH2 + IOPT(2)
      LNREC  = LFG    + IOPT(2)*IGMAX
      LMPOI  = LNREC  + MREC
      LLU235 = LMPOI  + IOPT(3)
      LLU238 = LLU235 + IOPT(3)
      LFGS   = LLU238 + IOPT(3)
      LNMSH3 = LFGS   + IOPT(3)*IGMAX
      LMESH1 = LNMSH3 + IOPT(3)
      LAST   = LMESH1
      CALL REACI1(MREC     ,IGMAX    ,IMESHT   ,IMESH1   ,IMESH2   ,
     2            IMESH3   ,A(LMTNM1),A(LIREC1),A(LNMSH1),A(LMTNM2),
     3            A(LIREC2),A(LNMSH2),A(LFG)   ,A(LNREC) ,A(LMPOI) ,
     4            A(LLU235),A(LLU238),A(LFGS)  ,A(LMESH1),LMESH2   ,
     5            A(LNMSH3),A(1)     ,LMESH3   ,LAST     ,LFINAM   ,
     5            ICVRAT   ,IRALIM   ,NOUT2    ,IOPT(1)  ,IOPT(2)  ,
     6            IOPT(3)  ,IOPT(4)                                 )
      LR1    = LAST
      LR2    = LR1 + 2*IMESH1
      LR3    = LR2 + 2*IMESH2
      LVOL   = LR3 + 8*IMESH3
      ISIZE  = LVOL + IMESHT
      IF (ISIZE.GT.IRALIM) GO TO 9000
      CALL IVALUE(A(LR1),2*IMESH1+2*IMESH2+8*IMESH3,0.0)
C
      RETURN
C
 8000 WRITE(NOUT1,6500)
      GO TO 9900
 9000 WRITE(NOUT1,6600) IRALIM,ISIZE
      GO TO 9900
 9100 WRITE(NOUT1,6800)
 9900 CONTINUE
      STOP
 6000 FORMAT(1H1/11X,'*****  INPUT DATA FOR REACTION DATA STEP  *****')
 6010 FORMAT(1H0,12X,'FLUX CALCULATION CODE IS ',A8,'. NUMBER OF MESH ',
     1       'POINTS FOR '/12X,'X,Y,Z-AXIS ARE',3I4,' .',I2,' DIMENSION'
     2      ,'AL CULATION FOR CITATION.'/12X,'NUMBER OF ENERGY GROUPS A'
     3      ,'RE',I4,'(ALL)',I4,'(FAST)',I4,'(TERMAL) .'   )
 6020 FORMAT(1H0,12X,'FLUX IS USED R-REGION FLUX IN REACTION RATIO CAL',
     1       'CULATION'                                                )
 6100 FORMAT(1H0/11X,
     1 'CASES OF NON FILTERED DETECTOR REACTION RATE  ',9('-'),I5/11X,
     2 'CASES OF     FILTERED DETECTOR REACTION RATE  ',9('-'),I5/11X,
     3 'CASES OF INTEGRATED PARAMETER OF FISSILE NUCLIDE  -----',I5)
 6110 FORMAT(1H ,10X,
CMOD 1 'CONVERSION RATIO CALCULATION OPTION (0/1)=(N/Y)  ------',I5)
     1 'CASES OF CONVERSION RATIO CALCULATION  ----------------',I5)
 6500 FORMAT(1H0,10X,'*REACTION DATA STEP* (REACIN)'/11X,
     1               'ERROR IOPT IS NEGATIVE')
 6600 FORMAT(1H0,10X,'*REACTION DATA STEP* (REACIN)'/11X,
     1               '/REACC/ LIMIT EXCEED'/11X,
     2               'ALLOCATED',I6,' WORDS,BUT NEEDS',I6,' WORDS')
 6700 FORMAT('0*** ERROR *** REACTION RATE CALCURATION OPTION SELECTED ,
     1 BUT IOPT(2) AND IOPT(12) ARE EQUAL TO ZERO OR 1. (ICODE =',I3,')'
     2 )
 6800 FORMAT('0*** ERROR *** INTEGRATED PARAMETER CALCULATION SPEC',
     *       'IFIED, '/14X,'BUT EFFECTIVE MICROSCOPIC CROSS-SECTION',
     *       'FILE WILL NOT BE CREATED IN THIS CASE.'       )
      END
