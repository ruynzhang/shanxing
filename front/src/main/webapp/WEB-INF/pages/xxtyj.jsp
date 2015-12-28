<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>善行创投</title>
		<meta name="description" content="善行创投体验金查询" />
		<meta name="keywords" content="善行创投体验金查询" />
		<meta name="author" content="shanLin" />
		<meta name="copyright" content="ShanLin all Right Reserved" />
		<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
		<meta name="apple-touch-fullscreen" content="YES" />
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<link href="/phone/css/mobile.css" rel="stylesheet" type="text/css" media="screen" />
		<link rel="shortcut icon" href="favicon.ico"/>
		<link rel="apple-touch-icon" href="icon.png"/>
		<link rel="apple-touch-icon" sizes="72×72" href="touch-icon-ipad.png" />
		<link rel="apple-touch-icon" sizes="114×114" href="touch-icon-iphone4.png" />
		<script src="/phone/js/jquery-1.11.0.min.js" type="text/javascript" ></script>
		<script src="/phone/js/common.js" type="text/javascript" ></script>
	</head>

	<body>
		<div id="sx_m_header">
			<div class="sx_m_logo"></div><div class="sx_m_btBox"></div>
		</div>
		<div id="sx_m_main">
			<div class="sx_m_block4 sx_m_block_login" id="sx_reg">
				<p id="tyjP" class="sx_reg_word2" style="display:none">目前共有<b class="sx_pinkColor" id="tyjId"></b>元体验金</p>
				<ul>
					<li><input type="text" id="accountName" name="accountName" placeholder="用户名/手机号码" maxlength="18" class="sx_input" value="" /></li>
					<li class="sx_login_liend"><input type="button" id="submitButton" value="查&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;询" class="sx_pinkBt" /></li>
				</ul>
				<p class="sx_reg_word">
					还没有帐号？<a href="<%=configureProvider.format(URLVariable.MREGISTER)%>?PID=<%=request.getParameter("PID")%>&score=<%=request.getParameter("score")%>" class="sx_blueColor">立即注册</a>
				</p>
			</div>
		</div>
	</body>
	<script>
	$(document).ready(function() {
	    wrap_xxtyj();
	});

	function wrap_xxtyj() {
		$("#submitButton").bind("click", function() {
							var url = "/xxtyjCalc.htm?accountName="+$.trim($("#accountName").val());
							$.post(url, {
								jsonData : null
							}, function(data) {
								var status = data.status;
								if (status == 1) {
									$("#tyjP").html("目前共有<b class=\"sx_pinkColor\" id=\"tyjId\">"+data.result+"</b>元体验金");
									$("#tyjP").show();
								}else if(status==0){
									$("#tyjP").html("没有该用户");
									$("#tyjP").show();
								}
							});
		});
	}
	</script>
</html>