C***********************************************************************
      SUBROUTINE            SRAC
C***********************************************************************
C     CONTROL ROUTINE OF SRAC CALLED BY MAIN (DIMENSION CONTROLLER)
C
CMOD  PARAMETER   ( MXNISO = 110 , MAXNG = 107  , MAXMT3 = 6 )
CMOD  PARAMETER   ( MAXMAT =  30 , MXLISO= 5000 )
CMOD  PARAMETER   ( MXMESH = 200 ) 
      INCLUDE  'BMICRINC'
      INCLUDE  'MATDTINC'
      INCLUDE  'PIJPMINC'
C
      PARAMETER   ( MXCOMC  = 9*MAXMAT +  6*MXLISO )
C
      COMMON /MAINC/ IOPT(20),JNFSTL   ,FNFSTL   ,JNTHEL   ,FNTHEL
     1   ,JNEFST   ,FNEFST   ,JNETHE   ,FNETHE   ,IUPSCT   ,IBSPCT
     2   ,ISCT     ,IFIXS    ,ICTOT    ,ICOND    ,IP1C     ,IFF1
     2   ,LCXIWT   ,IBKSCH   ,MXINP2   ,IDUM45(5)
     3   ,NEFL     ,NETL     ,NEF      ,NET      ,NERF     ,NERT
     4   ,NMAT     ,NETL1    ,BSQ      ,NIN1     ,NIN2     ,NOUT1
     5   ,NOUT2    ,IT0      ,NEFL1    ,NEFL2    ,NEFL3    ,NEF1
     6   ,NEF2     ,NEF3     ,ISTP     ,NSOUC    ,NFIN     ,NFOUT
     7   ,ITYPE    ,IMCEF    ,IBNSTP   ,MEMFST
     8   ,LCNEGF   ,LCNEGT   ,LCNECF   ,LCNECT   ,LCMTNM   ,LCNISO
     9   ,LCTEMP   ,LCXL     ,LCXCDC   ,LCLISO   ,LCIDNT   ,LCDN
     A   ,LCIRES   ,LCIXMC   ,NFTOT    ,MEMORY   ,IOPEN    ,IRANG
     B   ,ICF      ,INITL
     C   ,CASEID(2),TITLE(18)
     D   ,II(MXCOMC)
      CHARACTER*8       JNFSTL,FNFSTL,JNTHEL,FNTHEL
     1                 ,JNEFST,FNEFST,JNETHE,FNETHE
      COMMON /WORK/ ZZZZ(60000)
      COMMON /TUD1C/ NRT,NMPT,NGT,NGST,NGKT,NNT,DUMT(22),NXRT,LCIK,
     1              LCNK,LCXR,LCRK,LCNNR,LCVOLT,LCMTM,LCMTR,LCVLMT
     *              ,DUMTT(12),IIT(500)
      COMMON /CIT1C/ NMC,NXRC,IDC,IRN,LCNMC,LCNXRC,LCMACC,LCVOLC,
     *               LIMCIT,LCVLMC,IDMCIT(9),ICT(3000)
      DIMENSION CCC(3000)
      EQUIVALENCE(ICT,CCC)
C
CMOD  COMMON /BURNC1/ NEP,IBEND
      COMMON /BURNC1/ IBC(20),NEP,NEP1,IBREST,IBCOLP,NGBN,NGTBN,
     1                IMAXBN,LAPSBN,IBEND
C *** COLLISION PROBABILITY
      COMMON /PIJ2C/ PIJ(50),PAA(950)
      EQUIVALENCE (NR,PIJ(3)),(NRR,PIJ(4)),(NXR,PIJ(5)),(IDRECT,PIJ(7))
     * ,(NMP,PIJ(33)),(LCMMR,PIJ(40))
     * ,(LCNREG,PIJ(41)),(LCIRR,PIJ(42)),(LCIXR,PIJ(43))
     * ,(LCMAR,PIJ(44)),(LCMAT,PIJ(45)),(LCVOL,PIJ(46)),(LCVOLR,PIJ(47))
     * ,(LCVOLX,PIJ(48)),(LCMATD,PIJ(50)),(LCVOLM,PIJ(49))
CKSK  DIMENSION IPAA(100)
      DIMENSION IPAA(MXMESH)
C     IPAA CONTAINS ASCENDING NUMBER STARTING FROM 1;
C     LIMIT OF NUMBER OF R-REGION IS MXMESH IN COLLISION PROB. MET.
C *** ANISN
      COMMON /SN1C/ISA(1000)
      EQUIVALENCE (IM,ISA(37)),(IZM,ISA(36)),(LMZ,ISA(7))
     * ,(LMA,ISA(6)),(NMPA,ISA(79)),(LCNMPA,ISA(80)),(LV,ISA(24))
     * ,(LCNXRA,ISA(21)),(NXRA,ISA(81)),(LCMACA,ISA(82))
     * ,(ISA(83),LCVLMA),(LMY,ISA(22))
C *** TWOTRAN
      COMMON /TW1C/ TWRN(4000)
      EQUIVALENCE (ITJT,TWRN(68)),(IMJM,TWRN(58)),(LZRNUM,TWRN(181))
     * ,(MT,TWRN(15)),(LZRDUC,TWRN(205))
     * ,(LDC,TWRN(206)),(LVOLMA,TWRN(207)),(NMPW,TWRN(170))
     * ,(NXRW,TWRN(211)),(LFGP,TWRN(204))
C *** REACTION RATE
      COMMON /REACC/ IREAC(2000)
C **** PLOT FILE CONTROL *** ADDED BY JAIS K.KANEKO 6/14/84 ************
CKSK  COMMON /PLTCNT/ JJPLT
C **** D2O DELAYED DATA CONTROL
      COMMON /D2OCM / ID2O
C
CKSK  DIMENSION IAA(100),AA(80)
      DIMENSION IAA(127),AA(107)
      CHARACTER*4 LETR(3),ICF,LZERO,LTWO,IBLANK
      EQUIVALENCE (IAA(21),AA(1))
C     COMMON /PDSPDS/ DDNAME(135),IOS(135),IFLSW,FILENM,ECODE,TEMPRY
      COMMON /PDSPDS/ DDNAME(125),IST(15),IRW(15),IOS(35),NC(5,20),
     &                IFLSW,FILENM,ECODE,TEMP
      CHARACTER*12 DDNAME,FILENM
      CHARACTER*8 NODE,IDATE
CKSK  DATA IBLANK/'    '/,LZERO/'0000'/,LTWO/'0002'/
CKSK *  ,LETR/'FAST','THER','ALL '/
C
      COMMON   /MICCOM/ EFFMIC(MAXNG,MAXMT3,MXNISO),LENEFF
      COMMON   /REAMIO/ NOUT6, NDTLS
C
C   === INITIALIZE ===
C
      INITL   =  0
CDEL  NIN1    =  5
      NDTLS   = 95
      NIN1    =  NDTLS
      NOUT1   =  6
      NOUT6   =  NOUT1
      NOUT2   = 99
      NFTOT   =  4
      IOPEN   =  0
      NSOUC   = 32
      NFIN    = 33
      NFOUT   = 33
CKSK  JJPLT   = 0
C
      CALL DTLIST(5,NDTLS,NOUT1,0)
C
CKSK  CALL CLOCK(IT0)
      CALL UCLOCK(IT0)
CKSK  CALL ERRSET(208,10,10,2,1,208)
CK    CALL UERSET(208,10,10,2,1,208)
CKSK  INSTEAD OF DATA STATEMENT
      IBLANK = '    '
      LZERO  = '0000'
      LTWO   = '0002'
      LETR(1)= 'FAST'
      LETR(2)= 'THER'
      LETR(3)= 'ALL '
C
      DO 10 I = 1,MXMESH
      IPAA(I) = I
   10 CONTINUE
C
      LENEFF  = MAXMT3 * MAXNG * MXNISO
      CALL  CLEA( EFFMIC , LENEFF , 0.0 )
      CALL ICLEA( II     , MXCOMC , 0   )
      MXINP2 =  MXCOMC
C
C === START OF A CASE
CKSK  CALL DATE(IDATE)
CKSK  CALL TIME(NTIME)
      CALL UDATE(IDATE)
      CALL UTIME(NTIME)
C
      IH    =  NTIME/3600000
      IMINU = (NTIME-IH*3600000)/60000
      IS    = (NTIME-IH*3600000-IMINU*60000)/1000
      WRITE(NOUT1,61) IDATE,IH,IMINU,IS
      WRITE(NOUT2,61) IDATE,IH,IMINU,IS
   61 FORMAT(1H0,5X,'*** === SRAC CODE SYSTEM RUN    DATE : ',A8,
     * ' START TIME=',I2,':',I2,':',I2,':')
C
C PRINT VERSION NAME AND LAST MODIFYED DATE
      CALL STAMP(NOUT1,NOUT2)
C
 1000 ISTP  = 0
      CALL STPCOM(ISTP,1)
CMOD  CALL INPUT1(&21000,&6000)
      ICODE = 0
      CALL INPUT1( ICODE )
      IF( ICODE.EQ.1) GO TO 21000
CEND
      IF(IOPT(11).NE.0) GO TO 6000
      IF(INITL.NE.0) GO TO 4000
      INITL=1
C === UPDATE USER.FAST.LIBRARY ===
 2000 IF(JNFSTL(1:4).EQ.IBLANK) GO TO 3000
      CALL STPCOM(ISTP,2)
      KDUMY     = 0
      IPATH     = 0
      CALL USERFL(II(LCNEGF),IPATH,KDUMY)
C === UPDATE USER.THERMAL.LIBRARY ===
 3000 IF(JNTHEL(1:4).EQ.IBLANK) GO TO 4000
      CALL STPCOM(ISTP,3)
      CALL USERTL(II(LCNEGT),IPATH)
C === READ AND CHECK , PREPARE THE PATH TABLE FOR COLLISION PROB. ===
C4000     FILENM=12HMACROWRK
 4000     FILENM='MACROWRK    '
          MPSPDS= 0
          CALL FILSRC(MPSPDS,FILENM)
          FILENM=DDNAME(MPSPDS)
C
      IF(IOPT(1) .EQ.0) GO TO 5000
      CALL STPCOM(ISTP,4)
      CALL PIJIN
C6666 FORMAT(10X,'NMP=',I5,' MATD=',10I5)
C === READ FOR SN CODE
C9900 FORMAT(10X,'AFTER PIJIN NR=',I3)
 5000 IF(IOPT(2) .EQ.0.AND.IOPT(12).EQ.0) GO TO 6000
      CALL STPCOM(ISTP,5)
CM    IF(IOPT(2) .EQ.2 .OR.IOPT(12) .EQ.2) CALL ANISN1
      IF(IOPT(2) .EQ.2 .OR.IOPT(12) .EQ.2) THEN
                                           CALL ANISN1
                                           ENDIF
C
      IF(IOPT(2) .EQ.3 .OR.IOPT(12) .EQ.3) CALL TWTRN1
      IF(IOPT(2) .EQ.4 .OR.IOPT(12) .EQ.4) CALL TUD1
 6000 IF(IOPT(2) .EQ.5 .OR.IOPT(12) .EQ.5 .OR.IOPT(14).NE.0 )
     *CALL CIT1(ZZZZ,MEMORY,ZZZZ)
C === READ MATEIAL AND COMPOSITION ===
      CALL STPCOM(ISTP,6)
      CALL INPUT2
      IF (IOPT(18).NE.0) CALL REACIN
      IC2  = IOPT(2) + 1
      ICC2 = IC2
      IF(IOPT(2).EQ.0) ICC2 = IOPT(12)+1
      IF(IOPT(2).EQ.0.AND.IOPT(3).EQ.1) ICC2 = 2
      IF(IOPT(2).EQ.0.AND.IOPT(3).EQ.2) ICC2 = 2
CM    IF(IOPT(20).EQ.0) GO TO 7000
      IF(IOPT(20).EQ.0) GO TO 7950
C === READ BURNUP CONTROL DATA
      GO TO (7100,7200,7300,7400,7500,7600),ICC2
C     HOMOGENEOUS CASE
 7100 CALL BURNIN(1,1,1.0,1,1,1)
C     THE ABOVE BRANCH IS NOT YET TESTED
      GO TO 7900
 7200 CALL BURNIN(NMP,PAA(LCMATD),PAA(LCVOLM)
     @            ,PAA(LCMAR),PAA(LCIXR),NRR)
      GO TO 7900
 7300 CALL BURNIN(NMPA,ISA(LCNMPA),ISA(LCVLMA)
     @            ,ISA(LMZ),ISA(LCNXRA),IZM)
      GO TO 7900
 7400 CALL BURNIN(NMPW,TWRN(LZRDUC),TWRN(LVOLMA)
     @            ,TWRN(LDC),TWRN(LFGP),JMIM)
      GO TO 7900
 7500 CALL BURNIN(NMPT,IIT(LCMTM),IIT(LCVLMT)
     @            ,IIT(LCIK),IIT(LCXR),NRT)
      GO TO 7900
 7600 CALL BURNIN(NMC,ICT(LCNMC),ICT(LCVLMC)
     @            ,ICT(LCMACC),ICT(LCNXRC),IRN)
C     IBNSTP: BURN-UP INDICATOR
C7900 IBNSTP=0
 7900 CONTINUE
C
 7950 IF(JNFSTL(1:4).EQ.IBLANK) GO TO 7960
      CALL STPCOM(ISTP,2)
      KDUMY     = 0
      IPATH     = 1
      CALL USERFL(II(LCNEGF),IPATH,KDUMY)
C === UPDATE USER.THERMAL.LIBRARY ===
 7960 IF(JNTHEL(1:4).EQ.IBLANK) GO TO 7000
      IF(KDUMY.LE.0)            GO TO 7000
C
      CALL STPCOM(ISTP,3)
      CALL USERTL(II(LCNEGT),IPATH)
C
C === COMPOSE MACROSCOPIC X-SECTION IN THE FAST ENERGY RANGES
C
 7000 CALL STPCOM(ISTP,7)
      ICF  = LTWO
          IF(MOD(IMCEF,2).EQ.1) REWIND 52
CM        FILENM = DDNAME(10)
CKSK      FILENM=12HMICREF
          FILENM='MICREF      '
          MPSPDS= 0
          CALL FILSRC(MPSPDS,FILENM)
          FILENM=DDNAME(MPSPDS)
C === TEST D2O IN CALCULATION REGION FOR DELAYED NEUTRON DATA
      CALL D2OCHK(IOPT,NMAT,II(LCNISO),II(LCIDNT),II(LCLISO),ID2O)
      CALL MACROF
C === INTERMEDIATE RESONANCE APPROXIMATION
 8000 IF(IOPT(4).EQ.0) GO TO 8100
      CALL STPCOM(ISTP,8)
CM    FILENM = DDNAME(5)
CKSK      FILENM=12HTHERMALU
          FILENM='THERMALU    '
          MPSPDS= 0
          CALL FILSRC(MPSPDS,FILENM)
          FILENM=DDNAME(MPSPDS)
C === COMPOSE MACROSCOPIC X-SECTION FOR THE THERMAL RANGE ===
      CALL MACROT
C === COMPOSE MACROSCOPIC X-SECTION 'NAMERBN2' USING P1B1 ROUTINE ===
 8100 CALL STPCOM(ISTP,9)
      GO TO (8200,8300,8400,8500,8200,8200),ICC2
 8200 CALL GAM(0,II(LCMTNM),1,1.0,II(LCNISO))
      GO TO 9000
 8300 CALL GAM(NMP,II(LCMTNM),PAA(LCMATD),PAA(LCVOLM),II(LCNISO))
      GO TO 9000
 8400 CALL GAM(NMPA,II(LCMTNM),ISA(LCNMPA),ISA(LCVLMA),II(LCNISO))
      GO TO 9000
C8450 CALL GAM(NMC,II(LCMTNM),ICT(LCNMC),ICT(LCVOLC),II(LCNISO))
C     GO TO 9000
 8500 CONTINUE
      CALL GAM(NMPW,II(LCMTNM),TWRN(LZRDUC),TWRN(LVOLMA),II(LCNISO))
C
 9000 IF(IOPT(5).NE.1) GO TO 9500
      CALL STPCOM(ISTP,10)
C === CALCULATE RESONACE X-SECTION IN FAST RANGES USING IR APPROX. ===
      CALL IRA
 9500 IF(IOPT(8).EQ.0) GO TO 10000
C === CALCULATE NEUTRON FLUXES IN THE FAST RANGES ===
      NXX  = 0
10000 IF(IOPT(6).EQ.0) GO TO 15000
      CALL STPCOM(ISTP,12)
      IC7  = IOPT(7)+1
      NFFL = NEF
      GO TO (10010,10020,10030,10040,10050),IC7
C
10010 NFTL = 0
      GO TO 10060
10020 NFTL = NEF1
      GO TO 10060
10030 NFTL = NEF2
      GO TO 10060
10040 NFTL = NEF3
      GO TO 10060
10050 NFTL=NEF
C
10060 IF(IABS(IOPT(5)).NE.2) GO TO 10070
      IF(NFTL.GT.NEF3) NFTL=NEF3
      IF(NFTL.LT.NEF3) NFFL=NEF3
C === CALL TRANSPORT CODE ===
10070 IRANG = 0
      ITYPE = 1
      REWIND NFIN
      GO TO (10100,10200,10500,10600,10700,10800),IC2
10100 CALL FWRITE(IOPT(2),NFTL,NFFL,1,1,1,1.0)
C     WRITE WT AS VECTOR FLUX BY CASE NAME
      GO TO 14000
C === COLLISION PROBABILITY ROUTINE
10200 IF(NFTL.EQ.0) GO TO 10250
      NXX  = NXR
C     READ TOTAL CROSSSECTION
      CALL SIGT(NFTL,II(LCMTNM),PAA(LCMATD),NMP)
      CALL PIJ2(NFTL,2)
C9990 FORMAT(10X,'AFTER PIJ2 NR=',I3)
C     IPAA CONTAINS 1,2,3,.....
      CALL FSOURC (NRR,NFTL,NMP,PAA(LCMATD),II(LCMTNM),PAA(LCMAR),IPAA)
      CALL PIJ3(NFTL,NRR,II(LCMTNM),PAA(LCMMR),PAA(LCVOLR))
10250 CALL FWRITE(IOPT(2),NFTL,NFFL,NRR,NRR,IPAA,PAA(LCVOLR))
C === CREATE OR UPDATE FINE RESONANCE X-SECTION FILE ===
10300 IF(IABS(IOPT(5)).NE.2) GO TO 10400
      CALL STPCOM(ISTP,13)
      CALL PEACO
C
10400 IF(NXR.EQ.0) GO TO 14000
      CALL STPCOM(ISTP,14)
      CALL MIXX(IOPT(2),NRR,NXR,NEF,NFTL,II(LCMTNM),PAA(LCMAR)
     *  ,PAA(LCIXR) )
      GO TO 14000
C === ANISN ROUTINE
10500 CALL FSOURC(IM,NFTL,NMPA,ISA(LCNMPA),II(LCMTNM),ISA(LMZ),
     1            ISA(LMA))
      CALL ANISN2(NMAT,II(LCMTNM),NFTL,NFFL,ISA(LCNMPA))
      IF(NXRA.EQ.0) GO TO 14000
      CALL STPCOM(ISTP,14)
CM    CALL MIXX(IOPT(2),IZM,NXRA,NEF,NFTL,II(LCMTNM),ISA(LMY),
      CALL MIXX(IOPT(2),IZM,NXRA,NEF,NFTL,II(LCMTNM),ISA(LMZ),
     *        ISA(LCNXRA))
      GO TO 14000
C === TWOTRAN ROUTINE
10600 CALL FSOURW (ITJT,NFTL,NMPW,TWRN(LZRDUC),II(LCMTNM),TWRN(LZRNUM))
C === FLUX GUESS AS GROUP VECTOR
CJ    READ(JNMACR.FNMACR.'MACRO'.'FAST') IDUMY,(AA(I),I=1,IDUMY)
      CALL TWTRN2(NMAT,II(LCMTNM),NFTL)
      IF(NXRW.EQ.0) GO TO 14000
      CALL STPCOM(ISTP,14)
      CALL MIXX(IOPT(2),IMJM,NXRW,NEF,NFTL,II(LCMTNM),TWRN(LDC),
     *          TWRN(LFGP))
      GO TO 14000
C === TUD ONE DIMENSIONAL DIFFUSION
C     FIXED SOURCE AND FLUX GUESS FOR TUD IN FAST RANGE
10700 NNRMAX=NNT+NRT
      CALL FSOURC(NNRMAX,NFTL,NMPT,IIT(LCMTM),II(LCMTNM),IIT(LCIK)
     * ,IIT(LCNNR))
      CALL TUD2(NFTL,II(LCMTNM))
      IF(NXRT.EQ.0) GO TO 14000
      CALL STPCOM(ISTP,14)
      CALL MIXX(IOPT(2),NRT,NXRT,NEF,NFTL,II(LCMTNM),IIT(LCIK)
     1     ,IIT(LCXR))
      GO TO 14000
C === CITATION IN FIXED SOURCE PROBREM
10800 CALL CVMACT(NMC,IDC,ICT(LCNMC),II(LCMTNM))
      CALL CIT2(ZZZZ,MEMORY,2)
      IF(NXRC.EQ.0) GO TO 14000
      CALL STPCOM(ISTP,14)
      CALL MIXX(IOPT(2),IRN,NXRC,NEF,NFTL,II(LCMTNM),ICT(LCMACC),
     *          ICT(LCNXRC))
C === END OF TRANSPORT CALCULATION ===
C === THE OUTPUT FLUXES FROM TRANSPORT CODE IS STORED IN F33
C
14000 CONTINUE
      IF(IOPT(4).EQ.0) GO TO 15000
      CALL STPCOM(ISTP,15)
      IF(IOPT(2).NE.0) GO TO 14100
      NFTL  = 0
      NFFL  = NET
      GO TO 15000
14100 NFTF  = 1
      NFTL  = NET
      REWIND NFIN
14050 IRANG = 1
      ITYPE = 1
      NXX   = 1
      GO TO (15000,14400,14500,14600,14700,14800),IC2
C === COLLISION PROBABILITY ROUTINE
14400 CALL SIGT(NFTL,II(LCMTNM),PAA(LCMATD),NMP)
      CALL PIJ2(NFTL,1)
      CALL TSOURC(NR ,NRR,PAA(LCMAR),PAA(LCIRR),II(LCMTNM),PAA(LCVOLR))
      CALL PIJ3(NFTL,NR,II(LCMTNM),PAA(LCMAT),PAA(LCVOL))
      NXX=NXR
      CALL FWRITE(IOPT(2),NFTL,NFTL,NR,NRR,PAA(LCIRR),PAA(LCVOL))
      IF(NXX.EQ.0) GO TO 15000
      CALL STPCOM(ISTP,16)
C === MIX.X-SECTION FOR THFRMAL RANGE ===
      CALL MIXX (IOPT(2),NRR,NXR,NET,NFTL,II(LCMTNM),PAA(LCMAR)
     *   ,PAA(LCIXR))
      GO TO 15000
C === ANISN ROUTINE
14500 CALL TSOURC (IM ,IZM,ISA(LMZ),ISA(LMA),II(LCMTNM),ISA(LV))
      CALL ANISN2(NMAT,II(LCMTNM),NFTL,NFTL,ISA(LCNMPA))
      NXX=NXRA
      IF(NXX.EQ.0) GO TO 15000
      CALL STPCOM(ISTP,16)
CM    CALL MIXX(IOPT(2),IZM,NXRA,NET,NFTL,II(LCMTNM),ISA(LMY),
      CALL MIXX(IOPT(2),IZM,NXRA,NET,NFTL,II(LCMTNM),ISA(LMZ),
     *       ISA(LCNXRA))
      GO TO 15000
C === TWOTRAN IN FIXED SOURCE THERMAL
14600 CALL TSOURW (ITJT,IMJM,TWRN(LDC),II(LCMTNM))
C === FLUX GUESS AS GROUP VECTOR
CJ    READ(JNMACR.FNMACR.'MACRO'.'THERMAL') IDUMY,(AA(I),I=1,IDUMY)
      CALL TWTRN2(NMAT,II(LCMTNM),NFTL)
      NXX = NXRW
      IF(NXX.EQ.0) GO TO 15000
      CALL STPCOM(ISTP,16)
      CALL MIXX(IOPT(2),IMJM,NXRW,NET,NFTL,II(LCMTNM),TWRN(LDC),
     *          TWRN(LFGP))
      GO TO 15000
C==== FIXED SOURCE AND FLUX GUESS FOR TUD 1-DIM DIFFUSION
14700 CALL TSOURC(NNRMAX,NRT,IIT(LCIK),IIT(LCNNR),II(LCMTNM),
     1            IIT(LCVOLT))
      CALL TUD2(NFTL,II(LCMTNM))
      NXX=NXRT
      IF(NXX.EQ.0) GO TO 15000
      CALL STPCOM(ISTP,16)
      CALL MIXX(IOPT(2),NRT,NXRT,NET,NFTL,II(LCMTNM),IIT(LCIK)
     1        ,IIT(LCXR))
      GO TO 15000
C === CITATION IN FIXED SOURCE THERMAL
C === FIXED SOURCE AND FLUX GUESS FOR CITATION
14800 CALL CVMACT(NMC,IDC,ICT(LCNMC),II(LCMTNM))
      CALL CIT2(ZZZZ,MEMORY,2)
      NXX = NXRC
      IF(NXX.EQ.0) GO TO 15000
      CALL STPCOM(ISTP,16)
      CALL MIXX(IOPT(2),IRN,NXRC,NET,NFTL,II(LCMTNM),ICT(LCMACC),
     *          ICT(LCNXRC))
      GO TO 15000
C === END OF FIXED SOURCE CALCULATION ===
C === THE OUTPUT FLUXES
C === HOMOGENEOUS SPECTRUM ===
15000 CONTINUE
      IF(IOPT(9).EQ.0) GO TO 15500
      IF(IC2    .EQ.1) GO TO 15500
      IF(NXX.LE.0) THEN
                   WRITE(NOUT1,15100)
                   GO TO 15500
                   ENDIF
C
15100 FORMAT(1H0,'**STEP 17**HOMOSP** SKIPPED DUE TO ZERO-X-REGIONS **')
C
      CALL STPCOM(ISTP,17)
      IF(NXX.EQ.1) THEN
                   CALL HOMOSP
                   ELSE
                   CALL HOMOSM
                   ENDIF
C === CONDENSE MACRO INTO FEW GROUP CROSS SECTION
15500 IF(IOPT(10).EQ.0) GO TO 16000
      CALL STPCOM(ISTP,18)
      IC     = 1
      JC     = IOPT(2)
C
      GO TO (15510,15520,15530,15540,15550,15560),IC2
15510 CALL CONDEN(IC,JC,0,II(LCNECF),II(LCMTNM),0,IPAA(1),II(LCNISO))
      GO TO 15600
15520 CALL CONDEN(IC,JC,NXX,II(LCNECF),II(LCMTNM),NMP,PAA(LCMATD)
     *  ,II(LCNISO))
      GO TO 15600
15530 CALL CONDEN(IC,JC,NXX,II(LCNECF),II(LCMTNM),NMPA,ISA(LCNMPA)
     *  ,II(LCNISO))
      GO TO 15600
15540 CALL CONDEN(IC,JC,NXX,II(LCNECF),II(LCMTNM),NMPW,TWRN(LZRDUC)
     *  ,II(LCNISO))
      GO TO 15600
15550 CALL CONDEN(IC,JC,NXX,II(LCNECF),II(LCMTNM),NMPT,IIT(LCMTM)
     *  ,II(LCNISO))
      GO TO 15600
15560 CALL CONDEN(IC,JC,NXX,II(LCNECF),II(LCMTNM),NMC,ICT(LCNMC)
     1  ,II(LCNISO))
C
15600 ICF = LZERO
      GO TO 17000
C
16000 CONTINUE
      IF(IOPT(4).EQ.0) GO TO 17000
      CALL STPCOM(ISTP,19)
16500 IF(IOPT(2).NE.0) CALL CONCAT(NXX  ,CASEID    ,IOPT(2))
16600                  CALL CONCAT(NMAT ,II(LCMTNM),      0)
C
C ===  REACTION RATE CALCULATION
C
17000 IF (IOPT(18).NE.0.AND.IOPT(12).EQ.0.AND.IOPT(6).NE.0)
     >   CALL REACT(0,1)
      IF(MOD(IMCEF,2).EQ.0) GO TO 17040
      IF(IOPT(20).EQ.0)     GO TO 17001
C *** IF NO FIX S PROBLEM SOLVED, SKIP MICREF*** SEPT 25 82'
      IF(IOPT(2).EQ.0 .AND. IOPT(12).NE.0) GO TO 17040
C ***
17001 CALL STPCOM(ISTP,20)
      GO TO (17040,17002,17003,17004,17005,17006),IC2
C     HOMOGENEOUS CASE REJECTED
17002 CONTINUE
      IF (IOPT(18).EQ.0) GO TO 17112
      IF (IREAC(3).EQ.0.OR.IOPT(12).NE.0.OR.IOPT(6).EQ.0) GO TO 17112
      CALL MICREM(0       ,PAA(LCMAR),PAA(LCIXR),NXR)
      CALL REACT(1,1)
      IF (IOPT(10).EQ.0) GO TO 17010
17112 CALL MICREM(IOPT(10),PAA(LCMAR),PAA(LCIXR),NXR)
      GO TO 17010
17003 CONTINUE
      IF (IOPT(18).EQ.0) GO TO 17113
      IF (IREAC(3).EQ.0.OR.IOPT(12).NE.0.OR.IOPT(6).EQ.0) GO TO 17113
      CALL MICREM(0       ,ISA(LMZ),ISA(LCNXRA),NXRA)
      CALL REACT(1,1)
      IF(IOPT(10).EQ.0) GO TO 17010
17113 CALL MICREM(IOPT(10),ISA(LMZ),ISA(LCNXRA),NXRA)
      GO TO 17010
17004 CONTINUE
      IF (IOPT(18).EQ.0) GO TO 17114
      IF (IREAC(3).EQ.0.OR.IOPT(12).NE.0.OR.IOPT(6).EQ.0) GO TO 17114
      CALL MICREM(0       ,TWRN(LDC),TWRN(LFGP),NXRW)
      CALL REACT(1,1)
      IF(IOPT(10).EQ.0) GO TO 17010
17114 CALL MICREM(IOPT(10),TWRN(LDC),TWRN(LFGP),NXRW)
      GO TO 17010
17005 CONTINUE
      IF (IOPT(18).EQ.0) GO TO 17115
      IF (IREAC(3).EQ.0.OR.IOPT(12).NE.0.OR.IOPT(6).EQ.0) GO TO 17115
      CALL MICREM(0       ,IIT(LCIK),IIT(LCXR),NXRT)
      CALL REACT(1,1)
      IF(IOPT(10).EQ.0) GO TO 17010
17115 CALL MICREM(IOPT(10),IIT(LCIK),IIT(LCXR),NXRT)
      GO TO 17010
17006 CONTINUE
      IF (IOPT(18).EQ.0) GO TO 17116
      IF (IREAC(3).EQ.0.OR.IOPT(12).NE.0.OR.IOPT(6).EQ.0) GO TO 17116
      CALL MICREM(0       ,ICT(LCMACC),ICT(LCNXRC),NXRC)
      CALL REACT(1,1)
      IF (IOPT(10).EQ.0) GO TO 17010
17116 CALL MICREM(IOPT(10),ICT(LCMACC),ICT(LCNXRC),NXRC)
C
C === BURNUP CALCULATION ===
C
17010 CONTINUE
      IF(IOPT(20) .EQ. 0) GO TO 17035
C     IF(IBEND.NE.0) GO TO 17035
C     IBEND NORMALLY 0 IF =1 ALL EXPOSURE STEP FINISHED
      CALL STPCOM(ISTP,21)
      GO TO (17011,17012,17013,17014,17015,17016),IC2
17011 CALL BURNUP(1,1,1.0)
      GO TO 17030
C     HOMOGENEOUS CASE
17012 CALL BURNUP(NMP,PAA(LCMATD),PAA(LCVOLM))
      GO TO 17030
17013 CALL BURNUP(NMPA,ISA(LCNMPA),ISA(LCVLMA))
      GO TO 17030
17014 CALL BURNUP(NMPW,TWRN(LZRDUC),TWRN(LVOLMA))
      GO TO 17030
17015 CALL BURNUP(NMPT,IIT(LCMTM),IIT(LCVLMT))
      GO TO 17030
17016 CALL BURNUP(NMC,ICT(LCNMC),ICT(LCVLMC))
      GO TO 17030
C
17030 IF(IBEND.NE.0 )    GO TO 17035
      IF(IOPT(20).NE.0 ) GO TO  7000
C     IBNSTP: BURN-UP INDICATOR
17035 IMCEF  = 0
      IBNSTP = 0
C
C === END OF FIXED SOURCE PROBLEM ===
C
17040 CONTINUE
      IF(IOPT(10).NE.0) THEN
                        ICF=LZERO
                        END IF
      IF(IOPT(13).EQ.1) THEN
                        ICF=LTWO
                        END IF
C
      IF(ICF.EQ.LTWO) GO TO 17050
      NFTL  = NERF
      IRANG = 0
      IF(IOPT(4).EQ.0) GO TO 17090
      NFTL  = NERF + NERT
      IRANG = 2
      GO TO 17090
C
17050 NFTL  = NEF
      IRANG = 0
      IF(IOPT(4).EQ.0) GO TO 17090
      NFTL  = NEF + NET
      IRANG = 2
C
C === EIGENVALUE CALCULATION STEP
C
17090 IF(IOPT(12).EQ.0) GO TO 19000
      CALL STPCOM(ISTP,22)
      IC12  = IOPT(12)
      ITYPE = 0
      IF(IFIXS.EQ.2) ITYPE = 1
      GO TO (17100,17200,17300,17400,17600), IC12
C === EIGENVALUE CALCULATION BY PIJ ===
17100 CALL SIGT(NFTL,II(LCMTNM),PAA(LCMATD),NMP)
      CALL PIJ2(NFTL,2)
      IF(IFIXS.EQ.2)  CALL SSOURC(NRR,NFTL)
      CALL PIJ3(NFTL,NRR,II(LCMTNM),PAA(LCMMR),PAA(LCVOLR))
      NXX=NXR
      CALL FWRITE(IOPT(12),NFTL,NFTL,NRR,NRR,IPAA,PAA(LCVOLR))
      IF(NXX.EQ.0) GO TO 18000
      CALL STPCOM(ISTP,23)
      CALL MIXX(IOPT(12),NRR,NXR,NFTL,NFTL,II(LCMTNM),PAA(LCMAR)
     *  ,PAA(LCIXR))
      GO TO 18000
C === EIGENVALUE CALCULATION BY SN ROUTINE ===
17200 CONTINUE
C === ANISN EIGEN VALUE PROBLEM ===
C ===
      REWIND NFIN
C === FLUX GUESS BY GROUP VECTOR ===
CJ    READ(JNMACR.FNMACR.'MACRO'.RANGE) IDUMY,(AA(I),I=1,IDUMY)
CM    FILENM=DDNAME(8)
CM    IF(ICF.EQ.LTWO) FILENM=DDNAME(6)
CKSK      FILENM=12HMACRO
          FILENM='MACRO       '
CKSK      IF(ICF.EQ.LTWO) FILENM=12HMACROWRK
          IF(ICF.EQ.LTWO) FILENM='MACROWRK    '
          MPSPDS= 0
          CALL FILSRC(MPSPDS,FILENM)
          FILENM=DDNAME(MPSPDS)
CEND
      NODE='CONTX00X'
      NODE(5:5)=LETR(IRANG+1)(1:1)
      NODE(8:8)=ICF(4:4)
      CALL READ(NODE,IAA(20),NFTL+1)
      WRITE(NFIN) (AA(I),I=1,NFTL)
C
      CALL ANISN2(NMAT,II(LCMTNM),NFTL,NFTL,ISA(LCNMPA))
      NXX=NXRA
      IF(NXX.EQ.0) GO TO 18000
      CALL STPCOM(ISTP,23)
C
      CALL MIXX(IOPT(12),IZM,NXRA,NFTL,NFTL,II(LCMTNM),ISA(LMZ),
     *         ISA(LCNXRA))
      GO TO 18000
C === TWOTRAN EIGEN VALUE PROBLEM ===
17300 CONTINUE
      CALL TWTRN2(NMAT,II(LCMTNM),NFTL)
      NXX = NXRW
      IF(NXX.EQ.0) GO TO 18000
      CALL STPCOM(ISTP,23)
      CALL MIXX(IOPT(12),IMJM,NXRW,NFTL,NFTL,II(LCMTNM),TWRN(LDC),
     *          TWRN(LFGP))
      GO TO 18000
C === ONE DIMENSIONAL DIFFUSION CALCULATION ===
17400 CONTINUE
      CALL TUD2(NFTL,II(LCMTNM))
      NXX=NXRT
      IF(NXX.EQ.0) GO TO 18000
      CALL STPCOM(ISTP,23)
      CALL MIXX(IOPT(12),NRT,NXRT,NFTL,NFTL,II(LCMTNM),IIT(LCIK)
     1       ,IIT(LCXR))
      GO TO 18000
17600 CONTINUE
      CALL CVMACT(NMC,IDC,ICT(LCNMC),II(LCMTNM))
      CALL CIT2(ZZZZ,MEMORY,2)
      NXX = NXRC
      IF(NXX.EQ.0) GO TO 18000
      CALL STPCOM(ISTP,23)
      CALL MIXX(IOPT(12),IRN,NXRC,NFTL,NFTL,II(LCMTNM),ICT(LCMACC),
     *          ICT(LCNXRC))
C === IDIFF=1 ISOTROPIC OR PERDENDICULAR DIFFUSION COEFFICIENT
C === IDIFF=2 PARALLEL DIFFUSION COEFFICIENT
C === FTNAME  FISSION YIELD OF MIXTURE FTNAME TAKEN
18000 CONTINUE
C
      IF(IOPT(9).EQ.0) GO TO 18050
C     IF(IOPT(12).EQ.0) GO TO 18050
      IF(NXX.NE.1) THEN
CMOD  PRINT 15100,NXX
                   WRITE(NOUT1,18010)
                   GO TO 18050
                   ENDIF
      CALL STPCOM(ISTP,17)
      CALL HOMOFP
C
18010 FORMAT(1H0,'**STEP 17**HOMOFP** SKIPPED DUE TO MULTI-X-REGIONS *')
C
18050 IF (IOPT(18).NE.0) CALL REACT(0,2)
      IF(NXX.EQ.0)      GO TO 18600
      IF(IOPT(13).EQ.0) GO TO 18600
      CALL STPCOM(ISTP,24)
      IC  = 2
      IF(IOPT(4).EQ.0) IC = 1
      GO TO (18100,18200,18300,18400,18500),IC12
C     FOR PIJ
18100 CALL CONDEN(IC,IC12,NXX,II(LCNECF),II(LCMTNM),NMP ,PAA(LCMATD)
     *           ,II(LCNISO))
      GO TO 18600
C     FOR ANISN
18200 CALL CONDEN(IC,IC12,NXX,II(LCNECF),II(LCMTNM),NMPA,ISA(LCNMPA)
     *           ,II(LCNISO))
      GO TO 18600
18300 CONTINUE
C     FOR TWOTRAN
      CALL CONDEN(IC,IC12,NXX,II(LCNECF),II(LCMTNM),NMPW,TWRN(LZRDUC)
     *           ,II(LCNISO))
      GO TO 18600
C     FOR TUD
18400 CALL CONDEN(IC,IC12,NXX,II(LCNECF),II(LCMTNM),NMPT,IIT(LCMTM)
     *           ,II(LCNISO))
      GO TO 18600
C     FOR CITATION
18500 CALL CONDEN(IC,IC12,NXX,II(LCNECF),II(LCMTNM),NMC,ICT(LCNMC)
     1           ,II(LCNISO))
CM18600 IF(MOD(IMCEF,2).EQ.0) GO TO 19000
18600 IF(MOD(IMCEF,2).EQ.0) GO TO 18800
      IF(ICF.EQ.LZERO) GO TO 18800
      CALL STPCOM(ISTP,25)
      GO TO (18710,18720,18730,18740,18750),IC12
C     FOR PIJ
18710 CALL MICREM(IOPT(10),PAA(LCMAR),PAA(LCIXR),NXR)
      GOTO 18800
C     FOR ANISN
18720 CALL MICREM(IOPT(10),ISA(LMZ),ISA(LCNXRA),NXRA)
      GOTO 18800
C     FOR TWOTRAN
18730 CALL MICREM(IOPT(10),TWRN(LDC),TWRN(LFGP),NXRW)
      GOTO 18800
C     FOR TUD
18740 CALL MICREM(IOPT(10),IIT(LCIK),IIT(LCXR),NXRT)
      GOTO 18800
C     FOR CITATION
18750 CALL MICREM(IOPT(10),ICT(LCMACC),ICT(LCNXRC),NXRC)
C
C18800 IF(IOPT(20).EQ.0) GO TO 19000
18800 IF(IOPT(18).NE.0) CALL REACT(1,2)
      IF(IOPT(20).EQ.0) GO TO 19000
      IF(IBEND.NE.0) GO TO 18870
      CALL STPCOM(ISTP,26)
      GO TO (18810,18820,18830,18840,18850),IC12
C     FOR PIJ
18810 CALL BURNUP(NMP,PAA(LCMATD),PAA(LCVOLM))
      GO TO 18860
C     FOR ANISN
18820 CALL BURNUP(NMPA,ISA(LCNMPA),ISA(LCVLMA))
      GO TO 18860
C     FOR TWOTRAN
18830 CALL BURNUP(NMPW,TWRN(LZRDUC),TWRN(LVOLMA))
      GO TO 18860
C     FOR TUD
18840 CALL BURNUP(NMPT,IIT(LCMTM),IIT(LCVLMT))
      GO TO 18860
18850 CONTINUE
      CALL BURNUP(NMC,ICT(LCNMC),ICT(LCVLMC))
18860 IF(IBEND.NE.0 ) GO TO 18870
      IF(IOPT(20).NE.0 ) GO TO 7000
18870 IMCEF=0
C     IBNSTP: BURN-UP INDICATOR
      IBNSTP=0
19000 IF(IOPT(14).EQ.0) GO TO 20000
      ICF=LZERO
      CALL STPCOM(ISTP,27)
      CALL CVMACT(NMC,IDC,ICT(LCNMC),II(LCMTNM))
20000 CALL STPCOM(ISTP,28)
      GO TO 1000
C     CLOSE PLOTTER FILE
21000 IF(IOPEN.NE.0) CALL PLOT(0.,0.,999)
C
C     CLOSE PDS FILES
C
      DO 20100 I=2,11
           FILENM=DDNAME(I)
           IF(IOS(I).NE.0) CALL CLSPDS(1)
20100 CONTINUE
      WRITE(NOUT1,*)
      WRITE(NOUT1,'(A)') ' ============================== END OF SRAC '
     &               //' CALCULATION =============================='
      WRITE(NOUT2,*)
      WRITE(NOUT2,'(A)') ' ============================== END OF SRAC '
     &               //' CALCULATION ==============================' 
      RETURN
      END
