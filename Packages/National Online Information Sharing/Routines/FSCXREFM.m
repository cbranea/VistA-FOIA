FSCXREFM ;SLC/STAFF-NOIS Xrefs Misc ;5/26/98  14:37
 ;;1.1;NOIS;;Sep 06, 1998
 ;
AEP(OP,FIELD,VALUE,CALL) ; from dd 7100
 N PACK,STATUS
 I OP="SET" D  Q
 .I FIELD="STATUS" D  Q
 ..I VALUE=5 S PACK=$P(^FSCD("CALL",CALL,120),U,9) I PACK S ^FSCD("CALL","AEP",PACK,CALL)=""
 .I FIELD="PACK" D  Q
 ..I VALUE S STATUS=$P(^FSCD("CALL",CALL,0),U,17) I STATUS=5 S ^FSCD("CALL","AEP",VALUE,CALL)=""
 I OP="KILL" D  Q
 .I FIELD="STATUS" D  Q
 ..S PACK=$P(^FSCD("CALL",CALL,120),U,9) I PACK K ^FSCD("CALL","AEP",PACK,CALL)
 .I FIELD="PACK" D  Q
 ..K ^FSCD("CALL","AEP",VALUE,CALL)
 Q
 ;
ACN(OP,FIELD,VALUE,CALL) ; from dd 7100
 N CONTACT,STATUS
 I OP="SET" D  Q
 .I FIELD="STATUS" D  Q
 ..I VALUE,VALUE'=2 S CONTACT=$P(^FSCD("CALL",CALL,0),U,6) I CONTACT S ^FSCD("CALL","ACN",CONTACT,CALL)=""
 .I FIELD="CONTACT" D  Q
 ..I VALUE S STATUS=$P(^FSCD("CALL",CALL,0),U,2) I STATUS,STATUS'=2 S ^FSCD("CALL","ACN",VALUE,CALL)=""
 I OP="KILL" D  Q
 .I FIELD="STATUS" D  Q
 ..S CONTACT=$P(^FSCD("CALL",CALL,0),U,6) I CONTACT K ^FSCD("CALL","ACN",CONTACT,CALL)
 .I FIELD="CONTACT" D  Q
 ..K ^FSCD("CALL","ACN",VALUE,CALL)
 Q
 ;
AEN(OP,FIELD,VALUE,CALL) ; from dd 7100
 N ENTRYP,STATUS
 I OP="SET" D  Q
 .I FIELD="STATUS" D  Q
 ..I VALUE,VALUE'=2 S ENTRYP=+$P($G(^FSCD("CALL",CALL,120)),U,20) I ENTRYP S ^FSCD("CALL","AEN",ENTRYP,CALL)=""
 .I FIELD="ENTRYP" D  Q
 ..I VALUE S STATUS=$P(^FSCD("CALL",CALL,0),U,2) I STATUS,STATUS'=2 S ^FSCD("CALL","AEN",VALUE,CALL)=""
 I OP="KILL" D  Q
 .I FIELD="STATUS" D  Q
 ..S ENTRYP=$P($G(^FSCD("CALL",CALL,120)),U,20) I ENTRYP K ^FSCD("CALL","AEN",ENTRYP,CALL)
 .I FIELD="ENTRYP" D  Q
 ..K ^FSCD("CALL","AEN",VALUE,CALL)
 Q
 ;
ANS(OP,FIELD,VALUE,CALL) ; from dd 7100
 N SITE,STATUS
 I OP="SET" D  Q
 .I FIELD="STATUS" D  Q
 ..I VALUE,VALUE'=2 S SITE=$P(^FSCD("CALL",CALL,0),U,5) I SITE S ^FSCD("CALL","ANS",SITE,CALL)=""
 .I FIELD="SITE" D  Q
 ..I VALUE S STATUS=$P(^FSCD("CALL",CALL,0),U,2) I STATUS,STATUS'=2 S ^FSCD("CALL","ANS",VALUE,CALL)=""
 I OP="KILL" D  Q
 .I FIELD="STATUS" D  Q
 ..S SITE=$P(^FSCD("CALL",CALL,0),U,5) I SITE K ^FSCD("CALL","ANS",SITE,CALL)
 .I FIELD="SITE" D  Q
 ..K ^FSCD("CALL","ANS",VALUE,CALL)
 Q
 ;
ANDS(OP,FIELD,VALUE,CALL) ; from dd 7100
 N SPECD,STATUS
 I OP="SET" D  Q
 .I FIELD="STATUS" D  Q
 ..I VALUE,VALUE'=2 S SPECD=$P(^FSCD("CALL",CALL,0),U,21) I SPECD S ^FSCD("CALL","ANDS",SPECD,CALL)=""
 .I FIELD="SPECD" D  Q
 ..I VALUE S STATUS=$P(^FSCD("CALL",CALL,0),U,2) I STATUS,STATUS'=2 S ^FSCD("CALL","ANDS",VALUE,CALL)=""
 I OP="KILL" D  Q
 .I FIELD="STATUS" D  Q
 ..S SPECD=$P(^FSCD("CALL",CALL,0),U,21) I SPECD K ^FSCD("CALL","ANDS",SPECD,CALL)
 .I FIELD="SPECD" D  Q
 ..K ^FSCD("CALL","ANDS",VALUE,CALL)
 Q