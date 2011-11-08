FSCLMV ;SLC/STAFF-NOIS List Manager - View ;1/13/98  13:12
 ;;1.1;NOIS;;Sep 06, 1998
 ;
ENTRY ; from list template - entry code, FSCELL
 N CALLCNT,CALLLINE,CALLNUM,LISTNUM,MAXLINE,OVERFLOW
 K ^TMP("FSC VIEW",$J),^TMP("FSC VIEW BRIEF",$J),^TMP("FSC VIEW DETAIL",$J),^TMP("FSC VIEW FORMAT",$J),^TMP("FSC VIEW STAT",$J),^TMP("FSC VIEW CUSTOM",$J)
 S VALMCNT=0
 S VALMCAP=$$CAP^FSCU("V",.FSCSTYLE)
 I '$G(FSCDEV) W !
 S MAXLINE=$$MAXLINE^FSCUP,OVERFLOW=0
 S (CALLCNT,LISTNUM)=0 F  S LISTNUM=$O(^TMP("FSC SELECT",$J,LISTSEL,LISTNUM)) Q:LISTNUM<1  D  Q:$D(DTOUT)  Q:OVERFLOW
 .S CALLCNT=CALLCNT+1
 .S CALLLINE=+$O(^TMP("FSC LIST CALLS",$J,"IDX",LISTNUM,0))
 .S CALLNUM=+$O(^TMP("FSC LIST CALLS",$J,"ICX",CALLLINE,0))
 .D BUILD^FSCFORM(CALLLINE,CALLNUM,.FSCFMT,.VALMCNT,"FSC VIEW ")
 .I VALMCNT>MAXLINE D
 ..S OVERFLOW=1
 ..W !,"List is restricted to ",MAXLINE," lines.",$C(7) H 2
 S VALMAR="^TMP(""FSC VIEW "_FSCFMT_""",$J)"
 S @VALMAR=CALLCNT_U_VALMCNT
 D VIDEOOFF^FSCU
 I $D(FSCFMT("E")) S VALMQUIT=1,VALMBCK="Q"
 I $D(FSCFMT("T")) S VALMQUIT=1,VALMBCK="Q"
 Q
 ;
HEADER ; from list template - header code, FSCELL
 S VALMHDR(1)=$$SETSTR^VALM1("# of calls: "_+@VALMAR,"List: "_FSCLNAME,62,18)
 Q
 ;
EXIT ; from list template - exit code
 I $G(FSC1) D CLEAR^VALM1
 K ^TMP("FSC VIEW",$J)
 K ^TMP("FSC VIEW BRIEF",$J)
 K ^TMP("FSC VIEW DETAIL",$J)
 K ^TMP("FSC VIEW FORMAT",$J)
 K ^TMP("FSC VIEW STAT",$J)
 K ^TMP("FSC VIEW CUSTOM",$J)
 K ^TMP("FSC SELECT",$J,"VVALUES")
 Q
 ;
HELP ; from list template - help code
 I $G(X)'["?" Q
 S VALMBCK="R"
 N XQH
 I X="?" S XQH="FSC MENU VIEW" D EN^XQH Q
 I X="???" S VALMANS="?" D CLEAR^VALM1 S XQH="FSC U1 NOIS" D EN^XQH Q
 Q