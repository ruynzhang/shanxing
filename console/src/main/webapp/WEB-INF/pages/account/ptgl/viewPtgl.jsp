<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.ptgl.ViewPtgl"%>
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
	CURRENT_SUB_CATEGORY="PT";
	
	T7101 entity = (T7101)request.getAttribute("entity");
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改平台管理</h3>
                    </div>
                    <div class="con">
                    <form action="<%=controller.getURI(request, ViewPtgl.class)%>" method="post" class="form1" enctype="multipart/form-data">
                    <ul class="cell noborder yxjh ">
                    <li>
                        <div class="til"><span class="red">*</span>前台LOGO文件编码：</div>
                        <div class="info">
							<p class="mb10"><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.QTLOGO))%>" width="277" height="89" /></p>
                        	<input type="file" class="text yhgl_ser yw_w4" name="qtlg"/>
						</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>后台登录LOGO文件编码：</div>
                        <div class="info">
                        	<p class="mb10"><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.HTDLLOGO))%>" width="277" height="89" /></p>
                        	<input type="file" class="text yhgl_ser yw_w4" name="htdl"/>
						</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>后台首页LOGO文件编码：</div>
                        <div class="info">
                        	<p class="mb10"><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.HTSYLOGO))%>" width="277" height="89" /></p>
                        	<input type="file" class="text yhgl_ser yw_w4" name="htsy"/>
						</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="clear"></div>
                    </li>                    
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="hidden" name="F01" value="<%=entity.F01%>"/>
                    	<input type="submit" onclick="onSubmit();" class="btn4 mr30 sumbitForme" fromname="form1" value="保存" />
                    	<input type="button" onclick="window.location.href='<%=controller.getURI(request, PtglList.class)%>'" class="btn4" value="返回列表页" />
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
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	
	<script type="text/javascript">
		alert(message);
	</script>
	<%
		}
	%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		alert(errorMessage);
	</script>
	<%
		}
	%>
	
	<%
		String warnMessage = controller.getPrompt(request, response , PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warnMessage)) {
	%>
	<script type="text/javascript">
		alert(warnMessage);
	</script>
	<%
		}
	%>
</body>
</html>