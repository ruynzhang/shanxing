<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.entities.T6213"%>
<%@page import="com.dimeng.p2p.console.servlets.base.dywsx.AddDywsx"%>
<html>
<link href="<%=controller.getStaticPath(request) %>/css/hhmmss.css" rel="stylesheet">
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%	
	CURRENT_CATEGORY="JCXXGL";
	CURRENT_SUB_CATEGORY="DYWSX";
	
	T6213[] dywTypeArr = (T6213[])request.getAttribute("dywType");
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>新增抵押物属性</h3>
                    </div>
                    <div class="con">
                    <form action="<%=controller.getURI(request, AddDywsx.class)%>" method="post" class="form1">
                    <ul class="cell noborder yxjh ">
                    <li>
                    	<div class="til"><span class="red">*</span>抵押物类型：</div>
                    	<div class="info">
							<select name="F02">
		                    	<%
	                        	for (T6213 dywType : dywTypeArr) {
	                        		if(dywType == null){
	                        			continue;
	                        		}
	                        		String f02str = dywType.F01+"";
	                        	%>
								<option value="<%=dywType.F01%>"><%StringHelper.filterHTML(out, dywType.F02);%></option>
								<%
								}
								%>
		                    </select>
	                    </div>
	                    <div class="clear"></div>
					</li>
                    <li>
                        <div class="til"><span class="red">*</span>属性名称：</div>
                        <div class="info">
                        	<input name="F03" type="text" class="text yhgl_ser required" />
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
						</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="clear"></div>
                    </li>                    
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" onclick="onSubmit();" class="btn4 mr30 sumbitForme" fromname="form1" value="保存" />
                    	<input type="button" onclick="window.location.href='<%=controller.getURI(request, DywsxList.class)%>'" class="btn4" value="返回列表页" />
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