PRCFDADD ;WISC@ALTOONA/CTB-COMPRESS ADDRESS INTO PRINTABLE FORMAT ;10 Sep 89/3:08 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;TAKES ADDRESS IN PRCFA("TMP",X) AND COMPRESSES IT INTO PRINTABLE
 ;ARRAY PRCFA("TMP1",X)
 ;SOURCE ARRAY MUST BE IN FOLLOWING FORMAT
 ;$P(PRCFA("TMP",1),"^",1,6) ADDRESS LINES
 ;$P(PRCFA("TMP",2),"^",1,3)=CITY_"^"_STATE_"^"_ZIP
 ;$P(PRCFA("TMP",3),"^",1,3)= OTHER PRINTABLE LINES
 N I,J,X S J=1 F I=1:1:6 I $P(PRCFA("TMP",1),"^",I)]"" S PRCFA("TMP1",J)=$P(PRCFA("TMP",1),"^",I),J=J+1
 S PRCFA("TMP1",J)="" S:$P(PRCFA("TMP",2),"^")]"" PRCFA("TMP1",J)=$P(PRCFA("TMP",2),"^")_", "
 I +$P(PRCFA("TMP",2),"^",2)>0 S PRCFA("TMP1",J)=PRCFA("TMP1",J)_$P(^DIC(5,$P(PRCFA("TMP",2),"^",2),0),"^",2)_"  "_$P(PRCFA("TMP",2),"^",3),J=J+1
 I $D(PRCFA("TMP",3)) F I=1:1:3 I $P(PRCFA("TMP",3),"^",I)]"" S PRCFA("TMP1",J)=$P(PRCFA("TMP",3),"^",I),J=J+1
 I $D(PRCFOUT) F I=0:0 S I=$O(PRCFA("TMP1",I)) Q:'I  S X="S "_PRCFOUT_I_")=PRCFA(""TMP1"",I)" X X
 K PRCFA("TMP") K:$D(PRCFOUT) PRCFOUT,PRCFA("TMP1")
 Q
ADD ;IDENTIFIER FOR FILE 440
 ;REQUIRES Z8 TO CONTAIN NODE 7 OF VENDOR FILE
 W !,?10,"PAYMENT ADDRESS:  ",$P(Z8,"^",3)
 I $P(Z8,"^",4)]"" W !?28,$P(Z8,"^",4)
 I $P(Z8,"^",5)]"" W !?28,$P(Z8,"^",5)
 I $P(Z8,"^",6)]"" W !?28,$P(Z8,"^",6)
 W !?28,$P(Z8,"^",7),", ",$S($D(^DIC(5,+$P(Z8,U,8),0)):$P(^(0),"^",2),1:"")," ",$P(Z8,U,9)
 K Z8 W ! Q