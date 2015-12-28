<!DOCTYPE html>
<%@page import="java.util.Map"%>
<html lang="en">
<head>
    <title>善行创投-身份认证</title>
    <%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
	<%@include file="/WEB-INF/pages/mobile/javascript.jsp" %>    
<%
Map<String, Object> map=(Map<String, Object>)request.getAttribute("resultMap");
%>
</head>
<body>
<!---top--->
<%@include file="/WEB-INF/pages/mobile/header.jsp"%>

<!----container-->
<%if((boolean)map.get("isPass")){%>
<div class="sj_user">
    <div class="sj_user_title"><a href="/user/mobile/myWealth.htm"><b>实名认证</b></a></div>
    <div class="sj_user_info"><b>姓名</b><span style="color: gray;"><%=map.get("name")%></span></div>
    <div class="sj_user_info"><b>身份认证</b><span style="color: gray;"><%=map.get("idCard")%></span></div>
    <a href="/user/mobile/user.htm" class=" wx_btn_orange">确定</a>
</div>
<%}else{%>
<div class="wx_login_box">
		<div class="sx_pinkColor" style="display: none;" id="msg"></div>
        <div class="input_box">
            <input type="text" placeholder="姓名" id="name" class=" input_text" >
        </div>
        <div class="input_box">
            <input type="text" placeholder="身份证号码" id="idCard" class=" input_text" >
        </div>
        <a onclick="onSubmit();" href="javascript:;;" tabindex="4" class="btn_wap wx_btn_orange"> 确定 </a>
</div>
<%}%>

<script type="text/javascript">
var isNull = /^[\s]{0,}$/;
var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;  
var patrn = /^\s*[\u4e00-\u9fa5]{1,}[\u4e00-\u9fa5.·]{0,15}[\u4e00-\u9fa5]{1,}\s*$/; 
onSubmit=function(){
	var name=$("#name").val();
	var idCard=$("#idCard").val();
	if(!patrn.exec(name))
    {
		$("#msg").html("姓名错误");
		$("#msg").show();
        return;
    }
	if(!reg.test(idCard)){  
		$("#msg").html("身份证输入不合法");
		$("#msg").show();
	    return;  
	} 
	$.ajax({
		type : "POST",
		url : "/user/mobile/updIdentity.htm",
		data : {"name":name, "idCard":idCard},
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