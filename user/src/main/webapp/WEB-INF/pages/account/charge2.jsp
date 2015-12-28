<%@page import="com.dimeng.p2p.S61.enums.T6141_F04"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Safety"%>
<%@page import="com.dimeng.p2p.account.user.service.SafetyManage"%>
<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的<%configureProvider.format(out,SystemVariable.SITE_NAME);%>_充值管理
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link href="<%=controller.getStaticPath(request)%>/css/login.css" rel="stylesheet" type="text/css" media="screen">
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		SafetyManage safeManage = serviceSession.getService(SafetyManage.class);
		Safety data = safeManage.get();
		//如果没有实名认证
		if(StringHelper.isEmpty(data.isIdCard) || !data.isIdCard.equals(T6141_F04.TG.name())){
			controller.sendRedirect(request, response, "safetymsg2.html");
			return;
		}
		UserManage userManage = serviceSession.getService(UserManage.class);
		String usrCustId = userManage.getUsrCustId();
		if(!StringHelper.isEmpty(usrCustId)){
			controller.sendRedirect(request, response, "safetypwd.html");
			return;
		} %>
	<div class="sx_normal_box sx_user_outline">
        <div class="sx_user_step">
        <ul class="sx_user_reg2">
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
			<div class="f16 mt30 pt50 pb50 tc ml20 mr20 mb10" style="background:#f3f3f3;">
	            	 您需要在第三方托管平台上进行注册，才可申请充值提现！
	        </div>
                  <div class="sx_g_bt"><a class="sx_pinkBt" href="<%=configureProvider.format(URLVariable.ESCROW_URL_USERREGISTER) %>" target="_blank">立即注册</a></div>
			<div class="clear"></div>
		</div>
	</div>
	<div id="dialog" style="display: none;">
		<div class="popup_bg"></div>
		<div class="dialog w510 thickpos" style="margin:-80px 0 0 -255px;">
		  <div class="dialog_close fr"><a href="javascript:void(0);"></a></div>
		  <div class="con clearfix">
		    <div class="d_perfect fl"></div>
		    <div class="info fr">
		      <p class="f20 gray33" id="con_error"></p>
		    </div>
		  </div>
		</div>
	</div>
    <div class="sx_overlay"></div>
<div class="tyj_popup">
   <div class="tyj_close">X</div>
   <div class="tyj_main">
     <div class="sx_tiptitle">第三方注册</div>
     <div class="tyj_ctbox">您的账户资金将由第三方平台托管,有助于您的资金安全！</div>
     <div class="tyj_gbox"><a href="safetypwd.html" class="btg_1">注册成功</a><a href="charge2.html" class="btg_2">未完成注册</a></div>
   </div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/charge.js"></script>
    
     <script type="text/javascript">
   $(".sx_pinkBt").click(function(){
	     $(".tyj_popup").css("display","block");
		 $(".sx_overlay").css("display","block");
   })
   $(".btg_1").click(function(){
	     $(".tyj_popup").css("display","none");
		 $(".sx_overlay").css("display","none");
   })
   $(".btg_2").click(function(){
	     $(".tyj_popup").css("display","none");
		 $(".sx_overlay").css("display","none");
   })
   $(".tyj_close").click(function(){
	     $(".tyj_popup").css("display","none");
		 $(".sx_overlay").css("display","none");
   })
</script>
</body>
</html>