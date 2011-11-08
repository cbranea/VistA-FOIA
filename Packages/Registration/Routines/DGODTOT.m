DGODTOT ;ALB/EG - PRINT TOTALS FOR OUTPUT REPORTS ; 2/22/89 1420
 ;;5.3;Registration;;Aug 13, 1993
 ;;V 4.5
TOTI ;grand total
 Q:ZRT[U  F I=30:10:110 W ?I,"======"
 W !,?1,"TOTAL",?30,^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"AS"),?40,^("AN"),?50,^("B"),?60,^("C"),?70,^("N"),?80,^("X"),?90,^("U")
 W ?100,^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV),?110,"("_$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2)_")"
 W !,?1,"%",?30,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"AS")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2),?40,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"AN")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2)
 W ?50,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"B")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2),?60,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"C")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2)
 W ?70,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"N")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2),?80,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"X")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2)
 W ?90,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"U")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2)
 W ?100,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2),!
 S ZRT1="Hit RETURN to continue" I (IOST["C-")&(IO=IO(0)) W !,?IOM-$L(ZRT1)-2,ZRT1 R ZRT:DTIME
 Q
HDR ;header
 U IO W @IOF,!,?1,"INPATIENT DISCHARGES REPORT",?IOM-20,T2 S $P(L,"-",IOM-1)="" W !,L,!
 W !,?1,"DATE RANGE: FROM  " S Y=DGBD X ^DD("DD") W Y,"  TO  " S Y=DGND X ^DD("DD") W Y,!
 W !,?(IOM-26\2),"MEANS TEST CLASSIFICATION",!
 Q
 ;
TOTO ;print total for division
 S ^UTILITY("DGOD",$J,DGJB,K1,DGDV)=$C(35)_U_DGGE_U_DGDV_U_DGJB_U_DGBD_U_DGND_U_DGTOUT
 Q:ZRT[U  Q:^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)=0  F I=30:10:110 W ?I,"======"
 W !,?1,"TOTAL",?30,^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"AS"),?40,^("AN"),?50,^("B"),?60,^("C"),?70,^("N"),?80,^("X"),?90,^("U")
 W ?100,^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV),?110,"("_$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2)_")"
 W !,?1,"%",?30,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"AS")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2),?40,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"AN")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2)
 W ?50,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"B")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2),?60,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"C")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2)
 W ?70,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"N")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2),?80,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"X")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2)
 W ?90,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,"U")/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2)
 W ?100,$J(^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)/^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)*100,2,2),!
 S ^UTILITY("DGOD",$J,DGJB,K1,DGDV)=$C(35)_U_DGGE_U_DGDV_U_DGJB_U_DGBD_U_DGND_U_DGTOUT
 S ZRT1="Hit RETURN to continue" I (IOST["C-")&(IO=IO(0)) W !,?IOM-$L(ZRT1)-2,ZRT1 R ZRT:DTIME
 Q
 ;