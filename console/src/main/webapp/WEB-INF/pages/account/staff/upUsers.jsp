<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.staff.UpUsers"%>
<%@page import="com.dimeng.p2p.S71.entities.T7101"%>
<html>
<link href="<%=controller.getStaticPath(request) %>/css/hhmmss.css" rel="stylesheet">
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%	
CURRENT_CATEGORY="YHGL";
CURRENT_SUB_CATEGORY="UPUSERS";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>批量注册用户</h3>
                    </div>
                    <div class="con">
                    <form action="<%=controller.getURI(request, UpUsers.class)%>" method="post" class="form1" enctype="multipart/form-data">
                    <ul class="cell noborder yxjh ">
					  <li>
					  <% 
					  		Object obj=request.getAttribute("msg");
					  		if(obj!=null){
					  %>
                        <div class="red"><%=obj%></div>
                       <%} %>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>请上传xlsx格式文件：</div>
                        <div class="info">
                        	<p class="mb10"></p>
                        	<input type="file" class="text yhgl_ser yw_w4" name="qtlg"/>
						</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="clear"></div>
                    </li>                    
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" onclick="onSubmit();" class="btn4 mr30 sumbitForme" fromname="form1" value="保存" />
                    </div>
                	<div class="clear"></div>
                    </form>
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
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<%
		String warringMessage=controller.getPrompt(request, response, PromptLevel.ERROR);
		if(!StringHelper.isEmpty(warringMessage))
		{
	%>
	<script type="text/javascript">alert("<%=warringMessage%>");</script>
	<%} %>
</body>
</html>