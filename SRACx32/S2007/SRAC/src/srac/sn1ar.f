      SUBROUTINE SN1AR (LL2,J3,N5,N6)
C
C   *** SN1 ANISN PART READ ROUTINE
C
      COMMON /SN1C/
     &              D(1),LIM1,LR,LW,LDSN,LMA,LMZ,LMB,LMC,LXMD,LFIX,LFLT,
     1       LJ5,LRM,LDF,LJ3,LJ4,LIGT,LART,LALFT,
     2LFGP,LFGG,LEND,LV,LAA,LWD,LMR,LPNC,
     BID,ITH,ISCT,ISN,IGE,IBL,IBR,IZM,IM,IEVT,IGM,IHT,IHS,IHM,MS,MCR,MTP
     C,MT,IDFM,IPVT,IQM,IPM,IPP,IIM,ID1,ID2,ID3,ID4,ICM,IDAT1,IDAT2,IFG,
     DIFLU,IFN,IPRT,IXTR,
     EEV,EVM,EPS,BF,DY,DZ,DFM1,XNF,PV,RYF,XLAL,XLAH,EQL,XNPM,
     FT(12),NIN,NOU,MM,JT
C
      COMMON /MAINC/ III(1000)
C
      EQUIVALENCE (D(1),LDTK(1)),(III(64),NOUT1)
C
      DIMENSION LDTK(1)
C
      CHARACTER *4 LDL,LS,LT,K
      DATA LDL,LS,LT/'&   ','*   ','T   '/
C
      J3 = 0
    1 CONTINUE
      READ(N5,5000) IDNO,K
CKSK  IF(K.NE.LT) GO TO 100
CKSK  WRITE(N6,6000) K
CKSK  RETURN
      IF(K.EQ.LT) THEN
        WRITE(N6,6000) K
        RETURN
      ENDIF
CK100 CONTINUE
      IDNO1=IDNO-3
      IF(IDNO.GE.6) IDNO1=IDNO1-1
      IF(IDNO.GE.15) IDNO1=IDNO1-2
      IF(IDNO.GE.19) IDNO1=IDNO1-2
CKSK  TOO MANY GOTO STATEMENTS FOR HP9000/735(HP-UX9.0)
CKSK  GO TO (101,102,103,104,105,106,107,108,109,110,111,112,113,114,
CKSK 1       115,116,117,118,119,120,121,122,123,124,125,126,127,128,
CKSK 2       129,130,131,132,133,134) , IDNO
CKSK
      IGOTO = 0
      IF(IDNO.EQ. 1.) IGOTO = 2
      IF(IDNO.EQ. 2.) IGOTO = 2
      IF(IDNO.EQ. 3.) IGOTO = 2
      IF(IDNO.EQ. 4.) THEN
        NCOUNT=IM+1
        IGOTO = 200
      ENDIF
      IF(IDNO.EQ. 5.) IGOTO = 2
      IF(IDNO.EQ.6.OR.IDNO.EQ.7) THEN
        NCOUNT=MM
        IGOTO = 200
      ENDIF
      IF(IDNO.EQ. 8) THEN
        NCOUNT=IM
        IGOTO = 150
      ENDIF
      IF(IDNO.EQ. 9) THEN
        NCOUNT=IZM
        IGOTO = 150
      ENDIF
      IF(IDNO.EQ.10.OR.IDNO.EQ.11) THEN
        NCOUNT=MS
        IGOTO = 150
      ENDIF
      IF(IDNO.EQ.12) THEN
        NCOUNT=MS
        IGOTO = 200
      ENDIF
      IF(IDNO.EQ.13.) IGOTO = 2
      IF(IDNO.EQ.14.) IGOTO = 2
      IF(IDNO.EQ.15) THEN
        NCOUNT=36
        IGOTO = 150
      ENDIF
      IF(IDNO.EQ.16) THEN
        NCOUNT=14
        IGOTO = 200
      ENDIF
      IF(IDNO.EQ.17.) IGOTO = 2
      IF(IDNO.EQ.18.) IGOTO = 2
      IF(IDNO.EQ.19) THEN
        NCOUNT=IZM
        IGOTO = 150
      ENDIF
      IF(IDNO.EQ.20) THEN
        NCOUNT=IZM
        IGOTO = 200
      ENDIF
      IF(IDNO.EQ.21) THEN
        NCOUNT=IM
        IGOTO = 200
      ENDIF
      IF(IDNO.EQ.22.OR.IDNO.EQ.23) THEN
        NCOUNT=ID3
        IGOTO = 150
      ENDIF
      IF(IDNO.EQ.24) THEN
        IF (IDAT2.LE.0) WRITE(NOUT1,7020)
        NCOUNT=IGM
        LIGT=LEND
        LEND=LIGT+NCOUNT
CKUNI
        if(LIGT.ne.LDTK(18)) then
                             LDTK(18) = LIGT
                             endif
CEND
        IGOTO = 150
      ENDIF
      IF(IDNO.EQ.25) THEN
        NCOUNT=IGM
        LART=LEND
        LEND=LART+NCOUNT
        IGOTO = 200
      ENDIF
      IF(IDNO.EQ.26) THEN
        NCOUNT=IGM
        LALFT=LEND
        LEND=LALFT+NCOUNT
        IGOTO = 200
      ENDIF
      IF(IDNO.EQ.27) THEN
        NCOUNT=IZM
        IGOTO = 150
      ENDIF
      IF(IDNO.GE.28.AND.IDNO.LE.33) IGOTO = 2
      IF(IDNO.EQ.34) THEN
        NCOUNT=JT*MM
        IGOTO = 200
      ENDIF
C
      IF(IGOTO.EQ.150) GOTO 150
      IF(IGOTO.EQ.200) GOTO 200
    2 WRITE(NOUT1,7000) IDNO,K
      STOP 7
CK101 CONTINUE
CK102 CONTINUE
CK103 CONTINUE
CK    GO TO 2
CK104 CONTINUE
CK    NCOUNT=IM+1
CK    GO TO 200
CK105 CONTINUE
CK    GO TO 2
CK106 CONTINUE
CK    NCOUNT=MM
CK    GO TO 200
CK107 CONTINUE
CK    NCOUNT=MM
CK    GO TO 200
CK108 CONTINUE
CK    NCOUNT=IM
CK    GO TO 150
CK109 CONTINUE
CK    NCOUNT=IZM
CK    GO TO 150
CK110 CONTINUE
CK    NCOUNT=MS
CK    GO TO 150
CK111 CONTINUE
CK    NCOUNT=MS
CK    GO TO 150
CK112 CONTINUE
CK    NCOUNT=MS
CK    GO TO 200
CK113 CONTINUE
CK114 CONTINUE
CK    GO TO 2
CK115 CONTINUE
CK    NCOUNT=36
CK    GO TO 150
CK116 CONTINUE
CK    NCOUNT=14
CK    GO TO 200
CK117 CONTINUE
CK118 CONTINUE
CK    GO TO 2
CK119 CONTINUE
CK    NCOUNT=IZM
CK    GO TO 150
CK120 CONTINUE
CK    NCOUNT=IZM
CK    GO TO 200
CK121 CONTINUE
CK    NCOUNT=IM
CK    GO TO 200
CK122 CONTINUE
CK    NCOUNT=ID3
CK    GO TO 150
CK123 CONTINUE
CK    NCOUNT=ID3
CK    GO TO 150
CK124 CONTINUE
CK    IF (IDAT2.LE.0) WRITE(NOUT1,7020)
CK    NCOUNT=IGM
CK    LIGT=LEND
CK    LEND=LIGT+NCOUNT
CK    GO TO 150
CK125 CONTINUE
CK    NCOUNT=IGM
CK    LART=LEND
CK    LEND=LART+NCOUNT
CK    GO TO 200
CK126 CONTINUE
CK    NCOUNT=IGM
CK    LALFT=LEND
CK    LEND=LALFT+NCOUNT
CK    GO TO 200
CK127 CONTINUE
CK    NCOUNT=IZM
CK    GO TO 150
CK128 CONTINUE
CK129 CONTINUE
CK130 CONTINUE
CK131 CONTINUE
CK132 CONTINUE
CK133 CONTINUE
CK    GO TO 2
CK134 CONTINUE
CK    NCOUNT=JT*MM
CK    GO TO 200
C
C   INTEGER ARRAY
  150 CONTINUE
      ITEMP=LDTK(IDNO1+LL2-1)
C     CALL REAI(LDTK(ITEMP),NCOUNT,4HBLOC,4HK1  )
      CALL REAM(DUM,LDTK(ITEMP),DUM,0,NCOUNT,0)
      GO TO 210
  200 CONTINUE
      ITEMP=LDTK(IDNO1+LL2-1)
      IF(IDNO .EQ. 6 .OR. IDNO .EQ. 7) GO TO 210
C     CALL REAG(D(ITEMP),NCOUNT,4HBLOC,4HK2  )
      CALL REAM(DUM,DUM,D(ITEMP),0,0,NCOUNT)
  210 CONTINUE
      WRITE(NOU,6010) IDNO,K,NCOUNT
      ITEMP=ITEMP+NCOUNT-1
      IF(ITEMP.LE.LIM1) GO TO 1
      WRITE(NOUT1,7010) ITEMP,LIM1
      STOP 7
C
 5000 FORMAT(I2,A1 )
 6000 FORMAT(1H0,5X,A1)
 6010 FORMAT(1H0,I5,A1,6H ARRAY,I7,13H ENTRIES READ)
 7000 FORMAT(1H0,16H*** ERROR 'SN1A',I5,A1,' CARD IS NOT REQUIRED' )
 7010 FORMAT(1H0,16H*** ERROR 'SN1A',I7,' LOCATIONS REQUIRED , ALLOCATE'
     *      ,'D LOCATIONS',I7  )
 7020 FORMAT(1H0,'*** WARNNING ANISN-1 STEP , IDAT2=0 , BUT 24& ARRAY'
     *      ,' ENTERED , 24& ARRAY ARE NOT USSED')
      END
