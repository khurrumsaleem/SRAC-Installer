CINPT*****CITATION - COMMENTS AND DEFINITIONS FOLLOW*****
C
C***********************************************************************
C*****REAL*8 STATEMENTS ARE USED TO ACHIEVE DOUBLE PRECISION. SEE
C     COMMENTS IN SUBROUTINES KRST AND CNIO FOR CHANGES TO ALLOCATE
C     STORAGE FOR MACHINES OTHER THAN IBM-360 SERIES WHICH ALLOWS USE
C     OF 4-BYTE OR 8-BYTE WORDS.*****
C
C*****FOLLOWING ARE THE DEFINITIONS OF THE VARIABLE INTEGER
C     SUBSCRIPTS USED TO DIMENSION ADJUSTABLE DIMENSIONED VARIABLES.
C     IVX=IMAX - NUMBER OF ROWS IN THE MESH.
C     JVX=JMAX - NUMBER OF COLUMNS IN THE MESH.
C     KBVX=KBMAX - NUMBER OF PLANES IN THE MESH.
C     KVX=KMAX - NUMBER OF ENERGY GROUPS.
C     LVX=LMAX - NUMBER OF REGIONS.
C     MVX=MMAX - NUMBER OF ZONES.
C     NVX=NMAX - MAX. NUMBER OF NUCLIDES IN ANY ONE CROSS SECTION SET.
C     NSETVX=NSETMX - NUMBER OF MICROSCOPIC CROSS SECTION SETS.
C     NVO=IVO - MAXIMUM NUMBER OF SUB-ZONE DENSITIES IN ANY ONE ZONE.
C     MVZ = MAXIMUM(MVX,NSETVX + 2)
C     IVXP1 = IVX+1.
C     JVXP1 = JVX+1.
C     KBVXP1 = KBVX+1.
C     JIVX = JVX*IVX.
C     JIP1VX = JVX*IVXP1.
C     IVZ = IVX+1 FOR HEX GEOMETRY, = IVX FOR ALL OTHERS.
C     KVZ = 2*KVX FOR HEX GEOMETRY, = KVX FOR ALL OTHERS.
C     JP1IXZ = JVXP1*IVZ
C     IOVX = KVX IF NO I/O DURING ITERATION, = 1 OTHERWISE.
C     IOVZ = KVZ IF NO I/O DURING ITERATION, = 2 OTHERWISE.
C     NSPB = 0 FOR STATICS AND DEPLETION PROBLEMS,
C          = 1 FOR FIXED SOURCE PROBLEMS,
C          = 5 FOR XENON OSCILLATION ONLY,
C          = 2*(NO. DELAYED GROUPS)+5 FOR ALL OTHER DYNAMICS PROBLEMS.
C     NSPA = 1 IF NSPB=0, = NSPB OTHERWISE.
C     NCRP = IVX*JVX*KBVX IF NSPB.GT.0, = 1 OTHERWISE.*****
C     NBLOCK - UTILITY STORAGE. PRESENTLY = 2200.
C
C*****FOLLOWING ARE THE DEFINITIONS OF THE ADJUSTABLE DIMENSIONED
C     VARIABLES.
C     AC(NVX) - NUCLIDE CAPTURE RATE.
C     AL(NVX) - ABSORPTION RATE.
C     AP(NVX) - PRODUCTION RATE.
C     AX(NVX) - FISSION RATE.
C     BAL(KVX,MVX,1) - 1/V LOSSES
C             BAL IS ALSO USED IN PERT AND BEYOND FOR TEMPORARY STORAGE
C     BAL(KVX,MVX,2) - ABSORPTIONS.
C     BAL(KVX,MVX,3) - PRODUCTIONS.
C     BAL(KVX,MVX,4) - POWER(WATTS).
C     BAL(KVX,MVX,5) - OUTSCATTER.
C     BAL(KVX,MVX,6) - INSCATTER.
C     BAL(KVX,MVX,7) - BUCKLING LOSSES.
C     BAL(KVX,MVX,8) - XENON LOSSES.
C     BBND(KVX) - INTERNAL ROD BOUNDARY CONDITION CONSTANTS.
C     BIEMS(KVX) - FIXED SOURCE DISTRIBUTION FUNCTION
C     BIK(20,KVX) - AUXILIARY STORAGE.
C     BND(6,KVX) - EXTERNAL BOUNDARY CONDITION CONSTANTS.
C     B1(MVX,KVX) - ZONE AVERAGE FLUX (REAL*8)
C     B2(MVX,KVX) - ZONE ABSORPTION + BUCKLING LOSSES
C     B3(MVX,KVX) - ZONE PRODUCTIONS.
C     B4(MVX,KVX) - ZONE LOSSES TO SEARCH PARAMETER, ZONE FLUX
C     B5(MVX,KVX) - ZONE PRODUCTIONS IN SEARCH PARAMETER.
C     CM(IVO) - SUB-ZONE CONCENTRATIONS (1 ZONE).
C     CN(IVO) - SAME.
C     CO(NVX) - SMEARED CONCENTRATIONS (1 ZONE).
C     CONC(NVX,MVX) - ZONE NUCLIDE CONCENTRATIONS.
C     CP(NVX) - AVERAGE NUCLIDE CONCENTRATION OVER A TIME STEP (1 ZONE).
C     DCONB(JVX,IVXP1,IOVX) - TOP, BOTTOM DIFF. EQU. CNST. 1- AND 2-D.
C     DCONBE(JIP1VX,KBVX,IOVX) - SAME, AND SAME STORAGE EXCEPT 3-D
C     DCONBK(JIVX,KBVXP1,IOVX) - FRONT, BACK DIFF. EQU. CNST. FOR 3-D.
C     DCONR(JVXP1,IVZ,IOVZ) - LEFT,RIGHT DIFF. EQU. CNST. 1- AND 2-D.
C     DCONRE(JP1IXZ,IVBX,IOVZ) - SAME, AND SAME STORAGE EXCEPT 3-D.
C     E1(LVX,KVX) - LOSS TO SEARCH PARAMETER - EQUATION CONSTANT.
C     F1(KVX,MVX) - MACROSCOPIC INSCATTER CROSS SECTION (SCATTER TO K).
C     HOL(NVX,NSETVX,10) = H1-H6 AND A1-A4 PAGE 105-3 OF THE REPORT.
C     HOX(NVX,NSETVX,20) FISSION YIELD , DELAYED NEUTRON DATA BY NUCLIDE
C     HOY(NVX,NSETVX,20) TEMPORARY STORAGE FOR DELAYED NEUTRON DATA
C     MJJR(200,NSETVX) - NUCLIDE ORDER NUMBERS (SUBSCRIPT IS REAL NO.).
C     NCOMP(LVX) - ZONE NUMBER FOR EACH REGION.
C     NFO(20,NSETVX) - REAL NUMBER OF FIRST NUCLIDE WHICH CAUSES YIELD.
C     NIC(1000) - STORAGE OF NUCLIDES IN CHAINS FOR DEPLETION.
C     NJJR(NVX,NSETVX) - NUCLIDE REAL NUMBERS (SUBSCRIPT IS ORDER NO.).
C     NNDI1(NVX,NSETVX) = N3 PAGE 105-3 OF THE REPORT.
C     NNFO(20,NSETVX) - ODER NUMBER OF FIRST NUCLIDE CAUSING YIELD.
C     NNXTRA(NVX,NSETVX) = N5 PAGE 105-3 OF THE REPORT.
C     NRGN(JVX,IVX) - REGION NUMBER AT EACH MESH POINT, 1- AND 2-D.
C     NRGNE(JVX,IVX,KBVX) - SAME, AND SAME STORAGE EXCEPT FOR 3-D.
C     ONEOV(KVX,NSETVX) - MICROSCOPIC 1/V CROSS SECTION.
C     PTSA(JVX,IVX,IOVX)- TOTAL LOSS EQUATION CONSTANT FOR 1- AND 2-D.
C     PTSAE(JIVX,KBVX,IOVX)- SAME, AND SAME STORAGE EXCEPT FOR 3-D.
C     PVOL(LVX) - POINT VOLUME.
C     P1(JVX,IVX)     - FLUX AT ITERATION N-1 FOR 1- AND 2-D.
C     P1E(JIVX,KBVX)     - SAME ,AND SAME STORAGE FOR 3-D.
C     P2(JVX,IVX,KVX) - FLUX FOR 1- AND 2-D (REAL*8).
C     P2E(JIVX,KBVX,KVX) - SAME, AND SAME STORAGE EXCEPT 3-D (REAL*4).
C     QMI(MVX,10) - AUXILIARY STORAGE.
C     RATAT(NBLOCK) - UTILITY STORAGE.
C     RATE(NVX,MVX,1) - NUCLIDE, ZONE ABSORPTIONS.
C     RATE(NVX,MVX,2) - CAPTURES.
C     RATE(NVX,MVX,3) - PRODUCTIONS.
C     RATE(NVX,MVX,4) - AMOUNT (KG.).
C     RATE(NVX,MVX,5) - ETA.
C     RATE(NVX,MVX,6) - FISSIONS.
C     RATE(NVX,MVX,7) - AUXILIARY STORAGE.
C     RATE(NVX,MVX,8) - AUXILIARY STORAGE.
C     RATE(NVX,MVX,9) - AUXILIARY STORAGE.
C     RATE(NVX,MVX,10) - AUXILIARY STORAGE.
C     RATET(NVX,1) - TOTAL NUCLIDE ABSORPTIONS.
C     RATET(NVX,2) - CAPTURES.
C     RATET(NVX,3) - PRODUCTIONS.
C     RATET(NVX,4) - AMOUNT (KG.).
C     RATET(NVX,5) - ETA.
C     RATET(NVX,6) - FISSIONS.
C     RVOL(LVX) - REGION VOLUME*****.
C     SCAC(MAX((KVX,MVX,KVX),(KVX,NSETVX+2,KVX)))-INSCAT.EQU.CNST(KKTOK)
C     SCAT(JVX,IVX) - INSCATTER SOURCE FOR 1- AND 2-D (REAL*8).
C     SCATE(JVX,IVX,KBVX) - SAME, AND SAME STORAGE EXCEPT 3-D (REAL*4).
C     SIG(KVX,MVX,1) - MACROSCOPIC DIFFUSION COEFFICIENT.
C     SIG(KVX,MVX,2) - MACROSCOPIC REMOVAL CROSS SECTION.
C     SIG(KVX,MVX,3) - MACROSCOPIC ABSORPTION CROSS SECTION.
C     SIG(KVX,MVX,4) - MACROSCOPIC NU*(FISSION CROSS SECTION).
C     SIG(KVX,MVX,5) - MACRO. ABSORP. CROSS SECTION OF SEARCH NUCLIDES.
C     SIG(KVX,MVX,6) - BUCKLING (B**2)
C     SIG(KVX,MVX,7) - POWER PER UNIT FLUX.
C     SIG(KVX,MVX,8) - MACRO. NU*SIGF CROSS SECTION OF SEARCH NUCLIDES.
C     SIG(KVX,MVX,9) - DIFFUSION COEFFICIENT * BUCKLING (D*B**2)
C     SIG(KVX,MVX,10) -  SIGA + SIGR + D*B**2
C     SIG(KVX,MVX,11) - ANISOTROPIC DIFFUSION COEFFICIENT Y-AXIS
C     SIG(KVX,MVX,12) - ANISOTROPIC DIFFUSION COEFFICIENT Z-AXIS
C     SIG(KVX,MVX,13) - 1/V CROSS SECTION FOR NEUTRON DENSITY EDIT
C     SOUR(JVX,IVX) - FISSION SOURCE FOR 1- AND 2-D (REAL*8 ON IBM-360).
C     SOURE(JVX,IVX,KBVX) - SAME, AND SAME STORAGE EXCEPT 3-D (REAL*4).
C     SPAR(NCRP,NSPA) - FIXED SOURCE BY POINT
C     SSC(KVX,KVX) - MICRO. INSCATTER CROSS SECTION (TO K FROM KK).
C     SS1(KVX,NVX,NSETVX) - MICROSCOPIC ABSORPTION CROSS SECTION.
C     SS2(KVX,NVX,NSETVX) - MICROSCOPIC FISSION CROSS SECTION.
C     SS3(KVX,NVX,NSETVX) - MICROSCOPIC TRANSPORT CROSS SECTION.
C     SS4(KVX,NVX,NSETVX) - NU, NEUTRONS PER FISSION
C     SS5(KVX,NVX,NSETVX) - MICRO. SCATTER CROSS SECTION FROM K TO K+1.
C     UTIL(JVX,IVX)     - AUXILLIARY STORAGE FOR 1- AND 2-D.
C     UTILE(JIVX,KBVX)     - SAME ,AND SAME STORAGE EXCEPT FOR 3-D.
C     XI(KVX,MVX) - FISSION DISTRIBUTION FUNCTION.
C     XII(KVX,MVX) - XI(K)/(MULTIPLICATION FACTOR) (REAL*8).
C     XIK(KVX) - AUXILIARY STORAGE.
C     XIKP(KVX) - AUXILIARY STORAGE.
C     XL(6,KVX) - EXTERNAL BOUNDARY LEAKAGE.
C     YD(IVO) - YIELD RATE.
C     ZONEN(NVO) - SUB-ZONE CONCENTRATIONS (ONE ZONE AT A TIME).
C           STARTING ADDRESSES OF PRINCIPAL VARIABLES IN THE -A- ARRAY
C
C  K1     SS1, HOY                  K2     SS2
C  K3     SS3                       K4     SS4
C  K5     SS5                       K6     SSC
C  K7     ONEOV                     K8     HOL
C  K9     NJJR                      K10    MJJR
C  K11                              K12    NNDI1
C  K13    NNXTRA                    K14    SIG
C  K15    F1                        K16    XI
C  K17    CONC                      K18    ZONEN
C  K19    SOUR, SOURE, RATE         K20    SCAT, SCATE
C  K21    B1                        K22
C  K23    SCAC                      K24    P2, P2E
C  K25                              K26
C  K27                              K28
C  K29    E1                        K30    HOX
C  K31    NFO                       K32    NNFO
C  K33    NIC                       K34    AC
C  K35                              K36    B2
C  K37    B3                        K38    B4
C  K39    B5                        K40 = K63  BAL
C  K41    P1, P1E, UTIL, UTILE      K42    (DUMMY OF UNIT LENGTH)
C  K43    RATET                     K44    QMI
C  K45    BIEMS                     K46    XIK
C  K47    XIKP                      K48    BIK
C  K49    XII                       K50    BBND
C  K51    BND                       K52    XL
C  K53                              K54    AL
C  K55    AX                        K56    AP
C  K57    CP                        K58    CO
C  K59    CN                        K60    CM
C  K61    YD                        K62    SPAR
C  K63    PTSA, PTSAE               K64    DCONR, DCONRE
C  K65    DCONB, DCONBE             K66    DCONBK
C  K67 = K63  RATAT                 K68    (DUMMY OF UNIT LENGTH)
C  K69                              K70
C  KNRGN  NRGN, NRGNE               KNCOMP NCOMP
C  KPVOL  PVOL                      KRVOL  RVOL
C
C        ORDER OF STORAGE
C
C   K1 K2 K3 K4 K5 K6 K7 K8 K9 K10 K11 K12 K13 K14 K15 K16 K17 K18 K38
C
C   K39 K19 K20 K23 K24 K41
C       K30 K31 K32 K33 K34 K54 K55 K56 K57 K58 K59 K60 K61 (OVERLAID)
C
C   K42 K43 -THRU- K51 K52 K62 K64 K65 K66 K63 K21 K29 K36 K37 K68
C                                          K40 (OVERLAID)
C                                          K67 (OVERLAID)
C
C   KNRGN KNCOMP KPVOL KRVOL
C
C
C*****FOLLOWING ARE THE DEFINITIONS OF SOME OF THE FIXED DIMENSIONED
C     VARIABLES IN NAMED COMMONS.
C     AVZPD(200) - ZONE AVERAGE POWER DENSITY.
C     NCH(50) - LOCATION OF CHAIN DATA IN NIC(SEE BELOW).
C     NCLASS(200) - CLASS.
C     NJJM(50) - FIRST NUC. IN SET THAT HAS FISSION YIELD.
C     NJM(50) - NUMBER OF NUCLIDES.
C     NJNQ(50) - NUMBER OF FISSILE NUCLIDES WHICH CAUSE FISSION.
C     NSIG1(50) - TYPE OF DATA.
C     NSIG2(50) - NUMBER OF NUCLIDES.
C     NSIG3(50) - NUMBER OF GROUPS.
C     NSIG4(50) - NUMBER OF GROUPS FOR DOWNSCATTER.
C     NSIG5(50) - NUMBER OF GROUPS FOR UPSCATTER.
C     NSIG6(50) - NUMBER OF GROUPS WHICH CAN SCATTER TO GROUP 1.
C     NXODR(200) - MICROSCOPIC CROSS SECTION SET ODER NUMBER.
C     NXSET(200) - REAL MICROSCOPIC CROSS SECTION SET NUMBER.
C     NZON(200) - NUMBER OF SUB-ZONES FOR EACH ZONE.
C     PDKB(211) - POWER DENSITY TRAVERSE FORE AND AFT.
C     PDI(211) - POWER DENSITY TRAVERSE ALONG ROWS.
C     PDJ(211) - POWER DENSITY TRAVERSE ALONG COLUMNS.
C     X(211) - DISTANCE TO FLUX POINTS, LEFT TO RIGHT.
C     XNAME(3,200) - NAME.
C     XX(211) - DISTANCE TO INTERVAL INTERFACES, LEFT TO RIGHT.
C     Y(211) - DISTANCE TO FLUX POINTS, TOP TO BOTTOM.
C     YY(211) - DISTANCE TO INTERVAL INTERFACES, TOP TO BOTTOM.
C     ZONVOL(200) - ZONE VOLUME.
C     Z(211) - DISTANCE TO FLUX POINTS, FRONT TO BACK.
C     ZZ(211) - DISTANCE TO INTERVAL INTERFACES, FRONT TO BACK.
C***********************************************************************
C
C     IX(  1)      1 IF IBM-360/75, 5 IF IBM-360/91
C     IX(  2)      NUMBER OF DEPLETION TIME STEPS
C     IX(  3)      NUMBER OF CYCLES (FUELINGS)
C     IX(  4)      END OF CYCLE INDICATOR
C     IX(  5)      INDICATES TYPE OF SEARCH IN NEUTRONICS
C     IX(  6)      BEHAVIOR OF SEARCH PROBLEM, DIVERGING IF .GT.0
C     IX(  7)      IF .GT.0 INDICATES NUMBER OF REGIONS CHANGED FROM
C                      PREVIOUS CASE
C     IX(  8)      REPEAT CYCLE INDEX
C     IX(  9)      REPEAT TIME STEP INDEX
C     IX( 10)      POINT IN MESH FOR CHECKING ITERATIVE BEHAVIOR (I)
C     IX( 11)      POINT IN MESH FOR CHECKING ITERATIVE BEHAVIOR (J)
C     IX( 12)      POINT IN MESH FOR CHECKING ITERATIVE BEHAVIOR (KB)
C     IX( 13)      POINT IN MESH FOR CHECKING ITERATIVE BEHAVIOR (GROUP)
C     IX( 14)      COUNT ON NEUTRONICS PROBLEM
C     IX( 15)      EXTRAPOLATION IN TIME, SEE IEXTRP IN BURN
C     IX( 16)      INDICATES AN INITIALIZATION PROBLEM IS DONE 1ST CYCLE
C     IX( 17)      TYPE OF SEARCH PREVIOUS PROBLEM
C     IX( 18)      NUMBER OF DELAYED NEUTRON FAMILIES
C     IX( 19)      CYCLE NUMBER FROM RESTART TAPE
C     IX( 20)      1 EXCEPT NUMBER OF GROUPS WITH I/O OF CONSTANTS
C     IX( 21)      INDICATOR ON UPDATE OF MACRO DATA IN NEUTRONICS
C     IX( 22)      POINT FLUXES NOT ON RESTART TAPE IF .GT.0
C     IX( 23)      REQUESTS ADJOINT NEUTRONICS FOLLOWING REGULAR PROBLEM
C     IX( 24)      0- REGULAR, 1- ADJOINT NEUTRONICS BEING DONE
C     IX( 25)      1, 2, 3, INDICATING GEOMETRIC DIMENSIONS
C     IX( 26)      VALUE OF NUAC(5) GEOMETRY OPTION
C     IX( 27)      A SUCCEEDING CASE IF .GT.0
C     IX( 28)      NUMBER OF DOWN-SCATTER GROUPS
C     IX( 29)      NUMBER OF UP-SCATTER GROUPS
C     IX( 30)      TYPE OF CROSS SECTION DATA PROVIDED
C     IX( 31)      BOUNDARY CONDITIONS SUPPLIED IF .GT.0
C     IX( 32)      FLUX WAS EXTRAPOLATED IN NEUTRONICS IF .GT.0
C     IX( 33)      OVERRELAXATION FACTOR WAS REDUCED IF .GT.0
C     IX( 34)      COUNT OF THE NUMBER OF SETS OF REGIONS IN CLASS INPUT
C     IX( 35)      NEUTRONICS FLUX EXTRAPOLATION CYCLE
C     IX( 36)      GROUPS UP-SCATTER TO THE FIRST
C     IX( 37)      I/O INDICATOR BLOCK A(IX37) - A(IX38) IF .GT.0
C     IX( 38)      I/O INDICATOR BLOCK A(IX37) - A(IX38) IF .GT.0
C     IX( 39)      FORCES CONSTANT POINT FLUX INITIALIZATION IF .GT.0
C                      EXCEPT ON RESTART
C     IX( 40)      INDICATOR ON I/O DEVICE DATA (WRITE F1 IF .EQ.0)
C     IX( 41)      LAST TIME STEP IN CYCLE IF .GT.0
C     IX( 42)      NUCLIDE INDEX IN PERTURBATION ROUTINE PURT
C     IX( 43)      GROUP INDEX IN PERTURBATION ROUTINE PURT
C     IX( 44)      SEARCH DATA FLAG (NSRH(4))
C     IX( 45)      SEARCH DATA FLAG (NSRH(5))
C     IX( 46)      SEARCH DATA FLAG (NSRH(6))
C     IX( 47)      SEARCH DATA FLAG (NSRH(7))
C     IX( 48)      SEARCH DATA FLAG (NSRH(8))
C     IX( 49)      SEARCH DATA FLAG (NSRH(9))
C     IX( 50)      FUEL MANAGEMENT EDIT FLAG (SEE THOSE ROUTINES)
C     IX( 51)      FIRST ENTRY IN FISSLE TABLE
C     IX( 52)      FINAL ENTRY IN FISSLE TABLE
C     IX( 53)      FIRST ENTRY IN FERTILE TABLE
C     IX( 54)      FINAL ENTRY IN FERTILE TABLE
C     IX( 55)      FIRST ENTRY IN INTERMEDIATE TABLE
C     IX( 56)      FINAL ENTRY IN INTERMEDIATE TABLE
C     IX( 57)      FIRST ENTRY IN (OTHER) TABLE
C     IX( 58)      FINAL ENTRY IN (OTHER) TABLE
C     IX( 59)      FIRST ENTRY IN STRUCTURAL TABLE
C     IX( 60)      FINAL ENTRY IN STRUCTURAL TABLE
C     IX( 61)      FIRST ENTRY IN SPECIAL TABLE
C     IX( 62)      FINAL ENTRY IN SPECIAL TABLE
C     IX( 63)      FIRST ENTRY IN FISSION PRODUCT TABLE
C     IX( 64)      FINAL ENTRY IN FISSION PRODUCT TABLE
C     IX( 68)      GEOMETRY OPTION FROM PRECEEDING CASE
C     IX( 69)      DATA FROM PRECEEDING CASE (NGC(19))
C     IX( 70)      INDIRECT SEARCH PROBLEM BEHAVIOR FLAG STOP IF .NE.0
C     IX( 71)      INDICATES ADJOINT PROBLEM WITH I/O OF CONSTANTS
C                  IF .GT. 0
C     IX( 72)      SPECIAL BOUNDARY CONDITIONS IF .GT.0
C     IX( 73)      COUNTER ON ITERATIONS FOR INDIRECT SEARCH
C     IX( 74)      INDICATOR ON CALCULATION OF SEARCH PROBLEM EIGENVALUE
C     IX( 75)      INDIRECT SEARCH ITERATION CONVERGED IF .GT.0
C     IX( 76)      SECTION 002 INPUT WITH RESTART IF .GT.0
C     IX( 77)      I/O DEVICE (10)
C     IX( 78)      I/O DEVICE (11)
C     IX( 79)      I/O DEVICE (12)
C     IX( 80)      I/O DEVICE (13)
C     IX( 81)      I/O DEVICE (14)
C     IX( 82)      I/O DEVICE (15)
C     IX( 83)      I/O DEVICE (16)
C     IX( 84)      I/O DEVICE (17)
C     IX( 85)      I/O DEVICE (18)
C     IX( 86)      I/O DEVICE (19)
C     IX( 87)      I/O DEVICE (20)
C     IX( 88)      I/O DEVICE (21)
C     IX( 89)      I/O DEVICE (22)
C     IX( 90)      I/O DEVICE (23)
C     IX( 91)      I/O DEVICE (24)
C     IX( 92)      I/O DEVICE (25)
C     IX( 93)      I/O DEVICE (26)
C     IX( 94)      I/O DEVICE (27)
C     IX( 95)      I/O DEVICE (28)
C     IX( 96)      I/O DEVICE (29)
C     IX( 97)      I/O DEVICE (30)
C     IX( 98)      CALCULATE THERMAL ENERGY IF .GT.0 FOR EDIT
C     IX( 99)      CALCULATING END-OF-CYCLE NEUTRONICS IF .GT.0
C     IX(101)-IX(124)   EDIT OPTIONS, SEE INPUT IEDG AND IXPUT
C     IX(126)      INDIRECT SEARCH NOT CONVERGING IF .GT.0
C     IX(127)      REFERENCE CLOCK TIME FOR INDIRECT SEARCH
C     IX(128)      SPECIAL TYPE OF DIRECT SEARCH PROBLEM
C     IX(129)      NUCLIDE CONCENTRATIONS UPDATED RECENTLY IF .GT.0
C     IX(130)      INDICATES INDIRECT SEARCH USING PREVIOUS ESTIMATE
C                  OF N-DK/DN IF .GT. 0
C     IX(131)      INDICATES SECTION 026 WAS INPUT IF .GT.0
C     IX(132)      INDICATES FIXED SOURCE IS TO BE SUPPLIED FROM I/O
C                  DEVICE IF .GT. 0
C     IX(133)      RESERVED
C     IX(134)      INDICATES FLUX HAS BEEN SCALED BY 1.0E+30 OR
C                  1.0E-30 IF .GT. 0
C     IX(135)      INDICATES FLUX TO BE WRITTEN FOR POSSIBLE
C                  EXTRAPOLATION IF .GT. 0
C     IX(136)      INDICATES MACROSCOPIC CROSS SECTIONS WERE INPUT
C                  FROM TAPE OR DISK
C     IX(137)      I/O DEVICE (31)
C     IX(138)      I/O DEVICE (32)
C     IX(139)      I/O DEVICE (33)
C     IX(140)      I/O DEVICE (34)
C     IX(141)      I/O DEVICE (35)
C     IX(142)      INDICATES SECTION 030 SUPPLIED IF GT 0
C     IX(150)      INDICATOR FOR PUNCHING OR COLLSP. MACROS.
C     IX(151)      INDICATES IF SECTION 038 HAS BEEN INPUT
C     IX(152)      SAVE NFLXA
C     IX(153)      SAVE NFLXB
C     IX(160)      RESTART DATA (ISK)
C     IX(161)      RESTART DATA (IEXR)
C     IX(162)      RESTART DATA (NI3)
C     IX(163)      RESTART DATA (IC10)
C     IX(164)      RESTART DATA (IC20)
C     IX(165)      NUCLIDE REFERENCE FOR DAMAGE RATE MAP
C     IX(166)      CROSS SECTION CORRELATION IF .GT.0, SUBZONES IF 2
C     IX(167)      INDICATES THAT ONLY INPUT SECTION 000 WAS USAD
C     IX(168)      MAXIMUM NUMBER OF SUBZONES IN A ZONE
C     IX(169)      SET TO K64 IN CNIO, USAE IN KNST
C     IX(170)      SET TO K21-1 IN CNIO, USED IN KNST
C     IX(171)      SET TO INTGR(29) IN CALR, USED IN CALR
C     IX(172)      INDICATES IF READING FLUXES FROM PREVIOUS CYCLE
C     IX(190)      INPUT ROUTINES COMMUNICATION (NUO)
C     IX(191)      INPUT ROUTINES COMMUNICATION (NHEX)
C     IX(192)      INPUT ROUTINES COMMUNICATION (NRVX)
C     IX(193)      INPUT ROUTINES COMMUNICATION (IJKBX)
C     IX(196)      RESTART INDICATOR ON VARIABLES (IND)
C     IX(197)      RESTART INDICATOR ON VARIABLES (IBCUT)
C     IX(198)      RESTART INDICATOR ON VARIABLES (NTITE)
C     IX(199)      INDICATOR OF SUBZONE TREATMENT REQUIRING I/O IF GT.0
C     IX(200)      WE SUSPECT SOME CAD IS PLAYING WITH THIS
C
C     SPARE(  1)        CYCLE DEPLETION (EXPOSURE) TIME, SEC (CYED)
C     SPARE(  2)        CYCLE DEPLETION (EXPOSURE) TIME, DAYS (BURN)
C     SPARE(  3)        EXPOSURE TIME INTERVAL, 1ST STEP 1ST CYCLE, DAYS
C     SPARE(  4)        EXPOSURE TIME INTERVAL, 2ND STEP 1ST CYCLE, DAYS
C     SPARE(  5)        EXPOSURE TIME INTERVAL, 3RD+ STEP CYCLE 1, DAYS
C     SPARE(  6)        EXPOSURE TIME INTERVAL, 2ND STEP CYCLE 2+, DAYS
C     SPARE(  7)        EXPOSURE TIME INTERVAL, 3RD+ STEP CYCLE 2+, DAYS
C     SPARE(  8)        EXPOSURE TIME INTERVAL, 3RD+ STEP CYCLE 2+, DAYS
C     SPARE(  9)        CURRENT EXPOSURE TIME STEP, SEC (CYED)
C     SPARE( 10)        PREVIOUS EXPOSURE TIME STEP, SEC (CYED)
C     SPARE( 11)        BEFORE PREVIOUS EXPOSURE TIME STEP, SEC (CYED)
C     SPARE( 12)        TOTAL DEPLETION TIME, DAYS    (DTOR)
C     SPARE( 13)        CYCLE DEPLETION TIME START EXPOSURE, DAYS (BURN)
C     SPARE( 14)        REFERENCE MULTIPLICATION FACTOR (MAIN)
C     SPARE( 15)        PRESENT MULTIPLICATION FACTOR (CYED)
C     SPARE( 16)        PREVIOUS MULTIPLICATION FACTOR (CYED)
C     SPARE( 17)        BEFORE PREVIOUS MULTIPLICATION FACTOR (CYED)
C     SPARE( 18)        NEUTRONICS EIGENVALUE (NMBL)
C     SPARE( 19)        TIME STEP THERMAL ENERGY, MW-HRS (TABL)
C     SPARE( 20)        SPARE(  3) IN SEC, ACTIVE
C     SPARE( 21)        SPARE(  4) IN SEC, ACTIVE
C     SPARE( 22)        SPARE(  5) IN SEC, ACTIVE
C     SPARE( 23)        SPARE(  6) IN SEC, ACTIVE
C     SPARE( 24)        SPARE(  7) IN SEC, ACTIVE
C     SPARE( 25)        SPARE(  8) IN SEC, ACTIVE
C     SPARE( 26)        CYCLE THERMAL ENERGY, CURRENT SUM, MW-HRS
C     SPARE( 27)        NEUTRONICS EIGENVALUE FOR RECOVERY (NMBL)
C     SPARE( 28)        SEARCH PROBLEM EIGENVALUE
C     SPARE( 29)        RUNNING PRODUCT OF SPARE( 29) , EIGENVALUE SUM
C     SPARE( 31)        ERROR MODE EIGENVALUE, FLUX INCREASING
C     SPARE( 32)        ERROR MODE EIGENVALUE, FLUX DECREASING
C     SPARE( 33)        POINT FLUX CHANGE
C     SPARE( 34)        FLUX EXTRAPOLATION FACTOR
C     SPARE( 35)        FLUX EXTRAPOLATION FACTOR AT A REFERENCE POINT
C     SPARE( 39)        THIRD DIMENSION OVERRELAXATION FACTOR
C     SPARE( 40)        REFERENCE INFORMATION FOR FLUX EXTRAPOLATION
C     SPARE( 43)        POINT FLUX EXTRAPOLATION FACTOR, PAST ESTIMATE
C     SPARE( 44)        REFERENCE POINT FLUX VALUE, PREVIOUS ITERATION
C     SPARE( 44)        REFERENCE POINT FLUX DATA, LAST ITERATION
C     SPARE( 45)        REFERENCE POINT FLUX DATA, BEFORE LAST ITERATION
C     SPARE( 46)        DAMPENING FACTOR FOR SEARCH PROCEDURE
C     SPARE( 48)        NEUTRON ABSORPTIONS IN SEARCH MAYERIAL
C     SPARE( 49)        NEUTRON PRODUCTIONS BY SEARCH MATERIAL
C     SPARE( 50)        REFERENCE MULTIPLICATION FACTOR FOR SEARCH
C     SPARE( 51)        LIMITING VALUE SEARCH PROBLEM EIGENVALUE
C     SPARE( 52)        FRACTION LOSS RATE TO SEARCH MATERIAL
C     SPARE( 53)        FRACTION LOSS RATE TO SEARCH MATERIAL, N
C     SPARE( 54)        FRACTION LOSS RATE TO SEARCH MATERIAL, N-1
C     SPARE( 55)        FRACTION LOSS RATE TO SEARCH MATERIAL, N-2
C     SPARE( 56)        TOTAL NEUTRON LOSSES
C     SPARE( 56)        REFERENCE FRACTION SEARCH LOSSES
C     SPARE( 57)        REFERENCE FRACTION SEARCH LOSSES
C     SPARE( 58)        MAXIMUM SEARCH NUCLIDE DENSITY
C     SPARE( 60)        SEARCH PROBLEM EIGENVALUE (DISH)
C     SPARE( 61)        SEARCH PROBLEM DATA
C     SPARE( 62)        SEARCH PROBLEM DATA
C     SPARE( 63)        SEARCH PROBLEM DATA
C     SPARE( 64)        SEARCH PROBLEM DATA
C     SPARE( 65)        SEARCH PROBLEM DATA
C     SPARE( 74)        REFERENCE EDIT TIME FOR REACTION RATES, DAYS
C     SPARE( 75)        REFERENCE EDIT TIME FOR MASS DATA, DAYS
C     SPARE( 87)        FIXED SOURCE FRACTION, AS DELAYED NEUTRONS
C     SPARE( 88)        SUM OF FIXED SOURCE
C     SPARE( 89)        SCALING FACTOR FOR FIXED SOURCE PROBLEM
C     SPARE( 91)        REFERENCE PERTURBATION DATA (POUT, KOUT)
C     SPARE( 94)        RESERVED BY A LOCAL USER
C     SPARE( 95)        RESERVED BY A LOCAL USER
C     SPARE( 96)        RESERVED BY A LOCAL USER
C     SPARE( 97)        RESERVED BY A LOCAL USER
C     SPARE( 98)        ZONE FACTOR SUM (SIG(K,M,8) IN CNST,KNST)
C     SPARE( 99)        POWER LEVEL FOR NEUTRONICS PROBLEM, FISSION MW
C     SPARE(100)        POWER LEVEL FOR REACTOR, THERMAL MW
C     SPARE(160)        RESTART DATA (VOG1 IN EXTR)
C     SPARE(161)        RESTART DATA (RP(1) IN EXTR)
C     SPARE(162)        RESTART DATA (RP(2) IN EXTR)
C     SPARE(163)        RESTART DATA (RP(3) IN EXTR)
C     SPARE(164)        RESTART DATA (RP(4) IN EXTR)
C     SPARE(165)        RESTART DATA (RP(5) IN EXTR)
C     SPARE(166)        RESTART DATA (RP(6) IN EXTR)
C     SPARE(167)        RESTART DATA (RP(7) IN EXTR)
C     SPARE(168)        RESTART DATA (RP(8) IN EXTR)
C     SPARE(169)        RESTART DATA (RP(9) IN EXTR)
C     SPARE(170)        RESTART DATA (RP(10) IN EXTR)
      FUNCTION AHO(A)
      REAL*8 AHO ,A
      AHO = A
      RETURN
      END
