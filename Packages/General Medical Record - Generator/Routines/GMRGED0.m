GMRGED0 ;HIRMFO/RM,RTK-TEXT GENERATOR PATIENT DATA EDIT ;9/11/95
 ;;3.0;Text Generator;;Jan 24, 1996
EN1 ; ENTRY TO GMR TEXT GENERATOR IF PRIME DOCUMENT IS KNOWN
 ; GMRGRT=PTR TO 124.2 FOR PD^PD TEXT
 Q:'$D(GMRGRT)  Q:$P(GMRGRT,"^")'>0!($P(GMRGRT,"^",2)="")
 S (GMRGUP,GMRGOUT)=0,DIC="^DPT(",DIC(0)="AEQM",DIC("A")="Select Patient: " W ! D ^DIC K DIC S:$D(DTOUT)!$D(DUOUT) GMRGOUT=1 S:+Y'>0 GMRGUP=1 G Q1:GMRGOUT!GMRGUP S DFN=+Y
 D EN4 G Q1:GMRGOUT!GMRGUP,EN1
Q1 K DFN,DIC,DTOUT,DUOUT,GMRGUP
 Q
EN4 ; ENTRY IF PATIENT, PRIME DOCUMENT KNOWN
 Q:'$D(GMRGRT)!'$D(DFN)
 S GMRGXPRT="0^1^1" D EN1^GMRGRUT3 G:GMRGOUT!(GMRGPDA'>0) Q4
 D EN3 G Q4:GMRGOUT!GMRGUP,EN4
Q4 S GMRGUP=0 K GMRGPDA
 Q
EN3 ; ENTRY IF PATIENT, PRIME DOCUMENT AND GMR TEXT 124.3 FILE ENTRY KNOWN.
 ; DFN=PTR TO PATIENT, GMRGPDA=PTR TO 124.3 FILE, GMRGRT= PDOC PTR^TEXT
 Q:'$D(DFN)!'$D(GMRGPDA)!'$D(GMRGRT)  Q:DFN'>0!(GMRGPDA'>0)!($P(GMRGRT,"^")'>0)!($P(GMRGRT,"^",2)="")  K GMRGTPLT
 S GMRGOUT=0 L +^GMR(124.3,GMRGPDA,0):1 I '$T W !,$C(7),"ANOTHER TERMINAL IS EDITING THIS ENTRY!!" L -^GMR(124.3,GMRGPDA,0) Q
 D BEGADD^GMRGED7
 D DEM^VADPT,INP^VADPT
 S GMRGVNAM=VADM(1),GMRGVSSN=$P(VADM(2),U,2),GMRGVDOB=$P(VADM(3),U,2),GMRGVAGE=VADM(4),GMRGVAMV=VAIN(1),GMRGVPRV=$P(VAIN(2),U,2),GMRGVWRD=$P(VAIN(4),U,2),GMRGVRBD=VAIN(5),GMRGVADT=$P(VAIN(7),U,2),GMRGVDX=VAIN(9) D KVAR^VADPT K VA
 K ^TMP($J) S GMRGTOP(0)=+GMRGRT,(GMRGNORD,GMRGUP)=0,(GMRGTOP,GMRGLVL)=1,GMRGLVL(1)=1,GMRGLVL(1,1)=1,GMRGTERM=GMRGRT,GMRGTERM(0)=$S($D(^GMRD(124.2,+GMRGRT,0)):^(0),1:""),GMRGSCRP=0
 S GMRGSITE=$S($P(GMRGTERM(0),"^",3)="":"",1:$O(^GMRD(124.1,1,1,"B",$P(GMRGTERM(0),"^",3),0))),GMRGSITE("P")=$S($D(^GMRD(124.1,1,1,+GMRGSITE,"P")):^("P"),1:""),GMRGSITE(0)=$S($D(^GMRD(124.1,1,1,+GMRGSITE,0)):^(0),1:"")
 S GMRGPRC=$P(GMRGRT,"^")_"^^0",GMRGPRC(0)=$P(GMRGRT,"^",2),^TMP($J,"GMRGLVL",1,1,1)=$P(GMRGRT,"^")_"^^0",^TMP($J,"GMRGLVL",1,1,1,0)=$P(GMRGRT,"^",2)
 S IOP="HOME" D ^%ZIS S X="IORVON;IORVOFF" D ENDR^%ZISS S GMRGIO("RVOF")=IORVOFF,GMRGIO("RVON")=IORVON,GMRGIO("S")=$L(GMRGIO("RVOF"))&$L(GMRGIO("RVON")) K IORVOFF,IORVON
 S (GMRGLIN("-"),GMRGLIN("*"))="",$P(GMRGLIN("-"),"-",IOM+1)="",$P(GMRGLIN("*"),"*",IOM+1)="" ;D:$D(XRTL) T0^%ZOSV ; START RT
 D EN1^GMRGED1 D QP^GMRGED2 S:'GMRGUP GMRGUP=GMRGNORD#2
 I GMRGUP,'GMRGOUT D  G Q3:GMRGOUT!GMRGUP,EN3
 .   W ! S DIR("A")="Would you like to print a copy of this "_$P(GMRGRT,"^",2)_"? ",DIR(0)="YA",DIR("B")="YES" D ^DIR S:"^^"[Y GMRGOUT=1 Q:Y=0!GMRGOUT
 .   D NOW^%DTC S GMRGPDT=%,GMRGPROU="D "_$S(GMRGSITE("P")'="":GMRGSITE("P"),1:"EN1^GMRGPUTL") X GMRGPROU
 .   Q
Q3 K ^TMP($J),D,DIK,GMRG0,GMRG00,GMRG01,GMRG02,GMRG03,GMRG1,GMRG2,GMRG10,GMRG11,GMRG12,GMRG13,GMRG14,GMRG3,GMRG4,GMRG5,GMRG6,GMRG7,GMRG8,GMRGART,GMRGCNT,GMRGDLT,GMRGDN,GMRGHOW,GMRGIO,GMRGJUMP
 K GMRGKU,GMRGL,GMRGLEN,GMRGLIN,GMRGLIST,GMRGLVL,GMRGOOD,GMRGMAX,GMRGMIN,GMRGMSR,GMRGND,GMRGNORD,GMRGPAT,GMRGPATH,GMRGPDT,GMRGPLN,GMRGPRC,GMRGPROU,GMRGPRT,GMRGPSEL,GMRGQ,GMRGQUSL,GMRGRDIS,GMRGREP
 K GMRGS,GMRGSCRP,GMRGSEL,GMRGSELC,GMRGSELP,GMRGSITE,GMRGSLVL,GMRGSLY,GMRGST,GMRGSTAR,GMRGTCHK,GMRGTDL,GMRGTERM,GMRGTLC,GMRGTLVL,GMRGTOP,GMRGTPLT,GMRGTX,GMRGUSL,GMRGXDF,GMRGY,Y,Z D KVAR^VADPT K VA L -^GMR(124.3,GMRGPDA,0)
 Q
EN2 ; ENTRY TO GMR TEXT GENERATOR IF UNKNOWN PRIME DOCUMENT
 W !
 S DIC="^GMRD(124.2,",DIC(0)="AEQ",DIC("A")="Select Document for which patient data will be added: ",DIC("S")="S GMRG=$O(^GMRD(124.25,""B"",""PRIME DOCUMENT"",0)) I $P(^GMRD(124.2,+Y,0),U,4)=GMRG",DIC("W")="" D ^DIC K DIC G Q2:+Y'>0
 S GMRGRT=Y D EN1 G Q2:GMRGOUT,EN2
Q2 K GMRGOUT,GMRGRT,DIC,GMRG
 Q