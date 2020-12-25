      SUBROUTINE      UMCSET(IRCODE)
C
      REAL*8          EBOUND,UIGP,UFGP,UBGP,DELU
      CHARACTER*4     IDTMP,NFILE
      CHARACTER*8     MEMBER
C
      COMMON /UMCPIN/ ITAPE,MATNO,NPE,NPF,NPC,IZA,ISWUN,AM,ELOW,EHI,
     +                RFTEMP,QVALE,QVALF,QVALC,EULOW,EUHIGH
      COMMON /UMCINT/ NPMAX,IFISS,IENDUN,IDPOS,ISWTMP,MF,MT,NP,IMAX,
     +                NSYSI,NSYSO,RQTEMP,NPRT,IPRINT
C
      COMMON /UMC001/ LIBTYP,NEF,ISTART,NG,NOMESH,KFGP,NGMAX,MAXINT,NSET
      COMMON /UMC002/ ENERGY(75),EE(47),NI(46),INTNO(46),
     +                NXG(10),NFI(10),NOIG(10),MST(46),MEND(46)
      COMMON /UMC003/ EBOUND(11),UIGP(10),UFGP(10),UBGP(46)
      COMMON /UMC004/ INTBL(2000),ENGD(2000)
      COMMON /UMCTMP/ NTEMP,TMPSET(40),IDTMP(40)
      COMMON /PCOWK3/ WORK(1000),IWORK(46),ECONT(100)
C
      COMMON /PDSPDS/ BUFFER(540),IFLSW,NFILE(3),ECODE,TEMPPP
C
C     SET COMMON VALUE FROM 'CONT000N' MEMBER OF USER'S MCROSS
C
C
C     READ FAST ENERGY STRUCTURE FORM 'FASTU' LIBRARY
C
      CALL CLEA ( ECONT , 100 , 0.0 )
      IFLSW     = 1
      NFILE(1)  = 'FAST'
      NFILE(2)  = 'U   '
      MEMBER    = 'FASTLIB '
C
      CALL READ (MEMBER ,NEF   ,1)
      LENG = NEF*2 + 5
      CALL READ (MEMBER ,WORK  ,LENG)
C
      DO 50  I = 1 , NEF + 1
      ECONT(I) = WORK(4+NEF+I)
   50 CONTINUE
C
      NEFOLD    = NEF
      IFLSW     = 1
      NFILE(1)  = 'UMCR'
      NFILE(2)  = 'OSS '
C
C     READ 'CONT0001' FROM USER'S MCROSS LIBRARY
C
      IRCODE   = 0
      LENG     = 9
      MEMBER   = 'CONT0001'
      CALL READ  ( MEMBER , IWORK , LENG )
C
      LIBTYP   =  IWORK(1)
      NEF      =  IWORK(2)
      ISTART   =  IWORK(3)
      NG       =  IWORK(4)
      NOMESH   =  IWORK(5)
      KFGP     =  IWORK(6)
      NGMAX    =  IWORK(7)
      MAXINT   =  IWORK(8)
      NSET     =  IWORK(9)
C
      IF(NEF.NE.NEFOLD) THEN
                        IRCODE = 1
                        RETURN
                        ENDIF
C
C     READ 'CONT0002' FROM USER'S MCROSS LIBRARY
C
      LENG    = 75 + 47 + 4*46 + 30
      MEMBER   = 'CONT0002'
      CALL READ (  MEMBER , ENERGY, LENG )
C
      DO 100 I = 1 , NEF
      SAVE     = ENERGY(I)/ECONT(I) - 1.0000
      IF(ABS(SAVE).GT.0.0001) IRCODE = 1
  100 CONTINUE
      IF(IRCODE.NE.0) RETURN
C
C     READ 'CONT0003' FROM USER'S MCROSS LIBRARY
C
      LENG     = 2 * ( 11 + 10 + 10 + 46 )
      MEMBER   = 'CONT0003'
      CALL READ ( MEMBER , EBOUND , LENG )
C
C     READ 'CONT0004' FROM USER'S MCROSS LIBRARY
C
      LENG     =  NGMAX
      MEMBER   = 'CONT0004'
      CALL READ  ( MEMBER , INTBL , LENG  )
C
C     READ 'CONT0005' FROM USER'S MCROSS LIBRARY
C
      LENG     =  NGMAX
      MEMBER   = 'CONT0005'
      CALL READ  ( MEMBER , ENGD  , LENG  )
C
C     READ 'CONTTEMP' FROM USER'S MCROSS LIBRARY
C
      LENG     =  81
      MEMBER   = 'CONTTEMP'
      CALL READ  ( MEMBER , NTEMP , LENG  )
C
C     PRINT THE  USER'S MCROSS ENERGY STRUCTURE
C
      IF(IPRINT.LE.0)  GO TO 699
C
      WRITE(NPRT,703) NEF,NG,ISTART,LIBTYP,MAXINT,NGMAX,KFGP,NOMESH
      WRITE(NPRT,704)
      DO 710           I = 1 , NOMESH
      WRITE(NPRT,705) I,EBOUND(I),EBOUND(I+1),UIGP(I),UFGP(I),
     +                   NFI(I),NXG(I)
  710 CONTINUE
      WRITE(NPRT,704)
C
  699 CONTINUE
      ISUM     = 1
      DSAVE    = 0.0
      ISAVE    = 0
      WRITE(NPRT,701)
      DO 700 I = 1,NG
      JSAVE    = NI(I)   - ISAVE
      DELU     = UBGP(I) - DSAVE
      IF(INTNO(I).GT.0) THEN
                        WRITE(NPRT,702) I,EE(I),EE(I+1),DELU,JSAVE,
     +                                   NI(I),INTBL(ISUM),INTNO(I)
                        ELSE
                        WRITE(NPRT,702) I,EE(I),EE(I+1),DELU,JSAVE,
     +                                   NI(I),INTBL(ISUM)
                        ENDIF
      ISUM     = 1     +  NI(I)
      DSAVE    = UBGP(I)
      ISAVE    = NI(I)
  700 CONTINUE
C
CDEL  WRITE(NPRT,707) (NOIG(I),I=1,NOMESH)
CDEL  WRITE(NPRT,708) (UBGP(I),I=1,NG)
CDEL  WRITE(NPRT,711)   NSET
CDEL  WRITE(NPRT,712) (MST(I),I=1,NSET)
CDEL  WRITE(NPRT,713) (MEND(I),I=1,NSET)
CDEL  WRITE(NPRT,721)   NTEMP
CDEL  WRITE(NPRT,722) (TMPSET(I),I=1,NTEMP)
CDEL  WRITE(NPRT,723) (IDTMP (I),I=1,    40)
C
CDEL  WRITE(NPRT,714)
CDEL  WRITE(NPRT,706) (I,ENGD(I),INTBL(I),I=1,NGMAX)
C
C     END OF PROCESS
C
      RETURN
C
  701 FORMAT(//1H ,35X,'ENERGY GROUP STRUCTURE FOR USER''S MCROSS',
     1/1H0,30X,'ENERGY (EV)',11X,'LETHAGY',9X,'NUMBER OF   START   '
     2,2X,'LENGTH OF'/1H ,22X,'NO.',2X,'UPPER   -    LOWER'
     3,7X,'WIDTH',11X,'I.M. GROUP  POSITION  SUBSECTION ')
  702 FORMAT(1H ,20X,I4,1X,F8.4,1X,' - ',1X,F8.4,4X,F9.5,6X,3I6,I12)
  703 FORMAT(//1H ,25X,
     +     ' << INFORMATION OF USER''S MCROSS ENERGY MESH >>'/
     +/1H ,20X,'NEF    ; NO. OF NERGY GROUP IN FAST-LIB. --------- ',I6,
     +/1H ,20X,'NG     ; NO. OF ENERGY GROUP IN PEACO ------------ ',I6,
     +/1H ,20X,'ISTART ; INITIAL GROUP NO. AT WHICH PEACO START -- ',I6,
     +/1H ,20X,'LIBTYP ; ENERGY MESH DEVIDION TYPE --------------- ',I6,
     +/1H ,20X,'MAXINT ; MAXIMUN NO. OF INERMEDIATE GROUP -------- ',I6,
     +/1H ,20X,'NGMAX  ; TOTAL INTERMEDIATE GROUP NO. ------------ ',I6,
     +/1H ,20X,'KFGP   ; NO. OF FINE GROUP IN A INTERMEDIATE GRP.- ',I6,
     +/1H ,20X,'NOMESH ; NO. OF BROAD GROUP IN MCROSS LIB.-------- ',I6,
     +//1H ,10X,'MESH',2X,' UPPER    ',2X,'LOWER     ',2X,'  UIGP    ',
     +                 2X,'  UFGP    ',2X,' NFI    CUMULATIVE'
     + /1H ,10X,' NO ',2X,'ENERGY(EV)',2X,'ENERGY(EV)',2X,'(INTERME.)',
     +                 2X,' (FINE)   ',2X,'        MESH NO. ')
  704 FORMAT(1H , 9X,9(8H--------),4H----)
  705 FORMAT(1H ,10X,I3,4F12.6,3(I6,6X))
  706 FORMAT(1H ,10X,I4,E12.5,I12,10X,I4,E12.5,I12,10X,I4,E12.5,I12)
  707 FORMAT(1H ,' ## NOIG ## ',10I10)
  708 FORMAT(1H ,' ## UBGP ## ',1P10E11.4)
  709 FORMAT(1H ,' ERROR STOP AT SUBROUTINE(UMCSET) BECAUSE OF FATAL ',
     +           'PROGRAMING ERROR ]] ',
     +/1H ,' LENGTH OF INTBL OR ENGD ARRAY IS NEEDED ',I6,' WARDS.')
  711 FORMAT(1H ,' ## NSET ## ',10I10)
  712 FORMAT(1H ,' ## MST  ## ',10I10)
  713 FORMAT(1H ,' ## MEND ## ',10I10)
  714 FORMAT(/1H ,' ## NO ENGD INTBL ## ')
  721 FORMAT(1H ,' ## NTEMP ## ',I10)
  722 FORMAT(1H ,' ## TMPSET## ',10F10.3)
  723 FORMAT(1H ,' ## IDTMP ## ',20A4)
C
      END
