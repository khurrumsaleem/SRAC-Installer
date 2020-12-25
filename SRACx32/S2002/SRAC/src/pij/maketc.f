      SUBROUTINE MAKETC(NREG,IRR,MMR,VOL,S,IM,IP,II,DD,
     1 XX,III,RX,A02,A03,IA04,A05,A06,IA30,IA31,IA32,IA33)
      DIMENSION NREG(*),IRR(*),MMR(*),VOL(*),S(*),RX(*)
     1         ,DD(*),IM(*),IP(*),II(*),XX(*),III(*)
      COMMON / PIJ1C / NX,NY,NTPIN,NAPIN,NCELL,NM,NGR,NGA,NDPIN,
     1              IDIVP,BETM,NX1,NY1,I14,WEIGHT,I16,IXP,IYP,IZP,
     2              NDPIN1,NDR,NDA,LL,L0,RO1,DRO,FVOL,RAN,
     3              PIT,ROG,ANG,INV,NHEX,SINB,COSB,I36
      COMMON / PIJ2C / IGT,NZ,NR,NRR,NXR,IBOUND,IDRECT,LCOUNT,IEDPIJ,
     1                 IFORM,NTTAB,NUTAB,SZ
      COMMON / MAINC / DDM(63),NOUT1,NOUT2,IT0,DDM1(36),TITLE(18),
     1                 DDM2(380)
      DIMENSION GA(231),GW(231),NGG(15),LOC(15)
      DIMENSION GUR(96),GWR(96)
C     GAUSSIAN QUARDRATURE
      DIMENSION GA1(87),GA2(56),GW1(87),GW2(56)
      DIMENSION GA3(88),GW3(88)
      EQUIVALENCE (GA(1),GA1(1)) ,(GA(88),GA2(1)),(GW(1),GW1(1)),
     1  (GW(88),GW2(1))
      EQUIVALENCE  (GA(144),GA3(1)),(GW(144),GW3(1))
      DATA GW1/     1.0,      .6521452, .3478548,
     1              .4679139, .3607616, .1713245,
     2    .3626838, .3137066, .2223810, .1012285,
     3    .2955242, .2692667, .2190864, .1494513, .0666713,
     4    .2491470, .2334925, .2031674, .1600783, .1069393, .0471753,
     5    .18945061,.18260342,.16915652,.14959599,
     6    .12462897,.09515851,.06225352,.02715246,
     7    .15275339,.14917299,.14209611,.13168864,.11819453,
     8    .10193012,.08327674,.06267205,.04060143,.01761401,
     9    .12793820,.12583746,.12167047,.11550567,.10744427,.09761865,
     A    .08619016,.07334648,.05929858,.04427744,.02853139,.01234123,
     B    .09654009,.09563872,.09384440,.09117388,.08765209,.08331192,
     C    .07819390,.07234579,.06582222,.05868409,.05099806,.04283590,
     D    .03427386,.02539207,.01627440,.00701861,
     E    .07750595,.07703982,.07611036,.07472317,.07288658,
     F    .07061165,.06791205,.06480401,.06130624,.05743977,
     G    .05322785,.04869581,.04387091,.03878217,.03346020,
     H    .02793701,.02224585,.01642106,.01049828,.00452128/
      DATA GW2/
     1    .06473770,.06446616,.06392424,.06311419,.06203942,.06070444,
     2    .05911484,.05727729,.05519950,.05289019,.05035904,.04761666,
     3    .04467456,.04154508,.03824135,.03477722,.03116723,.0272651,
     4    .02357076,.01961616,.01557932,.01147723,.00732755,.00315335,
     5    .04869096,.04857546,.04834476,.04799939,.04754017,.04696818,
     6    .04628480,.04549163,.04459056,.04358372,.04247352,.04126256,
     7    .03995374,.03855015,.03705513,.03547221,.03380516,.03205793,
     8    .03023465,.02833967,.02637747,.02435270,.02227617,.02013482,
     9    .01795172,.01572603,.01348305,.01116814,.00884676,.00650446,
     A    .00414703,.00178328/
      DATA GW3/
     1    .03901781,.03895840,.03883965,.03866176,.03842499,.03812971,
     2    .03777636,.03736549,.03689771,.03637375,.0357944 ,.03516053,
     3    .03447312,.03373321,.03294194,.03210050,.03121017,.03027232,
     4    .02928837,.02825982,.02718823,.02607523,.02492254,.02373188,
     5    .02250509,.02124403,.01995061,.01862681,.01727465,.01589618,
     6    .01449350,.01306876,.01162411,.01016177,.00868395,.00719290,
     7    .00569092,.00418031,.00266353,.00114495,
     8    .03255061,.03251612,.03244716,.03234382,.03220620,.03203446,
     9    .03182876,.03158933,.03131642,.03101033,.03067138,.03029992,
     A    .02989634,.02946109,.02899461,.02849741,.02797001,.02741296,
     B    .02682687,.02621234,.02557004,.02490063,.02420484,.02348340,
     C    .02273707,.02196664,.02117294,.02035680,.01951908,.01866068,
     D    .01778250,.01688580,.01597056,.01503872,.01409094,.01312823,
     E    .01215160,.01116210,.01016077,.00914867,.00812688,.00709647,
     F    .00605854,.00501420,.00396455,.00291073,.00185396,.00079679/
      DATA GA1/     .5773503, .3399810, .8611363,
     1              .2386192, .6612094, .9324695,
     2    .1834346, .5255324, .7966665, .9602899,
     3    .1488743, .4333954, .6794096, .8650634, .9739065,
     4    .1252334, .3678315, .5873180, .7699027, .9041173, .9815606,
     5    .0950125, .2816036, .4580168, .6178762,
     6    .7554044, .8656312, .9445750, .9894009,
     7    .0765265, .2277859, .3737061, .5108670, .6360537,
     8    .7463319, .8391170, .9122344, .9639119, .9931286,
     9    .0640569, .1911189, .3150427, .4337935, .5454215, .6480937,
     A    .7401242, .8200020, .8864155, .9382146, .9747286, .9951872,
     B    .0483077, .1444720, .2392874, .3318686, .4213513, .5068999,
     C    .5877158, .6630443, .7321821, .7944838, .8493676, .8963212,
     D    .9349061 ,.9647623 ,.9856115 ,.9972639 ,
     E    .03877242,.11608407,.19269758,.26815219,.34199409,
     F    .41377920,.48307580,.54940713,.61255389,.67195668,
     G    .72731826,.77830565,.82461223,.86595950,.90209881,
     H    .93281281,.95791682,.97725995,.99072624,.99823771/
      DATA GA2/
     1    .03238017,.09700470,.16122236,.22476379,.28736249,.34875589,
     2    .40868648,.46690290,.52316097,.57722473,.62886740,.67787238,
     3    .72403413,.76715903,.80706620,.84358826,.87657202,.90587914,
     4    .93138669,.95298770,.97059159,.98412458,.99353017,.99877101,
     5    .02435029,.07299312,.12146282,.16964442,.21742364,.26468716,
     6    .31132287,.35722016,.40227016,.44636601,.48940315,.53127946,
     7    .57189564,.61115536,.64896547,.68523631,.71988185,.75281991,
     8    .78397236,.81326532,.84062930,.86599940,.88931545,.91052214,
     9    .92956917,.94641137,.96100880,.97332683,.98333625,.99101337,
     A    .99634012,.99930504/
      DATA GA3/
     1    .01951138,.05850443,.09740840,.13616402,.17471229,.21299450,
     2    .25095236,.28852805,.32566437,.36230475,.39839341,.43387537,
     3    .46869661,.50280411,.53614592,.56867127,.60033062,.63107577,
     4    .66085990,.68963764,.71736519,.74400030,.76950242,.79383272,
     5    .81695414,.83883147,.85943141,.87872257,.89667558,.91326310,
     6    .92845988,.94224276,.95459077,.96548509,.97490914,.98284857,
     7    .98929130,.99422428,.99764986,.99955382,
     8    .01627674,.04881299,.08129750,.11369585,.14597371,.17809688,
     9    .21003131,.24174316,.27319881,.30436494,.33520852,.36569686,
     A    .39579765,.42547899,.45470942,.48345797,.51169418,.53938811,
     B    .56651042,.59303236,.61892584,.64416340,.66871831,.69256454,
     C    .71567681,.73803064,.75960234,.78036904,.80030874,.81940031,
     D    .83762351,.85495903,.87138851,.88689452,.90146064,.91507142,
     E    .92771246,.93937034,.95003272,.95968829,.96832683,.97590917,
     F    .98251726,.98805413,.99254390,.99598184,.99836437,.99968950/
      DATA LOC/1,2,4,7,11,16,22,30,40,52,68,88,112,144,184/
      DATA NGG/1,2,3,4,5,6,8,10,12,16,20,24,32,40,48/
      DO 5 I=1,15
      IF(NGR .LE. NGG(I)) GO TO 6
    5 CONTINUE
      I=15
    6 NGR=NGG(I)
      I=LOC(I)
      DO 10 L=1,NGR
      L1=NGR+1-L
      L2=NGR+L
      GUR(L)=GA(I)
      GWR(L)=GW(I)
   10 I=I+1
      DO 100 I=1,NR
  100 S(I)=0.
      NTWO=1
      IF(RO1.LT.0.) NTWO=2
      DA=BETM/FLOAT(NDA)
      LCOUNT=0
      CALL OPNBUF(4)
      DO 500 NN=1,NDR
      DRO =RX(NN+1)-RX(NN)
      DO 500 NNG=1,NGR
      ROG1=-RX(NN)-DRO*GUR(NNG)
      IF(ABS(ROG1).LT.RAN) GOTO 25
      NDA=1
      DA=BETM
  25  WEIGHT=DRO*DA*GWR(NNG)
      DO 500 NNN=1,NTWO
      ROG1=-ROG1
      DO 500 NA=1,NDA
      ROG=ROG1
      ANG=DA*(FLOAT(NA-1)+0.5)
      SINB=SIN(ANG)
      COSB=COS(ANG)
      IXP=0
      IYP=0
      IZP=0
      LLL=0
      NCOUNT=0
   30 CONTINUE
      IF(IGT.EQ.11 .OR. IGT.EQ.12)
     *CALL GEOMH(RX,A02,A03,A05,A06,IA04,IA30,IA31,IA32,IA33,DD,IM,IP)
      IF(IGT.EQ.10)
     *CALL GEOM (RX,A02,A03,IA04,A05,IA30,IA31,IA32,DD,IM,IP)
      IF (NCOUNT.EQ.0 .AND. LL.EQ.0) GO TO 49
      IF (LL.EQ.0) GO TO 999
C
      IF(NCOUNT.EQ.0) L0=LL
      DO 39 L=1,LL
      LLL=LLL+1
      XX(LLL)=DD(L)
      II(LLL)=IM(L)
   39 CONTINUE
      IF(IBOUND.EQ.0 .OR. IBOUND.EQ.2) GO TO 40
      NCOUNT=NCOUNT+1
      IF (IXP.LE.NCELL .AND. IYP.LT.NCELL .AND. IZP.LT.NCELL) GO TO 30
   40 CALL ELIM(XX,II,III,NREG,L0,LLL)
      CALL WRTBUF(LLL,L0,WEIGHT,XX,III,4)
      DO 105 L=1,L0
      I=III(L)
  105 S(I)=S(I) + WEIGHT*XX(L)
   45 LCOUNT=LCOUNT+1
   49 CONTINUE
  500 CONTINUE
C  *******************************************************************
C     END PATH TABLE ***** NUMERICAL VOLUME TEST FOLLOWS
C  *******************************************************************
      DO 115 I=1,NR
      S(I)=S(I)/BETM*FVOL/VOL(I)
  115 CONTINUE
      CALL CLSBUF(4)
      WRITE(NOUT1,616) 'VOLUME(NUMERICAL)/VOLUME(ANALYTICAL) '
      WRITE(NOUT2,616) 'VOLUME(NUMERICAL)/VOLUME(ANALYTICAL) '
      WRITE(NOUT1,617) (I,S(I),I=1,NR)
      WRITE(NOUT2,617) (I,S(I),I=1,NR)
  616 FORMAT(/10X,A)
  617 FORMAT(
     1(10X,I3,1H),F8.5,3X,I3,1H),F8.5,
     2 3X,I3,1H),F8.5,3X,I3,1H),F8.5,3X,I3,1H),F8.5,3X,I3,1H),F8.5,3X,
     3 I3,1H),F8.5,3X))
CKSK  CALL CLOCK(IT)
      CALL UCLOCK(IT)
      IT=IT-IT0
      WRITE(NOUT2,2003) LCOUNT,IT
      WRITE(NOUT1,2003) LCOUNT,IT
 2003 FORMAT('0 ***',I5,' LINES DRAWN ON FT84 ***',50X,
     1 '****ELAPSED CPU TIME',  I8,' SEC')
      IF(LCOUNT.EQ.0) STOP
      CALL OPNBUF(1)
      IF(NR.NE.NRR) CALL OPNBUF(2)
      IF(NRR.NE.NM) CALL OPNBUF(3)
      CALL OPNBUF(4)
      DO 810 LINE=1,LCOUNT
      CALL RDBUF(LLL,L0,WEIGHT,XX,II,4)
C  *******************************************************************
C      MODIFY PATH TABLE BY NUMERICAL VOLUME
C  *******************************************************************
      DO 805 L=1,LLL
      I=II(L)
      XX(L)=XX(L)/S(I)
  805 CONTINUE
      CALL WRTBUF(LLL,L0,WEIGHT,XX,II,1)
      IF(NR.EQ.NRR) GO TO 41
      CALL ELIM(XX,II,III,IRR,L0,LLL)
      DO 35 L=1,LLL
      II(L)=III(L)
   35 CONTINUE
      CALL WRTBUF(LLL,L0,WEIGHT,XX,II,2)
   41 IF(NRR.EQ.NM) GO TO 42
      CALL ELIM(XX,II,III,MMR,L0,LLL)
      DO 36 L=1,LLL
      II(L)=III(L)
   36 CONTINUE
      CALL WRTBUF(LLL,L0,WEIGHT,XX,II,3)
   42 CONTINUE
  810 CONTINUE
      CALL CLSBUF(1)
      IF(NR.NE.NRR) CALL CLSBUF(2)
      IF(NRR.NE.NM) CALL CLSBUF(3)
CKSK  CALL CLOCK(IT)
      CALL UCLOCK(IT)
      WRITE(NOUT1,2004) LCOUNT,IT
 2004 FORMAT('0 ***',I5,' LINES REWRITTEN ON FT81 ***',50X,
     1 '****ELAPSED CPU TIME',  I8,' SEC')
      RETURN
  999 WRITE(NOUT1,8010) NN,NA,LL,ROG,ANG,(IM(L),DD(L),L=1,LL)
 8010 FORMAT(5X,'NN=',I3,' NA=',I3,' LL=',I4,' RHO=',E12.5,
     1 ' ANG=',F7.4,
     2   (/5X,' IM(L)=',I3,' DD(L)=',E12.5))
      STOP
      END
