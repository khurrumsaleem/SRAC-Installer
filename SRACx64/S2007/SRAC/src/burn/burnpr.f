       SUBROUTINE  BURNPR ( NOWSTP , IBEDIT , LAPSE  , MATDPL , NMAT   ,
     1                      NXR    , VOLM   , VOLX   , TITLE  , CASEID ,
     2                      NTNUC  , NTDEPZ ,          TWTHVY , STDNUC ,
     3                      LAPSET , NOUT2  , MTYP   , SRACID , GAMAV  ,
     4                      YDXE   , YDIO   , YDSM   , YDPM   , DNSITY ,
     5                      SIGXE  , SIGIO  , SIGSM  , SIGPM  , MTYPX  ,
     6                      POWRX  , EXPSX  , U235FX , HMINVX , GAMAVX ,
     7                      YDXEX  , YDIOX  , YDSMX  , YDPMX  , DENSX  ,
     8                      SIGXEX , SIGIOX , SIGSMX , SIGPMX , AFISSX ,
     9                      CFERTX , FLUXX  , AFISSM , CFERTM , FLUXM  ,
     A                      NTFISS , LASTFP , MTNAME , ABSMAT , ABSXRG )
C
      INCLUDE  'BURNPINC'
C
       REAL*4         INSCR,INTCR
C
      COMMON /DEPLET/ AKEFF (MXSTEP),AKINF (MXSTEP),
     1                PERIOD(MXSTEP),POWERL(MXSTEP),
     2                DAYS  (MXSTEP),U235F (MXSTEP),
     3                EXPST (MXSTEP),CUMMWD(MXSTEP),
     4                INSCR (MXSTEP),INTCR (MXSTEP),
     5                FLXNRM(MXSTEP),FACNRM(MXSTEP),
     6                FISABS(MXSTEP),FRTCAP(MXSTEP),
     7                FDECAY(MXSTEP),CDECAY(MXSTEP),
     8                POWRZN(MXSTEP,MXDEPL),
     9                EXPSZN(MXSTEP,MXDEPL),
     A                HMINV (MXSTEP,MXDEPL),
     B                DMWZON(MXSTEP,MXDEPL)
C
C **** LOCAL ARRAY
C
       REAL*4       SWORK(MXSTEP) , FPWORK(MXSTEP) , TWTHVY(MXSTEP)
C
C **** ARRAY DECLEARATION FOR ARGUMENT ARRAY
C
       INTEGER*4    MTYP(NMAT),MATDPL(NMAT),MTYPX(NXR)
       REAL*4       VOLM(NMAT),VOLX(NXR)
C
       CHARACTER*4  STDNUC,TITLE(18)
       CHARACTER*8  CASEID
C
       CHARACTER*4  SRACID(NTNUC)
       CHARACTER*8  MTNAME(NMAT)
C
       REAL*4       GAMAV (NOWSTP,NTDEPZ)
       REAL*4       YDXE  (NOWSTP,NTDEPZ),YDIO  (NOWSTP,NTDEPZ)
       REAL*4       YDSM  (NOWSTP,NTDEPZ),YDPM  (NOWSTP,NTDEPZ)
       REAL*4       DNSITY(NOWSTP,NTNUC,NTDEPZ)
       REAL*4       SIGXE (LAPSE,NOWSTP,NTDEPZ)
       REAL*4       SIGIO (LAPSE,NOWSTP,NTDEPZ)
       REAL*4       SIGSM (LAPSE,NOWSTP,NTDEPZ)
       REAL*4       SIGPM (LAPSE,NOWSTP,NTDEPZ)
       REAL*4       FLUXM (LAPSE,NOWSTP,NMAT)
       REAL*4       FLUXX (LAPSE,NOWSTP,NXR )
       REAL*4       ABSMAT(NOWSTP,NTNUC,NTDEPZ)
       REAL*4       ABSXRG(NOWSTP,NTNUC,NXR )
C
       REAL*4       POWRX (NOWSTP,NXR) , EXPSX (NOWSTP,NXR)
       REAL*4       U235FX(NOWSTP,NXR) , HMINVX(NOWSTP,NXR)
       REAL*4       GAMAVX(NOWSTP,NXR)
       REAL*4       YDXEX (NOWSTP,NXR) , YDIOX (NOWSTP,NXR)
       REAL*4       YDSMX (NOWSTP,NXR) , YDPMX (NOWSTP,NXR)
       REAL*4       DENSX (NOWSTP,NTNUC,NXR)
       REAL*4       SIGXEX(LAPSE,NOWSTP,NXR)
       REAL*4       SIGIOX(LAPSE,NOWSTP,NXR)
       REAL*4       SIGSMX(LAPSE,NOWSTP,NXR)
       REAL*4       SIGPMX(LAPSE,NOWSTP,NXR)
       REAL*4       AFISSX(LAPSE,NOWSTP,NXR)
       REAL*4       CFERTX(LAPSE,NOWSTP,NXR)
       REAL*4       AFISSM(LAPSE,NOWSTP,NTDEPZ)
       REAL*4       CFERTM(LAPSE,NOWSTP,NTDEPZ)
C
       CHARACTER*8  IDMTYP(3)
C
CKSK   DATA    IDMTYP / 8HNOBURNUP   , 8HFUEL        , 8HABSORBER  /
       DATA    IDMTYP / 'NOBURNUP'   , 'FUEL    '    , 'ABSORBER'  /
C
C ***   PRINT OUT PROCESS ****
C
      IPRT   = NOUT2
 3600 CONTINUE
      WRITE(IPRT,4101)
      WRITE(IPRT,4102) CASEID(1:4),(TITLE(I),I=1,18)
      WRITE(IPRT,4103) (DAYS (I),I=1,NOWSTP)
      WRITE(IPRT,4104) (EXPST(I),I=1,NOWSTP)
      WRITE(IPRT,4105) STDNUC(2:4),(U235F(I),I=1,NOWSTP)
      IF(AKEFF(1).GT.0.0) THEN
                          WRITE(IPRT,4106) (AKEFF (I),I=1,NOWSTP-1)
                          WRITE(IPRT,4107) (AKINF (I),I=1,NOWSTP-1)
                          ENDIF
      WRITE(IPRT,4108) (INSCR(I),I=1,NOWSTP-1)
      WRITE(IPRT,4109) (INTCR(I),I=1,NOWSTP-1)
      WRITE(IPRT,4110) (CUMMWD(I),I=1,NOWSTP)
      WRITE(IPRT,4111) (POWERL(I),I=1,NOWSTP-1)
      WRITE(IPRT,4112) (TWTHVY(I),I=1,NOWSTP)
      WRITE(IPRT,4113) (FLXNRM(I),I=1,NOWSTP-1)
      WRITE(IPRT,6001) (FISABS(I),I=1,NOWSTP-1)
      WRITE(IPRT,6002) (FDECAY(I),I=1,NOWSTP-1)
      WRITE(IPRT,6003) (FRTCAP(I),I=1,NOWSTP-1)
      WRITE(IPRT,6004) (CDECAY(I),I=1,NOWSTP-1)
Cksk
 4101 FORMAT(1H1,/40X,31(1H-),/40X,'RESULT OF DEPLETION CALCULATION'/
     1            40X,31(1H-))
 4102 FORMAT(1H0,10X,'CASEID = ',A4,'   / TITLE : ',18A4/)
 4103 FORMAT(/' DAYS       ',1P9E12.5:/(12X,1P9E12.5:))
 4104 FORMAT( ' MWD/TON    ',1P9E12.5:/(12X,1P9E12.5:))
C4105 FORMAT( ' U235-%     ',1P9E12.5:/(12X,1P9E12.5:))
 4105 FORMAT( ' ',A3,'-%      ',1P9E12.5:/(12X,1P9E12.5:))
 4106 FORMAT(/' K-EFF      ',F9.6,8F12.6:/(9X,0P9F12.6:))
 4107 FORMAT( ' K-INF      ',F9.6,8F12.6:/(9X,0P9F12.6:))
 4108 FORMAT(/' INST.-C.R. ',F9.6,8F12.6:/(9X,0P9F12.6:))
 4109 FORMAT( ' INTE.-C.R. ',F9.6,8F12.6:/(9X,0P9F12.6:))
 4110 FORMAT( ' MWD        ',1P9E12.5:/(12X,1P9E12.5:))
 4111 FORMAT( ' POWER(MW)  ',1P9E12.5:/(12X,1P9E12.5:))
 4112 FORMAT( ' TON-HM     ',1P9E12.5:/(12X,1P9E12.5:))
 4113 FORMAT( ' FLUX-LEVEL ',1P9E12.5:/(12X,1P9E12.5:))
 6001 FORMAT( ' FIS.-ABSOR ',1P9E12.5:/(12X,1P9E12.5:))
 6002 FORMAT( ' FIS.-DECAY ',1P9E12.5:/(12X,1P9E12.5:))
 6003 FORMAT( ' FER.-CAPTR ',1P9E12.5:/(12X,1P9E12.5:))
 6004 FORMAT( ' FER.-DECAY ',1P9E12.5:/(12X,1P9E12.5:))
C
C *** MATERIAL-WIZE PRINT OUT
C
      DO 4300 M = 1 , NMAT
      MN        = MATDPL(M)
      IF(MN.LE.0) GO TO 4300
C
      VOL       = VOLM(M)
      WRITE(IPRT,4301)
     1            M,VOL,HMINV(1,MN),IDMTYP(MTYP(M)+1),MTNAME(M)(1:4)
      WRITE(IPRT,4103) (DAYS (I),I=1,NOWSTP)
      WRITE(IPRT,4104) (EXPSZN(I,MN),I=1,NOWSTP)
      WRITE(IPRT,4302) (POWRZN(I,MN),I=1,NOWSTP-1)
      WRITE(IPRT,5307) (GAMAV (I,MN),I=1,NOWSTP-1)
      WRITE(IPRT,5308) (YDXE  (I,MN),I=1,NOWSTP-1)
      WRITE(IPRT,5309) (YDIO  (I,MN),I=1,NOWSTP-1)
      WRITE(IPRT,5310) (YDSM  (I,MN),I=1,NOWSTP-1)
      WRITE(IPRT,5311) (YDPM  (I,MN),I=1,NOWSTP-1)
      WRITE(IPRT,4305)
      DO 4100 N = 1 , NTNUC
      WRITE(IPRT,4303) N,SRACID(N),(DNSITY(I,N,MN),I=1,NOWSTP)
 4100 CONTINUE
      WRITE(IPRT,4305)
C
      IF(IBEDIT.GE.1) THEN
        WRITE(IPRT,5313) LAPSE,LAPSET
        WRITE(IPRT,'(/A)') ' MACRO FISSILE ABSORPTION XS BY GROUP'
        DO 4115 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(AFISSM(IG,NST,MN),IG=1,LAPSE)
 4115   CONTINUE
C
        WRITE(IPRT,'(/A)') ' MACRO FERTILE CAPTURE XS BY GROUP'
        DO 4120 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(CFERTM(IG,NST,MN),IG=1,LAPSE)
 4120   CONTINUE
C
        WRITE(IPRT,'(/A)') ' XE-135 EFFECTIVE MICRO. XS BY GROUP'
        DO 4130 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(SIGXE (IG,NST,MN),IG=1,LAPSE)
 4130   CONTINUE
C
        WRITE(IPRT,'(/A)') '  I-135 EFFECTIVE MICRO. XS BY GROUP'
        DO 4140 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(SIGIO (IG,NST,MN),IG=1,LAPSE)
 4140   CONTINUE
C
        WRITE(IPRT,'(/A)') ' SM-149 EFFECTIVE MICRO. XS BY GROUP'
        DO 4150 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(SIGSM (IG,NST,MN),IG=1,LAPSE)
 4150   CONTINUE
C
        WRITE(IPRT,'(/A)') ' PM-149 EFFECTIVE MICRO. XS BY GROUP'
        DO 4160 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(SIGPM (IG,NST,MN),IG=1,LAPSE)
 4160   CONTINUE
C
        WRITE(IPRT,'(/A)') ' FLUX (N/SEC/CM/CM)  BY GROUP'
        DO 4170 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(FLUXM (IG,NST,M ),IG=1,LAPSE)
 4170   CONTINUE
C
                      ENDIF
      IF(IBEDIT.LE.1) GO TO 4300
C
      WRITE(IPRT,4304) '  ++ MACROSCOPIC ABSORPTION CROSS SECTION'
     1                  ,' : SIGA(ID)/SIGA ++'
      WRITE(IPRT,4305)
C
      CALL  CLEA (  SWORK , MXSTEP  , 0.0 )
      CALL  CLEA ( FPWORK , MXSTEP  , 0.0 )
C
      DO 4250 I = 1 , NOWSTP - 1
      DO 4230 N = 1 , NTNUC
      SWORK (I) = SWORK(I) + ABSMAT(I,N,MN )
 4230 CONTINUE
C
      IF(SWORK(I).LE.0.0)  SWORK(I) = 1.0000
      DO 4240 N = NTFISS+1 , LASTFP
      FPWORK(I) = FPWORK(I) + ABSMAT(I,N,MN )
 4240 CONTINUE
      FPWORK(I) = FPWORK(I) / SWORK(I)
 4250 CONTINUE
C
      DO 4260  N = 1 , NTNUC
      WRITE(IPRT,4303) N,SRACID(N),
     1                  (ABSMAT(I,N,MN)/SWORK(I),I=1,NOWSTP-1)
 4260 CONTINUE
C
      WRITE(IPRT,4305)
      WRITE(IPRT,4306) '  FP TOTAL  ',(FPWORK(I),I=1,NOWSTP-1)
C
 4300 CONTINUE
C
 4301 FORMAT(//,1X,'MATERIAL-NO.=',I3,
     1       2X,'VOLUME=',1PE12.5,5H CC :,2X,'WEIGHT=',1PE12.5,
     2       ' TON/CC  : MATERIAL-TYPE IS ',A8,
     3       ' : MATERIAL-NAME IS ',A4/)
 4302 FORMAT(' POW(MW/CC) ',1P9E12.5:/(12X,1P9E12.5:))
 4303 FORMAT(1X,I4,1X,A4,2X,1P9E12.5:/(12X,1P9E12.5:))
 4304 FORMAT(/A,A)
C4305 FORMAT(2(1X,4(1H-)),1X,11(1X,9(1H-)))
 4305 FORMAT(1X,4(1H-),1X,4(1H-),2X,9(1X,11(1H-)))
 4306 FORMAT(A,1P9E12.5:/(12X,1P9E12.5:))
C
C *** X-REGION-WIZE PRINT OUT
C
      DO 5300 M = 1 , NXR
      VOL       = VOLX(M)
      WRITE(IPRT,5301) M,VOL,HMINVX(1,M),IDMTYP(MTYPX(M)+1)
      WRITE(IPRT,5302) (DAYS (I),I=1,NOWSTP)
CMOD  WRITE(IPRT,5303) (EXPSX(I,M),I=1,NOWSTP)
      IF(MTYPX(M).EQ.2) THEN
      WRITE(IPRT,5303) (EXPSX(I,M),I=1,NOWSTP)
                        ELSE
      WRITE(IPRT,4104) (EXPSX(I,M),I=1,NOWSTP)
                        ENDIF
      WRITE(IPRT,5304) STDNUC(2:4),(U235FX(I,M),I=1,NOWSTP)
      WRITE(IPRT,5305) (POWRX(I,M),I=1,NOWSTP-1)
CM    WRITE(IPRT,5306) (HMINVX(I,M),I=1,NOWSTP)
      WRITE(IPRT,5306) (HMINVX(I,M)*VOL,I=1,NOWSTP)
      WRITE(IPRT,5307) (GAMAVX (I,M),I=1,NOWSTP-1)
      WRITE(IPRT,5308) (YDXEX (I,M),I=1,NOWSTP-1)
      WRITE(IPRT,5309) (YDIOX (I,M),I=1,NOWSTP-1)
      WRITE(IPRT,5310) (YDSMX (I,M),I=1,NOWSTP-1)
      WRITE(IPRT,5311) (YDPMX (I,M),I=1,NOWSTP-1)
      WRITE(IPRT,4305)
      DO 5100 N = 1 , NTNUC
      WRITE(IPRT,5312) N,SRACID(N),(DENSX(I,N,M),I=1,NOWSTP)
 5100 CONTINUE
      WRITE(IPRT,4305)
C
      IF(IBEDIT.GE.1) THEN
        WRITE(IPRT,5313) LAPSE,LAPSET
        WRITE(IPRT,'(/A)') ' MACRO FISSILE ABSORPTION XS BY GROUP'
        DO 5110 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(AFISSX(IG,NST,M),IG=1,LAPSE)
 5110   CONTINUE
C
        WRITE(IPRT,'(/A)') ' MACRO FERTILE CAPTURE XS BY GROUP'
        DO 5120 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(CFERTX(IG,NST,M),IG=1,LAPSE)
 5120   CONTINUE
C
        WRITE(IPRT,'(/A)') ' XE-135 EFFECTIVE MICRO. XS BY GROUP'
        DO 5130 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(SIGXEX(IG,NST,M),IG=1,LAPSE)
 5130   CONTINUE
C
        WRITE(IPRT,'(/A)') '  I-135 EFFECTIVE MICRO. XS BY GROUP'
        DO 5140 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(SIGIOX(IG,NST,M),IG=1,LAPSE)
 5140   CONTINUE
C
        WRITE(IPRT,'(/A)') ' SM-149 EFFECTIVE MICRO. XS BY GROUP'
        DO 5150 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(SIGSMX(IG,NST,M),IG=1,LAPSE)
 5150   CONTINUE
C
        WRITE(IPRT,'(/A)') ' PM-149 EFFECTIVE MICRO. XS BY GROUP'
        DO 5160 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(SIGPMX(IG,NST,M),IG=1,LAPSE)
 5160   CONTINUE
C
        WRITE(IPRT,'(/A)') ' FLUX (N/SEC/CM/CM)  BY GROUP'
        DO 5170 NST=1,NOWSTP-1
          WRITE(IPRT,5314) NST-1,(FLUXX (IG,NST,M ),IG=1,LAPSE)
 5170   CONTINUE
C
                      ENDIF
C
      IF(IBEDIT.LE.1) GO TO 5300
C
      WRITE(IPRT,4304) '  ++ MACROSCOPIC ABSORPTION CROSS SECTION'
     1                  ,' : SIGA(ID)/SIGA ++'
      WRITE(IPRT,4305)
C
      CALL  CLEA (  SWORK , MXSTEP  , 0.0 )
      CALL  CLEA ( FPWORK , MXSTEP  , 0.0 )
C
      DO 5250 I = 1 , NOWSTP - 1
      DO 5230 N = 1 , NTNUC
      SWORK (I) = SWORK(I) + ABSXRG(I,N,M)
 5230 CONTINUE
C
      IF(SWORK(I).LE.0.0)  SWORK(I) = 1.0000
      DO 5240 N = NTFISS+1 , LASTFP
      FPWORK(I) = FPWORK(I) + ABSXRG(I,N,M )
 5240 CONTINUE
      FPWORK(I) = FPWORK(I) / SWORK(I)
 5250 CONTINUE
C
      DO 5260  N = 1 , NTNUC
      WRITE(IPRT,4303) N,SRACID(N),
     1                  (ABSXRG(I,N,M)/SWORK(I),I=1,NOWSTP-1)
 5260 CONTINUE
C
      WRITE(IPRT,4305)
      WRITE(IPRT,4306) '  FP TOTAL  ',(FPWORK(I),I=1,NOWSTP-1)
C
 5300 CONTINUE
C
 5301 FORMAT(//,1X,'X-REGION NO.=',I3,
     1       2X,'VOLUME=',1PE12.5,5H CC :,2X,'WEIGHT=',1PE12.5,
     2       ' TON/CC  : MATERIAL-TYPE IS ',A8/)
 5302 FORMAT(/' DAYS       ',1P9E12.5:/(12X,1P9E12.5:))
 5303 FORMAT( ' ABS./CC    ',1P9E12.5:/(12X,1P9E12.5:))
C5304 FORMAT( ' U235-%     ',1P9E12.5:/(12X,1P9E12.5:))
 5304 FORMAT( ' ',A3,'-%      ',1P9E12.5:/(12X,1P9E12.5:))
 5305 FORMAT( ' POW(MW/CC) ',1P9E12.5:/(12X,1P9E12.5:))
 5306 FORMAT( ' TON-HM     ',1P9E12.5:/(12X,1P9E12.5:))
 5307 FORMAT( ' ENRGY/FIS. ',1P9E12.5:/(12X,1P9E12.5:))
 5308 FORMAT( ' XE-135-YD. ',1P9E12.5:/(12X,1P9E12.5:))
 5309 FORMAT( '  I-135-YD. ',1P9E12.5:/(12X,1P9E12.5:))
 5310 FORMAT( ' SM-149-YD. ',1P9E12.5:/(12X,1P9E12.5:))
 5311 FORMAT( ' PM-149-YD. ',1P9E12.5:/(12X,1P9E12.5:))
 5312 FORMAT(1X,I4,1X,A4,2X,1P9E12.5:/(12X,1P9E12.5:))
 5313 FORMAT(/1H ,'NO OF ENERGY GROUP = ',I3,
     1            ' : NO OF THERMAL ENERGY GROUP = ',I3/)
C
C5314   FORMAT(2X,'NSTEP-1:',I3,2X,1P10E11.4:/(15X,1P10E11.4))
 5314   FORMAT(1X,'NSTEP-1:',I3,1P9E12.5:/(11X,1P9E12.5))
C
CKUNI IF(IPRT.EQ.NOUT2) THEN
CKUNI                   IPRT = 98
CKUNI                   GO TO 3600
CKUNI                   ENDIF
C
      IPRT = 98
C
      CALL BURNP2 ( NOWSTP , IBEDIT , LAPSE  , MATDPL , NMAT   ,
     1              NXR    , VOLM   , VOLX   , TITLE  , CASEID ,
     2              NTNUC  , NTDEPZ ,          TWTHVY , STDNUC ,
     3              LAPSET , NOUT2  , MTYP   , SRACID , GAMAV  ,
     4              YDXE   , YDIO   , YDSM   , YDPM   , DNSITY ,
     5              SIGXE  , SIGIO  , SIGSM  , SIGPM  , MTYPX  ,
     6              POWRX  , EXPSX  , U235FX , HMINVX , GAMAVX ,
     7              YDXEX  , YDIOX  , YDSMX  , YDPMX  , DENSX  ,
     8              SIGXEX , SIGIOX , SIGSMX , SIGPMX , AFISSX ,
     9              CFERTX , FLUXX  , AFISSM , CFERTM , FLUXM  ,
     A              NTFISS , LASTFP , MTNAME , ABSMAT , ABSXRG ,
     B              IPRT  )
C
C ***   END OF PROCESS ****
C
        RETURN
        END
