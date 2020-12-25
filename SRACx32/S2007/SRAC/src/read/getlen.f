      SUBROUTINE GETLEN(MEMBER,LENGTH)
C
      INCLUDE  'READPINC'
C
      CHARACTER*8     CZMEMB,SCMEMB,FLMODE,DATAKP,MEMBER
      CHARACTER*12    DDNAME,FILENM
      CHARACTER*68    PATHNM
      INTEGER*4       ECODE,TEMP,PATH
C
      COMMON /PDSPDS/ DDNAME(125),IST(15),IRW(15),IOS(35),NC(5,20),
     &                IFLSW,FILENM,ECODE,TEMP
C
      COMMON /PDSWK3/ PATHNM(15),FLMODE(15),DATAKP(15),CZMEMB(MAXMEM),
     1                SCMEMB(MAXMEM)
      COMMON /PDSWK2/ IZWRIT,IZMXDT,IZWCNT,IZDWTL,ICNTMX,
     1                LENPAT(15),INCORE(15),ICNTSC,
     2                IZDTLN(MAXMEM),IZDTTL(MAXMEM),IDUMZ,
     3                IPOSDD(MAXMEM),IPOSSC(MAXMEM),
     4                RZDATA(MXWORK)
C
C *  GETLEN
C
      PATH   = 5
      EOCDE  = 0
      LENGTH = 0
      CALL FILSRC(NFILE,FILENM)
C
      IF(IOS(NFILE).EQ.0) THEN
                    WRITE(6,*) ' *** FILE NOT OPENED DD=',DDNAME(NFILE)
                          STOP
                          ENDIF
C
      IF(  INCORE(NFILE) .EQ. 1 ) THEN
           DO 100 I=ICNTMX,1,-1
           IF( IPOSDD(I).EQ.NFILE .AND. CZMEMB(I).EQ.MEMBER) GO TO 200
  100      CONTINUE
           ENDIF
C
      LENG        = 0
CFACOMS
CM    CALL PDSLEN(DDNAME(NFILE),MEMBER,LENG,ECODE)
CFACOME
CUNIXS
      CALL PDSLEN( PATHNM(NFILE),LENPAT(NFILE),MEMBER,LENG,ECODE )
CUNIXE
      IF(ECODE.NE.0) THEN
                     CALL PDSERR(ECODE,MEMBER,PATH,DDNAME(NFILE))
                     RETURN
                     ENDIF
C
      NC(1,NFILE) = NC(1,NFILE) + 1
      LENGTH      = LENG/4
      RETURN
C
  200 LENGTH      = IZDTLN(I)
      ECODE       = 0
      NC(1,NFILE) = NC(1,NFILE) + 1
      RETURN
      END
