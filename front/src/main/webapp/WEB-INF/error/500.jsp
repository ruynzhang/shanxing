<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>当前系统繁忙，请稍候再试</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
</head>

<body style="background:#e7e6eb;">
<div style="width:460px; height:155px; background:url(images/505.jpg) no-repeat #fff 50px 55px; border:1px solid #b9b8bc; margin:250px auto 0 auto;font-family:Microsoft yahei; padding:75px 0 0 180px; line-height:30px;">
<p style="font-size:24px; color:#f13320; margin:0px;">当前系统繁忙，请稍候再试</p>
<p style="margin:0px; color:#666;">当前访问人数较多，请按返回，或者稍后再访问该页面！<br />
返回<a href="<%configureProvider.format(out,URLVariable.INDEX);%>" style="color:#00a7e5;"><%configureProvider.format(out,SystemVariable.SITE_NAME);%>首页</a></p>
</div>
</body>
</html>
