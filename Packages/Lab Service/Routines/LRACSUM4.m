LRACSUM4 ;SLC/DCM - PRINT INDIVIDUAL PATIENT SUMMARY ; 2/11/88  12:06 ;
 ;;5.2;LAB SERVICE;**201**;Sep 27, 1994
BS ;from LRACSUM3
 K I,^TMP($J,"TY") S LRCW=10,LRHI="",LRLO="",LRTT=1,I=0,LRTY=IOM-20\10,LRMU=LRMU+1
 S LRII=0 F  S LRII=$O(^LAB(64.5,1,1,LRMH,1,LRSH,1,LRII)) Q:LRII<1  S Z=^(LRII,0),P3=$P(Z,U,3),P6=$P(Z,U,6),I=I+1,I(I)=LRII,^TMP($J,"TY",0,I)=P3 S:P6 ^TMP($J,"TY",I,"D")=P6
 K P3,P6
 F K=1:1:(LRTY-1) S LRFDT=$O(^TMP($J,LRDFN,LRMH,LRSH,LRFDT)) Q:LRFDT<1  S Z=^(LRFDT,0),^TMP($J,"TY",K,"L")=$P(Z,U,1),LRTT=LRTT+1 S:LRFDT>LRLFDT LRLFDT=LRFDT D UDT^LRACSUM3 D BS1
 S:LRTT>(LRTY-1)&(LRMULT=1) LRFULL=1 S:LRTT>(LRTY-1)&(LRMU=(LRMULT-1)) LRFULL=1 F I=1:1:LRSHD D LRLO^LRACSUM5 S:$L(LRLOHI) ^TMP($J,"TY",(LRTT+1),I)=LRLOHI S:$L(P7) ^TMP($J,"TY",LRTT,I)=P7
 S ^TMP($J,"TY",LRTT,"T")="Units",^TMP($J,"TY",(LRTT+1),"T")="Ranges",^TMP($J,"TY",(LRTT+1),0)=$S($L($P(^LAB(64.5,"A",1,LRMH,LRSH,I(1)),U,11)):"Therapeutic",1:"Reference"),^TMP($J,"TY",LRTT,0)=""
 W !
 I $D(LRCALE(LRMH,LRSH)) W !,"Locale " F I=1:1:(LRTT-1) W $J(^TMP($J,"TY",I,"L"),10)
 ;
 ;
Y2K ;
 W !,$E(LRTOPP,1,7),?6 F I=1:1:(LRTT+1) W $J(^TMP($J,"TY",I,0),10)
YEAR ;
 W !?5 F I=1:1:(LRTT-1) W $J(^TMP($J,"Y2K",I),10)
 W !?6 F I=1:1:(LRTT+1) W $J(^TMP($J,"TY",I,"T"),10)
 ;W !,$E(LRTOPP,1,7),?7 F I=1:1:(LRTT+1) W $J(^TMP($J,"TY",I,0),6),"  "
 ;W !,$E(LRTOPP,1,7),?7 F I=1:1:(LRTT+1) W ^TMP($J,"TY",I,0)_" "
 ;
 ;W !?6 F I=1:1:(LRTT+1) W $J(^TMP($J,"TY",I,"T"),10)
 ;W !?11 F I=1:1:(LRTT+1) W ^TMP($J,"TY",I,"T")_"     "
 D DASH^LRX
 F I=1:1:LRSHD S LRCL=8,LRG=^LAB(64.5,1,1,LRMH,1,LRSH,1,I(I),0) W ! D BS4
 I $D(LRTX) S LRTX="" W !,"Comments: " F I=1:1 S LRTX=$O(LRTX(LRTX)) Q:LRTX=""  W ?(10*LRTX-6),$C(96+I)
 D TXT1^LRACSUM5 S LROFDT=LRFDT I $D(LRTX) S LRTX="" F I=1:1 S LRTX=$O(LRTX(LRTX)) Q:LRTX=""  S LRFDT=LRTX(LRTX) W !,$C(96+I),". " D TXT^LRACSUM5
 S LRFDT=LROFDT K LRTY,LRTX,^TMP($J,"TY") I 'LRFDT G LRSH^LRACSUM3
 I $O(^TMP($J,LRDFN,LRMH,LRSH,LRFDT))="" G LRSH^LRACSUM3
 S LRFDT=LRLFDT I LRFULL D HEAD^LRACSUM6,LRNP^LRACSUM3 S LRFULL=0,LRMU=0
 G BS
BS1 S ^TMP($J,"TY",K,0)=$P(LRUDT," ",1),^TMP($J,"TY",K,"T")=$P(LRUDT," ",2) S ^TMP($J,"TY",K,0)=$P(LRUDT," ",1),^TMP($J,"TY",K,"T")=$P(LRUDT," ",2) S ^TMP($J,"Y2K",K)=$E($P($P($$Y2K^LRX(LRFDT),"."),"/",3),1,4)
 F J=1:1:LRSHD S:$D(^TMP($J,LRDFN,LRMH,LRSH,LRFDT,I(J))) ^TMP($J,"TY",K,J)=^(I(J)) S:$D(^TMP($J,LRDFN,LRMH,LRSH,LRFDT,"TX"))&'$D(LRTX(LRTT)) LRTX(LRTT)=LRFDT
 Q
BS2 S X=$S($D(^TMP($J,"TY",J,I)):$P(^(I),U,1),1:""),X1=$S($L(X):$P(^TMP($J,"TY",J,I),U,2),1:""),LRDP=$S($D(^TMP($J,"TY",I,"D")):^("D"),1:""),LRCL=LRCL+10
 K T1,T3 Q
BS4 F J=0:1:(LRTT+1) W:J=0 ^TMP($J,"TY",J,I) W ?LRCL I J>0 D BS2 I $L(X) S LRCW=10 D:J<LRTT C1^LRACSUM5 W:$L($P(LRG,U,4))&(J<LRTT) @$P(LRG,U,4),X1 W:'$L($P(LRG,U,4))!(J'<LRTT) $J(X,LRCW)
 Q