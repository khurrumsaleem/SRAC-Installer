CKPER --124 ***CITATION*** LINE RELAXATION ON ROWS FOR PERIODIC
C                          BOUNDARY CONDITIONS (3-D)/ CF-KNSD
C
      SUBROUTINE KPER(SCATE,P2E,DCONBE,DCONRE,DCONBK,PTSAE,TSOUR, NRGNE,
     &  E1,LVX, IVX,JVX,KBVX,KVX,IVXP1,JVXP1,KBVXP1, JIVX,JIP1VX,JP1IXZ,
     &  IOVX,IOVZ)
C
CDEL  INTEGER RGX , MSX , ZNEX , ZDX , WZX
CDEL  PARAMETER ( RGX=100, MSX=211, ZDX=200, ZNEX=1000, WZX=100 )
      INCLUDE  'CITPMINC'
C
      COMMON/ALSUB/BLSUB(30),TITL1(18),TITL2(18),IMAX,JMAX,KBMAX,KMAX,
     & LMAX,MMAX, NMAX,IMXP1,JMXP1,KBMXP1,NSETMX,NTO,MM1VX,KM1VX,IOIN,
     & IOUT,IOSIG,IOFLX,IO1,IO2,IO3,IO4,IO7,NER(100), IX(200),INNO(100),
     &  NGC(24),IEDG(24),ITMX(24),TIMX(6), GLIM(6),NDPL(24),IEDP1(24),
     & IEDP2(24),IEDP3(24), DPLH(6),NUAC(24),EPI(6),XMIS(6),NSRH(24),
     & XSRH1(6), XTR1(WZX),XTR2(WZX),NXTR1(WZX),NXTR2(WZX),SPARE(200),
     & IXPUT(200),XPUT(200)
      COMMON/AFLUX/BFLUX(30),KXMN8,NIT,NIIT,NIIIT,JXP1,KSCT1,KSCT2,
     & ISTART,IEP, VRGP1,VRGP2,VRGP3,VRG1,VRG2,VRGK1,VRGK2,XABS,PROD,
     & XLEK,RMX,RMN,XKEF1,XKEF2,XKEF3,EXFC1,EXFC2,EXFC3, NI3,IEXTR,
     & IRECV,VRGABS,LO3,LO4,XLAMDA,EPI1,EPI2, BETTA,SUMXI,IX25,IX28,I,J,
     &  KB,K,ITMAX,ITIME, BET(MSX),DEL(MSX)
C
      DIMENSION SCATE(JVX,IVX,KBVX),P2E(JIVX,KBVX,KVX), DCONBE(JIP1VX,
     & KBVX,IOVX),DCONRE(JP1IXZ,KBVX,IOVZ), DCONBK(JIVX,KBVXP1,IOVX),
     & PTSAE(JIVX,KBVX,IOVX)
      DIMENSION E1(LVX,KVX),NRGNE(JVX,IVX,KBVX)
      DIMENSION TSOUR(MSX)
      DIMENSION ALP(MSX)
C
CCCC ********** SUBSCRIPT DEFINITIONS (KPER E-071) ********* CCCCC
C    NEW         OLD            NEW         OLD
C     N1         J,I             N5 *     J+1,I
C     N2         J,I-1           N6       JVX,I
C     N3         J,I+1           N7 *     JVX,I
C     N4 *       1,I             N8 *   JVX+1,I
C
C
      N = IX(20)
      JVXM1 = JVX - 1
      DO 127 KB=1,KBVX
      KBM1 = KB - 1
      KBP1 = KB + 1
      DO 126 I=1,IVX
      IM1 = I - 1
      IP1 = I + 1
      NN1 = IM1*JVX
      NN2 = NN1 - JVX
      NN3 = NN1 + JVX
      N1 = NN1
      N2 = NN2
      N3 = NN3
      DO 104 J=1,JVX
      N1 = N1 + 1
      N2 = N2 + 1
      N3 = N3 + 1
      CKSS = SCATE(J,I,KB)
      IF (KB.LE.1) GO TO 100
      CKSS = CKSS + P2E(N1 ,KBM1,K)*DCONBK(N1 ,KB,N)
  100 IF (KB.GE.KBVX) GO TO 101
      CKSS = CKSS + P2E(N1 ,KBP1,K)*DCONBK(N1 ,KBP1,N)
  101 IF (I.LE.1) GO TO 102
      CKSS = CKSS + P2E(N2 ,KB,K)*DCONBE(N1 ,KB,N)
  102 IF (I.GE.IVX) GO TO 103
      CKSS = CKSS + P2E(N3 ,KB,K)*DCONBE(N3 ,KB,N)
  103 TSOUR(J) = CKSS
  104 CONTINUE
      NN4 = IM1*JVXP1
      N4 = NN4 + 1
      N5 = N4 + 1
      N1 = NN1 + 1
      D4 = DCONRE(N5 ,KB,N)
      IF (P2E(N1,KB,K).EQ.0.0) GO TO 105
      L = NRGNE(1,I,KB)
      BET(1) = TSOUR(1)/D4
      DEL(1) = D4/(PTSAE(N1 ,KB,N) + E1(L,K))
      ALP(1) = DCONRE(N4 ,KB,N)/D4
      GO TO 106
  105 BET(1) = 0.0
      DEL(1) = 0.0
      ALP(1) = 0.0
  106 CONTINUE
      DO 108 J=2,JVX
      N1 = N1 + 1
      N5 = N5 + 1
      IF (P2E(N1,KB,K).EQ.0.0) GO TO 107
      L = NRGNE(J,I,KB)
      T = D4*DEL(J-1)
      D4 = DCONRE(N5 ,KB,N)
      BET(J) = ( TSOUR(J) + BET(J-1)*T)/D4
      DEL(J) = D4/(PTSAE(N1 ,KB,N) + E1(L,K) - T)
      ALP(J) = ALP(J-1)*T/D4
      GO TO 108
  107 BET(J) = 0.0
      DEL(J) = 0.0
      ALP(J) = 0.0
  108 CONTINUE
      N6 = NN3
      N7 = NN4 + JVX
      N8 = N7 + 1
      IF (P2E(N6,KB,K).NE.0.0) GO TO 109
      TEMP = 0.0
      TT = 0.0
      GO TO 117
  109 F = 1.0
      D = 0.0
      E = 0.0
      DO 110 J=1,JVXM1
      F = F*DEL(J)
      IF (DEL(J).EQ.0.0) GO TO 111
      D = D + BET(J)*F
      E = E + ALP(J)*F
  110 CONTINUE
  111 CONTINUE
      RDEL = 0.0
      IF (DEL(JVXM1).NE.0.0) RDEL = 1.0/DEL(JVXM1)
      L = NRGNE(JVX,I,KB)
      D1 = DCONRE(N7 ,KB,N)
      D2 = DCONRE(N8 ,KB,N)
      D4 = D1 + F*D2
      TEMP =((TSOUR(JVX) + D*D2)*RDEL + D4*BET(JVXM1))/ ((PTSAE(N6 ,KB,
     & N) + E1(L,K) - E*D2)*RDEL - D4*(1.0 + ALP(JVXM1)))
      TT = TEMP
      T = P2E(N6 ,KB,K)
      TMF=T+BETTA*(TEMP-T)
      IF (IEP) 112,116,113
  112 P2E(N6 ,KB,K) = TEMP
      GO TO 117
  113 IF (TMF-TEMP) 115,116,114
  114 TMF=AMIN1(TMF,(TEMP+T))
      GO TO 116
  115 TMF=AMAX1(TMF,0.5*TEMP)
  116 CONTINUE
      P2E(N6 ,KB,K) = TMF
  117 DO 125JJ=2,JVX
      J=JVXP1-JJ
      N1= NN1 + J
      T=P2E(N1 ,KB,K)
      IF (T.NE.0.0) GO TO 118
      TEMP = 0.0
      GO TO 125
  118 CONTINUE
      TEMP = DEL(J)*(TEMP + BET(J) + TT*ALP(J))
      TMF=T+BETTA*(TEMP-T)
      IF (IEP) 119,123,120
  119 P2E(N1 ,KB,K)=TEMP
      GO TO 125
  120 IF (TMF-TEMP) 122,123,121
  121 TMF=AMIN1(TMF,(TEMP+T))
      GO TO 123
  122 TMF=AMAX1(TMF,0.5*TEMP)
  123 CONTINUE
  124 P2E(N1 ,KB,K)=TMF
  125 CONTINUE
  126 CONTINUE
  127 CONTINUE
      RETURN
      END
