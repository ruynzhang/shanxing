<%@page import="com.dimeng.p2p.console.servlets.info.gywm.gltd.AddGltd"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>

<body>
<%
	CURRENT_CATEGORY = "XCGL";
	CURRENT_SUB_CATEGORY = "GLTD";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>添加管理团队</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form name="example" method="post" action="<%=controller.getURI(request, AddGltd.class)%>" class="form1" enctype="multipart/form-data" onsubmit="return checkImage();">
                    <ul class="cell xc_jcxx ">
                    <li>
                        <div class="til"><span class="red">&nbsp;</span></div>
                        <div class="info orange">
                        <%StringHelper.filterHTML(out, controller.getPrompt(request, response, PromptLevel.ERROR));%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>团队名称：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 required max-length-15" name="title" value="<%StringHelper.filterHTML(out, request.getParameter("title"));%>"/>
                        	<p tip>最大15个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span>相片：</div>
                        <div class="info orange"><input type="file" class="text yhgl_ser yw_w4" name="image"/><p id="errorImage">&nbsp;</p></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>团队简介：</div>
                        <div class="info">
                        	<textarea name="content" class="yhgl_ser required" cols="100" rows="8" style="width:700px;height:200px;"><%StringHelper.format(out, request.getParameter("content"), fileStore); %></textarea>
                        	 <div class="clear"></div>
                        	<p tip>&nbsp;</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span>排序值：</div>
                        <div class="info orange">
                        	<input type="text" class="text yhgl_ser yw_w4 required isint max-length-10" name="sortindex"  value="<%StringHelper.filterHTML(out, request.getParameter("sortindex"));%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" class="btn4 mr30 sumbitForme" style="cursor: pointer;" fromname="form1" value="确认发布" />
                    	<a href="<%=controller.getURI(request, SearchGltd.class) %>" class="btn4">返回</a>
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
    <%@include file="/WEB-INF/include/left.jsp" %>
</div>
</div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
<script type="text/javascript">
	function checkImage(){
		var suffix = $("input:file").val();
		if('' == suffix || suffix == null || suffix.length == 0){
			$("#errorImage").addClass("red");
			$("#errorImage").html("您还没有选择图片");	
			return false;
		}
		var img = ['jpg','png','jpeg','gif','ico'];
		for(var i=0; i<img.length; i++){
			if(suffix.length > img[i].length && img[i] == suffix.substring(suffix.length-img[i].length)){
				$("#errorImage").removeClass("red");
				$("#errorImage").html("&nbsp;");
				return true;
			}
		}
		$("#errorImage").addClass("red");
		$("#errorImage").html("您插入的图片格式不正确");	
		return false;
	}
</script>
</body>
</html>