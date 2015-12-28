<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<title>线下债权转让详情-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%
	String cityid="";
%>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="contain clearfix">
		<%@include file="/WEB-INF/include/xxzq/header.jsp"%>
		
		<div class="plan_tab clearfix">
			<ul>
				<li class="hover">标的详情</li>
				<%
					if(creditInfo.F11 == T6230_F11.S){
				%>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.xxzq.Dbxx.class, id)%>">风控信息</a></li>
				<%
					}
				%>
				<%
					if(creditInfo.F13 == T6230_F13.S){
				%>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.xxzq.Dyxx.class, id)%>">抵押物信息</a></li>
				<%
					}
				%>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.xxzq.Xgwj.class, id)%>">相关文件</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.xxzq.Hkjl.class, id)%>">还款计划</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.xxzq.Tbjl.class, id)%>">投资记录</a></li>
				<li style="border-left: 1px solid #d1dfea; padding: 0;"></li>
			</ul>
		</div>
		<%
				UserInfoManage infoManage =serviceSession.getService(UserInfoManage.class);
				DistrictManage districtManage = serviceSession.getService(DistrictManage.class);
				UserRZInfo[] userRZInfos = infoManage.getRZInfo(creditInfo.F02);
		%>
		
		 <div class="contain_main clearfix ">
		
		<div class="pub_title pt10"><span class="fl">项目信息</span></div>
	    <div class="plan_tab_con clearfix">
	        <ul class="plan_tabli">
	        <%
	       
	        String qyName="";
	        if(t6110.F06 == T6110_F06.ZRR) {
	        	if(t6110.F02 != null && t6110.F02.length() >4){
	        		qyName = "***"+t6110.F02.substring(t6110.F02.length()-4, t6110.F02.length());
	        	}else{
	        		qyName = t6110.F02;
	        	}
	        }else{
		        EnterpriseInfoManage enterpriseInfoManage = serviceSession.getService(EnterpriseInfoManage.class);
	        	Enterprise enterprise = enterpriseInfoManage.get(creditInfo.F02);
	        	if(enterprise.F04 != null && enterprise.F04.length() >4){
	        		qyName =  "***"+enterprise.F04.substring(enterprise.F04.length()-4,enterprise.F04.length());
	        	}else{
	        		qyName = enterprise.F04;
	        	}
	        }
	        
	        %>
	        <li>融资方：<%StringHelper.filterHTML(out, qyName); %></li>
	        <li>本期融资金额：<%if(creditInfo.F05.doubleValue()>=10000){%><%=creditInfo.F05.doubleValue()/10000%>万元
					            	<%}else{%><%=Formater.formatAmount(creditInfo.F05)%>元<%}%></li>
	        <li>项目区域：<%StringHelper.filterHTML(out, districtManage.getShengName(t6231.F07).F06);%></li>
	        <%if(t6231.F06 != null){ %>
	        <li>还款日期：<%=DateParser.format(t6231.F06) %></li>
	        <%} %>
	        <li>年化利率：<%=Formater.formatRate(creditInfo.F06)%></li>
	        <li>投标截止日期：<%=TimestampParser.format(creditInfo.jsTime) %></li>
	        <li>借款用途：<%StringHelper.filterHTML(out, t6231.F08);%></li>
	        <li>还款来源：<i title="<%StringHelper.filterHTML(out, t6231.F16);%>"><%StringHelper.truncation(out, t6231.F16, 10); %></i></li>                       
	        </ul>
	    </div>
		
		
			<% 
			if(t6110.F06 == T6110_F06.FZRR){ %>
			<%@include file="/WEB-INF/include/sbtz/qyxx.jsp"%>
			<%@include file="/WEB-INF/include/sbtz/qycwxx.jsp"%>
			<%} %>
				
			
			<%-- <div class="pub_title pt10">
				<span class="fl">审核状态</span>
			</div>
			<div class="plan_tab_con01 clearfix">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tc">
					<tr class="leve_titbj">
						<td class="tl" style="padding-left: 160px;">审核项目</td>
						<td width="156" class="w50">状态</td>
						<td width="362">通过日期</td>
					</tr>
					<%
						if(userRZInfos!=null)
						{
							for(UserRZInfo userRz:userRZInfos)
							{
								if(userRz==null)
								{
									continue;
								}
					%>
					<tr>
						<td class="tl" style="padding-left: 160px;"><%StringHelper.filterHTML(out, userRz.F03); %></td>
						<td><%if(userRz.F01==T6120_F05.TG) {%><i class="ui_plan_bj ui_plan_right tl ml20"></i><%} %></td>
						<td><%=DateParser.format(userRz.F02) %></td>
					</tr>
					<%} }%>
				</table>
				<p class="pt10">
					<em class="s_blue">•</em> <%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>及其合作机构将始终秉持客观公正的原则，严控风险，最大程度的尽力确保借入者信息的真实性，但不保证审核信息 100%无误。<br /> <em class="s_blue">•</em> 借入者若长期逾期，其个人信息将被公布。
				</p>
			</div>
			<div class="pub_title pt10">借款描述</div>
			<div class="plan_tab_con01"><p><%StringHelper.filterHTML(out, t6231.F09); %></p></div> --%>
			
			
		</div>
		
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