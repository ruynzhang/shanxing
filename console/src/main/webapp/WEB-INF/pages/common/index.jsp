<%@page import="com.dimeng.p2p.common.enums.FundAccountType"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.IndexCount"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.Txcg"%>
<%@page import="com.dimeng.p2p.console.servlets.common.Update"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<%@page import="com.dimeng.p2p.modules.member.console.service.entity.User"%>
<%@page import="com.dimeng.p2p.console.config.ConsoleConst"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.common.Index"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	IndexCount indexCount = ObjectHelper.convert(
		request.getAttribute("indexCount"), IndexCount.class);
	boolean isOneLogin=ObjectHelper.convert(request.getAttribute("isOneLogin"), Boolean.class);
%>
<body>
	<%
		CURRENT_CATEGORY = "SY";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1">
							<div class="atil">
								<h3>信息统计</h3>
							</div>
							<div class="con">
								<ul class="yhxq_li yw_w">
									<li>今日注册用户数：( <span class="blue"> <%
 	if(dimengSession.isAccessableResource(GrList.class))
 								{
 %> <a href="<%=controller.getURI(request, GrList.class)%>"><%=indexCount.todayRegisterUser%></a> <%
 	}else{
 %> <a href="javascript:void(0)" class="disabled"><%=indexCount.todayRegisterUser%></a>
											<%
												}
											%>
									</span>)人
									</li>
									<li>历史注册用户数：( <span class="blue"> <%
 	if(dimengSession.isAccessableResource(GrList.class))
 								{
 %> <a href="<%=controller.getURI(request, GrList.class)%>"><%=indexCount.historyRegisterUser%></a> <%
 	}else{
 %> <a href="javascript:void(0)" class="disabled"><%=indexCount.historyRegisterUser%></a>
											<%
												}
											%>
									</span>)人
									</li>
								</ul>
								<ul class="yhxq_li yw_w">
									<li>今日登录用户数：(<span><%=indexCount.todayLoginUser%></span>)人</li>
									<li>当前在线用户数：(<span class="blue"><a href="<%=controller.getURI(request, UserOnline.class)%>"><%=indexCount.onlineUser%></a></span>)人</li>
								</ul>
								<div class="clear"></div>
								<div class="hsxt"></div>
								<ul class="yhxq_li yw_w">
									<li>今日用户总充值：( <span class="blue"> <%
 	if(dimengSession.isAccessableResource(CzglList.class))
 								{
 %> <a href="<%=controller.getURI(request, CzglList.class)%>"><%=Formater
						.formatAmount(indexCount.todayTotalUserRecharge)%></a> <%
 	}else{
 %> <a href="javascript:void(0)" class="disabled"><%=Formater
						.formatAmount(indexCount.todayTotalUserRecharge)%></a> <%
 	}
 %>
									</span>)元
									</li>
									<li>今日用户总提现：( <span class="blue"> <%
 	if(dimengSession.isAccessableResource(Txcg.class))
 								{
 %> <a href="<%=controller.getURI(request, Txcg.class)%>"><%=Formater
						.formatAmount(indexCount.todayTotalUserExtract)%></a> <%
 	}else{
 %> <a href="javascript:void(0)" class="disabled"><%=Formater
						.formatAmount(indexCount.todayTotalUserExtract)%></a> <%
 	}
 %>
									</span>)元
									</li>
									<li>平台总收益：( <span class="blue"> <%
 	if(dimengSession.isAccessableResource(ZjList.class))
 								{
 %> <a href="<%=controller.getURI(request, ZjList.class)%>?fundAccountType=<%=FundAccountType.PT%>"><%=Formater
						.formatAmount(indexCount.platformTotalIncome)%></a> <%
 	}else{
 %> <a href="javascript:void(0)" class="disabled"><%=Formater
						.formatAmount(indexCount.platformTotalIncome)%></a> <%
 	}
 %>
									</span>)元
									</li>
								</ul>
								<ul class="yhxq_li yw_w">
									<li>用户历史总充值：( <span class="blue"> <%
 	if(dimengSession.isAccessableResource(CzglList.class))
 								{
 %> <a href="<%=controller.getURI(request, CzglList.class)%>"><%=Formater
						.formatAmount(indexCount.historyTotalUserRecharge)%></a> <%
 	}else{
 %> <a href="javascript:void(0)" class="disabled"><%=Formater
						.formatAmount(indexCount.historyTotalUserRecharge)%></a> <%
 	}
 %>
									</span>)元
									</li>
									<li>用户历史总提现：( <span class="blue"> <%
 	if(dimengSession.isAccessableResource(Txcg.class))
 								{
 %> <a href="<%=controller.getURI(request, Txcg.class)%>"><%=Formater
						.formatAmount(indexCount.historyTotalUserExtract)%></a> <%
 	}else{
 %> <a href="javascript:void(0)" class="disabled"><%=Formater
						.formatAmount(indexCount.historyTotalUserExtract)%></a> <%
 	}
 %>
									</span>)元
									</li>
									<li>用户总收益：( <span class="blue"> <%
 	if(dimengSession.isAccessableResource(ZjList.class))
 								{
 %> <a href="<%=controller.getURI(request, ZjList.class)%>"><%=Formater
						.formatAmount(indexCount.userInvestTotalIncome)%></a> <%
 	}else{
 %> <a href="javascript:void(0)" class="disabled"><%=Formater
						.formatAmount(indexCount.userInvestTotalIncome)%></a> <%
 	}
 %>
									</span>)元
									</li>
								</ul>
								<div class="clear"></div>
							</div>
						</div>
						<div class="box2 clearfix"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%
		String message=controller.getPrompt(request,response, PromptLevel.WARRING);
		if(isOneLogin||!StringHelper.isEmpty(message))
		{
	%>
	<div class="popup_bg"></div>
	<div class="w440 thickbox thickpos" id="updatePass" style="margin: -120px 0 0 -220px;">
		<div class="tit">
			<span class="fl pl15">修改密码</span>
		</div>
		<form action="<%=controller.getURI(request, Update.class)%>" method="post">
			<div class="info clearfix">
				<div class="mb10 tc">为保障账户安全，首次登录请修改您的密码！</div>
				<div class="cell clearfix">
					<div class="list01"><span class="red">*</span>原密码：</div>
					<div class="list02">
						<input type="password" class="text required" name="oldPassWord"/>
						<p tip></p>
						<p errortip class="" style="display: none"></p>
					</div>
				</div>
				<div class="cell clearfix">
					<div class="list01"><span class="red">*</span>新密码：</div>
					<div class="list02">
						<input type="password" class="text required password-a" name="newPassWord1"/>
						<p tip></p>
						<p errortip class="" style="display: none"></p>
					</div>
				</div>
				<div class="cell clearfix">
					<div class="list01"><span class="red">*</span>重复新密码：</div>
					<div class="list02">
						<input type="password" class="text required password-b" name="newPassWord2"/>
						<p tip></p>
						<p errortip class="" style="display: none"></p>
					</div>
				</div>
				<div align="center">
						<font color="red" size="2">
							<%
								StringHelper.filterHTML(out,message);
							%>
						</font>
				</div>
				<div class="clear"></div>
				<div class="dialog_btn">
					<input type="submit" name="button2" id="button2" value="确认" class="btn4 ml50" />
				</div>
			</div>
		</form>
	</div>
	<%
		}
	%>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>