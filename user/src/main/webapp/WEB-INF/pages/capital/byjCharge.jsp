<%@page import="com.dimeng.p2p.user.servlets.capital.ByjCharge"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.S61.entities.T6101"%>
<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Unpay"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.TradingRecord"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Safetymsg"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Charge"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的<%configureProvider.format(out,SystemVariable.SITE_NAME);%>_备用金充值管理
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
	
		UserInfoManage manage = serviceSession.getService(UserInfoManage.class);
		T6101 balance = manage.search();
		String type = ObjectHelper.convert(request.getAttribute("type"), String.class);
		String amount = ObjectHelper.convert(request.getAttribute("amount"), String.class);
		T6110 userInfo=	manage.getUserInfo(serviceSession.getSession().getAccountId());
		UserManage userManage = serviceSession.getService(UserManage.class);
		String usrCustId = userManage.getUsrCustId();
		CURRENT_CATEGORY = "ZJGL";
		CURRENT_SUB_CATEGORY = "CZ";
	%>
	<div class="w994 pb5">
		<span class="f16">
		<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.Index.class)%>">我的<%
			configureProvider.format(out,SystemVariable.SITE_NAME);
		%></a>
		</span> &gt; <a href="javascript:void(0)">资金管理</a>&gt; 备用金充值
	</div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<form action="<%=controller.getURI(request, ByjCharge.class)%>" method="post" onsubmit="return onSubmit()" class="form1">
			<div class="container fr">
				<div class="p15">
					<div class="user_lsjt mb15">填写充值金额</div>
					<div class="bom mb20">
						<ul class="noborder">
							<li>
								<div class="til">可用金额：</div>
								<div class="info">
									<span class="f24"><%=Formater.formatAmount(balance.F06) %></span>元
								</div>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>充值金额：
								</div>
								<div class="info">
									<input name="amount" type="text" class="text yhgl_ser fl mr5 required" value="<%StringHelper.filterQuoter(out, amount); %>" />
									<span class="fl">元</span>
									<p tip id="con_error" class="red"></p>
									<p errortip class="" style="display: none"></p>
								</div>
		                        <div class="clear"></div>
							</li>
							<li>
								<div class="til">&nbsp;</div>
								<div class="info">
									<input type="submit" style="cursor: pointer;"  value="充值" class="btn01 mb15 mt15 sumbitForme" fromname="form1"/>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
	<%
		String infoMsg = controller.getPrompt(request, response, PromptLevel.WARRING);
	%>
	<div id="dialog" style="<%=StringHelper.isEmpty(infoMsg)?"display: none;":"" %>">
		<div class="popup_bg"></div>
		<div class="dialog w510 thickpos" style="margin:-80px 0 0 -255px;">
		  <div class="dialog_close fr"><a href="javascript:void(0);"></a></div>
		  <div class="con clearfix">
		    <div class="d_perfect fl"></div>
		    <div class="info fr">
		      <p class="f20 gray33" id="con_error"><%=StringHelper.isEmpty(infoMsg)?"":infoMsg %></p>
		    </div>
		  </div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	$("#dialog div.dialog_close").click(function(){
		$("#dialog").hide();
	});
	function checkAmount(amount){
		if(isNaN(amount)){
			$("input[name='amount']").val("");
			$("#con_error").html("对不起，您输入的金额不为数字");
			return false;
		}
		return true;
	}
	function onSubmit(){
		var amount = $("input[name='amount']").val()*1;
		if(checkAmount(amount)){
			return true;
		}
		return false;
	}
	</script>
</body>
</html>