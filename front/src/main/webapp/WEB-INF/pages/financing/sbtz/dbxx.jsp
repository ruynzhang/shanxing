<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Dbxx"%>
<%@page import="com.dimeng.p2p.S62.entities.T6237"%>
<html>
<head>
<title>散标详情-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
    <!--banner-->
<div class="zq_banner">
<div class="banner4"></div>
</div>
<!--banner-->
<div class="sx_memo"><p class="blue_ls">惊喜奖是标的满标放款后按照您预期收益的奖励百分比直接转账到您账户，投资金额越大，返现越多!</p></div>
	<div class="contain clearfix">
		<%@include file="/WEB-INF/include/sbtz/header.jsp"%>
		
		<div class="plan_tab clearfix">
			<ul>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq.class, id)%>">标的详情</a></li>
				<%if(creditInfo.F11 == T6230_F11.S){ %>
				<li class="hover">风控信息</li>
				<%} %>
				<%
					if(creditInfo.F13 == T6230_F13.S){
				%>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Dyxx.class, id)%>">抵押物信息</a></li>
				<%
					}
				%>
				<%if(isXgwj){%>
				<li><a href="<%=controller.getPagingItemURI(request,  com.dimeng.p2p.front.servlets.financing.sbtz.Xgwj.class, id)%>">相关文件</a></li>
				<%} %>
				<li><a href="<%=controller.getPagingItemURI(request,  com.dimeng.p2p.front.servlets.financing.sbtz.Hkjl.class, id)%>">还款计划</a></li>
				<li><a href="<%=controller.getPagingItemURI(request,  com.dimeng.p2p.front.servlets.financing.sbtz.Tbjl.class, id)%>">投资记录</a></li>
				<%if(creditInfo.surpriseStatus != null && creditInfo.surpriseStatus != SURPRISE_STATUS.WPZ){ %>
				<li><a href="<%=controller.getPagingItemURI(request,  com.dimeng.p2p.front.servlets.financing.sbtz.Hjjl.class, id)%>">获奖记录</a></li>
				<%} %>
				<li style="border-left: 1px solid #d1dfea; padding: 0;"></li>
			</ul>
		</div>
		<%{
			T6237 fkInfos = investManage.getFk(id);
			Dbxx dbInfos = investManage.getDB(id);
		%>
		
		 <div class="contain_main clearfix ">
		 	<%
				if(dbInfos != null){%>
				<div class="pub_title pt10">担保机构</div>
					<div class="pt10"><%StringHelper.filterHTML(out, dbInfos.F06);%>	</div>
			
		     
		    
		     <div class="pub_title pt10">担保机构介绍</div>
		    <div class="pt10">
				<%StringHelper.filterHTML(out, dbInfos.F05); %>  
			</div>
			<div class="pub_title pt10">担保情况</div>
		    <div class="pt10">
			<%StringHelper.filterHTML(out, dbInfos.F07); %>    
			</div>
			<%
				}
			%>
			<%
					if(fkInfos != null){
				%>
			<div class="pub_title pt10">风险控制措施</div>
		    <div class="pt10">
			<%StringHelper.filterHTML(out, fkInfos.F02); %>    
			</div>
		    <div class="pub_title pt10">反担保情况</div>
		    <div class="pt10">
		       <%StringHelper.filterHTML(out, fkInfos.F03); %>  
		    </div>
   		</div>
   	<%} }%>
			
		
	</div>
	<div id="info"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/sbtz.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>

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