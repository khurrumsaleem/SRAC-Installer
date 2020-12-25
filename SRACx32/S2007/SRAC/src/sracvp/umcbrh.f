      SUBROUTINE UMCBRH(IEND,MTH,NPMAX,XCOLD,SCOLD,CKCOLD,SHOT,
     +                  OVPI,OVPI2,ATOP )
C
C     HIGH ENERGY DOPPLER BROADENING ROUTINE. THIS ROUTINE WILL
C     BE USED TO DOPPLER BROADEN ALL CROSS SECTIONS AT ENERGIES
C     WHERE AE/KT IS GREATER THAN 16. ANY POINT WITH A LOWER
C     ENERGY WILL ALREADY HAVE BEEN DOPPLER BROADENED BY
C     ROUTINE BROADL.
C
C     FOR AE/KT LESS THAN OR EQUAL TO 16 BOTH EXPONENTIALS IN THE
C     DOPPLER BROADENING KERNEL MUST BE CONSIDERED. FOR HIGHER ENERGIES
C     THE SECOND EXPONENTIAL MAY BE IGNORED, WHICH SIMPLIFIES THE
C     DOPPLER BROADENING.
C
C     THE ROUTINE HAS BEEN DESIGNED WITH NO SUBROUTINE CALLS
C     IN ORDER TO MINIMIZE RUNNING TIME. THE ARITHMETIC
C     STATEMENT FUNCTIONS RATION(A) AND ERFC(R,EXPERF) WILL
C     BE COMPILED AS IN LINE CODING BY VIRTUALLY ANY FORTRAN
C     COMPILER, AND AS SUCH DO NOT REPRESENT FUNCTION CALLS.
C
      INTEGER COLD1,COLD2,COLD1P,COLD2P,HOT1,HOT2,
     1        HEATME,HEATER,HIHEAT
C
      DOUBLE PRECISION A1,A2,A3,A4,A5,Y,OVPI,OVPI2,
     1                 YY,YYA,YYB,YYC,YYD,DUMMY1,DUMMY2,
     2                 DEL,R1,R2,DSAVE,F2ATOB,F4ATOB,DATOP
C
      COMMON/UMCIDX/COLD1,COLD2,COLD1P,COLD2P,HOT1,HOT2,N2IN,
     1              HEATME,HEATER,LOHEAT,HIHEAT
C
      PARAMETER   (IMAXD=1001,IMAXX=1000)
C
      REAL*8       B(IMAXD),R(IMAXD),BMY(IMAXD),BPY(IMAXD)
      REAL*8       EXBMY(IMAXD),ERFCBM(IMAXD)
      REAL*8       F2B(IMAXD),F4B(IMAXD),BB(IMAXD)
      REAL*8       SNEW(IMAXD),CKNEW(IMAXD)
C
      REAL*4       XCOLD(NPMAX),SCOLD(NPMAX),CKCOLD(NPMAX),SHOT(NPMAX)
C
C     COMPLEMENTARY ERROR FUNCTION DEFINITION.
C
      DATA A1,A2,A3,A4,A5/0.254829592D+00,-0.284496736D+00,
     1    1.421413741D+00,-1.453152027D+00,1.061405429D+00/
      DATA R1,R2/ 1.0000000D+00,3.275911D-01/
C
C     SET UP LOOP TO DOPPLER BROADEN CROSS SECTIONS.
C
CDEL  WRITE(6,6010) MTH,HEATME,IEND,COLD1P,COLD2P
 6010 FORMAT(1H ,' ## MT HEATME IEND COLD1P COLD2P (UMCBRH) ## ',6I6)
C
      NNLOW  = HEATME
      DSAVE  = 0.0
      DATOP  = DBLE(ATOP)
      CALL DCLEA(B     ,IMAXD,DSAVE)
      CALL DCLEA(BB    ,IMAXD,DSAVE)
      CALL DCLEA(R     ,IMAXD,DSAVE)
      CALL DCLEA(BMY   ,IMAXD,DSAVE)
      CALL DCLEA(BPY   ,IMAXD,DSAVE)
      CALL DCLEA(EXBMY ,IMAXD,DSAVE)
      CALL DCLEA(ERFCBM,IMAXD,DSAVE)
      CALL DCLEA(SNEW  ,IMAXD,DSAVE)
      CALL DCLEA(CKNEW ,IMAXD,DSAVE)
C
C     LOOP OF INTEGFRAL ENERGY RANGE
C
      DO 200 HEATME=NNLOW,IEND
C-----INITIALIZE INTEGRAL AND CONSTANTS.
      Y    = XCOLD(HEATME)
C-----DEFINE ALL REQUIRED CONSTANTS FOR POINT.
      YY   = Y*Y
      BB(1)= YY
      YYA  = 0.5 + YY
      YYB  = YY*(YY+3.0)+0.75
      YYC  = 2.0*(YY+1.0)
      YYD  = YY+1.5
C-----INITIALIZE INTEGRALS.
      DUMMY1= 0.0
      DUMMY2= 0.0
      F2B(1)   = YYA + OVPI2*Y
      F4B(1)   = YYB + OVPI2*Y*YYC
C*
C*    INTEGRATE OVER ALL ENERGY INTERVALS ABOVE THE CURRENT ENERGY
C*    POINT.
C*
C-----NO INTERVALS ABOVE THE LAST POINT.
      IF(HEATME.EQ.COLD2P) THEN
C-----Y IS AT UPPER END OF TABULATED RANGE. DEFINE REQUIRED EXP AND ERFC
C-----TO ALLOW CROSS SECTION EXTENSION TO INFINITY.
                           IMAX     = 1
                           EXBMY(1) = 1.0
                           ERFCBM(1)= 1.0
                           GO TO 85
                           ENDIF
C-----SET UP LOOP OVER INTERVALS ABOVE CURRENT ONE.
      IMAX    = 0
      DO 50 HEATER=HEATME,HIHEAT
      IMAX    = IMAX + 1
      IF(IMAX.GT.IMAXX) STOP 999
      B(IMAX) = XCOLD(HEATER+1)
      DEL     = B(IMAX) - Y
C-----ONLY EXTEND RANGE OF INTEGRATION UP TO DATOP UNITS ABOVE Y.
      IF(DEL.GE.DATOP) THEN
                       B  (IMAX)   =  Y + DATOP
                       BMY(IMAX)   = DATOP
                       SNEW(IMAX)  = SCOLD(HEATER)
                       CKNEW(IMAX) = CKCOLD(HEATER)
                       GO TO 55
                       ENDIF
C
      BMY(IMAX)   = DEL
      SNEW(IMAX)  = SCOLD(HEATER)
      CKNEW(IMAX) = CKCOLD(HEATER)
   50 CONTINUE
   55 CONTINUE
C
      DO   60 I = 1 , IMAX
      BB (I+1)  = B(I)*B(I)
      BPY(I)    = B(I)+Y
      R  (I)    = R1/(R1 + R2*BMY(I))
      EXBMY(I)  = DEXP(-BMY(I)*BMY(I))
   60 CONTINUE
C
      DO   70 I=1 , IMAX
      ERFCBM(I)=((((A5*R(I)+A4)*R(I)+A3)*R(I)+A2)*R(I)+A1)*R(I)*EXBMY(I)
      F2B(I+1) = YYA*ERFCBM(I) + OVPI*BPY(I)*EXBMY(I)
      F4B(I+1) = YYB*ERFCBM(I) + OVPI*(BPY(I)*(BB(I+1)+YYD)+Y)*EXBMY(I)
   70 CONTINUE
C
      DO  80 I = 1 , IMAX
      F2ATOB    = F2B(I) - F2B(I+1)
      F4ATOB    = F4B(I) - F4B(I+1)
      DUMMY1    = DUMMY1 + SNEW (I)* F2ATOB
      DUMMY2    = DUMMY2 + CKNEW(I)*(F4ATOB-BB(I)*F2ATOB)
   80 CONTINUE
      IF(BMY(IMAX).GE.DATOP) GO TO 90
C-----CONTINUE CROSS SECTION AS 1/V TO XCOLD=INFINITY.
   85 DUMMY1  = DUMMY1 +  SCOLD(COLD2P)*XCOLD(COLD2P)*
     @                  ( Y*ERFCBM(IMAX) + OVPI*EXBMY(IMAX) )
C
C-----RE-INITIALIZE INTEGRALS TO ZERO DISTANCE VALUES
C
   90 CONTINUE
      BB (1)  =  YY
      F2B(1)  = -YYA  + OVPI2*Y
      F4B(1)  = -YYB  + OVPI2*Y*YYC
C*
C*    INTEGRATE OVER ALL ENERGY INTERVALS BELOW THE CURRENT ENERGY
C*    POINT.
C*
C-----NO INTERVALS BELOW CURRENT FIRST POINT.
      IF(HEATME.EQ.COLD1P) THEN
C-----Y IS AT LOWER END OF TABULATED RANGE. DEFINE REQUIRED EXP AND ERFC
C-----TO ALLOW CROSS SECTION EXTENSION TO INFINITY.
                           IMAX     = 1
                           EXBMY(1) = 1.0
                           ERFCBM(1)= 1.0
                           GO TO 185
                           ENDIF
C-----SET UP LOOP OVER INTERVALS BELOW CURRENT POINT.
      IMAX    = 0
      HEATER  = HEATME
      DO 150 LL= LOHEAT,HEATME
      IMAX    = IMAX + 1
      IF(IMAX.GT.IMAXX) STOP 999
      HEATER  = HEATER-1
      B(IMAX) = XCOLD(HEATER)
      DEL     = Y - B(IMAX)
C-----ONLY EXTEND RANGE OF INTEGRATION UP TO DATOP UNITS ABOVE Y.
      IF(DEL.GE.DATOP) THEN
                       B  (IMAX)   = Y - DATOP
                       BMY(IMAX)   = DATOP
                       SNEW(IMAX)  = SCOLD (HEATER+1)
                       CKNEW(IMAX) = CKCOLD(HEATER)
                       GO TO 155
                       ENDIF
C
      BMY(IMAX)   = DEL
      SNEW(IMAX)  = SCOLD (HEATER+1)
      CKNEW(IMAX) = CKCOLD(HEATER)
  150 CONTINUE
  155 CONTINUE
C-----DEFINE CONSTANTS FOR THIS POINT.
      DO  160 I = 1 , IMAX
      BB (I+1)  = B(I)*B(I)
      BPY(I)    = B(I) + Y
      R  (I)    = R1/(R1 + R2*BMY(I))
      EXBMY(I)  = DEXP(-BMY(I)*BMY(I))
  160 CONTINUE
C
      DO  170 I = 1 , IMAX
      ERFCBM(I)=
     @ -((((A5*R(I)+A4)*R(I)+A3)*R(I)+A2)*R(I)+A1)*R(I)*EXBMY(I)
      F2B(I+1) = YYA*ERFCBM(I) + OVPI*BPY(I)*EXBMY(I)
      F4B(I+1) = YYB*ERFCBM(I) + OVPI*(BPY(I)*(BB(I+1)+YYD)+Y)*EXBMY(I)
  170 CONTINUE
C
      DO 180 I = 1 , IMAX
      F2ATOB    = F2B(I+1) - F2B(I)
      F4ATOB    = F4B(I+1) - F4B(I)
      DUMMY1    = DUMMY1 + SNEW (I)* F2ATOB
      DUMMY2    = DUMMY2 + CKNEW(I)*(F4ATOB-BB(I)*F2ATOB)
  180 CONTINUE
      IF(BMY(IMAX).GE.DATOP) GO TO 190
C-----CONTINUE CROSS SECTION AS 1/V TO XCOLD=0.0
  185 DUMMY1  = DUMMY1 +  SCOLD(COLD1P)*XCOLD(COLD1P)*
     @                  ( Y*ERFCBM(IMAX) - OVPI*EXBMY(IMAX) )
C-----DEFINE BROADENED CROSS SECTION.
  190 SHOT(HEATME)=0.5*(DUMMY1+DUMMY2)/YY
  200 CONTINUE
C
C     END OF PROCESS
C
      RETURN
      END
