      SUBROUTINE UGTENV(ENVNAM,ENVVAL)
C=========================================================
C  GET CHARACTERS ALLOCATED TO ENVIROMENTAL PARAMETER
C  ORIGINAL FUNCTION IS "GETENV", BUT IT IS SYSTEM-DEPENDENT
C  EX. SETENV FILE1 /USER/OKUMURA/KEISUKE.DATA
C      INPUT  : ENVNAM = 'FILE1'
C      OUTPUT : ENVVAL = '/USER/OKUMURA/KEISUKE.DATA'
C
C=========================================================
      CHARACTER*(*)  ENVNAM, ENVVAL
C
CKSK  CALL GETENV(ENVNAM,ENVVAL)
      RETURN
      END
