ORPFCNVT ; SLC/AEB - Convert Order Parameter File (100.99) to Parameter Definitions(8989.51) ;3/17/97  12:17
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;
 ;  This program will move data from the Order Parameter File into the Parameter definitions
SYS1 N X,I,ENT,INST,ERR S X=$G(^ORD(100.99,1,0))
 ;W !,"ENTITY",?10,"PARAMETER",?41,"INSTANCE",?55,"VALUE",!
 ;D SAVE("SYS","ORPF TREATING SPECIALTY",1,$P(X,U,3),.ERR)
 ;D SAVE("SYS","ORPF LAST PURGE DATE",1,$P(X,U,5),.ERR)
 D STUF("SYS","ORPF LAST PURGE DATE",1,$P(X,U,5),.ERR)   ;non-editable
 D SAVE("SYS","ORPF LAST ORDER PURGED",1,"`"_$P(X,U,6),.ERR)
 D SAVE("SYS","ORPF ERROR DAYS",1,$P(X,U,7),.ERR)
 ;D SAVE("SYS","ORPF SHOW PATIENT NAME",1,$P(X,U,11),.ERR)
 D SAVE("SYS","ORPF ACTIVE ORDERS CONTEXT HRS",1,$P(X,U,12),.ERR)
 D SAVE("SYS","ORPF REVIEW ON PATIENT MVMT",1,$P(X,U,13),.ERR)
 D SAVE("SYS","ORPF INITIALS ON SUMMARY",1,$P(X,U,14),.ERR)
 D SAVE("SYS","ORPF DEFAULT PROVIDER",1,$P(X,U,15),.ERR)
 D SAVE("SYS","ORPF CONFIRM PROVIDER",1,$P(X,U,17),.ERR)
 ;
SYS2 S X=$G(^ORD(100.99,1,2))
 ;D SAVE("SYS","ORPF ELECTRONIC SIGNATURE",1,$P(X,U,1),.ERR)
 D SAVE("SYS","ORPF EXPAND CONTINUOUS ORDERS",1,$P(X,U,5),.ERR)
 D SAVE("SYS","ORPF CHART COPY FORMAT",1,"`"_$P(X,U,6),.ERR)
 D SAVE("SYS","ORPF CHART COPY HEADER",1,"`"_$P(X,U,7),.ERR)
 D SAVE("SYS","ORPF CHART COPY FOOTER",1,"`"_$P(X,U,8),.ERR)
 D SAVE("SYS","ORPF RESTRICT REQUESTOR",1,$P(X,U,17),.ERR)
 D SAVE("SYS","ORPF AUTO UNFLAG",1,$P(X,U,18),.ERR)
 ;
MPKG5 S I=0 F  S I=$O(^ORD(100.99,1,5,I)) Q:I'>0  D
 .S ENT="PKG.`"_I
 .;S X=$G(^ORD(100.99,1,5,I,4)) D SAVE(ENT,"ORPF CLEAN-UP ACTION",1,$P(X,U,1),.ERR)
 .;S X=$G(^ORD(100.99,1,5,I,15)) D SAVE(ENT,"ORPF PATIENT SELECT ACTION",1,$P(X,U,1),.ERR)
 ;
MSYS20 S I=0 F  S I=$O(^ORD(100.99,1,20,I)) Q:I'>0  D
 .S X=^ORD(100.99,1,20,I,0),INST="`"_I
 .D SAVE("SYS","ORPF WARD LABEL FORMAT",INST,"`"_$P(X,U,3),.ERR)
 .D SAVE("SYS","ORPF WARD REQUISITION FORMAT",INST,"`"_$P(X,U,4),.ERR)
 .D SAVE("SYS","ORPF SERVICE COPY DEFLT DEVICE",INST,"`"_$P(X,U,5),.ERR)
 .D SAVE("SYS","ORPF SERVICE COPY HEADER",INST,"`"_$P(X,U,7),.ERR)
 .D SAVE("SYS","ORPF SERVICE COPY FORMAT",INST,"`"_$P(X,U,6),.ERR)
 .D SAVE("SYS","ORPF SERVICE COPY FOOTER",INST,"`"_$P(X,U,8),.ERR)
 .S J=0 F  S J=$O(^ORD(100.99,1,20,I,1,J)) Q:J'>0  D
 ..S X=^ORD(100.99,1,20,I,1,J,0),ENT="LOC.`"_$P(X,U,1)
 ..D SAVE(ENT,"ORPF SERVICE COPY DEFLT DEVICE",INST,"`"_$P(X,U,2),.ERR)
 ;
MLOC25 S I=0 F  S I=$O(^ORD(100.99,1,25,I)) Q:I'>0  D
 .S X=^ORD(100.99,1,25,I,0),ENT="LOC.`"_I
 .D SAVE(ENT,"ORPF PROMPT FOR CHART COPY",1,$P(X,U,3),.ERR)
 .D SAVE(ENT,"ORPF CHART COPY PRINT DEVICE",1,"`"_$P(X,U,4),.ERR)
 .D SAVE(ENT,"ORPF LABEL PRINT DEVICE",1,"`"_$P(X,U,5),.ERR)
 .D SAVE(ENT,"ORPF REQUISITION PRINT DEVICE",1,"`"_$P(X,U,6),.ERR)
 .D SAVE(ENT,"ORPF PROMPT FOR LABELS",1,$P(X,U,7),.ERR)
 .D SAVE(ENT,"ORPF PROMPT FOR REQUISITIONS",1,$P(X,U,8),.ERR)
 .D SAVE(ENT,"ORPF PRINT DAILY ORDER SUMMARY",1,$P(X,U,9),.ERR)
 .D SAVE(ENT,"ORPF DAILY ORDER SUMMARY DEVC",1,"`"_$P(X,U,10),.ERR)
 .D SAVE(ENT,"ORPF PRINT CHART COPY SUMMARY",1,$P(X,U,11),.ERR)
 Q
SAVE(ENT,PAR,INST,VAL,ORERR) ;
 I ($L(VAL)&(VAL'="`")) D
 .;W !,ENT,?10,PAR,?45,INST,?55,VAL
 .D EN^XPAR(ENT,PAR,INST,VAL,.ORERR) I ORERR D ONERR
 Q
STUF(ENT,PAR,INST,VAL,ORERR) ; bypass input xform
 D PUT^XPAR(ENT,PAR,INST,VAL,.ORERR) I ORERR D ONERR
 Q
ONERR ; come here on error, expects ORERR,ENT,PAR,INST,VAL to be defined
 N X
 S X(1)="Error: "_PAR_" "_$$EZBLD^DIALOG(+ORERR)
 S X(2)="       Entity:"_ENT_"  Inst:"_INST_"  Val:"_VAL
 D MES^XPDUTL(.X)
 Q