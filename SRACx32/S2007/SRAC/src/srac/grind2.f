C             GRIND2              LEVEL=1        DATE=81.11.14
      SUBROUTINE GRIND2
C
      COMMON /TW1C/ DD(1),LIM1,IA(210)
      COMMON /WORK/AAA(1),LIM2,AA(130)
      DIMENSION D(212),A(132)
      EQUIVALENCE (D(1),DD(1)),(AAA(1),A(1))
      EQUIVALENCE (D(150),IEDOPS),(D(107),IGCDMP),(D(152),JFISC),
     &(D(151),NEXTER),(D(136),TIMSLD)
C
C     EQUIVALENCE
C
      EQUIVALENCE (A(97),LSIN),(A(106),LBAL),(A(8),JCONV),(A(19),ALAR),
     &(A(24),NGOTO),(A(28),ALA),(A(29),TIN),(A(30),FTP)
C     INITIALIZE STARTING TIME
      TIN=TIMSLD
C
C     CHECK GROUP RESTART INDICATOR
C
      IF (IGCDMP.NE.0) GO TO 120
C
C     CALCULATE INITIALLY REQUIRED FUNCTIONS
C
  100 CONTINUE
      JFISC=1
  110 CONTINUE
      CALL GRID21
      IF (NEXTER.NE.0) GO TO 140
      IF (JFISC.EQ.2) GO TO 130
C
C     PRINT MONITOR LINE
C
CK120 CALL MONITR (A(LBAL))
  120 CALL MONITR (AAA(LBAL))
C
C     CHECK DIRECT EXIT TO FINAL PRINT AND EDIT
C
      IF ((IGCDMP.NE.0).AND.(IEDOPS.LT.0)) GO TO 140
C
C     BEGIN OUTER ITERATION
C
      CALL GRID22
C
C     CHECK TIME LIMIT DUMP FOR FINAL PRINT EXIT
C
      IF (IGCDMP.NE.0) GO TO 140
C
C     STORE FTP FOR USE IN FISCAL
C
CKSK  FTP=A(LSIN-1)
      FTP=AAA(LSIN-1)
      ALAR=ALA
C
C     RECOMPUTE FISSION SOURCE
C
      JFISC=2
      GO TO 110
C
C     ****RETURNS TO GRIND23****
C
C     COMPUTE CONVERGENCE NUMBERS AND NEW PARAMETERS
C
  130 CONTINUE
      CALL GRID23
      IF (JCONV.GT.0) GO TO 120
C
C     EXIT 1 IS FINAL PRINT
C     EXIT 2 IS ANOTHER OUTER ITERATION (MONITR)
C     EXIT 3 IS FOR EIGENVALUE SEARCH (INITAL)
C
      GO TO (140,120,100), NGOTO
  140 CONTINUE
      RETURN
      END
