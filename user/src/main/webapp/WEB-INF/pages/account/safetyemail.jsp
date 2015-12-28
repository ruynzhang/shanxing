<%@page import="com.dimeng.p2p.account.user.service.BankCardManage"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.BankCard"%>
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
		BankCardManage  bankCardManage = serviceSession.getService(BankCardManage.class);
		BankCard[] card = bankCardManage.bankCards();
		SafetyManage userManage = serviceSession.getService(SafetyManage.class);
		Safety data = userManage.get();
		if(card == null || card.length < 1){
			controller.sendRedirect(request, response, "bankcardlist2.html");
			return;
		}
		if(!StringHelper.isEmpty(data.isEmil) && data.isEmil.equals(T6118_F04.TG.name())){
			controller.sendRedirect(request, response, configureProvider.format(URLVariable.USER_NCIIC));
			return;
		}
	%>
	<div class="sx_normal_box sx_user_outline">
        <div class="sx_user_step">
        <ul class="sx_user_reg5">
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
		<form action="<%=controller.getURI(request, BindEmil.class)%>" method="post" class="form3">
			<input type="hidden" name="type" value="2">
			<div class="container">
				<div class="p15">
					<div class="user_lsjt mb20">绑定邮箱</div>
					<%String ermsg = controller.getPrompt(request, response,PromptLevel.ERROR);if(!StringHelper.isEmpty(ermsg)){ %>
					<ul class="xx_li" id="kjd">
						<li style="text-align: center;color: red;">
						<%StringHelper.filterHTML(out, ermsg);%>
						</li>
					</ul>
					<%}%>
					<ul class="xx_li">
						<li><span class="xx_ico4 mr40"></span>
							<div class="til">绑定邮箱</div>
							<div class="info red">有助于您在平台享受更优质的金融服务，建议绑定</div>
							<div class="clear"></div>
							<div id="box3" class="mt15">
							 	<ul class="tou_li">
									<li>
				                        <div class="til">邮箱： </div>
                        				<div class="info">
                        				<input name="bemil" type="text" class="text yhgl_ser w150 fl mr10 required e-mail" maxlength="26"/>
                        				<p tip></p>
										<p errortip class="" style="display: none"></p>
                        				</div>
                       					 <div class="clear"></div> 
				                    </li>
				                    <li>
				                        <div class="til"><span class="red">*</span>验证码：</div>
				                        <div class="info">
				                        <input name="bemilCode" type="text" class="text yhgl_ser w150 fl mr10 required" />
				                        <input name="input" type="button" onclick="bandEmil(this)" value="获取验证码" class="btn03"/>
				                        <p tip></p>
										<p errortip class="" style="display: none"></p>
				                        </div>
				                        <div class="clear"></div> 
				                   </li>
			                    </ul>
							</div>
						</li>
					</ul>
				</div>
			</div>
            <div class="sx_g_bt"><input type="submit" value="完&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;成" class="sx_pinkBt" >
            <a class="sx_blueBt2" href="<%=configureProvider.format(URLVariable.USER_INDEX)%>">以后待绑定</a></div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
	<script type="text/javascript">
		
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/zhankai.js"></script>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	<%--绑定邮箱时--%>
	var wait = 180;
	<%--新邮箱时--%>
	var wait1 = 180;
	<%--手机修改邮箱时--%>
	var wait2 = 180;
	<%--绑定手机时--%>
	var wait3 = 180;
	<%--新手机时--%>
	var wait4 = 180;
	<%--找回提现密码时--%>
	var wait5 = 180;
	<%--修改邮箱时--%>
	var wait6 = 180;
	<%--修改手机时--%>
	var wait7 = 180;
		function bandEmil(evn){
			var bemil = $("input[name='bemil']");
			if(bemil.val().length<=0){
				$error = bemil.nextAll("p[errortip]");
				$tip = bemil.nextAll("p[tip]");
				$error.addClass("error_tip");
				$error.html("邮箱地址不正确！");
				$tip.hide();
				$error.show();
				return false;
			}
			var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/;
			if(!myreg.test(bemil.val()))
			{
				$error = bemil.nextAll("p[errortip]");
				$tip = bemil.nextAll("p[tip]");
				$error.addClass("error_tip");
				$error.html("邮箱地址不正确！");
				$tip.hide();
				$error.show();
				return false;
			}
			var data1={"evencheck":"emil","value":bemil.val()};
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=controller.getURI(request, Check.class)%>",
				data:data1,
				success:function(data){
					if(data == "04"){
						$error = bemil.nextAll("p[errortip]");
						$tip = bemil.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("邮箱已存在！");
						$tip.hide();
						$error.show();
						return false;
					}else{
						var data3={"type":"band","emil":bemil.val(),"phone":""};
						$.ajax({
							type:"post",
							dataType:"html",
							url:"<%=controller.getURI(request, Send.class)%>",
							data:data3,
							success:function(data){
								if(data){
									var ct = eval('('+data+')');
									if(ct.length>0 && ct[0].num == 0){
										$error = bemil.nextAll("p[errortip]");
										$tip = bemil.nextAll("p[tip]");
										$error.addClass("error_tip");
										$error.html(ct[0].msg);
										$tip.hide();
										$error.show();
										return false;
									}
									if(ct.length>0 && ct[0].num == 1){
										sendclick(evn);
									}
								}
							}
						});
					}
				}
			});
		}
		function eupdate(evn){
			var bemil = "<%StringHelper.filterHTML(out, data.emil);%>";
			var data={"type":"update","emil":bemil,"phone":""};
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=controller.getURI(request, Send.class)%>",
				data:data,
				success:function(data){
					if(data){
						var ct = eval('('+data+')');
						if(ct.length>0 && ct[0].num == 0){
							$error = $(evn).nextAll("p[errortip]");
							$tip = $(evn).nextAll("p[tip]");
							$error.addClass("error_tip");
							$error.html(ct[0].msg);
							$tip.hide();
							$error.show();
							return false;
						}
						if(ct.length>0 && ct[0].num == 1){
							sendclick6(evn);
						}
					}
				}
			});
		}
		
		function pupdate(evn){
			var phone = "<%StringHelper.filterHTML(out, data.phoneNumber);%>";
			var data={"type":"update","emil":"","phone":phone};
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=controller.getURI(request, Send.class)%>",
				data:data,
				success:function(data){
					if(data){
						var ct = eval('('+data+')');
						if(ct.length>0 && ct[0].num == 0){
							$error = $(evn).nextAll("p[errortip]");
							$tip = $(evn).nextAll("p[tip]");
							$error.addClass("error_tip");
							$error.html(ct[0].msg);
							$tip.hide();
							$error.show();
							return false;
						}
						if(ct.length>0 && ct[0].num == 1){
							sendclick7(evn);
						}
					}
				}
			});
		}
		function getoldcode(evn){
			var phone = "<%StringHelper.filterHTML(out, data.phoneNumber);%>";
			var data={"type":"getoldpas","emil":"","phone":phone};
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=controller.getURI(request, Send.class)%>",
				data:data,
				success:function(data){
					if(data){
						var ct = eval('('+data+')');
						if(ct.length>0 && ct[0].num == 0){
							$error = $(evn).nextAll("p[errortip]");
							$tip = $(evn).nextAll("p[tip]");
							$error.addClass("error_tip");
							$error.html(ct[0].msg);
							$tip.hide();
							$error.show();
							return false;
						}
						if(ct.length>0 && ct[0].num == 1){
							sendclick5(evn);
						}
					}
				}
			});
		}
		
		function epupdate(evn){
			var phone = "<%StringHelper.filterHTML(out, data.phoneNumber);%>";
			var data={"type":"phoneemil","emil":"","phone":phone};
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=controller.getURI(request, Send.class)%>",
				data:data,
				success:function(data){
					if(data){
						var ct = eval('('+data+')');
						if(ct.length>0 && ct[0].num == 0){
							$error = $(evn).nextAll("p[errortip]");
							$tip = $(evn).nextAll("p[tip]");
							$error.addClass("error_tip");
							$error.html(ct[0].msg);
							$tip.hide();
							$error.show();
							return false;
						}
						if(ct.length>0 && ct[0].num == 1){
							sendclick2(evn);
						}
					}
				}
			});
		}
		
		$(".w100").click( function () {
			var ind = $(this).index(".w100");
			<%--通过邮箱修改邮箱--%>
			if(ind==0){
				$("#mt1").hide();
				$("#e1").show();
			}
			<%--通过手机号修改邮箱--%>
			if(ind==1){
				$("#mt1").hide();
				$("#ep1").show();
			}
			<%--通过手机号修改绑定手机--%>
			if(ind==2){
				$("#mt2").hide();
				$("#p1").show();
			}
			<%--通过身份证修改绑定手机--%>
			if(ind==3){
				$("#mt2").hide();
				$("#ip1").show();
			}
		});
		
		$(function(){
			$(".coden").click(function(){
				$intext =$('input[type="text"]');
				$inpassword =$('input[type="password"]');
				var type = $(this).attr("checktype");
				flgs = true;
				if(type=="oldone"){
					<%--通过旧邮箱修改邮箱 1--%>
					var $cli = $(this).parent().parent().prev();
					var code = $cli.children("div").eq(1).children("input").eq(0);
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					var data={"evencheck":"emil","ctp":"eupdate","code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckCode.class)%>",
						data:data,
						success:function(data){
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入邮箱有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#e1").hide();
								$("#e2").show();
							}
						}
					});
				}
				if(type=="newtwo"){
					<%--通过旧邮箱修改邮箱 2--%>
					var $cli = $(this).parent().parent().prev();
					var $eli = $(this).parent().parent().prev().prev();
					var emil = $eli.children("div").eq(1).children("input").eq(0);
					var code = $cli.children("div").eq(1).children("input").eq(0);
					
					var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/;
					if(!myreg.test(emil.val()))
					{
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("邮箱地址不正确！");
						$tip.hide();
						$error.show();
						return false;
					}
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					
					var data={"evencheck":"emil","utp":"eupdate","ctp":"enew","value":emil.val(),"code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckNewCode.class)%>",
						data:data,
						success:function(data){
							if(data == "00"){
								$("#e1").show();
								$("#e2").hide();
								return false;
							}
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入邮箱有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "04"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("邮箱已存在！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#e2").hide();
								$("#e3").show();
								$("#e3").find("p").html(emil.val().substring(0,1)+"*****"+emil.val().split("@")[1]);
							}
						}
					});
				}if(type=="epoldone"){
					<%--通过手机修改邮箱 1--%>
					var $cli = $(this).parent().parent().prev();
					var code = $cli.children("div").eq(1).children("input").eq(0);
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					var data={"evencheck":"phone","ctp":"pphoneemil","code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckCode.class)%>",
						data:data,
						success:function(data){
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入手机号！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#ep1").hide();
								$("#ep2").show();
							}
						}
					});
				}
				if(type=="epnewtwo"){
					<%--通过手机修改邮箱 2--%>
					var $cli = $(this).parent().parent().prev();
					var $eli = $(this).parent().parent().prev().prev();
					var emil = $eli.children("div").eq(1).children("input").eq(0);
					var code = $cli.children("div").eq(1).children("input").eq(0);
					
					var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/;
					if(!myreg.test(emil.val()))
					{
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("邮箱地址不正确！");
						$tip.hide();
						$error.show();
						return false;
					}
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					var data={"evencheck":"emil","utp":"pphoneemil","ctp":"enew","value":emil.val(),"code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckNewCode.class)%>",
						data:data,
						success:function(data){
							if(data == "00"){
								$("#ep1").show();
								$("#ep2").hide();
								return false;
							}
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入邮箱有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "04"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("邮箱已存在！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#ep2").hide();
								$("#ep3").show();
								$("#ep3").find("p").html(emil.val().substring(0,1)+"*****"+emil.val().split("@")[1]);
							}
						}
					});
					
				}if(type=="poldone"){
					<%--通过短信修改手机号 1--%>
					var $cli = $(this).parent().parent().prev();
					var code = $cli.children("div").eq(1).children("input").eq(0);
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					
					var data={"evencheck":"phone","ctp":"pupdate","code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckCode.class)%>",
						data:data,
						success:function(data){
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入手机号！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#p1").hide();
								$("#p2").show();
							}
						}
					});
					
				}
				if(type=="pnewtwo"){
					<%--通过短信修改手机号 2--%>
					var $cli = $(this).parent().parent().prev();
					var $eli = $(this).parent().parent().prev().prev();
					var emil = $eli.children("div").eq(1).children("input").eq(0);
					var code = $cli.children("div").eq(1).children("input").eq(0);
					
					var myreg = /^(13|15|18|14|17)[0-9]{9}$/;
					if(!myreg.test(emil.val()))
					{
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("手机号码不正确!");
						$tip.hide();
						$error.show();
						return false;
					}
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					
					var data={"evencheck":"phone","utp":"pupdate","ctp":"pnew","value":emil.val(),"code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckNewCode.class)%>",
						data:data,
						success:function(data){
							if(data == "00"){
								$("#p1").show();
								$("#p2").hide();
								return false;
							}
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入手机号有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "04"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("手机号码已存在！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#p2").hide();
								$("#p3").show();
								$("#p3").find("p").html(emil.val().substring(0,3)+"*****"+emil.val().substring(7,11));
							}
						}
					});
				}if(type=="ipoldone"){
					<%--通过身份证修改手机号 1 --%>
					
					if("BTG" == "<%=data.isIdCard%>"){
						$("#ip1").hide();
						$("#pr2").show();
						return false;
					}
					
					var t = true;
					<%if(StringHelper.isEmpty(data.txpassword)){%>
					t = false;
					<%}%>
					if(!t){
						$("#ip1").hide();
						$("#pr1").show();
						return false;
					}
					
					var $tli = $(this).parent().parent().prev();
					var $ili = $(this).parent().parent().prev().prev();
					var idcard = $ili.children("div").eq(1).children("input").eq(0).val();
					var txpassword = $tli.children("div").eq(1).children("input").eq(0);
					if(!isIdCardNo(idcard)){
						return false;
					}
					if(txpassword.val().length<=0){
						$error = txpassword.nextAll("p[errortip]");
						$tip = txpassword.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入提现密码！");
						$tip.hide();
						$error.show();
						return false;
					}
					if(idcard != "<%=StringHelper.decode(data.sfzh)%>"){
						$error = txpassword.nextAll("p[errortip]");
						$tip = txpassword.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("不是本人身份证！");
						$tip.hide();
						$error.show();
						return false;
					}
					var data={"value":txpassword.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, Checkpassword.class)%>",
						data:data,
						success:function(data){
							if(data == "01"){
								$error = txpassword.nextAll("p[errortip]");
								$tip = txpassword.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("提现密码输入错误！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#ip1").hide();
								$("#ip2").show();
							}
						}
					});
					
				}
				if(type=="ipnewtwo"){
					<%--通过身份证修改手机号 2 --%>
					var $cli = $(this).parent().parent().prev();
					var $eli = $(this).parent().parent().prev().prev();
					var emil = $eli.children("div").eq(1).children("input").eq(0);
					var code = $cli.children("div").eq(1).children("input").eq(0);
					
					var myreg = /^(13|15|18|14|17)[0-9]{9}$/;
					
					if(!myreg.test(emil.val()))
					{
						alert("手机号码不正确!");
						return false;
					}
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					var data={"evencheck":"phone","utp":"pnew","ctp":"pnew","value":emil.val(),"code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckNewCode.class)%>",
						data:data,
						success:function(data){
							if(data == "00"){
								$("#p1").show();
								$("#p2").hide();
								return false;
							}
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入手机号有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "04"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("手机号码已存在！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#ip2").hide();
								$("#ip3").show();
								$("#ip3").find("p").html(emil.val().substring(0,3)+"*****"+emil.val().substring(7,11));
							}
						}
					});
				}if(type=="pswone"){
					<%--找回提现密码 1--%>
					var $cli = $(this).parent().parent().prev();
					var code = $cli.children("div").eq(1).children("input").eq(0);
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					
					var data={"evencheck":"phone","ctp":"pgetoldpas","code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckCode.class)%>",
						data:data,
						success:function(data){
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入手机号！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#ps1").hide();
								$("#ps2").show();
							}
						}
					});
				}
				if(type=="pswtwo"){
					<%--找回提现密码 2--%>
					var $cli = $(this).parent().parent().prev();
					var $eli = $(this).parent().parent().prev().prev();
					var code = $cli.children("div").eq(1).children("input").eq(0);
					var emil = $eli.children("div").eq(1).children("input").eq(0);
					
					var myreg = /^[a-zA-Z0-9]{6,20}$/;
					
					if(emil.val().length<=0){
						$error = emil.nextAll("p[errortip]");
						$tip = emil.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("不能为空！");
						$tip.hide();
						$error.show();
						return false;
					}else if(!myreg.test(emil.val()))
					{
						$error = emil.nextAll("p[errortip]");
						$tip = emil.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("6-20个字符，区分大小写");
						$tip.hide();
						$error.show();
						return false;
					}
					if(code.val() != emil.val()){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("两次输入密码不一致！");
						$tip.hide();
						$error.show();
						return false;
					}
					var data={"evencheck":"phone","utp":"pgetoldpas","number":"<%StringHelper.filterHTML(out, data.phoneNumber);%>","new":emil.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, pdatetxPasswordajx.class)%>",
						data:data,
						success:function(data){
							if(data == "09"){
								$("#ps1").show();
								$("#ps2").hide();
								return false;
							}else if(data == "00"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入正确密码！");
								$tip.hide();
								$error.show();
								return false;
							}
							else if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("不能和登录密码相同！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$("#ps2").hide();
								$("#ps3").show();
							}
							else{
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html(data);
								$tip.hide();
								$error.show();
								return false;
							}
						}
					});
				}
			});
		});
		
		$(function(){
			$(".emilsend").click(function(){
				var $eli = $(this).parent().parent().prev();
				var bemil = $eli.children("div").eq(1).children("input").eq(0);
				var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/;
				if(bemil.val().length<=0 || !myreg.test(bemil.val()))
				{
					$error = bemil.nextAll("p[errortip]");
					$tip = bemil.nextAll("p[tip]");
					$error.addClass("error_tip");
					$error.html("邮箱地址不正确!");
					$tip.hide();
					$error.show();
					return false;
				}
				var evn = this;
				var data={"type":"new","emil":bemil.val(),"phone":""};
				$.ajax({
					type:"post",
					dataType:"html",
					url:"<%=controller.getURI(request, Send.class)%>",
					data:data,
					success:function(data){
						if(data){
							var ct = eval('('+data+')');
							if(ct.length>0 && ct[0].num == 0){
								$error = bemil.nextAll("p[errortip]");
								$tip = bemil.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html(ct[0].msg);
								$tip.hide();
								$error.show();
								return false;
							}
							if(ct.length>0 && ct[0].num == 1){
								sendclick1(evn);
							}
						}
					}
				});
			});
		});
		
		$(function(){
			$(".phonesend").click(function(){
				var $eli = $(this).parent().parent().prev();
				var bemil = $eli.children("div").eq(1).children("input").eq(0);
				var myreg = /^(13|15|18|14|17)[0-9]{9}$/;
				if(bemil.val().length<=0 || !myreg.test(bemil.val()))
				{
					$error = bemil.nextAll("p[errortip]");
					$tip = bemil.nextAll("p[tip]");
					$error.addClass("error_tip");
					$error.html("手机号码不正确!");
					$tip.hide();
					$error.show();
					return false;
				}
				var evn = this;
				var data={"type":"new","emil":"","phone":bemil.val()};
				$.ajax({
					type:"post",
					dataType:"html",
					url:"<%=controller.getURI(request, Send.class)%>",
					data:data,
					success:function(data){
						if(data){
							var ct = eval('('+data+')');
							if(ct.length>0 && ct[0].num == 0){
								$error = bemil.nextAll("p[errortip]");
								$tip = bemil.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html(ct[0].msg);
								$tip.hide();
								$error.show();
								return false;
							}
							if(ct.length>0 && ct[0].num == 1){
								sendclick4(evn);
							}
						}
					}
				});
			});
		});
		
		
		function isIdCardNo(num) {           
		    num = num.toUpperCase();           //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X。        
		    if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(num))) {     
		        alert('输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X。');              
		        return false;         
		    } //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
		    //下面分别分析出生日期和校验位 
		    var len, re; len = num.length; if (len == 15) { 
		        re = new RegExp(/^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/); 
		        var arrSplit = num.match(re);  //检查生日日期是否正确
		        var dtmBirth = new Date('19' + arrSplit[2] + '/' + arrSplit[3] + '/' + arrSplit[4]); 
		        var bGoodDay; bGoodDay = (dtmBirth.getYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4]));
		        if (!bGoodDay) {         
		            alert('输入的身份证号里出生日期不对！');            
		            return false;
		        } else { //将15位身份证转成18位 //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。        
		            var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);         
		            var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');      
		            var nTemp = 0, i;            
		            num = num.substr(0, 6) + '19' + num.substr(6, num.length - 6);           
		            for(i = 0; i < 17; i ++) {                 
		                nTemp += num.substr(i, 1) * arrInt[i];        
		            }
		            num += arrCh[nTemp % 11]; 
		            return true;
		        }
		    }
		    if (len == 18) {
		        re = new RegExp(/^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/); 
		        var arrSplit = num.match(re);  //检查生日日期是否正确 
		        var dtmBirth = new Date(arrSplit[2] + "/" + arrSplit[3] + "/" + arrSplit[4]); 
		        var bGoodDay; bGoodDay = (dtmBirth.getFullYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4])); 
		        if (!bGoodDay) { 
		            alert(dtmBirth.getYear()); 
		            alert(arrSplit[2]); 
		            alert('输入的身份证号里出生日期不对！'); 
		            return false; 
		        }
		        else { //检验18位身份证的校验码是否正确。 //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
		            var valnum; 
		            var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
		            var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
		            var nTemp = 0, i; 
		            for(i = 0; i < 17; i ++) { 
		                nTemp += num.substr(i, 1) * arrInt[i];
		            } 
		            valnum = arrCh[nTemp % 11]; 
		            if (valnum != num.substr(17, 1)) { 
		                alert('18位身份证的校验码不正确!'); 
		                return false; 
		            } 
		            return true; 
		        } 
		    } return false;
		}
		
		function localch(id){
			$("#"+id).hide();
			$("#ip1").show();
		}
		
		
		<%--绑定邮箱时计时器 --%>
		function sendclick(evn){
			if (wait == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait + ")秒重新获取";
				wait--;
				setTimeout(function() {
					sendclick(evn);
				},
				1000);
			}
		}
		<%--修改邮箱时计时器 --%>
		function sendclick6(evn){
			if (wait6 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait6 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait6 + ")秒重新获取";
				wait6--;
				setTimeout(function() {
					sendclick6(evn);
				},
				1000);
			}
		}
		<%--新邮箱时计时器 --%>
		function sendclick1(evn){
			if (wait1 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait1 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait1 + ")秒重新获取";
				wait1--;
				setTimeout(function() {
					sendclick1(evn);
				},
				1000);
			}
		}
		
		<%--手机修改邮箱时 --%>
		function sendclick2(evn){
			if (wait2 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait2 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait2 + ")秒重新获取";
				wait2--;
				setTimeout(function() {
					sendclick2(evn);
				},
				1000);
			}
		}
		
		<%--绑定手机时计时器 --%>
		function sendclick3(evn){
			if (wait3 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait3 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait3 + ")秒重新获取";
				wait3--;
				setTimeout(function() {
					sendclick3(evn);
				},
				1000);
			}
		}
		<%--修改手机时计时器 --%>
		function sendclick7(evn){
			if (wait7 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait7 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait7 + ")秒重新获取";
				wait7--;
				setTimeout(function() {
					sendclick7(evn);
				},
				1000);
			}
		}
		<%--新手机时计时器 --%>
		function sendclick4(evn){
			if (wait4 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait4 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait4 + ")秒重新获取";
				wait4--;
				setTimeout(function() {
					sendclick4(evn);
				},
				1000);
			}
		}
		<%--提现密码时计时器 --%>
		function sendclick5(evn){
			if (wait5 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait5 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait5 + ")秒重新获取";
				wait5--;
				setTimeout(function() {
					sendclick5(evn);
				},
				1000);
			}
		}
	</script>
	
</body>
</html>