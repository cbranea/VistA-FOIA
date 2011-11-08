SROQADM ;BIR/ADM - ADMISSIONS WITHIN 14 DAYS OF OUTPATIENT SURGERY ;09/22/98
 ;;3.0; Surgery ;**62,77,50,142**;24 Jun 93
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to ^DGPM("APTT1" supported by DBIA #565
 ;
 S SRSOUT=0,SRSPEC="" W @IOF,!,?18,"Outpatient Cases with Postop Occurrences",!,?24,"and Admissions Within 14 Days"
 W !!!,"This report displays the completed outpatient surgical cases which resulted in",!,"at least one postoperative occurrence and a hospital admission within 14 days.",!
SEL ; select date range and specialty
 D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END D SPEC^SROUTL G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,"^"),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,"^",2))
IO W !!,"This report is designed to use a 132 column format.",!
 K %ZIS,IOP,IO("Q"),POP S %ZIS("A")="Print the report to which Printer ? ",%ZIS("B")="",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Outpatient Cases with Admissions in 14 Days",(ZTSAVE("EDATE"),ZTSAVE("SDATE"),ZTSAVE("SRSITE*"),ZTSAVE("SRSPEC*"),ZTSAVE("SRINSTP"))="",ZTRTN="EN^SROQADM" D ^%ZTLOAD S SRSOUT=1 G END
EN U IO S (SRADMT,SRSOUT)=0,(SRHDR,SRPAGE)=1,SRSD=SDATE-.0001,SRED=EDATE+.9999,Y=SDATE X ^DD("DD") S STARTDT=Y,Y=EDATE X ^DD("DD") S ENDATE=Y K ^TMP("SR",$J)
 S SRRPT="OUTPATIENT CASES WITH POSTOP OCCURRENCES AND ADMISSIONS WITHIN 14 DAYS",SRFRTO="From: "_STARTDT_"  To: "_ENDATE
 S SRINST=$S(SRINSTP["ALL DIV":$P($$SITE^SROVAR,"^",2)_" - ALL DIVISIONS",1:$$GET1^DIQ(4,SRINSTP,.01))
 D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S SRPRINT="Report Printed: "_Y
 D HDR,AC
 I SRADMT=0 W $$NODATA^SROUTL0() G END
 S SRSD=0 F  S SRSD=$O(^TMP("SR",$J,SRSD)) Q:'SRSD!SRSOUT  S SRTN=0 F  S SRTN=$O(^TMP("SR",$J,SRSD,SRTN)) Q:'SRTN!SRSOUT  S SRZ=^TMP("SR",$J,SRSD,SRTN) D PRINT
 D:$Y+6>IOSL PAGE G:SRSOUT END W !,"TOTAL CASES: ",SRADMT
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" D PRESS
 D ^%ZISC K ^TMP("SR",$J),SR14,SRADM,SRADMT,SRFRTO,SRIO,SRIOT,SROCC,SRRPT,SRTN D ^SRSKILL W @IOF
 Q
AC F  S SRSD=$O(^SRF("AC",SRSD)) Q:'SRSD!(SRSD>SRED)!SRSOUT  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSD,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$MANDIV^SROUTL0(SRINSTP,SRTN) K SRADM D CASE I $O(SRADM(0)) D TMP
 Q
CASE ; examine case
 Q:'$P($G(^SRF(SRTN,.2)),"^",12)!($P($G(^SRF(SRTN,"NON")),"^")="Y")!$P($G(^SRF(SRTN,30)),"^")
 S SR(0)=^SRF(SRTN,0),DFN=$P(SR(0),"^"),SRSS=$P(SR(0),"^",4) I SRSPEC Q:SRSS'=SRSPEC
 S SRIO=$P(SR(0),"^",12) I SRIO'="O"&(SRIO'="I") S VAIP("D")=SRSD D IN5^VADPT S SRIO=$S(VAIP(13):"I",1:"O") K VAIP
 Q:(SRIO'="O")!'$O(^SRF(SRTN,16,0))
ADM ; check for admission within 14 days of surgery
 S (SRSDATE,X1)=$P($G(^SRF(SRTN,.2)),"^",12),X2=14 D C^%DTC S SR14=X
 F  S SRSDATE=$O(^DGPM("APTT1",DFN,SRSDATE)) Q:'SRSDATE!(SRSDATE>SR14)  S SRADM(SRSDATE)="",SRADMT=SRADMT+1 Q
 Q
TMP ; set TMP global
 S SRSDATE=$O(SRADM(0)),^TMP("SR",$J,SRSD,SRTN)=DFN_"^"_SRSDATE_"^"_SRSS
 Q
PRINT ; print case information
 D:$Y+9>IOSL PAGE Q:SRSOUT  S SRL=78,SRSUPCPT=1 D PROC^SROUTL
 S DFN=$P(SRZ,"^"),SRSS=$P(^SRO(137.45,$P(SRZ,"^",3),0),"^"),Y=$P(SRZ,"^",2) X ^DD("DD") S SRADM=$P(Y,":",1,2) S SRDOC=$P($G(^SRF(SRTN,.1)),"^",4) I SRDOC S SRDOC=$P(^VA(200,SRDOC,0),"^")
 D DEM^VADPT S SRSNM=VADM(1),SRSSN=VA("PID"),Y=SRSD X ^DD("DD") S SRSDATE=Y,SRAGE=$E(SRSD,1,3)-$E($P(VADM(3),"^"),1,3)-($E(SRSD,4,7)<$E($P(VADM(3),"^"),4,7))
 D TECH^SROPRIN S SRANES=$S(SRTECH'="":SRTECH,1:"NOT ENTERED") D OCC
 W !,SRSDATE,?22,SRSNM,?54,$S(SRSPEC:$E(SRDOC,1,30),1:$E(SRSS,1,30)),?87,SRANES,?114,SRADM
 W !,SRTN,?22,SRSSN_"  ("_SRAGE_")",?54,SRPROC(1),!
 F I=1:1 Q:'$D(SRPOST(I))&('$D(SRPROC(I+1)))  W:$D(SRPOST(I)) "*"_$P(SRPOST(I),"^")_" - ("_$P(SRPOST(I),"^",2)_")" W:$D(SRPROC(I+1)) ?54,SRPROC(I+1) W !
 W !
 Q
PRESS W !! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
OCC ; get post-op occurrences
 K SRPOST S SROCC=0,SRP=1
 F  S SROCC=$O(^SRF(SRTN,16,SROCC)) Q:'SROCC  S SRCAT=$P(^SRF(SRTN,16,SROCC,0),"^",2) I SRCAT S X=$P(^(0),"^",7) D
 .S:X Z=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) S:'X Z="??/??/??"
 .S SRPOST(SRP)=$P(^SRO(136.5,SRCAT,0),"^")_"^"_Z,SRP=SRP+1
 Q
PAGE I $E(IOST)="P"!SRHDR G HDR
 D PRESS I SRSOUT Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W:$Y @IOF W:$E(IOST)="P" !,?(IOM-$L(SRINST)\2),SRINST W !,?(IOM-$L(SRRPT)\2),SRRPT,?(IOM-10),$J("PAGE "_SRPAGE,9),!,?(IOM-$L(SRFRTO)\2),SRFRTO W:$E(IOST)="P" !,?(IOM-$L(SRPRINT)\2),SRPRINT
 I SRSPEC S X="SURGICAL SPECIALTY: "_SRSPECN W !,?(IOM-$L(X)\2),X
 W !!,"DATE OF OPERATION",?22,"PATIENT NAME",?54,$S(SRSPEC:"SURGEON",1:"SURGICAL SPECIALTY"),?87,"ANESTHESIA TECHNIQUE",?114,"DATE OF ADMISSION"
 W !,"CASE #",?22,"PATIENT ID  (AGE)",?54,"PROCEDURE(S) PERFORMED",!,"*OCCURRENCE - (DATE)"
 S SRHDR=0,SRPAGE=SRPAGE+1 W ! F I=1:1:IOM W "="
 Q