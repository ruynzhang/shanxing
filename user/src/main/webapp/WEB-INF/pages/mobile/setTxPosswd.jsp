<!DOCTYPE html>
<html lang="en">
<head>
    <title>善行创投</title>
	<%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/javascript.jsp" %>
</head>
<body>
<!---top--->
<%@include file="/WEB-INF/pages/mobile/header.jsp"%>
<!--login-->
<div class="wx_login_box">
    	<div class="sx_pinkColor" style="display: none;" id="msg"></div>
        <div class="input_box">
            <input type="password"  placeholder="密码"  name="password" id="old_pass" class=" input_text" >
        </div>
        <div class="input_box">
            <input type="password"  placeholder="确认密码"  name="password" id="new_pass" class=" input_text" >
        </div>
        <a onclick="onSubmit();" href="javascript:;;" tabindex="4" class="btn_wap wx_btn_orange"> 确定 </a>
</div>
<script type="text/javascript">
var isNull = /^[\s]{0,}$/;
onSubmit=function(){
	var val=$("#new_pass").val();
	var old_pass=$("#old_pass").val();
	if (isNull.test(val)) {
		$("#msg").html("密码不能为空");
		$("#msg").show();
		return;
	}
	if (val.length<6||val.length>20) {
		$("#msg").html("密码不能小于6位，大于20位");
		$("#msg").show();
		return;
	}
	if (val != old_pass) {
		$("#msg").html("您两次输入的密码不一致");
		$("#msg").show();
		return;
	}
	$.ajax({
		type : "POST",
		url : "/user/mobile/setTxPassword.htm",
		data : {"new":val},
		success : function(data){
			$("input").attr("value","");
			$("#msg").html(data);
			$("#msg").show();
			if(data.indexOf("成功")>0){
				location.href="/user/mobile/user.htm";
			}
		}
	}); 
}
</script>
</body>
</html>