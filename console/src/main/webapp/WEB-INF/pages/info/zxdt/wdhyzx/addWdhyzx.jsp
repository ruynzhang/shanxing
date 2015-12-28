<%@page import="com.dimeng.p2p.common.enums.ArticlePublishStatus"%>
<%@page import="com.dimeng.p2p.console.servlets.info.zxdt.wdhyzx.AddWdhyzx"%>
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
	CURRENT_SUB_CATEGORY = "WDHYZX";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>添加网贷行业资讯</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form name="example" method="post" action="<%=controller.getURI(request, AddWdhyzx.class)%>" class="form1" onsubmit="return onSubmit();">
                    <ul class="cell xc_jcxx ">
                    <li>
                        <div class="til"><span class="red">&nbsp;</span></div>
                        <div class="info orange">
                        <%StringHelper.filterHTML(out, controller.getPrompt(request, response, PromptLevel.ERROR));%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>文章标题：</div>
                        <div class="info"><input type="text" class="text yhgl_ser yw_w4 required max-length-30" name="title" value="<%StringHelper.filterHTML(out,request.getParameter("title"));%>"/>
            				<p tip>最大30个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                      <li>
                        <div class="til">来源：</div>
                        <div class="info orange"><input type="text" class="text yhgl_ser yw_w4 max-length-50" name="source" value="<%StringHelper.filterHTML(out,request.getParameter("source"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                      <li>
                        <div class="til"><span class="red"></span>排序值：</div>
                        <div class="info orange"><input type="text" class="text yhgl_ser yw_w4 isint max-length-10" name="sortIndex" value="<%StringHelper.filterHTML(out,request.getParameter("sortIndex"));%>" />
                        	<p tip></p>
                        	<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                      <li>
                        <div class="til"><span class="red"></span>是否发布：</div>
                        <div class="info orange">
                        	<select name="status" class="yhgl_ser">
                        		<%String status =request.getParameter("status");  %>
                        		<option value="<%=ArticlePublishStatus.WFB%>" <%if(!StringHelper.isEmpty(status) && status.equals(ArticlePublishStatus.WFB.name())){ %>selected="selected" <%} %>><%=ArticlePublishStatus.WFB.getName()%></option>
                        		<option value="<%=ArticlePublishStatus.YFB%>" <%if(!StringHelper.isEmpty(status) && status.equals(ArticlePublishStatus.YFB.name())){ %>selected="selected" <%} %>><%=ArticlePublishStatus.YFB.getName()%></option>
                        	</select>
                       </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>发布时间：</div>
                        <div class="info orange">
                        	<input type="text" readonly="readonly" id="datepicker1" name="publishTime" class="text yhgl_ser yw_w4 required" value="<%StringHelper.filterHTML(out, request.getParameter("publishTime"));%>"/>
                        	<p tip></p>
                        	<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>标题：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 max-length-30" name="html_title" value="<%StringHelper.filterHTML(out, request.getParameter("html_title"));%>"/>
                       		<p tip>最大30个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>关键字：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 max-length-50" name="html_keywords" value="<%StringHelper.filterHTML(out, request.getParameter("html_keywords"));%>"/>
                        	<p tip>最大50个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>描述：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 max-length-110" name="html_description" value="<%StringHelper.filterHTML(out, request.getParameter("html_description"));%>"/>
                        	<p tip>最大110个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>文章内容：</div>
                        <div class="info">
                        	<textarea name="content" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"><%StringHelper.format(out, request.getParameter("content"), fileStore); %></textarea>
                        	<p id="errorContent">&nbsp;</p>
                        </div>
                        <div class="clear"></div>
                    </li>
               		</ul>
                    <div class="tc w220 pt20"><input type="submit"  class="btn4 mr30 sumbitForme" style="cursor: pointer;" fromname="form1" value="确认发布" />
                    <a href="<%=controller.getURI(request, SearchWdhyzx.class) %>" class="btn4">返回</a>
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
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	$(function() {
		$("#datepicker1").datepicker({inline: true});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("publishTime"));%>");
	});
	</script>
</body>
</html>