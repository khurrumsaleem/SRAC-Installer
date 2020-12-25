      SUBROUTINE UCLOCK(ICPU)
C
C     CLOCK IS FACOM BUILTIN SERVICE ROUTINE TO RETURN CURRENT CPU TIME.
C     ICPU(OUTPUT)  : CURRENT USED CPU TIME (SEC) IN 4-BYTE INTEGER
C
C     GENERALLY;
C     ICPU(OUTPUT)  : CURRENT USED CPU TIME (UNIT IS DEPEND ON IC1)
C     IC1  (INPUT)  : =0(SEC.), =1(MILI-SEC.), =2(MICRO-SEC.)
C     IC2  (INPUT)  : =0(INTEGER*4), =1(REAL*4), =2(REAL*8), =3(REAL*16)
C
      IC1 = 0
      IC2 = 0
      CALL CLOCK(ICPU,IC1,IC2)
      RETURN
      END
