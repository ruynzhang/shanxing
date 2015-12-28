<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<title>散标详情-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%
	String cityid="";
String partId = request.getParameter("partId");
partId = (partId==null?"":partId);
%>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<input type="hidden" value="<%=partId %>" id="partId"/>
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
				<li class="hover">标的详情</li>
				<%
					if(creditInfo.F11 == T6230_F11.S){
				%>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Dbxx.class, id)%>">风控信息</a></li>
				<%
					}
				%>
				<%
					if(creditInfo.F13 == T6230_F13.S){
				%>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Dyxx.class, id)%>">抵押物信息</a></li>
				<%
					}
				%>
				<%if(isXgwj){%>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Xgwj.class, id)%>">相关文件</a></li>
				<%} %>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Hkjl.class, id)%>">还款计划</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Tbjl.class, id)%>">投资记录</a></li>
				<%if(creditInfo.surpriseStatus != null && creditInfo.surpriseStatus != SURPRISE_STATUS.WPZ){ %>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Hjjl.class, id)%>">获奖记录</a></li>
				<%} %>
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
	        <ul class="plan_tabli clearfix">
	        <%
	       
	        String qyName="";
	        if(t6110.F06 == T6110_F06.ZRR) {
	        	if(t6110.F02 != null && t6110.F02.length() >4){
	        		qyName = t6110.F02.substring(0, 4)+"***";
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
	         <%if(t6231.F06 != null){ %><li>还款日期：<%=DateParser.format(t6231.F06) %></li><%} %>
	        <li>年化利率：<%=Formater.formatRate(creditInfo.F06)%></li>
	        <li>投标截止日期：<%=TimestampParser.format(creditInfo.jsTime) %></li>
	        <li>借款用途：<%StringHelper.filterHTML(out, t6231.F08);%></li>
	        </ul>
	        <div style="word-wrap:break-word" class="mt15">还款来源：<%StringHelper.filterHTML(out, t6231.F16); %></div>
	        <div style="word-wrap:break-word" class="mt15">借款描述：<%=t6231.F09 %></div>
            
	    </div>
			<% 
			if(t6110.F06 == T6110_F06.FZRR){ %>
			<%@include file="/WEB-INF/include/sbtz/qyxx.jsp"%>
			<%@include file="/WEB-INF/include/sbtz/qycwxx.jsp"%>
			<%} %>
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

<script>
var href = $(".sx_regbox").find("a").eq(1).attr("href");
$(".sx_regbox").find("a").eq(1).attr("href",href+($("#partId").val()!=""?"?partId="+$("#partId").val():""));
</script>
</html>