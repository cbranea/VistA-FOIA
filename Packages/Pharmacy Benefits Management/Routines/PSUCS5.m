PSUCS5 ;BIR/DJE,DJM - PBM CS ASSEMBLE RECORD ;10 JUL 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ; DBIA(s)
 ; none needed for this routine
 ;
 ; 
 ; Build a reporting record(s)
 ; 
 ;
 ;
BUILDREC ; Assemble record
 Q:'$G(PSUTQY(5))  ; quit if quantity = 0
 K PSUR
 I PSUTYP=2,$S(PSULTP(1)="M":0,PSULTP(1)="S":0,1:1) Q
 I PSUTYP=17,$S(PSULTP(1)="N":0,1:1) Q
 I PSUTYP=2 S PSUMCHK=0
 S PSURIEN=$S(PSUMCHK:PSUMCIEN,1:PSUIENDA)
 ;S DRUG=$S(PSUTYP=2:PSUDRG(4),1:PSUDSE(4))
 S DRUG=PSUDRG(4)
 ;S PSURDIV=$S(PSURI="H":"H",1:1)    DAM TEST
 S PSUR(0)=PSUTYP
 S PSUR(2)=$G(SENDER)
 S PSUR(3)=$G(PSURI)
 ;S PSUR(4)=$P($S(PSUTYP=2:PSUDTM(3),1:""),".",1) ; Just the data
 S PSUR(4)=PSUDTM(3)\1
 ;S PSUR(4)=SEE ^XTMP(PSUCSJB,"MC",PSURDIV,PSUIENDA,DRUG)=PSUDTM(3)
 S PSUR(5)=$G(PSUPLC(.01))
 S PSUR(6)=$G(PSUSSN(.09))
 S PSUR(7)=$G(PSUVPN(21))
 S PSUR(8)=$G(PSUFID(.01))
 S PSUR(9)=$G(PSUGDN(.01))
 S PSUR(10)=$G(PSUFID(51))
 S PSUR(11)=$G(PSUNFI(17))
 S PSUR(12)=$G(PSUNFR(.01))
 S PSUR(13)=$G(PSUNDC(31))
 S PSUR(14)=$G(UNIT)
 I PSUTYP=2 S PSUR(15)=$G(PSUPDT(8))
 S PSUR(16)=$G(PSUPDU(16))
 S PSUR(17)=PSUTQY(5) ; both from type 2 & 17
 S PSUR(18)=$S($G(PSUDRG(52)):"N/F",1:"")
 S PSUR(19)=$G(PSUDRG(3))
 I PSUR(6)'="" S PSUSSN=PSUR(6) D ICN^PSUV2 D
 .;MVP OIFO BAY PINES;ELR;PSU*3.0*24
 .S PSUPICN=$G(^XTMP("PSU_"_PSUJOB,"PSUPICN"))
 S PSUR(20)=$G(PSUPICN)
 S PSUR=""
 S I=0 F  S I=$O(PSUR(I)) Q:I'>0  S PSUR(I)=$TR(PSUR(I),"^","'")
 S I=0 F  S I=$O(PSUR(I)) Q:I'>0  S $P(PSUR,"^",I)=PSUR(I)
 S PSUR=PSUR_"^"
 S PSURC=$G(PSURC,0)+1
 S PSURDIV=SENDER
 ;S PSURDIV=$S(PSURI="H":PSUSNDR,1:SENDER) ;PSUTYP=2:$S(PSUOS(20)="":PSUDIV(3.5),1:PSUOS(20)),1:PSUDIV(.015))    DAM TEST
 I 'PSUMCHK D
 . S ^XTMP(PSUCSJB,"RECORDS",PSURDIV,PSURIEN)=PSURC
 . M ^XTMP(PSUCSJB,"RECORDS",PSURDIV,PSURIEN,PSURC)=PSUR
 I PSUMCHK D
 . S PSURRC=$G(^XTMP(PSUCSJB,"RECORDS",PSURDIV,PSURIEN))
 . S $P(^XTMP(PSUCSJB,"RECORDS",PSURDIV,PSURIEN,PSURRC),"^",17)=PSUR(17)
 K PSUR
 Q