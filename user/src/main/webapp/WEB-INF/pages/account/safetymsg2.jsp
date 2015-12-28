<%@page import="com.dimeng.p2p.account.user.service.entity.UserBaseInfo"%>
<%@page import="com.dimeng.p2p.account.user.service.IndexManage"%>
<%@page import="com.dimeng.p2p.S61.enums.T6118_F04"%>
<%@page import="com.dimeng.p2p.S61.enums.T6141_F04"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Safety"%>
<%@page import="com.dimeng.p2p.account.user.service.SafetyManage"%>
<%@page import="com.dimeng.p2p.user.servlets.account.*"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link href="<%=controller.getStaticPath(request)%>/css/login.css" rel="stylesheet" type="text/css" media="screen">
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		SafetyManage userManage = serviceSession.getService(SafetyManage.class);
		Safety data = userManage.get();
		if(!StringHelper.isEmpty(data.isIdCard) && data.isIdCard.equals(T6141_F04.TG.name())){
			controller.sendRedirect(request, response, "charge2.html");
			return;
		}
	%>
	<div class="sx_normal_box sx_user_outline">
        <div class="sx_user_step">
        <ul class="sx_user_reg1">
          <li class="r_1"><i>1</i>实名认证</li>
          <li class="r_2"><i>2</i>第三方注册</li>
          <li class="r_3"><i>3</i>提现密码</li>
          <li class="r_4"><i>4</i>绑定银行卡</li>
          <li class="r_5"><i>5</i>绑定邮箱</li>
        </ul>
        <div class="clear"></div>
        </div>
		<div class="user_top"></div>
		<div class="sx_group">
						<form action="<%=controller.getURI(request, UpdateName.class)%>" class="form1" method="post">
			<div class="container">
				<div class="p15">
					<div class="user_lsjt mb20">实名认证</div>
					<%String ermsg = controller.getPrompt(request, response,PromptLevel.ERROR);if(!StringHelper.isEmpty(ermsg)){ %>
					<ul class="xx_li" id="kjd">
						<li style="text-align: center;color: red;">
						<%StringHelper.filterHTML(out, ermsg);%>
						</li>
					</ul>
					<%}%>
					<ul class="xx_li">
						<li>
						<input type="hidden" name="type" value="2">
						<span class="xx_ico2 mr40"></span>
							<%-- <div class="til">实名认证</div>
							<div class="info">
							<%
							IndexManage manage = serviceSession.getService(IndexManage.class); 
							UserBaseInfo userBaseInfo = manage.getUserBaseInfo();
							UserInfoManage uManage1 = serviceSession.getService(UserInfoManage.class);
							boolean [] tyjHint = uManage1.getTyjHint(); %>
							<%if(tyjHint[1] == false && userBaseInfo.realName == false){%>
								<span class="red">认证后可获得<%if(tyjHint[0] == true){%>800<%}else{%>1000<%}%>体验金</span> 
							<%} %>
							</div>--%>
							<div class="clear"></div>
							<div id="box1" class="mt15">
									<ul class="tou_li">
										<li>
											<div class="til">
												<span class="red">*</span>真实姓名：
											</div>
											<div class="info">
												<input type="text" name="name" class="text yhgl_ser w200 required" mtest="/^[\u4e00-\u9fa5]{2,}$/" mtestmsg="请输入合法的姓名"/>
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>身份证号：
											</div>
											<div class="info">
												<input type="text" name="idCard" class="text yhgl_ser w200 required idcard" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
							</div>
						<div class="clear"></div>
						</li>
					</ul>
				</div>
			</div>
            <div class="sx_g_bt"><input type="submit" value="下一步" class="sx_pinkBt"></div>
							</form>
			<%--
            <div class="ln30 pl20 mb40">
						<p class="blue f16">温馨提示：</p>
						1、实名认证成功后您可以总共获得1000元体验金，该体验金可用于平台体验标投资，所得收益可直接用于提现<br>
						2、扫描下侧二维码，参与互动小游戏可以赢取更多体验金<br>
                        <p><img src="/images/tyj2d.jpg" alt="" /></p>
					</div> --%>
			<div class="clear"></div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/zhankai.js"></script>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>