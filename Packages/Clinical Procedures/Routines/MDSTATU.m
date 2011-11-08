MDSTATU ; HOIFO/NCA - Print List of Document Titles Needed ;10/21/04  13:44
 ;;1.0;CLINICAL PROCEDURES;**5**;Apr 01, 2004;Build 1
 ; Reference Integration Agreement:
 ; IA# 10035 [Supported] Access to DPT file (#2)
 ; IA# 10039 [Supported] Hospital Location lookup in DIC(42
 ; IA# 10061 [Supported VADPT calls
 ; IA# 10104 [Supported] Routine XLFSTR calls
 ;
DISP ; Display List of TIU titles need to be created for Medicine procedures
 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP Q:POP
 I $D(IO("Q")) S ZTRTN="D1^MDSTATU",ZTREQ="@",ZTSAVE("ZTREQ")="",ZTDESC="List Documents Titles Needed",(ZTDTH,ZTIO)="" D ^%ZTLOAD D ^%ZISC W !,"Request Queued" Q
 U IO D D1 D ^%ZISC K %ZIS,IOP Q
D1 ; Process Display
 N ANS,CNT,DTP,LN,LP,MDK,MDF,MDFIL,MDN,MDN1,MDR,MDTIT,MDV,MDX,PG,S1,TIT,X
 S (CNT,PG)=0,ANS="",S1=$S(IOST?1"C".E:IOSL-2,1:IOSL-7) D H1 S MDFIL=8925.1
 S LP=0 F  S LP=$O(^MDD(703.9,1,1,LP)) Q:LP<1!(ANS="^")  S MDF=$G(^(LP,0)) D
 .Q:'$P(MDF,U,3)
 .S MDTIT=$P(MDF,U,5) Q:MDTIT
 .Q:'$P(MDF,U)  S MDR="MCAR("_+$P(MDF,U)
 .S MDN=0 F  S MDN=$O(^MCAR(697.2,"C",MDR,MDN)) Q:MDN<1!(ANS="^")  I $G(^MCAR(697.2,MDN,0))'="" D
 ..S CNT=CNT+1,MDK=$G(^MCAR(697.2,MDN,0)),TIT=$S($P(MDK,U,8)'="":$P(MDK,U,8),1:$P(MDK,U)),TIT=$$UP^XLFSTR(TIT),MDN1=$G(^MCAR(697.2,MDN,1))
 ..D:$Y'<S1 HDR Q:ANS="^"
 ..I $P(MDF,U)=699 Q:$P(MDN1,U)="S"
 ..I $P(MDF,U)=694 Q:$P(MDN1,U)="S"
 ..I $P(MDF,U)=699.5 Q:$P(MDN1,U)="P"
 ..S MDV="HISTORICAL "_TIT_$S(TIT["PROCEDURE":"",1:" PROCEDURE")
 ..S:$L(MDV)>60 MDV=$E(MDV,1,60)
 ..Q:+$$FIND1^DIC(MDFIL,"","BOX",MDV,"B","","MDERR")
 ..W !,TIT,?35,MDV
 I 'CNT W !!,"No Historical TIU titles need to be created."
 W ! Q
PAUSE ; Pause For Scroll
 I IOST?1"C".E R !!,"Press RETURN to continue. ",X:DTIME S:'$T!(X["^") ANS="^" Q:ANS="^"  I "^"'[X W !,"Enter a RETURN to Continue." G PAUSE
 Q
DTP ; Printable Date/Time
 S %=DTP,DTP=$J(+$E(DTP,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(DTP,4,5))_"-"_$E(DTP,2,3)
 S:%#1 %=+$E(%_"0",9,10)_"^"_$E(%_"000",11,12),DTP=DTP_$J($S(%>12:%-12,1:+%),3)_":"_$P(%,"^",2)_$S(%<12:"am",%<24:"pm",1:"m") K % Q
HDR ; Display Header and Scroll Pause
 D PAUSE Q:ANS="^"
H1 ; Print Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 D NOW^%DTC S MDX=%
 S PG=PG+1,DTP=MDX D DTP W !,DTP,?20,"L I S T   O F   T I U   T I T L E S   N E E D E D",?73,"Page ",PG
 W ! S $P(LN,"-",80)="" W !,LN,!
 W !,"PROCEDURES",?35,"Titles Needed to be Created"
 W !,"----------",?35,"---------------------------",!
 Q
SETDEF ; Set default CP Definitions in Conversion Parameter
 N MDERR,MDDIEN,MDK,MDF,MDFC,MDFIL,MDFDA,MDLP,MDN,MDNAM,MDOPT,MDR,MDS,MDTAR,MDNAM,MDX,MDY S MDFIL=8925.1 K MDTAR
 F MDX=1:1 S MDOPT=$P($T(MEDTIT+MDX),";;",2) Q:MDOPT="**END**"  D
 .S MDS=$P(MDOPT,";",2)
 .S MDY=+$$FIND1^DIC(MDFIL,"","BOX",MDS,"B","","MDERR") Q:'MDY
 .S MDTAR(+MDOPT)=+MDY
 S MDLP=0 F  S MDLP=$O(^MDD(703.9,1,1,MDLP)) Q:MDLP<1  S MDF=$G(^(MDLP,0)) D
 .S MDFC=+$P(MDF,U)  Q:'MDFC  S MDR="MCAR("_MDFC
 .Q:MDFC=699
 .Q:MDFC=699.5
 .Q:MDFC=694
 .S (MDK,MDN)=0,MDNAM="" F  S MDN=$O(^MCAR(697.2,"C",MDR,MDN)) Q:MDN<1  I $G(^MCAR(697.2,MDN,0))'="" D
 ..S MDK=$G(^MCAR(697.2,MDN,0)),MDNAM=$S($P(MDK,U,8)'="":$P(MDK,U,8),1:$P(MDK,U)),MDNAM=$$UP^XLFSTR(MDNAM)
 .I MDNAM=""&(+$P(MDF,U)=694.5) S MDNAM="CARDIAC SURGERY RISK ASSESSMENT"
 .Q:MDNAM=""
 .S:$L(MDNAM)<30 MDNAM=MDNAM_" - HIST"
 .S:$L(MDNAM)>30 MDNAM=$E(MDNAM,1,30)
 .I '$O(^MDS(702.01,"B",MDNAM,0)) D
 ..Q:$P(MDF,U,2)'=""
 ..K MDERR,MDDIEN
 ..S MDFDA(702.01,"+1,",.01)=MDNAM
 ..D UPDATE^DIE("","MDFDA","MDDIEN","MDERR") Q:$D(MDERR)
 ..S:+MDDIEN(1) $P(^MDD(703.9,1,1,MDLP,0),U,2)=+MDDIEN(1)
 .I $P(MDF,U,5)="" S:+$G(MDTAR(MDFC)) $P(^MDD(703.9,1,1,MDLP,0),U,5)=+$G(MDTAR(MDFC))
 Q
GETMED(MDMNO,MDTYPE) ; Get the Medicine Procedure name
 N MDI,MDMF,MDLL,MDLL1,MDLL6,MDLL8,MDNA
 S MDNA=""
 Q:MDTYPE="" MDNA
 Q:'+MDMNO MDNA
 S MDI=+MDMNO,MDMF=+$P(MDMNO,"MCAR(",2) Q:'MDMF MDNA
 I MDMF=699 D
 .S (MDLL,MDLL1)=$P($G(^MCAR(699,+MDI,0)),U,12) Q:'MDLL
 .S MDLL=$G(^MCAR(697.2,MDLL,0)) Q:MDLL=""
 .S MDNA=$S($P(MDLL,U,8)'="":$P(MDLL,U,8),1:$P(MDLL,U)) Q
 I MDMF=699.5 D
 .S MDLL6=$P($G(^MCAR(699.5,+MDI,0)),U,6) Q:'MDLL6
 .S MDLL8=$P($G(^MCAR(699.5,+MDI,0)),U,8) S:MDLL8="" MDLL8=" "
 .S MDLL=$G(^MCAR(697.2,MDLL6,0)) Q:MDLL=""
 .I MDTYPE="N" S MDNA=$S($P(MDLL,U,8)'="":$P(MDLL,U,8),1:$P(MDLL,U)) Q
 .I MDTYPE="P" S MDNA=$E(($E($P(MDLL,U,8),1,13)_"/"_$P($G(^MCAR(697.2,+MDLL8,0)),U)),1,30)
 I MDMF=694 D
 .S MDLL=$P($G(^MCAR(694,MDI,0)),U,3) Q:'MDLL
 .S MDLL=$G(^MCAR(697.2,MDLL,0)) Q:MDLL=""
 .S MDNA=$S($P(MDLL,U,8)'="":$P(MDLL,U,8),1:$P(MDLL,U)) Q
 S:MDNA'="" MDNA=$$UP^XLFSTR(MDNA)
 Q MDNA
LOCATP(MDNNO) ; Locate the CP Definition procedure or Add the New Entry
 N MDDIEN,MDERR,MDFDA,MDNM,Y S Y=0
 Q:'+MDNNO 0  S MDMNO=MDNNO
 S MDNM=$$GETMED(MDMNO,"P") Q:MDNM="" Y
 S MDNM=MDNM_" - HIST" S:$L(MDNM)>30 MDNM=$E(MDNM,1,30)
 S Y=$O(^MDS(702.01,"B",MDNM,0)) Q:+Y Y
 S MDFDA(702.01,"+1,",.01)=MDNM
 D UPDATE^DIE("","MDFDA","MDDIEN","MDERR") Q:$D(MDERR)
 S Y=+MDDIEN(1)
 Q Y
LOCATN(MDNNO) ; Locate the Historical Document Title
 N MDDIEN,MDERR,MDFDA,MDNM,MDT,MDV,Y S Y=0,MDV=8925.1
 Q:'+MDNNO 0  S MDMNO=MDNNO
 S MDNM=$$GETMED(MDMNO,"N") Q:MDNM="" Y
 S MDT="HISTORICAL "_MDNM_$S(MDNM["PROCEDURE":"",1:" PROCEDURE")
 S Y=+$$FIND1^DIC(MDV,"","BOX",MDT,"B","","MDERR")
 Q Y
HOSP(MDNNO) ; Locate the Hospital Location
 N MDERR,MDI,MDMF,MDOPT,MDL,MDS,MDTAR,MDV,MDW,MDW1,MDX
 S MDL=0 K MDTAR
 Q:'+MDNNO MDL
 S MDI=+MDNNO,MDMF=+$P(MDNNO,"MCAR(",2) Q:'MDMF MDL
 F MDX=1:1 S MDOPT=$P($T(MEDTIT+MDX),";;",2) Q:MDOPT="**END**"  D
 .S MDS=$P(MDOPT,";",3,4)
 .S MDTAR(+MDOPT)=MDS
 S MDS=$G(MDTAR(MDMF))
 S:+$P(MDS,";",2) MDL=$P($G(^MCAR(MDMF,MDI,$P(MDS,";"))),"^",+$P(MDS,";",2))
 I 'MDL D
 .S DFN=+$P($G(^MCAR(MDMF,MDI,0)),U,2),VAIP("D")=$P($G(^MCAR(MDMF,MDI,0)),U,1)
 .D IN5^VADPT S MDW=+VAIP(5) D KVAR^VADPT S:MDW MDL=+$P($G(^DIC(42,+MDW,44)),U)
 .I 'MDL S MDW=$G(^DPT(DFN,.1)) I MDW'="" S MDV=42,MDW1=$$FIND1^DIC(MDV,"","BOX",MDW,"B","","MDERR") S:MDW1 MDL=+$P($G(^DIC(42,+MDW1,44)),U)
 Q MDL
MEDTIT ;; [Medicine Historical Document Titles]
 ;;691.1;HISTORICAL CARDIAC CATHETERIZATION PROCEDURE;0;6
 ;;691;HISTORICAL ECHOCARDIOGRAM PROCEDURE;11;2
 ;;691.5;HISTORICAL ELECTROCARDIOGRAM PROCEDURE;8;1
 ;;691.8;HISTORICAL ELECTROPHYSIOLOGY PROCEDURE;15;3
 ;;691.7;HISTORICAL EXERCISE TOLERANCE TEST PROCEDURE;10;5
 ;;691.6;HISTORICAL HOLTER PROCEDURE;0;18
 ;;698;HISTORICAL PACEMAKER IMPLANTATION PROCEDURE
 ;;698.1;HISTORICAL PACEMAKER IMPLANTATION PROCEDURE
 ;;698.2;HISTORICAL PACEMAKER IMPLANTATION PROCEDURE
 ;;698.3;HISTORICAL PACEMAKER IMPLANTATION PROCEDURE
 ;;694.5;HISTORICAL PRE/POST SURGERY RISK NOTE
 ;;694; ;0;4
 ;;699; ;0;11
 ;;700;HISTORICAL PULMONARY FUNCTION TEST PROCEDURE;0;10
 ;;701;HISTORICAL RHEUMATOLOGY PROCEDURE
 ;;**END**