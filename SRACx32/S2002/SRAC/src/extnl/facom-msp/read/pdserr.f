      SUBROUTINE PDSERR(IECODE,MEMBER,IFUNC,FILEN)
C
C     ERROR MESSAGE FOR PDSFUTY
C
      CHARACTER*8   MEMBER,FILEN
      CHARACTER*16  FUNC(8)
      CHARACTER*22  ERMES(19)
      DIMENSION     IDENT(48)
C
      DATA IDENT/1,9,3,2,6*18,4,5,4,6,4,18,7,8,6*9,10,18,11,12,11,12,
     1      13,18,14,2*18,15,2*16,2*17,2*18,19,5*18 /
C
      DATA ERMES/
     1 'ALREADY OPEND         ','LENGTH ZERO ENCOUNTERD',
     1 'DEFINED LENGTH OVER   ','MEMBER NOT FOUND      ',
     1 'ALREADY MEMBER EXIST  ','MEMBER NOT FOUND/EXIST',
     1 'OPEN MACRO ERROR      ','CLOSE MACRO ERROR     ',
     1 'NOT OPENED            ','GETDTRY MACRO ERROR   ',
     1 'READ I/O ERROR        ','NO SPACE IN DIRECTORY ',
     1 'OPEN/CLOSE MACRO ERROR','NO SPACE IN STORAGE   ',
     1 'WRITE      MACRO ERROR','FIND     MACRO ERROR  ',
     1 'STOW MACRO ERROR      ','UNEXPECTED ERROR      ',
     1 'NO SPACE IN WORK ARRAY'/
C
      DATA FUNC/
     1 'FILE OPEN       ','FILE CLOSE      ','READ MEMBER     ',
     1 'WRITE MEMBER    ','SEARCH MEMBER   ','RENAME MEMBER   ',
     1 'DELETE MEMBER   ','GET DIRECTRY    '/
C
C
C
      IECOD4 = IECODE/4
      IP     = IFUNC+(IECOD4-1)*8
      IPOS   = IDENT(IP)
C
      IF(IFUNC.LE.2) THEN
      WRITE(6,*) ' *** ',ERMES(IPOS),' ***ENCOUNTERED ON FUNCTION '
     * ,FUNC(IFUNC),' FOR DD= ',FILEN,' ECODE=',IECODE
                     ELSE
      WRITE(6,*) ' *** ',ERMES(IPOS),' ***ENCOUNTERED ON FUNCTION '
     * ,FUNC(IFUNC),' FOR MEMBER=',MEMBER,' DD= ',FILEN,' ECODE=',IECODE
                     END IF
C
      IF(IECODE.EQ.4) RETURN
C
CKSK  CALL ERRTRA
CKSK  CALL UERTRA
      STOP
      END
