PSS59P7 ;BHM/DB - Pharmacy System File API ;1 JUL 05
 ;;1.0;PHARMACY DATA MANAGEMENT;**101,108**;9/30/97;Build 10
PSS(PSSIEN,PSSTXT,LIST) ;SRS 3.2.78
 ;PSSIEN - INTERNAL ENTRY NUMBER (optional)
 ;PSSTXT - Free Text site name (optional)
 ;LIST: Subscript name used in ^TMP global [REQUIRED]
 N X,DA,DR,DIC,DIQ
 I $G(PSSIEN)="",$G(PSSTXT)="" Q
 I $G(LIST)="" Q
 K ^TMP($J,LIST),DA,^UTILITY("DIQ1",$J),DIQ
 I $G(PSSIEN)]"" S DA=PSSIEN I '$D(^PS(59.7,DA,0)) G RET0
 I $G(PSSTXT)'="",$G(PSSIEN)'>0,'$D(^PS(59.7,"B",PSSTXT)) G RET0
 I $G(PSSTXT)'="",$G(DA)'>0 S DA=$O(^PS(59.7,"B",PSSTXT,0))
 K ^UTILITY("DIQ1",$J),DIC S DIC=59.7,DR=".01;40.1;49.99;81",DIQ(0)="IE" D EN^DIQ1
 I '$D(^UTILITY("DIQ1",$J)) G RET0
 S:$G(PSSTXT)="" PSSTXT=^UTILITY("DIQ1",$J,59.7,DA,.01,"E")
 F X=40.1,49.99,81 S ^TMP($J,LIST,DA,X)=$G(^UTILITY("DIQ1",$J,59.7,DA,X,"I"))
 S ^TMP($J,LIST,DA,40.1)=$S($G(^UTILITY("DIQ1",$J,59.7,DA,40.1,"E"))'="":^TMP($J,LIST,DA,40.1)_"^"_$G(^UTILITY("DIQ1",$J,59.7,DA,40.1,"E")),1:"")
 S ^TMP($J,LIST,DA,81)=$S($G(^UTILITY("DIQ1",$J,59.7,DA,81,"E"))'="":^TMP($J,LIST,DA,81)_"^"_$G(^UTILITY("DIQ1",$J,59.7,DA,81,"E")),1:"")
 S ^TMP($J,LIST,"B",PSSTXT,DA)=""
 K PSSIEN,DA,X,PSSTXT,DR,DIC,^UTILITY("DIQ1",$J) Q
RET0 ;return no data
 S ^TMP($J,LIST,0)="-1^NO DATA FOUND" Q