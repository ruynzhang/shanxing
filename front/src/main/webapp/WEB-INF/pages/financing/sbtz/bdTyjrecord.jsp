<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.http.URLParameter"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.BdTyjrecord"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.BdxqTyj"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.S62.enums.SURPRISE_STATUS"%>
<%@page import="com.dimeng.p2p.account.front.service.entity.UserInfo"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.DistrictManage"%>
<%@page import="com.dimeng.p2p.front.servlets.Region"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdysx"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdylx"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.S61.enums.T6120_F05"%>
<%@page import="com.dimeng.p2p.account.front.service.entity.UserRZInfo"%>
<%@page import="com.dimeng.p2p.front.servlets.gywm.Hzjg"%>
<%@page import="com.dimeng.p2p.common.enums.CreditLevel"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.dimeng.p2p.common.enums.Sex"%>
<%@page import="com.dimeng.p2p.common.enums.AttestationState"%>
<%@page import="com.dimeng.p2p.common.enums.IsHovestatus"%>
<%@page import="com.dimeng.p2p.common.enums.CreditStatus"%>
<html>
<head>
<title>体验标的详情-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%
	String cityid="";
%>
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
<div class="zq_tab" >
    <ul>
      <li id="one1" onclick="setTab('one',1,4)" ><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class)%>">全部</a></li>
      <li id="one2" onclick="setTab('one',2,4)"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Grlb.class)%>">个人标</a></li>
      <li id="one3" onclick="setTab('one',3,4)"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Enterprise.class)%>">企业标</a></li>
      <li id="one4" onclick="setTab('one',4,4)"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Zqzrlb.class)%>">线上债权转让</a></li>
      <li id="one5" onclick="setTab('one',4,5)"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Tyblb.class)%>">体验标</a></li>
    </ul>
    <div class="clear"></div>
</div> 
<div class="sx_memo"></div>
	<div class="contain clearfix">
		<%@include file="/WEB-INF/include/sbtz/headertyj.jsp"%>
		
		<div class="plan_tab clearfix">
			<ul>
				<li ><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.BdxqTyj.class, id)%>">体验标活动介绍</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.BdTyjDetail.class, id)%>">体验标详情</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.BdTyjmorg.class, id)%>">抵押物信息</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.BdTyjfile.class, id)%>">相关文件</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.BdTyjhk.class, id)%>">还款计划</a></li>
				<li class="hover"><a href="#">体验记录</a></li>
			</ul>
		</div>
		
		 <%
				 	{
				 	//T6250[] tenderRecords = investManage.getRecord(id);
				 	final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
				 	PagingResult<Expemoneyrecord> Palist = investManage.getPagTyjrecordlist(id, new Paging() {
						@Override
						public int getSize() {
							return 10;
						}
						@Override
						public int getCurrentPage() {
							return currentPage;
						}
					});
				 %>
		<div class="contain_main clearfix">
			<div class="plan_tab_con01 clearfix">
				<div class="fr">
				<%
					
				    Expemoneyrecord Erlists = investManage.getTyjlistSumint(id);
						
				%>
					<span class="mr10">加入人次<em class="f18 orange"><%=Erlists.id %></em>人
					</span> <span class="mr10">投标总额<em class="f18 orange"><%=Formater.formatAmount(Erlists.invemoney)%></em>元
					</span>
				</div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tc">
					<tr class="leve_titbj">
						<td width="330">序号</td>
						<td width="156">投标人</td>
						<td width="362">投标金额</td>
						<td width="362">投标时间</td>
					</tr>
					<%
					  int i = 1;
						if (Palist != null) {
							Expemoneyrecord[] exrecords=Palist.getItems();
							if(exrecords!=null && exrecords.length >0) {
								for(Expemoneyrecord record: exrecords){
								     if (record == null) {
								    	 continue;
								    	 };
						
					%>
					<tr>
						<td width="330"><%=i++ %></td>
						<td width="156">
						<%StringHelper.filterHTML(out, record.account_name.substring(0,4)+"***");%>
						</td>
						<td width="362"><%=record.invemoney%>元</td>
						<td width="362"><%=DateTimeParser.format(record.invetime,"yyyy-MM-dd HH:mm") %></td>
					</tr>
					<%
					}}}%>
				</table>
				<div class="page">
				<% 
				   AbstractFinancingServlet.rendPaging(out, Palist,controller.getPagingURI(request, BdTyjrecord.class), "?id="+id);
				%>
				</div>
			</div>
		</div>
		<%}%>
		
	</div>
	<div id="info"></div>
	<%@include file="/WEB-INF/include/footer.jsp" %>
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