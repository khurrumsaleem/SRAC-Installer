C             FSPVEW
      SUBROUTINE FSPVEW(B,IB,XKI,VE,IGM,MTNAME,NM,IMX,NOU,
     &                  LIMB,NMP          )
C ***** FSPVEL LOADS FISSION SPECTRUM   VELOCITY FROM MACRO FILE
      COMMON /PDSPDS/ BUF(540),IFLSW,FILENM(3),ECOOD,TEMPRY
      COMMON /MAINC /III(1000)
      COMMON /WORK/ DUMMY(55000),S(5000)
      COMMON /TW1C/ KKKK(200)
C
      EQUIVALENCE (III(64),NOUT1),(III(98),IRANG),(III(99),ICF)
      EQUIVALENCE (III(77),ITYPE),(KKKK(68),ITJT),(KKKK(164),ITFLUX)
      DIMENSION XKI(IGM),VE (IGM),MTNAME(2,1),IRANGE(3),IMX(1),
     &          B(LIMB),IB(LIMB),IIDENT(2)
      CHARACTER*4 IRANGE,KZERO,ICF
C
      DATA IRANGE/'FAST','THER','ALL '/,KZERO/'0000'/
CJ    SYN MACRO = MANNO.FILENM.'MACR'
C
C     WRITE(NOU,6000) MANNO,FILENM,ERANG,IGM,FSMAT
C
CJ    READ(MACRO.ERANG) NGR,(W,I=1,NGR),(B(I+NGR+1),I=1,NGR),W
C
C********************************** PDS FILE ***************************
CCCCC FILENM(1)='MACR'
      CALL BSHIFT(FILENM(1),'MACR',0)
CCCCC FILENM(2)='O   '
      CALL BSHIFT(FILENM(2),'O   ',0)
CCCCC IF(ICF.NE.KZERO) FILENM(2)='OWRK'
      IF(ICF.NE.KZERO) CALL BSHIFT(FILENM(2),'OWRK',0)
CCCCC FILENM(3)='    '
      CALL BSHIFT(FILENM(3),'    ',0)
CCCCC IIDENT(1)='CONT'
      CALL BSHIFT(IIDENT(1),'CONT',0)
CCCCC IIDENT(2)='X00X'
      CALL BSHIFT(IIDENT(2),'X00X',0)
      CALL PACKX(IIDENT(2),1,IRANGE(IRANG+1),1)
      CALL PACK(IIDENT(2),4,ICF)
C     CALL GETLEN(IIDENT,LENGTH)
      CALL SEARCH(IIDENT,LENGTH,ISW)
      IF (ISW .EQ. 0) GO TO 95
      IF (ICF .NE. '0002') GO TO 95
      CALL PACK(IIDENT(2),4,'0004')
   95 CALL GETLEN(IIDENT,LENGTH)
      CALL READ(IIDENT,B,LENGTH)
C********************************** PDS FILE ***************************
      NGR = IB(1)
      IF(NGR.LE.IGM) GO TO 100
      WRITE(NOUT1,7000) IGM,NGR
      STOP 7
  100 CONTINUE
      DO 110 I=1,IGM
       VE(I)=SQRT(0.5*(B(I+NGR+1)+B(I+NGR+2)))
  110 CONTINUE
      DO 130 M=1,NMP
      MM=IABS(IMX(M))
      IIDENT(1)=MTNAME(1,MM)
      IIDENT(2)=MTNAME(2,MM)
      CALL PACKX(IIDENT(2),1,IRANGE(IRANG+1),1)
      CALL PACK(IIDENT(2),4,ICF)
C     WRITE(NOU,6030) M,MM,IIDENT
C     WRITE(NOUT1,6030) M,MM,IIDENT
C6030 FORMAT(10X,'MATERIAL NO. - ',I3,' MATERIAL REGION -',I3,
C    1       ' MATERIAL NAME - ',2A4)
C
CJ    READ(MACRO.FSMAT.ERANG.#0) IDENT,IP,LTH,(B(I),I=1,LTH)
C********************************** PDS FILE ***************************
C     CALL GETLEN(IIDENT,LENGTH)
      CALL SEARCH(IIDENT,LENGTH,ISW)
      IF (ISW.EQ.0) GO TO 111
      IF (ICF.NE.'0002') GO TO 111
      CALL PACK(IIDENT(2),4,'0004')
  111 CALL GETLEN(IIDENT,LENGTH)
      CALL READ(IIDENT,B,LENGTH)
      LTH = LENGTH - 1
C********************************** PDS FILE ***************************
      IF(LTH.LE.LIMB) GO TO 115
      WRITE(NOUT1,7010) LIMB,LTH
      STOP 7
  115 CONTINUE
      IBP = 0
      DO 120 I=1,IGM
       XKI(I) = B(IBP+7)
       IBP = IBP + IB(IBP+2) + 10
  120 CONTINUE
       IF(XKI(1).NE.0.) GO TO 135
  130 CONTINUE
  135 CONTINUE
      WRITE(NOU,6010) VE
      WRITE(NOU,6020) XKI
CKH
      IF(ITYPE.NE.0) RETURN
      REWIND ITFLUX
      DO 150 N=1,IGM
      DO 140 I=1,ITJT
  140 S(I)=1.0
      WRITE(ITFLUX) (S(I),I=1,ITJT)
  150 CONTINUE
      RETURN
 6000 FORMAT('0  FISSION SPECTRUM   VELOCITY LOADS START FROM MACRO ',
     &       'FILE ( ',A4,A1,'.',2A4,'.MACR.',2A4,' )'/6X,
     &       'NUMBER OF GROUPS',20X,I8          /6X,
     &       'FISSION SPECTRUM USED MATERIAL NAME ',2A4              )
 6010 FORMAT('0 *VELOCITIES*'/(1P10E12.5)  )
 6020 FORMAT('0 *FISSION SPECTRUM*'/(1P10E12.5)  )
 7000 FORMAT('0**** ERROR NUMBER OF GROUPS IS UNMACHED ( IGM,NGR ) ',
     &        2I10          )
 7010 FORMAT('0**** ERROR ALOCATED ARRAY ( B ) ',I10,' REQUIRED LENGTH',
     &        ' OF MATRIX',I10 )
      END
