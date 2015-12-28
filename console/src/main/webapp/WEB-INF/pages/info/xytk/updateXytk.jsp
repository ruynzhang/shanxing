<%@page import="com.dimeng.p2p.modules.base.console.service.entity.TermRecord"%>
<%@page import="com.dimeng.p2p.common.enums.TermType"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.TermManage"%>
<%@page import="com.dimeng.p2p.console.servlets.info.xytk.UpdateXytk"%>
<%@page import="com.dimeng.p2p.variables.FileType"%>
<%@page import="com.dimeng.p2p.console.servlets.upload.Upload"%>
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
	CURRENT_SUB_CATEGORY = "XYTK";
%>
<%
		TermRecord record = ObjectHelper.convert(request.getAttribute("record"), TermRecord.class);		
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改协议条款</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form name="example" method="post" action="<%=controller.getURI(request, UpdateXytk.class)%>" class="form1" onsubmit="return onSubmit();">
                    <ul class="cell xc_jcxx ">
                    <li>
                        <div class="til"><span class="red">&nbsp;</span></div>
                        <div class="info orange">
                        <%StringHelper.filterHTML(out, controller.getPrompt(request, response, PromptLevel.ERROR));%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>协议类型：</div>
                        <div class="info orange">
                        <select name="id"  class="yhgl_ser">
                        	<option value="<%=TermType.BXBZ %>" <% if(record.type.equals(TermType.BXBZ)){%> selected="selected"<%} %>><%=TermType.BXBZ.getName() %></option>
                        	<option value="<%=TermType.ZCXY %>" <% if(record.type.equals(TermType.ZCXY)){%> selected="selected"<%} %>><%=TermType.ZCXY.getName() %></option>
                        	<option value="<%=TermType.DBBXY %>" <% if(record.type.equals(TermType.DBBXY)){%> selected="selected"<%} %>><%=TermType.DBBXY.getName() %></option>
                        	<option value="<%=TermType.XYRZBXY %>" <% if(record.type.equals(TermType.XYRZBXY)){%> selected="selected"<%} %>><%=TermType.XYRZBXY.getName() %></option>
                        	<option value="<%=TermType.SDRZBXY %>" <% if(record.type.equals(TermType.SDRZBXY)){%> selected="selected"<%} %>><%=TermType.SDRZBXY.getName() %></option>
                        	<option value="<%=TermType.YXLCXY %>" <% if(record.type.equals(TermType.YXLCXY)){%> selected="selected"<%} %>><%=TermType.YXLCXY.getName() %></option>
                        	<option value="<%=TermType.ZQZRXY %>" <% if(record.type.equals(TermType.ZQZRXY)){%> selected="selected"<%} %>><%=TermType.ZQZRXY.getName() %></option>
                        	<option value="<%=TermType.JKXYSB %>" <% if(record.type.equals(TermType.JKXYSB)){%> selected="selected"<%} %>><%=TermType.JKXYSB.getName() %></option>
                        	<option value="<%=TermType.ZQZRSMS %>" <% if(record.type.equals(TermType.ZQZRSMS)){%> selected="selected"<%} %>><%=TermType.ZQZRSMS.getName() %></option>
                        
                        
                        </select>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>文章内容：</div>
                        <div class="info">
                        <textarea name="content" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"><%StringHelper.format(out, record.content, fileStore); %></textarea>
                        	<p id="errorContent">&nbsp;</p>
                        </div>
                        <div class="clear"></div>
                    </li>
                          
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" class="btn4 mr30 sumbitForme" style="cursor: pointer;" fromname="form1" value="确认发布" />
                    	<a href="<%=controller.getURI(request, SearchXytk.class) %>" class="btn4">返回</a>
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
<%@include file="/WEB-INF/include/kindeditor.jsp" %>
	<script>
		var editor1;
		KindEditor.ready(function(K) {
			editor1 = K.create('textarea[name="content"]', {
				uploadJson : '<%=controller.getURI(request, Upload.class)%>?type=<%=FileType.ARTICLE_ATTACHMENT.ordinal()%>',
				allowFileManager : false,
				formatUploadUrl: false,
				afterBlur:function(){
					this.sync();
					if(this.count('text')=='')
					{
						$("#errorContent").addClass("red");
						$("#errorContent").html("文章内容不能为空");	
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
				$("#errorContent").html("文章内容不能为空");
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
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>