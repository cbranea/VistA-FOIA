NURAAU1 ;HIRMFO/RM/MD-DRIVER FOR ACUITY COUNTS...(cont.) ;2/27/98  14:20
 ;;4.0;NURSING SERVICE;**1,7,9,14**;Apr 25, 1997
EN1 ; ENTRY TO CALCULATE PATIENT ACUITY FOR NURSING WARD NWARD.
 I OUTSW G MID
 S NURTYPE=0 F NWARD=NWARD(0):0 S NWARD=$O(^TMP($J,"NURCEN",NWARD)) Q:NWARD'>0  F DFN=DFN(0):0 S DFN=$O(^TMP($J,"NURCEN",NWARD,DFN)) Q:DFN'>0  W:'$D(ZTQUEUED) "." S $P(^DIC(213.9,1,"DATE"),U,3,4)=NWARD_U_DFN D AGAIN
 S SHIFT="D" D HEMCOUNT^NURAAU3,RECOUNT^NURAAU3 S $P(^DIC(213.9,1,"DATE"),U,2)=1,$P(^("DATE"),U,3)=0,$P(^("DATE"),U,4)=0
MID Q:OUTSW(1)  S NURTYPE=1,(NURCUTDT,NURCENDT)=RPTDATE_".2400" D ^NURSACEN ; Calculate hospital census at evening shift cutoff time (Midnight Acuity).
 F NWARD=NWARD(1):0 S NWARD=$O(^TMP($J,"NURCEN",NWARD)) Q:NWARD'>0  F DFN=+DFN(1):0 S DFN=$O(^TMP($J,"NURCEN",NWARD,DFN)) Q:DFN'>0  W:'$D(ZTQUEUED) "." S $P(^DIC(213.9,1,"DATE"),U,7,8)=NWARD_U_DFN D AGAIN
 S SHIFT="E" D HEMCOUNT^NURAAU3,RECOUNT^NURAAU3 S $P(^DIC(213.9,1,"DATE"),U,6)=1,$P(^("DATE"),U,7)=0,$P(^("DATE"),U,8)=0
 Q
AGAIN ; CHECK PATIENT RECORD IS TO SEE IF VALID
 K CLASDT,NCWARD
 S BEDSECT=+$O(^NURSF(213.3,"B","DOMICILIARY",""))
 I $D(^NURSF(211.4,"ABS",BEDSECT,NWARD)) S SHIFT=$S(NURTYPE=0:"D",1:"E"),NBEDSECT=$E("00"_BEDSECT,1+$L(BEDSECT),2+$L(BEDSECT)),NCWARD=NWARD D DOMRECNT^NURAAU2 Q
 S CHGSW=0 D EN6^NURSCUTL S NURSCLAS("CL")=0 D EN2^NURSCUTL S NURSADM=$S(VAIN(1)="":"",1:$P(VAIN(7),U))
 I NURSADM="" S NURSADM=$P($G(^NURSF(214,DFN,0)),U,5) I NURSADM="" S NMESS="NOT ADMITTED",CLSDATE="" S:'NURTYPE NERR=NMESS S:NURTYPE NERR(1)=NMESS G WRITE
B1 I NURSCLAS="" S NMESS="NOT CLASSIFIED",CLSDATE="" S:'NURTYPE NERR=NMESS S:NURTYPE NERR(1)=NMESS G WRITE
 S CLASDT=9999999-$P(^NURSA(214.6,NURSCLAS,0),U) I NURTYPE,(((9999999-CLASDT)'<RPTDATE)&((9999999-CLASDT)'>(.24+RPTDATE))) G B2
 I 'NURTYPE,(((9999999-CLASDT)'<RPTDATE)&((9999999-CLASDT)'>(.15+RPTDATE))) G B2
 I NURSADM>$P(^NURSA(214.6,NURSCLAS,0),U) S NMESS="NOT CLASSIFIED",CLSDATE="" S:'NURTYPE NERR=NMESS S:NURTYPE NERR(1)=NMESS G WRITE
 I (9999999-CLASDT)<RPTDATE S NMESS="CLASS. NOT CURRENT",CLSDATE=9999999-CLASDT S:'NURTYPE NERR=NMESS S:NURTYPE NERR(1)=NMESS G WRITE
 S CHGSW=1,NURSLCS=9999999-CLASDT
B S CLASDT=$O(^NURSA(214.6,"AA",DFN,CLASDT)) G B0:CLASDT="",B:((9999999-CLASDT)>(.15+RPTDATE))
B0 I CLASDT'>0!((9999999-CLASDT)<RPTDATE) S:'NURTYPE NERR="NOT CLASS. BY 3 PM" S:NURTYPE NERR(1)="" S CLSDATE=NURSLCS G WRITE
 S NURSCLAS=$O(^NURSA(214.6,"AA",DFN,CLASDT,0)) I '($P($G(^NURSA(214.6,+NURSCLAS,0)),U,8)=NWARD) S:'NURTYPE NERR="NO CLASS./NEW WARD" S:NURTYPE NERR(1)="" S CLSDATE=NURSLCS G WRITE
B2 S NURSCLAS=$O(^NURSA(214.6,"AA",DFN,CLASDT,0)) F CHKVAR=0:0 S CHKVAR=$O(^(NURSCLAS)) Q:CHKVAR'>0  S X=$D(^NURSA(214.6,CHKVAR,0)) S:X NURSCLAS=CHKVAR I 'X K ^NURSA(214.6,"AA",DFN,CLASDT,CHKVAR)
 I NURSCLAS,'$D(^NURSA(214.6,NURSCLAS,0)) K ^NURSA(214.6,"AA",DFN,CLASDT,NURSCLAS) G B
 I NURSCLAS="" S NMESS="BAD CLASS. XREF",CLSDATE=9999999-CLASDT S:'NURTYPE NERR=NMESS S:NURTYPE NERR(1)=NMESS G WRITE
ANYCLASS ; CHECK TO SEE PATIENT HAS BEEN CLASSIFIED THAT DAY
 S DATECL=$G(^NURSA(214.6,NURSCLAS,0))
 S CLSDATE=$P(DATECL,U)
 S NCWARD=$P(DATECL,U,8) G:NCWARD="" A
 I NCWARD'=NWARD S NMESS="NO CLASS./NEW WARD" S NURSCLAS("CL")=2,NURSCLAS("WARD")=NWARD,NURSCLAS("DATE")=RPTDATE D EN2^NURSCUTL S:NURTYPE NERR(1)=NMESS S:'NURSCLAS NERR=NMESS G:NURSCLAS B1 G:NURSCLAS="" WRITE
 S CLASS=$P(DATECL,U,3),BEDSECT=$P(DATECL,U,9)
A I (CLASS="")!(BEDSECT="")!(NCWARD="") S NMESS="BAD DATA" S:'NURTYPE NERR=NMESS S:NURTYPE NERR(1)=NMESS G WRITE
NOCLASS ; ADD PATIENT CLASSIFICATION TO ACUITY COUNTS
 I $L(BEDSECT)=1 S BEDSECT="0"_BEDSECT
 S NCWARD=NWARD,SHIFT=$S(NURTYPE=0:"D",1:"E") F I=1:1:5 S NCLASS(I)=0
 S NCLASS(CLASS)=1
 I $P($G(^NURSF(211.4,NCWARD,1)),U)="A" D FINALLY^NURAAU0
 Q
 ;
WRITE ; WRITE EXCEPTION LINE
 D ^NURSAPCH,EXCP^NURAAU3
 K NMESS,NERR
 Q