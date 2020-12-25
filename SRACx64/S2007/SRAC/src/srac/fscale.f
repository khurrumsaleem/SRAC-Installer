      SUBROUTINE  FSCALE(IMAXX,IMAX,X,Y,NLOGX,NLOGY,XWIDE,YWIDE,IXMIN,
     *IYMIN,AX1,AX2,AY1,AY2,XWITH,YWITH)
      REAL  X(IMAXX),Y(IMAX)
      IF(NLOGX.EQ.0)    GO TO  100
      DO  200  I=1,IMAXX
      IF(X(I).LE.0.)  X(I)=0.
      IF(X(I).EQ.0.) GO TO  200
      X(I)=(ALOG10(X(I))-FLOAT(IXMIN))*XWIDE
      IF(X(I).LE.0.)   X(I)=0.
      IF(X(I).GT.XWITH)  X(I)=XWITH
  200 CONTINUE
      GO TO  250
  100 DO  300  I=1,IMAXX
      X(I)=(X(I)-AX1)/AX2
      IF(X(I).LT.0.)    X(I)=0.
      IF(X(I).GT.XWITH)  X(I)=XWITH
  300 CONTINUE
  250 CONTINUE
      IF(NLOGY.EQ.0)   GO TO  400
      DO  350   I=1,IMAX
      IF(Y(I).LE.0.)  Y(I)=0.
      IF(Y(I).EQ.0.)   GO TO  350
      Y(I)=(ALOG10(Y(I))-FLOAT(IYMIN))*YWIDE
      IF(Y(I).GT.YWITH)  Y(I)=YWITH
      IF(Y(I).LE.0.)   Y(I)=0.
  350 CONTINUE
      GO TO 450
  400 CONTINUE
      DO  500  I=1,IMAX
      Y(I)=(Y(I)-AY1)/AY2
      IF(Y(I).GT.YWITH)  Y(I)=YWITH
      IF(Y(I).LE.0.)   Y(I)=0.
  500 CONTINUE
  450 RETURN
      END
