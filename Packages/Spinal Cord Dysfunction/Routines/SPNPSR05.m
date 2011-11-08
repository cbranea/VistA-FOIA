SPNPSR05 ;HIRMFO/DAD,WAA-HUNT: HOURS OF HELP NEEDED ;8/7/95  12:42
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
EN1(D0,BHOUR,EHOUR,BDATE,EDATE) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING # HRS HELP") = Hours ^ Hours
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING # HRS HELP") = Hours ^ Hours
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING DATE") = Date ^ Date_(Ext)
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING DATE") = Date ^ Date_(Ext)
 ;  BHOUR = Beginning date
 ;  EHOUR = Ending date
 ;  BDATE.=.Beginning date
 ;  EDATE = Ending date
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N DFN,HRSHELP,I,MEETSRCH,VA,VADM,VAERR
 S MEETSRCH=0
 S SPNFD0=0
 F  S SPNFD0=$O(^SPNL(154.1,"B",D0,SPNFD0)) Q:SPNFD0'>0!MEETSRCH  D
 . S HRSHELP=$P($G(^SPNL(154.1,SPNFD0,2)),U,9) Q:HRSHELP=""
 . S RECDATE=$P($G(^SPNL(154.1,SPNFD0,0)),U,4) Q:RECDATE=""
 . I RECDATE'<BDATE,RECDATE'>EDATE D
 .. I HRSHELP'<BHOUR,HRSHELP'>EHOUR S MEETSRCH=1
 .. Q
 . Q
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING # HRS HELP") = Hours ^ Hours
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING # HRS HELP") = Hours ^ Hours
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING DATE") = Date ^ Date_(Ext)
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING DATE") = Date ^ Date_(Ext)
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0) =
 ;                  $$EN1^SPNPSR05(D0,BHOUR,EHOUR,BDATE,EDATE)
 ;
 N DIR,DIRUT,DTOUT,DUOUT,HRSHELP,I
 K ^TMP($J,"SPNPRT",ACTION,SEQUENCE),DIR
 S DIR(0)="NOA^0:336"
 S DIR("A")="Hours of help needed start value: "
 S DIR("?")="Enter a number from 0 to 336 hours"
 D ^DIR S (BHOUR,HRSHELP("BEGINNING # HRS HELP"))=Y
 I '$D(DIRUT) D
 . K DIR S DIR(0)="NOA^"_HRSHELP("BEGINNING # HRS HELP")_":336"
 . S DIR("A")="Hours of help needed end value:   "
 . S DIR("?")="Enter a number from "_HRSHELP("BEGINNING # HRS HELP")_" to 336 hours"
 . D ^DIR S (EHOUR,HRSHELP("ENDING # HRS HELP"))=Y
 . Q
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 I 'SPNLEXIT,Y'="" D
 . S (BDATE,EDATE)=""
 . D EN1^SPNPSR00(ACTION,SEQUENCE+.1,.BDATE,.EDATE) Q:SPNLEXIT
 . F I="BEGINNING # HRS HELP","ENDING # HRS HELP" D
 .. S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,I)=$G(HRSHELP(I))_U_$G(HRSHELP(I))
 .. Q
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR05(D0,"_BHOUR_","_EHOUR_","_BDATE_","_EDATE_")"
 . Q
EN2EXIT ;
 Q