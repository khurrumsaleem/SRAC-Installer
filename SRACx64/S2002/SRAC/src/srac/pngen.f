C             PNGEN               LEVEL=1        DATE=81.11.14
      SUBROUTINE PNGEN (P,R,CM,CE,PHI,T,ISCT,MM,NM,ISC)
C
C     COPIED MOSTLY FROM DTF IV
C
C
      DIMENSION CM(1), PHI(1), T(1), P(MM,ISC,ISC), R(NM,MM,4), CE(1)
C
      IF=2*ISCT+1
C
C     GENERATE PHI
C
      DO 100 M=1,MM
  100 PHI(M)=ATAN(SQRT(1.-CM(M)**2-CE(M)**2)/CE(M))
      II=1
      DO 210 L=1,2
      TE=(-1.)**L
      DO 210 I=1,2
      TM=(-1.)**I
C     ZEROTH ORDER PNM (LEGENDE POLYNOMIALS)
      DO 120 M=1,MM
      C=TM*CM(M)
      P(M,1,1)=1.0
      IF (ISCT.EQ.0) GO TO 120
      P(M,2,1)=C
      IF (ISCT.EQ.1) GO TO 120
      DO 110 N=2,ISCT
      P(M,N+1,1)=(2.-1./N)*P(M,N,1)*C-(1.-1./N)*P(M,N-1,1)
  110 CONTINUE
  120 CONTINUE
      IF (ISCT.EQ.0) GO TO 180
C     ASSOCIATED LEGENDRE POLYNOMIALS
      DO 155 M=1,MM
      C=TM*CM(M)
      DO 155 J=2,ISC
      DO 150 N=1,ISC
      IF (N-J) 150,130,140
  130 P(M,N,J)=(2*J-3)*SQRT(1.-C*C)*P(M,N-1,J-1)
  140 IF (N.EQ.ISC) GO TO 150
      P(M,N+1,J)=((2*N-1)*C*P(M,N,J)-(N+J-2)*P(M,N-1,J))/(N-J+1)
  150 CONTINUE
  155 CONTINUE
C     FACTORIALS
      T(1)=1.
      DO 160 J=2,IF
  160 T(J)=(J-1)*T(J-1)
C     MULTIPLY BY COSPHI TERM (ADJUSTED FOR SIGN OF ETA),
C     AND FACTORIAL COEFFICIENT
      DO 170 J=2,ISC
      DO 170 N=J,ISC
      B=SQRT(2.*T(N-J+1)/T(N+J-1))
      DO 170 M=1,MM
      C=PHI(M)
      IF (TE.LT.0.0) C=C+3.14159265359
  170 P(M,N,J)=B*P(M,N,J)*COS((J-1)*C)
C     REDUCE NUMBER OF INDICES
  180 K=1
      DO 200 N=1,ISC
      DO 200 J=1,N
      DO 190 M=1,MM
      R(K,M,II)=P(M,N,J)
  190 CONTINUE
      K=K+1
  200 CONTINUE
      II=II+1
  210 CONTINUE
      RETURN
      END
