      SUBROUTINE  IRASFX(NOUT2)
C
      COMMON /IRASX1/ ISF1(64)
C
      WRITE(NOUT2,1)  ISF1
C
    1 FORMAT(///1H ,5X,'* ADDRESS OF ARGUMENT.(IRA) *',
     &//1H ,10X,')SUFX1>'//(1H ,5X,20I6/))
C
      RETURN
      END
