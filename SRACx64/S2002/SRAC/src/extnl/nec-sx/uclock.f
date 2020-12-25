      SUBROUTINE UCLOCK(ICPU)
C     for SX3(Monte-4) 
C     CLOCK IS FACOM BUILTIN SERVICE ROUTINE TO RETURN CURRENT CPU TIME.
C     ICPU(OUTPUT)  : CURRENT USED CPU TIME (SEC) IN 4-BYTE INTEGER
C
C
C     THIS ROUTINE IS REPLACED BY A CLOCK(D) WHICH IS A SX BUILTIN
C     SERVICE ROUTINE.
C
C     D : 8-BYTE REAL (SEC)
C
      REAL*8    TCPU
      INTEGER*4 ICPU
      CALL CLOCK(TCPU)
      ICPU = IDINT(TCPU)
      RETURN
      END
