      SUBROUTINE GETDIR(PREFIX,DIRNAM,LENG)
      CHARACTER*120    DIRNAM
      CHARACTER*30     PREFIX
C
      CALL GETENV(PREFIX,DIRNAM)
      LENG = INDEX(DIRNAM," ") - 1
      IF (LENG.GT.120) THEN
C     WRITE(6,*) DIRNAM(1:LENG)
        WRITE(6,6000) 
        STOP
      ENDIF
 6000 FORMAT(//1H ,'<<<  ERROR STOP (GETDIR)  >>>',/,1X,
     &'PDS FILE ACCESS ERROR, DIRECTORY NAME IS TOO LONG < 121')
      RETURN
      END
