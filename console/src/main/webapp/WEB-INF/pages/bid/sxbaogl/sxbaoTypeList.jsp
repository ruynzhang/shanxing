<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.sxbaogl.UpdateSxbaoType"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.sxbaogl.AddSxbaoType"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.sxbaogl.SxbaoTypeList"%>
<%@page import="com.dimeng.p2p.S62.entities.SxbaoType"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
			CURRENT_CATEGORY="YWGL";
			CURRENT_SUB_CATEGORY="SXBAOTYPEGL";
			PagingResult<SxbaoType> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
			SxbaoType[] sxbaos = result.getItems();
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, SxbaoTypeList.class)%>">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>善行宝类型管理</h3>
							</div>
							<div class="con">
							<!-- 
									<div class="admin_input admin_pb">
										<p>
											借款标题： <input type="text" name="title" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("title"));%>"/>
										</p>
										
										<div class="clear"></div>
									</div>
										<input name="input" type="submit" class="btn2 fl mr10" value="搜索" />
							 -->
									<div class="mt10">
										<%
										if(dimengSession.isAccessableResource(AddSxbaoType.class)){
										%>
										<a href="<%=controller.getURI(request, AddSxbaoType.class) %>" class="btn3"><span class="ico1"></span>新增</a>
										<%}else{ %>
										<span class="disabled">新增</span>
										<%} %>
									</div>
									<div class="clear"></div>
							</div>
						</div>
						<div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>名称</td>
									<td>发售状态</td>
									<td>已售总额</td>
									<td>操作</td>
								</tr>
								<%
								if(sxbaos!=null){
									int i=1;
									for(SxbaoType sxbaoType : sxbaos){
								%>
								<tr>
									<td><%=i++ %></td>
									<td title="<%StringHelper.filterHTML(out, sxbaoType.name); %>"><%StringHelper.filterHTML(out,StringHelper.truncation(sxbaoType.name, 15) ); %></td>
									<td><%=sxbaoType.sellStatus == T6230_F13.F? "停售" : "在售"%></td>
									<td><%=Formater.formatAmount(sxbaoType.totalAmount) %></td>
									<td class="blue">
										<%
										if(dimengSession.isAccessableResource(UpdateSxbaoType.class)){
										%>
										<a href="<%=controller.getURI(request, UpdateSxbaoType.class) %>?id=<%=sxbaoType.id%>" class="mr5">修改</a>
										<%}else{ %>
										<span class="disabled">修改</span>
										<%}%>
									</td>
								</tr>
								<%}}else{ %>
									<tr><td align="center" colspan="11"></td></tr>
								<%} %>
							</table>
						</div>
						<%
							AbstractConsoleServlet.rendPagingResult(out, result);
						%>
						<div class="clear"></div>
					</div>
					</form>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
	</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/jquery.jsp" %>
	<%
		String warringMessage=controller.getPrompt(request, response, PromptLevel.WARRING);
		if(!StringHelper.isEmpty(warringMessage))
		{
	%>
	<div class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;" id="showDiv">
      <div class="info clearfix">
        <div class="clearfix">
            <span class="fl tips"><%StringHelper.filterHTML(out, warringMessage); %></span>
        </div>
        <div class="dialog_btn"><input type="button" name="button2" onclick="$('#showDiv').hide()" value="确认"  class="btn4 ml50"/></div> 
      </div>
	</div>
	<%} %>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-ui-1.10.4/js/time.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	
		function showYfbDiv(loanId)
		{
			$("#loanId").attr("value",loanId);
			$("#yfbDiv").show();
		}
		
		function fbBid(title,url){
			if(confirm("您需要现在立即发布“"+title+"”标？")){
				location.href=url;
			}else{
				return;
			}
		}
		
		function showZf(title)
		{
			if(confirm("您确定要作废“"+title+"”标?"))
			{
				return true;	
			}else{
				return false;
			}
		}
	</script>
</body>
</html>