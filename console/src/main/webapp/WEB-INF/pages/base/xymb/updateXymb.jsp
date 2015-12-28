<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xymb.UpdateXymb"%>
<%@page import="com.dimeng.p2p.console.servlets.upload.Upload"%>
<%@page import="com.dimeng.p2p.FileType"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.Xymb"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xydj.ViewXydj"%>
<%@page import="com.dimeng.p2p.S51.entities.T5124"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xydj.AddXydj"%>
<html>
<link href="<%=controller.getStaticPath(request) %>/css/hhmmss.css" rel="stylesheet">
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%	
	CURRENT_CATEGORY="JCXXGL";
	CURRENT_SUB_CATEGORY="XYDJGL";
	Xymb xymb = ObjectHelper.convert(request.getAttribute("xymb"), Xymb.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改协议模板</h3>
                    </div>
                    <div class="con">
                    <form action="<%=controller.getURI(request, UpdateXymb.class)%>" method="post" class="form1" onsubmit="return onSubmit()">
                    <ul class="cell noborder yxjh ">
                    <li>
                        <div class="til"><span class="red">*</span>协议名称：</div>
                        <div class="info">
                        	<%StringHelper.filterHTML(out, xymb.F03);%>
						</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>协议模板内容：</div>
                        <div class="info">
                        	<textarea name="content" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;">
                        	<%=StringEscapeUtils.escapeHtml(xymb.text)%></textarea>
                       		<p id="errorContent">&nbsp;</p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="clear"></div>
                    </li>                    
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="hidden" name="id" value="<%=xymb.F01%>"/>
                    	<input type="submit" onclick="onSubmit();" class="btn4 mr30 sumbitForme" fromname="form1" value="保存" />
                    	<input type="button" onclick="window.location.href='<%=controller.getURI(request, XymbList.class)%>'" class="btn4" value="返回列表页" />
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
	<%@include file="/WEB-INF/include/kindeditor.jsp" %>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script>
		var editor1;
		KindEditor.ready(function(K) {
			editor1 = K.create('textarea[name="content"]', {
				uploadJson : '<%=controller.getURI(request, Upload.class)%>?type=<%=FileType.ARTICLE_ATTACHMENT.ordinal()%>',
				allowFileManager: true, 
				filterMode: false,
				formatUploadUrl: false,
				designMode:false,
				items : [
							'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
							'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
							'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
				afterBlur:function(){
					this.sync();
					if(this.count('text')=='')
					{
						$("#errorContent").addClass("red");
						$("#errorContent").html("协议模板内容不能为空");	
					}
					else
					{
						$("#errorContent").removeClass("red");
						$("#errorContent").html("&nbsp;");
					}
				}
			});
			prettyPrint();
		});
		
		function onSubmit()
		{
			if(editor1.count('text')=='')
			{
				$("#errorContent").addClass("red");
				$("#errorContent").html("内容不能为空");
				return false;
			}
			else
			{
				$("#errorContent").removeClass("red");
				$("#errorContent").html("&nbsp;");
				return true;
			}
		}
	</script>
</body>
</html>