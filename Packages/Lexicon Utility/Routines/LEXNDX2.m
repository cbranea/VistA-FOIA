LEXNDX2 ; ISL Set/kill indexes (Part 2)            ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
SS ; Get (unique) text for an expression in the Subset file
 Q:'$D(X)!('$D(DA))
 N LEXEXP,LEXMC,LEXTEXP,LEXOLDX S LEXOLDX=X
 S LEXEXP=+(^LEX(757.21,DA,0)),LEXMC=$P(^LEX(757.01,LEXEXP,1),U,1)
 S LEXTEXP=0 F  S LEXTEXP=$O(^LEX(757.01,"AMC",LEXMC,LEXTEXP)) Q:+LEXTEXP=0  D
 . S X=^LEX(757.01,LEXTEXP,0) D SS2
 S X=LEXOLDX K LEXOLDX,LEXEXP,LEXMC,LEXTEXP Q
SS2 ; Parse text and set node for each word
 N LEXYPE,LEXT,LEXSIDX,LEXIDX,LEXD,LEXJ,LEXI S LEXIDX=""
 S LEXYPE=+($P($G(^LEX(757.01,LEXTEXP,1)),U,2)) Q:LEXYPE'>0
 S LEXT=+($P($G(^LEX(757.011,LEXYPE,0)),"^",2)) Q:LEXT=0
 S LEXSIDX="A"_$P(^LEXT(757.2,LEXOLDX,0),U,2)
 D PTX^LEXTOLKN
 I $D(^TMP("LEXTKN",$J,0)),^TMP("LEXTKN",$J,0)>0 S LEXI="" F LEXJ=1:1:^TMP("LEXTKN",$J,0) D
 . S LEXI=$O(^TMP("LEXTKN",$J,LEXJ,""))
 . S:'$D(^LEX(757.21,LEXSIDX,LEXI,DA)) ^LEX(757.21,LEXSIDX,LEXI,DA)=""
 K LEXSIDX,LEXIDX,LEXD,LEXI,LEXJ,^TMP("LEXTKN",$J,0),^TMP("LEXTKN",$J) Q
SK ; Get (all) text for an expression in the Subset file
 Q:'$D(X)!('$D(DA))
 N LEXEXP,LEXMC,LEXTEXP,LEXOLDX S LEXOLDX=X
 S LEXEXP=+(^LEX(757.21,DA,0)),LEXMC=$P(^LEX(757.01,LEXEXP,1),U,1)
 S LEXTEXP=0 F  S LEXTEXP=$O(^LEX(757.01,"AMC",LEXMC,LEXTEXP)) Q:+LEXTEXP=0  D
 . S X=^LEX(757.01,LEXTEXP,0) D SK2
 S X=LEXOLDX K LEXOLDX,LEXEXP,LEXMC,LEXTEXP Q
SK2 ; Parse text and kill node for each word
 N LEXSIDX,LEXIDX,LEXD,LEXJ,LEXI S LEXIDX=""
 S LEXSIDX="A"_$P(^LEXT(757.2,LEXOLDX,0),U,2)
 D PTX^LEXTOLKN
 I $D(^TMP("LEXTKN",$J,0)),^TMP("LEXTKN",$J,0)>0 S LEXI="" F LEXJ=1:1:^TMP("LEXTKN",$J,0) D
 . S LEXI=$O(^TMP("LEXTKN",$J,LEXJ,""))
 . K ^LEX(757.21,LEXSIDX,LEXI,DA)
 K LEXSIDX,LEXIDX,LEXD,LEXI,LEXJ,^TMP("LEXTKN",$J,0),^TMP("LEXTKN",$J) Q
SET ; Given DIC and DA set indexes
 Q:$D(DIC)#2=0!('$D(DA))  Q:DIC'["LEX("&(DIC'["LEX(")
 N LEXRT,LEXFN,LEXFL,LEXRIDX,LEXN,LEXP,X
 S LEXFN=+($P(DIC,"(",2)),LEXRT=$TR($P(DIC,"(",1),"^","")
 S LEXFL=0 F  S LEXFL=$O(^DD(LEXFN,LEXFL)) Q:+LEXFL=0  D
 . S LEXN=$P($P(^DD(LEXFN,LEXFL,0),U,4),";",1)
 . S LEXP=$P($P(^DD(LEXFN,LEXFL,0),U,4),";",2),LEXRIDX=0
 . F  S LEXRIDX=$O(^DD(LEXFN,LEXFL,1,LEXRIDX)) Q:+LEXRIDX=0  D
 . . I $L($P($G(@("^"_LEXRT_"("_LEXFN_","_DA_","_LEXN_")")),U,LEXP)) D
 . . . S X=$P($G(@("^"_LEXRT_"("_LEXFN_","_DA_","_LEXN_")")),U,LEXP)
 . . . X:X'="" ^DD(LEXFN,LEXFL,1,LEXRIDX,1)
 . . I DA>$P($G(@("^"_LEXRT_"("_LEXFN_",0)")),"^",3) S $P(@("^"_LEXRT_"("_LEXFN_",0)"),"^",3)=DA
 K LEXFN,LEXFL,LEXRIDX,LEXN,LEXP,X
 Q
KILL ; Given DIC and DA kill indexes
 Q:$D(DIC)#2=0!('$D(DA))  Q:DIC'["LEX("&(DIC'["LEX(")
 N LEXRT,LEXFN,LEXFL,LEXRIDX,LEXN,LEXP,X
 S LEXFN=+($P(DIC,"(",2)),LEXRT=$TR($P(DIC,"(",1),"^","")
 S LEXFL=0 F  S LEXFL=$O(^DD(LEXFN,LEXFL)) Q:+LEXFL=0  D
 . S LEXN=$P($P(^DD(LEXFN,LEXFL,0),U,4),";",1)
 . S LEXP=$P($P(^DD(LEXFN,LEXFL,0),U,4),";",2),LEXRIDX=0
 . F  S LEXRIDX=$O(^DD(LEXFN,LEXFL,1,LEXRIDX)) Q:+LEXRIDX=0  D
 . . I $L($P($G(@("^"_LEXRT_"("_LEXFN_","_DA_","_LEXN_")")),U,LEXP)) D
 . . . S X=$P($G(@("^"_LEXRT_"("_LEXFN_","_DA_","_LEXN_")")),U,LEXP)
 . . . X:X'="" ^DD(LEXFN,LEXFL,1,LEXRIDX,2)
 K LEXFN,LEXFL,LEXRIDX,LEXN,LEXP,X
 Q
SAPP ; Set application subset definition index
 I X'="" D
 . N LEXIDX S LEXIDX=$P(^LEXT(757.2,DA,0),U,2) I LEXIDX'="" D
 . . K ^LEXT(757.2,"AA",LEXIDX) S $P(^LEXT(757.2,DA,0),U,2)="" K LEXIDX
 . S ^LEXT(757.2,"AB",X,DA)=""
 Q
KAPP ; Kill application subset definition index
 K ^LEXT(757.2,"AB",X,DA) Q
SSM ; Set index for Subset Mnemonic
 S ^LEXT(757.2,"AA",X,DA)="" N LEXX,LEXLOW
 S LEXX=$P($G(^LEXT(757.2,DA,0)),U,1)
 S:$L(LEXX) ^LEXT(757.2,"AA",LEXX,DA)="",^LEXT(757.2,"AA",$$UP^XLFSTR(LEXX),DA)=""
 I $L(LEXX) D
 . N X,LEXI S X=LEXX,LEXLOW="" D PTX^LEXTOLKN
 . I +($G(^TMP("LEXTKN",$J,0)))>0 F LEXI=1:1:+($G(^TMP("LEXTKN",$J,0))) D
 . . S ^LEXT(757.2,"AA",$O(^TMP("LEXTKN",$J,LEXI,"")),DA)=""
 . . S ^LEXT(757.2,"AA",$$UP^XLFSTR($O(^TMP("LEXTKN",$J,LEXI,""))),DA)=""
 Q
KSM ; Kill index for Subset Mnemonic
 K ^LEXT(757.2,"AA",X,DA) N LEXX,LEXLOW
 S LEXX=$P($G(^LEXT(757.2,DA,0)),U,1)
 K:$L(LEXX) ^LEXT(757.2,"AA",LEXX,DA),^LEXT(757.2,"AA",$$UP^XLFSTR(LEXX),DA)
 I $L(LEXX) D
 . N X,LEXI S X=LEXX,LEXLOW="" D PTX^LEXTOLKN
 . I +($G(^TMP("LEXTKN",$J,0)))>0 F LEXI=1:1:+($G(^TMP("LEXTKN",$J,0))) D
 . . K ^LEXT(757.2,"AA",$O(^TMP("LEXTKN",$J,LEXI,"")),DA)
 . . K ^LEXT(757.2,"AA",$$UP^XLFSTR($O(^TMP("LEXTKN",$J,LEXI,""))),DA)
 Q