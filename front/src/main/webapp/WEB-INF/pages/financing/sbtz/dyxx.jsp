<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdysx"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdylx"%>
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
	<div class="contain clearfix">
		<%@include file="/WEB-INF/include/sbtz/header.jsp"%>
		
		<div class="plan_tab clearfix">
			<ul>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq.class, id)%>">标的详情</a></li>
				<%if(creditInfo.F11 == T6230_F11.S){ %>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Dbxx.class, id)%>">风控信息</a></li>
				<%} %>
				<%
					if(creditInfo.F13 == T6230_F13.S){
				%>
				<li  class="hover">抵押物信息</li>
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
			</ul>
		</div>
		<div class="contain_main clearfix ">
		<%{
			Bdylx[] dyxxs = investManage.getDylb(id);
			if(dyxxs != null && dyxxs.length >0){
				for(Bdylx dyxx:dyxxs){
			%>
				<div class="pub_title pt10"><%=dyxx.dyName %></div>
				<%Bdysx[] dysxs= investManage.getDysx(dyxx.F01);
					if(dysxs != null && dysxs.length >0){
						for(Bdysx bdysx:dysxs){
				%>
				<div class="pt10"><%--<%=bdysx.dxsxName%>： --%><%=bdysx.F04 %></div>
				<%} %>
		
			<%}}} %>
			
   		</div>
   	<%} %>
			
		
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