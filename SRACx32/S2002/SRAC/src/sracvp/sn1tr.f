      SUBROUTINE SN1TR
C
      COMMON /MAINC/ KKK(1000)
      COMMON /TW1C/ DD(1),LIM1,IA(210)
      DIMENSION D(212)
      EQUIVALENCE (D(1),DD(1))
C
C     INPUT INTEGERS
C
      EQUIVALENCE (IA(1),ITH),(IA(2),ISCT),(IA(3),ISN),(IA(4),IGM),
     1(IA(5),IM),(IA(6),JM),(IA(7),IBL),(IA(8),IBR),(IA(9),IBB),
     2(IA(10),IBT),(IA(11),IEVT),(IA(12),ISTART),(IA(13),MT),
     3(IA(14),MIN),(IA(15),MS),(IA(16),IHT),(IA(17),IHS),(IA(18),IHM),
     4(IA(19),IQOPT),(IA(20),IQAN),(IA(21),IQB),(IA(23),IPVT),
     5(IA(24),IANG),(IA(26),IITL),(IA(28),IRBM),(IA(29),IXM),
     6(IA(30),IYM),(IA(31),IEDOPT),(IA(32),IGEOM),(IA(33),IQR),
     7(IA(34),IQT),(IA(35),ISDF)
C
C     INPUT FLOATING POINT NUMBERS
C
      EQUIVALENCE (IA(37),EV),(IA(38),EVM),(IA(39),PV),(IA(40),XLAL),
     1(IA(41),XLAH),(IA(42),XLAX),(IA(43),EPSO),(IA(48),NORM),
     2(IA(49),POD),(IA(50),BHGT)
C
C     COMPUTED CONVERGENCE NUMBERS
C
      EQUIVALENCE (IA(44),EPSI),(IA(45),EPSR),(IA(46),EPSX)
C
C     COMPUTED INTEGERS
C
      EQUIVALENCE (IA(51),IUP),(IA(52),IHF),(IA(53),IHA),(IA(54),IHTR),
     1(IA(55),IHNN),(IA(56),IMJM),(IA(57),MM),(IA(58),NM),(IA(59),NMQ),
     2(IA(60),IP),(IA(61),JP),(IA(62),IGP),(IA(63),IJMM),(IA(64),IT),
     3(IA(65),JT),(IA(66),ITJT),(IA(67),ITMM),(IA(68),JTMM),
     4(IA(69),NMIJ),(IA(70),NMM),(IA(71),ISPANC),(IA(72),IHMT),
     5(IA(73),ISPANF),(IA(74),ISCP),(IA(75),IMJP),(IA(76),IPJM),
     6(IA(77),ITP),(IA(78),JTP),(IA(79),ICLIM),(IA(81),NN),
     7(IA(82),NLIMIT),(IA(83),IANGPR),(IA(84),MCRRDS)
C
C     FIRST WORD ADDRESSES
C
      EQUIVALENCE (D (171),LIHX),(D (172),LIHY),(D (173),LXDF),
     1(D (174),LYDF),(D (180),LFLA),(D (181),LDC),(D (182),LXR),
     2(D(183),LYR),(D(184),LDX),(D(185),LDY),(D(186),LDYA),(D(187),LW),
     1(D(188),LCM),(D(189),LCE),
     3(D (190),LWM),(D (191),LP1),(D (192),LP2),(D (193),LP3),
     4(D (194),LP4),(D (195),LMN),(D (196),LMC),(D (197),LMD),
     5(D (198),LF),(D (199),LFU),(D (200),LYM),(D (201),LXM),
     6(D (202),LXRA),(D (203),LYRA),(D (204),LFGP),(D (205),LZRDUC),
     7(D(206),LZRNUM),(D(207),LVOLMA),(D(208),LVOLZO),
     8(D(209),IVMESH),(D(210),IZMESH),(D(211),NXRW)
C
C     DEFINITION OF MATERIAL MESH (WHEN SEPARATE FROM REBALANCE MESH)
C
      EQUIVALENCE (IA(25),IMC),(IA(27),JMC),( D(175),LIHXC),
     1( D(176),LIHYC),( D(177),LDXC),( D(178),LDYC),( D(179),LDYAC),
     2( D(82),MESH)
C
C
C    /FWBGN1/ , /FWBGN2/ , /LOCAL/ , /UNITS/
C
      EQUIVALENCE (D(87),IDUSE(1)),(D(134),IFO),(D(144),ISNT),
     1(D(143),ITLIM),(D(123),I1),(D(124),I2),(D(125),I3),(D(126),I4),
     2(D(127),I5),(D(128),I6),(D(105),LAST),(D(154),LIMIT),(D(145),MCR),
     3(D(146),MTP),(D(147),MTPS),(D(156),NINP),(D(157),NOUT)
      DIMENSION IDUSE(18)
      DIMENSION E1(4),E2(2),E3(3),E4(3),E5(5),E6(2),E7(2),E8(3),E9(3),
     1E10(3),E11(3),E12(4),E13(3),E14(2),E15(2),E16(3),E17(3),E18(3),
     2E19(3),E20(7),E21(7),E22(3),E23(3),E24(3),E28(4),E29(5),E30(6),
     3E31(6)
      DIMENSION NXYZ01(3), NXYZ02(3), NXYZ03(3), NXYZ04(3)
      DIMENSION ISPEC(9)
      DIMENSION IWORK(42)
C
      REAL NORM
C
      CHARACTER *8
     1       TDATE,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,
     1E16,E17,E18,E19,E20,E21,E22,E23,E24,E28,E29,E30,E31,NXYZ01,NXYZ02,
     2NXYZ03,NXYZ04
C
CKSK  DATA E1/6HNEGATI,6HVE INP,6HUT INT,6HEGER  /
CKSK  DATA E2/6HODD SN,6H ORDER/
CKSK  DATA E3/6HIEVT T,6HOO LAR,6HGE    /
CKSK  DATA E4/6HISTART,6H TOO L,6HARGE  /
CKSK  DATA E5/6HWRONG ,6HNUMBER,6H OF MA,6HTERIAL,6HS     /
CKSK  DATA E6/6HIHT.GT,6H,IHM  /
CKSK  DATA E7/6HWRONG ,6HIHS   /
CKSK  DATA E8/6HIQOPT ,6HTOO LA,6HRGE   /
CKSK  DATA E9/6HNO MOR,6HE PROB,6HLEMS  /
CKSK  DATA E10/6HIANG T,6HOO LAR,6HGE    /
CKSK  DATA E11/6HIEDOPT,6H TOO L,6HARGE  /
CKSK  DATA E12/6HIXM OR,6H IYM T,6HOO LAR,6HGE    /
CKSK  DATA E13/6HIGEOM ,6HIN ERR,6HOR    /
CKSK  DATA E14/6HXLAL.G,6HT.XLAH/
CKSK  DATA E15/6HNORM.L,6HT.0   /
CKSK  DATA E16/6HIBL TO,6HO LARG,6HE     /
CKSK  DATA E17/6HIBR TO,6HO LARG,6HE     /
CKSK  DATA E18/6HIBT TO,6HO LARG,6HE     /
CKSK  DATA E19/6HIBB TO,6HO LARG,6HE     /
CKSK  DATA E20/ 6HNON ZE,6HRO BUC,6HKLING ,6HHEIGHT,6H FOR R,6HZ GEOM,
CKSK 16HETRY  /
CKSK  DATA E21/ 6HSOURCE,6H ANISO,6HTROPY ,6HLARGER,6H THAN ,6HTHAT O,
CKSK 16HF FLU /
CKSK  DATA E22/6HIQR TO,6HO LARG,6HE     /
CKSK  DATA E23/6HIQB TO,6HO LARG,6HE     /
CKSK  DATA E24/6HIQT TO,6HO LARG,6HE     /
CKSK  DATA E28/6HCORE S,6HTORAGE,6H EXCEE,6HDED   /
CKSK  DATA E29/6HEXTEND,6HED COR,6HE STOR,6HAGE EX,6HCEEDED/
CKSK  DATA E30/6HTEMP S,6HTORAGE,6H INPUT,6H X-SEC,6HTS TOO,6H LARGE/
CKSK  DATA E31/6HTEMP S,6HTORAGE,6H ANISO,6H COEFF,6HS. TOO,6H LARGE/
CKSK  DATA NXYZ01/6HFINE X,6HFINE R,6HFINE R/
CKSK  DATA NXYZ02/6HFINE Y,6HFINE Z,6HFINE T/
CKSK  DATA NXYZ03/6HX     ,6HR     ,6HR     /
CKSK  DATA NXYZ04/6HY     ,6HZ     ,6HT     /
CKSK
      DATA E1/'NEGATI','VE INP','UT INT','EGER  '/
      DATA E2/'ODD SN',' ORDER'/
      DATA E3/'IEVT T','OO LAR','GE    '/
      DATA E4/'ISTART',' TOO L','ARGE  '/
      DATA E5/'WRONG ','NUMBER',' OF MA','TERIAL','S     '/
      DATA E6/'IHT.GT',',IHM  '/
      DATA E7/'WRONG ','IHS   '/
      DATA E8/'IQOPT ','TOO LA','RGE   '/
      DATA E9/'NO MOR','E PROB','LEMS  '/
      DATA E10/'IANG T','OO LAR','GE    '/
      DATA E11/'IEDOPT',' TOO L','ARGE  '/
      DATA E12/'IXM OR',' IYM T','OO LAR','GE    '/
      DATA E13/'IGEOM ','IN ERR','OR    '/
      DATA E14/'XLAL.G','T.XLAH'/
      DATA E15/'NORM.L','T.0   '/
      DATA E16/'IBL TO','O LARG','E     '/
      DATA E17/'IBR TO','O LARG','E     '/
      DATA E18/'IBT TO','O LARG','E     '/
      DATA E19/'IBB TO','O LARG','E     '/
      DATA E20/'NON ZE','RO BUC','KLING ','HEIGHT',' FOR R','Z GEOM',
     1'ETRY  '/
      DATA E21/'SOURCE',' ANISO','TROPY ','LARGER',' THAN ','THAT O',
     1'F FLU '/
      DATA E22/'IQR TO','O LARG','E     '/
      DATA E23/'IQB TO','O LARG','E     '/
      DATA E24/'IQT TO','O LARG','E     '/
      DATA E28/'CORE S','TORAGE',' EXCEE','DED   '/
      DATA E29/'EXTEND','ED COR','E STOR','AGE EX','CEEDED'/
      DATA E30/'TEMP S','TORAGE',' INPUT',' X-SEC','TS TOO',' LARGE'/
      DATA E31/'TEMP S','TORAGE',' ANISO',' COEFF','S. TOO',' LARGE'/
      DATA NXYZ01/'FINE X','FINE R','FINE R'/
      DATA NXYZ02/'FINE Y','FINE Z','FINE T'/
      DATA NXYZ03/'X     ','R     ','R     '/
      DATA NXYZ04/'Y     ','Z     ','T     '/
C
C     READ HEADERS AND CONTROL INTEGERS
C
      CALL DATE1 (TDATE)
      WRITE (NOUT,320)
      WRITE (NOUT,330)TDATE
      CALL REAM(ITCARD,ITCARD,ITCARD,0,1,0)
CKH   GO TO 110
C
C     AN END OF FILE HAS BEEN ENCOUNTERED
C
CK100 CALL ERROR (3,E9,3)
CKH   STOP
  110 CONTINUE
C
C     INITIALIZE STORAGE
C
C      CONSTANT NO. (UNIT NO.) NOT CLEAR
CKSK  CALL CLEARW(0.0,D(3),153)
      CALL CLEARW(0.0,DD(3),153)
CKSK  CALL CLEARW(0.0,D(212),LIM1-211)
      CALL CLEARW(0.0,DD(212),LIM1-211)
CKSK  CALL CLEARW(4H    ,IDUSE,18)
      CALL CLEARW('    ',IDUSE,18)
      IF (ITCARD.EQ.0) GO TO 130
      DO 120 K=1,ITCARD
CMOD  CALL REAM(IDUSE,IDUSE,IDUSE,18,0,0 )
      READ(NINP,'(18A4)')  (IDUSE(I),I=1,18)
      WRITE (NOUT,350)(IDUSE(I),I=1,18)
  120 CONTINUE
C
C     READ INTEGER PARAMETERS
C
  130 CONTINUE
      CALL REAM(IWORK,IWORK,IWORK,0,42,0)
      DO 135 I=1,13
  135 IA(I)=IWORK(I)
      MTPS=IWORK(14)
      MCR= IWORK(15)
      DO 136 I=16,21
  136 IA(I-1)=IWORK(I)
      IA(33)=IWORK(22)
      IA(21)=IWORK(23)
      IA(34)=IWORK(24)
      IA(23)=IWORK(25)
      IA(26)=IWORK(26)
      IA(29)=IWORK(27)
      IA(30)=IWORK(28)
      ITLIM=IWORK(29)
      IA(32)=IWORK(30)
      IA(31)=IWORK(31)
      IA(35)=IWORK(32)
      I1=IWORK(33)
      I2=IWORK(34)
      I3=IWORK(35)
      I4=IWORK(36)
      I5=IWORK(37)
      I6=IWORK(38)
      IANG=IWORK(39)
      IMC=IWORK(40)
      JMC=IWORK(41)
      IFO=IWORK(42)
      KKK(39)=IA(2)
C
C     IF MCR.LT.0 READ FIDO CROSS SECTIONS,
C     IF IHT.LT.0 CROSS SECTIONS DO NOT CONTAIN SIGMA UP
C
      MCRRDS=MCR
      MCR=IABS(MCR)
      MTP=MTPS*(ISCT+1)
C     MIN=MCR+MTP
      IF (IABS(IANG).NE.1) IANG=0
      IANGPR=IANG
      IANG=IABS(IANG)
      IF (ISTART.EQ.5) ISTART=-5
      IF (IABS(ISTART).NE.6) GO TO 140
C
C     READ RESTART DUMP FROM UNIT NFLUX
C
C     CALL DUMPRD(NDUMP1)
      GO TO 180
C
C     READ FLOATING POINT PARAMETERS
C
  140 CONTINUE
      CALL REAM(IWORK,IWORK,IWORK,0,0,10)
      DO 145 I=1,7
  145 IA(I+36)=IWORK(I)
      DO 146 I=8,10
  146 IA(I+40)=IWORK(I)
C
C     INTEGER CHECKING
C
      DO 150 I=1,36
      IF (IA(I).GE.0) GO TO 150
      IF ((I.EQ.3).OR.(I.EQ.12).OR.(I.EQ.19)) GO TO 150
      CALL ERROR (2,E1,4)
  150 CONTINUE
      IF (ITLIM.LT.0) CALL ERROR (2,E1,4)
      IF (IABS(ISN)/2.EQ.(IABS(ISN)-1)/2) CALL ERROR (2,E2,2)
      IF (IEVT.GT.4) CALL ERROR (2,E3,3)
      IF (IABS(ISTART).GT.5) CALL ERROR (2,E4,3)
C     IF ((MS.EQ.0).AND.(MIN.NE.MT)) CALL ERROR (2,E5,5)
      IF (IHT.GT.IHM) CALL ERROR (2,E6,2)
      IF ((IHS.GT.IHM).OR.(IHS.LT.IHT)) CALL ERROR (2,E7,2)
      IF (IQOPT.GT.5) CALL ERROR (2,E8,3)
      IF (IANG.GT.1) CALL ERROR (2,E10,3)
      IF ((IXM.GT.1).OR.(IYM.GT.1)) CALL ERROR (2,E12,4)
      IF (IGEOM.LE.0) GO TO 160
      IF (IGEOM.LE.3) GO TO 170
  160 CALL ERROR (2,E13,3)
      IGEOM=1
  170 CONTINUE
      IF (IBT.EQ.3) IBB=3
      IF (IBB.EQ.3) IBT=3
      IF (IQAN.GT.ISCT) CALL ERROR (2,E21,7)
      IF (IABS(ISN)/2-1.LT.ISCT) ISN=(2*ISCT+2)*ISN/IABS(ISN)
      IF (IBL.GT.1) CALL ERROR (2,E16,3)
      IF (IBR.GT.2) CALL ERROR (2,E17,3)
      IF (IBT.GT.3) CALL ERROR (2,E18,3)
      IF (IBB.GT.3) CALL ERROR (2,E19,3)
      IF (IQR.GT.1) CALL ERROR (2,E22,3)
      IF (IQB.GT.1) CALL ERROR (2,E23,3)
      IF (IQT.GT.1) CALL ERROR (2,E24,3)
C
C     PRINT INTEGER INPUT
C
      WRITE (NOUT,380) (IA(I),I=1,5),NXYZ03(IGEOM),IA(6),NXYZ04(IGEOM),
     1(IA(I),I=7,12)
      WRITE (NOUT,390) IA(13),MTPS,IA(84),IA(15),IHT,
     1(IA(I),I=17,20),IA(33),IA(21),IA(34)
      WRITE (NOUT,400) IA(23),IA(26),IA(29),NXYZ03(IGEOM),IA(30),
     1NXYZ04(IGEOM),ITLIM
      WRITE (NOUT,410) IA(32),IA(31),IA(35),I1,I2,I3,I4,I5,I6,IANGPR,
     1IMC,JMC,IFO
C
C     FLOATING POINT CHECKING
C
  180 IF ((IEVT.GT.1).AND.(EVM.EQ.0.0)) EVM=EV+0.1
      IF (XLAL.GT.XLAH) CALL ERROR (2,E14,2)
      IF (XLAX.EQ.0.0) XLAX=0.001
      IF (POD.EQ.0.0) POD=1.0
      IF (XLAL.EQ.0.0) XLAL=0.01
      IF (XLAH.EQ.0.0) XLAH=0.5
      IF (EPSO.LE.0.0) EPSO=0.001
      IF (NORM.LT.0.0) CALL ERROR (2,E15,2)
      IF (IEDOPT.GT.4) CALL ERROR (2,E11,3)
      IF (IABS(ISTART).EQ.6) GO TO 290
      IF (IGEOM.NE.2) GO TO 190
      IF (BHGT.NE.0.0) CALL ERROR (2,E20,7)
  190 CONTINUE
C
C     PRINT FLOATING INPUT
C
      WRITE(NOUT,420)(D(I),I=39,45)
      WRITE(NOUT,430) D(50)
      WRITE(NOUT,440)(D(I),I=51,52)
C
C     COMPUTE INNER ITERATION MAXIMUM AND ASSOCIATED CONSTANTS
C
      NLIMIT=MIN0(10,IITL)
      IF (NLIMIT.EQ.IITL) NLIMIT=NLIMIT-2
      NLIMIT=MAX0(2,NLIMIT)
      IF (IITL.GT.2) IITL=IITL-1
C
C     IF ISN.LT.0 USER SUPPLIES SN CONSTANTS
C
      ISNT=ISN
      ISN=IABS(ISN)
C
C     COMPUTE USEFUL INTEGERS
C
      IMJM=IM*JM
      MM=(ISN*(ISN+2))/8
      NM=((ISCT+1)*(ISCT+2))/2
      NMQ=((IQAN+1)*(IQAN+2))/2
      NN=ISN/2
      IP=IM+1
      JP=JM+1
      IJMM=IMJM*MM
      ISCP=ISCT+1
C
C     DEFINE MESHES
C
      IF (IMC.GT.0) GO TO 220
  210 MESH=0
      IMC=IM
      JMC=JM
      GO TO 230
  220 MESH=1
      IF (JMC.LE.0) GO TO 210
      IF (IEDOPT.NE.0) IANG=1
  230 CONTINUE
C
C     BEGIN CALCULATION OF STORAGE LOCATIONS
C
CKH   LIHX=206
      LIHX=212
CKSK  CALL LOAD (NXYZ01(IGEOM),6H MESH ,D(LIHX),D(LIHX),IM,-1)
CKSK  CALL LOAD (NXYZ01(IGEOM),6H MESH ,DD(LIHX),DD(LIHX),IM,-1)
      CALL LOAD (NXYZ01(IGEOM),' MESH ',DD(LIHX),DD(LIHX),IM,-1)
      IT=0
      DO 240 I=1,IM
  240 IT=IT+IA(I+LIHX-3)
      LIHY=LIHX+IM
CKSK  CALL LOAD (NXYZ02(IGEOM),6H MESH ,D(LIHY),D(LIHY),JM,-1)
CKSK  CALL LOAD (NXYZ02(IGEOM),6H MESH ,DD(LIHY),DD(LIHY),JM,-1)
      CALL LOAD (NXYZ02(IGEOM),' MESH ',DD(LIHY),DD(LIHY),JM,-1)
      JT=0
      DO 250 J=1,JM
  250 JT=JT+IA(J+LIHY-3)
      ITJT=IT*JT
      ITMM=IT*MM
      JTMM=JT*MM
      NMIJ=NM*ITJT
      NMM=NM*MM
      IPJM=IP*JM
      IMJP=IM*JP
      ITP=IT+1
      JTP=JT+1
      LXRA=LIHY+JM
      LYRA=LXRA+IMC+1
C
      LW=LYRA+JMC+1
      LCM=LW+MM
      LCE=LCM+MM
      LP1=LCE+MM
      LP2=LP1+NMM
      LP3=LP2+NMM
      LP4=LP3+NMM
      LWM=LP4+NMM
C
C     CONTINUE WITH STORAGE ALLOCATION
C
      LFLA=LWM+MM
C
C     GEOMTRY AND ANGULAR ARRAYS
C
      LDC=LFLA+MAX0(ITJT,IPJM)
      LXR=LDC+IMC*JMC
      LYR=LXR+MAX0(IP,IMC+1)
      LDX=LYR+MAX0(JP+1,JMC+2)
      LDY=LDX+IT+1
      LDYA=LDY+JT+1
      LXM=LDYA+JT+1
      LYM=LXM+IXM*IMC
      LXDF=LYM+IYM*JMC
      LYDF=LXDF+IT
      LMN=LYDF+JT
      LMC=LMN+MS
      LMD=LMC+MS
C
C     REBALANCE REQUIREMENTS
C
      LF=LMD+MS
      LFU=LF+IMJP
C    ***** VOLUME AND X-REGION
CKH   LV=LFU+IMJP
CKH   LFGP=LV+ITJT
      MT=MTPS+MCR
      LZRDUC=LFU+IMJP
      LZRNUM=LZRDUC+MT
      LVOLMA=LZRNUM+IMJM
      LVOLZO=LVOLMA+MT
      LFGP=LVOLZO+IMC*JMC
CKH
C
C     MATERIAL MESH (EQ.OR.NE. REBALANCE MESH)
C
      IF (MESH.NE.0) GO TO 260
      LAST=LFGP+IMJM
      LDXC=LDX
      LDYC=LDY
      LDYAC=LDYA
      LIHXC=LIHX
      LIHYC=LIHY
      GO TO 270
  260 LIHXC=LFGP+IMC*JMC
      LIHYC=LIHXC+IMC
      LDXC=LIHYC+JMC+1
      LDYC=LDXC+IT+1
      LDYAC=LDYC+JT+1
      LAST=LDYAC+JT+1
  270 CONTINUE
      IF (LAST.GT.LIM1) CALL ERROR(2,E28,6)
C
C     MAXIMUM STORAGE REQUIREMENTS INCLUDING TEMPORARIES
C
      ITEMP1=LF+2*ISCT+1+MM*ISCP**2
      ITEMP2=LAST
      LIMIT=LAST+IP+IMJM
      LAST=MAX0(LAST,LIMIT,ITEMP1)
      WRITE(6,450) LAST,LIM1
      WRITE (NOUT,450)LAST,LIM1
C
C     DEFINE AUXILIARY CONVERGENCE PRECISIONS
C
  290 CONTINUE
      EPSR=0.5*EPSO
      EPSI=EPSO
      EPSX=EPSO
C
C     SET MAXIMUM NUMBER OF REBALANCE ITERATIONS
C
      IRBM=200
      IF(ITJT.LE.5000) RETURN
      WRITE(6,451) ITJT
      WRITE(NOUT,451) ITJT
  451 FORMAT(' *** NUMBER OF SPATIAL MESH EXCEED THE LIMIT (5000)',I6)
      STOP
C
C
  300 FORMAT (12I6)
  310 FORMAT (18A4)
  320 FORMAT (1H1)
  330 FORMAT (67H     THIS CASE WAS PROCESSED BY THE TWOTRAN-II CODE OF
     104/24/73 ON , 2 X, A 8 )
  340 FORMAT (6E12.6)
  350 FORMAT (1H ,18A4)
  360 FORMAT (1I6,2I3,6I6,3I2,3I6)
  370 FORMAT (5I6,6I1,6I6)
  380 FORMAT (1H0,I4,26H ITH    0/1 DIRECT/ADJOINT/1X,I4,43H ISCT   0/N
     1ISOTROPIC/NTH ORDER ANISOTROPIC/1X,I4,58H ISN    SN ORDER ( +/- BU
     2ILT-IN/STANDARD INTERFACE FILE ) /1X,I4,18H IGM    NO. GROUPS/1X,I
     34,24H IM     NO. COARSE MESH ,A1,11H INTERVALS /1X,I4,24H JM     N
     4O. COARSE MESH ,A1,11H INTERVALS /1X,I2,I2,I2,I2,4X,81HLEFT,RIGHT,
     5BOTTOM,TOP BOUNDARY CONDITION 0/1/2/3 VACUUM/REFLECTIVE/WHITE/PERO
     6DIC /1X,I4,53H IEVT   0/1/2/3/4  Q/K/ALPHA/C/DELTA  CALCULATION
     7 /1X,I4,114H ISTART -5/-4/-3/-2/-1/0/1/2/3/4/6 STARTING OPTIONS (
     8MINUS FOR ISOTROPIC COMPONENT ONLY ) SEE MANUAL FOR DETAILS /)
  390 FORMAT (1X,I4,30H MT     TOTAL NO. OF MATERIALS/1X,I3,1X,I3,5X,40H
     1STANDARD INTERFACE/CARD INPUT MATERIALS /1X,I4,35H MS     NO. OF M
     2IXTURE INSTRUCTIONS/1X,I4,34H IHT    ROW OF TOTAL CROSS SECTION/1X
     3,I4,41H IHS    ROW OF SELF SCATTER CROSS SECTION/1X,I4,39H IHM
     4LAST ROW OF CROSS SECTION TABLE/1X,I4,63H IQOPT  0/1/2/3/4/5 NONE/
     5SAME AS ISTART FOR SOURCE DISTRIBUTION/1X,I4,51H IQAN   0/N  ISOTR
     6OPIC/NTH ORDER ANISOTROPIC SOURCE/1X,I2,I2,I2,6X,60HIQR/IQB/IQT RI
     7GHT,BOTTOM,TOP BOUNDARY SOURCE ( 0/1 NO/YES ) )
  400 FORMAT (1X,I4,55H IPVT   0/1/2 NONE/K/ALPHA  PARAMETRIC EIGENVALUE
     1 TYPE /1X,I4,33H IITL   MAX NO. INNER ITERATIONS /1X,I4,26H IXM
     2 0/1 NO/YES MODIFY ,A1,20H RADII (IEVT=4 ONLY)//1X,I4,26H IYM    0
     3/1 NO/YES MODIFY ,A1,20H RADII (IEVT=4 ONLY)/1X,I4,36H ITLIM  0/N
     4NONE/SECONDS TIME LIMIT )
  410 FORMAT (1X,I4,41H IGEOM  1/2/3 (X,Y)/(R,Z)/(R,T) GEOMETRY /1X,I4,6
     11H IEDOPT 0/1/2/3/4=NONE/N EDIT OPTIONS SEE MANUAL FOR DETAILS /1X
     2,I4,51H ISDF   0/1 NO/YES INPUT FINE MESH DENSITY FACTORS /1X,I4,4
     31H I1     0/1 YES/NO FULL INPUT FLUX PRINT /1X,I4,50H I2     0/1/2
     4 ALL/ISOTROPIC/NONE FINAL FLUX PRINT /1X,I4,49H I3     0/1/2 ALL/M
     5IXED/NONE CROSS SECTION PRINT /1X,I4,39H I4     0/1 YES/NO FINAL F
     6ISSION PRINT /1X,I4,62H I5     0/1/2/3 ALL/READQF/NORMALIZED/NONE
     7INPUT SOURCE PRINT /1X,I4,51H I6     0/1 YES/NO COARSE MESH BALANC
     8E TABLE PRINT /1X,I4,53H IANG   -1/0/1 PRINT AND STORE/NO/STORE AN
     9GULAR FLUX /1X,I4,96H IMC    NO. OF HORIZON. MAT.MESH INTERVALS (I
     XF.NE.0, REBAL.MESH.NE.MAT.MESH WHICH IS EDIT MESH) /,1X,I4,42H JMC
     X    NO. OF VERTICAL MAT.MESH INTERVALS/1X,I4,50H IFO    0/1 NO/YES
     X STANDARD INTERFACE FILE OUTPUT //)
  420 FORMAT (1X,1PE11.3,24H EV     EIGENVALUE GUESS/1X,1PE11.3,27H EVM
     1   EIGENVALUE MODIFIER/1X,1PE11.3,30H PV     PARAMETRIC EIGENVALUE
     2 /1X,1PE11.3,33H XLAL   SEARCH LAMBDA LOWER LIMIT/1X,1PE11.3,33H X
     3LAH   SEARCH LAMBDA UPPER LIMIT/1X,1PE11.3,35H XLAX   FINE MESH SE
     4ARCH PRECISION //1X,1PE11.3,30H EPS    CONVERGENCE PRECISION )
  430 FORMAT (1X,1PE11.3,31H NORM   NORMALIZATION AMPLITUDE)
  440 FORMAT (1X,1PE11.3,37H POD    PARAMETER OSCILLATION DAMPER /1X,1PE
     111.3,61H BHGT   TOTAL BUCKLING HEIGHT IN CM FOR (X,Y) AND (R,T) ON
     2LY //)
  450 FORMAT (//8H0STORAGE,4X,8HREQUIRED,8H ALLOWED/11H SMALL CORE,2(2X,
     1I6)/11H LARGE CORE,2(2X,I6))
      END
