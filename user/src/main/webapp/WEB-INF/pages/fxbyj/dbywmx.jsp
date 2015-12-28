
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.user.servlets.bid.Sbdf"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F19"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.BidManage"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.user.servlets.fxbyj.Dbywmx"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Dbxxmx"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.account.user.service.FxbyjManage"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>担保业务明细-<%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
	FxbyjManage service=serviceSession.getService(FxbyjManage.class);
	Paging paging=new Paging(){
		public int getCurrentPage(){
			return currentPage;
		}
		
		public int getSize(){
			return 10;
		}
	};
	PagingResult<Dbxxmx> result=service.searchDb(paging);
	CURRENT_CATEGORY = "JGDB";
	CURRENT_SUB_CATEGORY = "DBYWMX";
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<div class="w994 pb5"><span class="f16"><a href="<%=controller.getViewURI(request, Index.class) %>">我的<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %></a></span> &gt; 担保机构 &gt; 担保业务明细</div>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
      <%@include file="/WEB-INF/include/menu.jsp"%>
   <div class="w780 fr">       
      <div>
   	    <div class="newsbox">
               <form action="<%=controller.getViewURI(request, Dbywmx.class)%>"method="post">
               <input type="hidden" name="jkbId" id="jkbId" value="">
               <div class="bs_bg pt10">
                  <div class="no_table user_bolr bot">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
                      <tr class="user_lsbg">
                        <td>序号</td>
                        <td>借款标题</td>
                        <td>用户名</td>
                        <td>借款金额</td>
                        <td>剩余期限</td>
                        <td>担保方式</td>
                        <td>待还金额</td>
                        <td>是否逾期</td>
                        <td>状态</td>
                        <td>操作</td>
                      </tr>
                      <%
                      BidManage bidManage2 = serviceSession.getService(BidManage.class);
                     
                      UserInfoManage userInfoManage2 = serviceSession.getService(UserInfoManage.class);
                      if(result != null && result.getItemCount() >0){
				     			int i=1;
				     		for(Dbxxmx ibf :result.getItems()){
				     			if(ibf == null){
				     				continue;
				     			}
				     			T6231 t6231 = bidManage2.getExtra(ibf.jkbId);
				     			
				     %>
                      <tr>
                      	<td><%=i++ %></td>
                      	<td><%StringHelper.filterHTML(out, StringHelper.truncation(ibf.F02, 10));%></td>
                      	<td><%=userInfoManage2.getUserName(ibf.F01)%></td>
                      	<td><%=Formater.formatAmount(ibf.F03) %></td>
                      	<%-- <td><%=Formater.formatRate(ibf.F04) %></td> --%>
                      	<td><%=t6231.F03%>/<%=t6231.F02%></td>
                      	<td><%=ibf.F12.getChineseName() %></td>
                      	<td><%=Formater.formatAmount(ibf.dhbj)%></td>
                      	<td><%=ibf.F19.getChineseName()%></td>
                      	<td><%=ibf.F06.getChineseName()%></td>
                      	<td><%if(ibf.F19 != T6231_F19.F&&ibf.F06==T6230_F20.HKZ){ %>
                      		<a style="color: red;cursor: pointer;" onclick="Dfzq(<%=ibf.jkbId %>)">垫付</a>
                      		<%} %>
                      	</td>
                      </tr>
                      <%
				     		}}
                      %>
                    </table>
            	  </div>
                    <div class="page">
						<%AbstractFinancingServlet.rendPagingResult(out, result); %>
					</div>
                  </div>         </form>      
                  <div class="clear"></div>
        </div>
         </div>            
       	 </div><div class="clear"></div>
   </div>
</div>
<div class="dialog w510 thickpos" style="margin:-80px 0 0 -255px;display: none;">
	<div class="dialog_close fr"><a href="#"></a></div>
    <div class="con clearfix">
      <div class="d_perfect fl"></div>
      <div class="info fr">
        <p class="f20 gray33">是否执行垫付债权操作？</p>
      </div>
      <div class="clear"></div>
      <div class="dialog_btn"><a href="javascript:void(0)" id="ok" class="btn btn001">是</a><a href="javascript:void(0)" id="cancel" class="btn btn05">否</a></div> 
    </div>
</div>
<div id="info"></div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>
<script type="text/javascript">
$(function(){
	
	$("#ok").click(function(){
		var jkbId=$("#jkbId").val();
		var form = document.forms[0];
		form.action ="<%=controller.getURI(request, Sbdf.class)%>?loanId="+jkbId;
		form.submit();
	});
});

	function Dfzq(jkbId){
		$("div.popup_bg").show();
		$("div.dialog").show();
		$("#jkbId").val(jkbId);
	}
</script>

	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#sbSucc").val()));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=errorMessage%>","error"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String warnMessage = controller.getPrompt(request, response , PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warnMessage)) {
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=warnMessage%>","perfect"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>


</body>
</html>