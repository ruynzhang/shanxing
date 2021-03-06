<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S51.enums.T5123_F03"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xyrzx.ViewXyrzx"%>
<%@page import="com.dimeng.p2p.S51.entities.T5123"%>
<html>
<link href="<%=controller.getStaticPath(request) %>/css/hhmmss.css" rel="stylesheet">
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%	
	CURRENT_CATEGORY="JCXXGL";
	CURRENT_SUB_CATEGORY="XYRZX";
	
	T5123 entity = (T5123)request.getAttribute("entity");
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改信用等级</h3>
                    </div>
                    <div class="con">
                    <form action="<%=controller.getURI(request, ViewXyrzx.class)%>" method="post" class="form1">
                    <ul class="cell noborder yxjh ">
                    <li>
                        <div class="til"><span class="red">*</span>类型名称：</div>
                        <div class="info">
                        	<input name="F02" type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, entity.F02);%>"/>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
						</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>必要认证：</div>
                        <div class="info">
                        	<span class="tir required">
                          		<select name="F03" class="yhgl_sel" style="width:300px;">
                            		<%
									for (T5123_F03 t5123_F03 : T5123_F03.values()) {
									%>
									<option value="<%=t5123_F03.name()%>" <%if (t5123_F03.name().equals(entity.F03)) {%> selected="selected" <%}%>><%=t5123_F03.getChineseName()%></option>
									<%
										}
									%>
                          		</select>
                        	</span>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>最高分数：</div>
                        <div class="info">
                        	<input name="F05" type="text" class="text yhgl_ser required isint" value="<%=entity.F05%>"/>
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
                    	<input type="hidden" name="F01" value="<%=entity.F01%>"/>
                    	<input type="submit" onclick="onSubmit();" class="btn4 mr30 sumbitForme" fromname="form1" value="保存" />
                    	<input type="button" onclick="window.location.href='<%=controller.getURI(request, XyrzxList.class)%>'" class="btn4" value="返回列表页" />
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