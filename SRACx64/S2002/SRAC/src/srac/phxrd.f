      SUBROUTINE PHXRD(M,IGMAX,PHXVX,VX)
C
C     READ "PHXVX" & "VX" FROM MICRO CROSS-SECTION DATA FILE
C
      DIMENSION PHXVX(IGMAX)
CDELETE
C     LSIGS=52
C     REWIND LSIGS
C     DO 10 I=1,M
C         READ(LSIGS)
C  10 CONTINUE
C     READ(LSIGS) (PHXVX(I),I=1,IGMAX),VX
CEND
      VX       = 0.0
      DO 20  I = 1 , IGMAX
      PHXVX(I) = 0.0
   20 CONTINUE
C
      RETURN
      END
