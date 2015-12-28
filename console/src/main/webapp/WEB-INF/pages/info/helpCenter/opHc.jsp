<%@page import="com.dimeng.p2p.console.servlets.info.helpCenter.SubLevel"%>
<%@page import="java.util.Map"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.HelpCenterVO"%>
<%@page import="com.dimeng.p2p.console.servlets.info.helpCenter.OpHc"%>
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
	CURRENT_SUB_CATEGORY = "HCLIST";
	HelpCenterVO record  = ObjectHelper.convert(request.getAttribute("vo"), HelpCenterVO.class);
	if(null==record){
		record=new HelpCenterVO();
	}
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>添加网站公告</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form name="example" method="post" action="<%=controller.getURI(request, OpHc.class)%>" class="form1" onsubmit="return onSubmit();">
                     <input type="hidden" value="<%=record.id %>" name="id"/>
                    <ul class="cell xc_jcxx ">
                     <li>
                        <div class="til"><span class="red">&nbsp;</span></div>
                        <div class="info orange">
                        <%StringHelper.filterHTML(out, controller.getPrompt(request, response,PromptLevel.ERROR )); %>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red"></span>一级：</div>
                        <div class="info orange">
                        <%if(record.id==0){ %>
                        	<select id="sel_id"  class="yhgl_ser"">
                        		<%
								Map<Integer, String> mapList=(Map<Integer, String>)request.getAttribute("map");
								if(mapList!=null){
									int mapSize=mapList.size();
									Object s[] = mapList.keySet().toArray();
									for(int i = 0; i < mapSize; i++) {
								%>
									<option value="<%=s[i]%>"><%=mapList.get(s[i])%></option>
								<%}} %>
                        	</select>
                        	<%}else{out.print(record.l1Name);} %>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>二级：</div>
                        <div class="info orange">
                       	 <%if(record.id==0){ %>
                        	<select name="pid"  class="yhgl_ser" id="pid">
                        	</select>
                        	<%}else{out.print(record.l2Name);}%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>问题：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 required max-length-30" name="title" value="<%StringHelper.filterHTML(out,record.title);%>"/>
                        	<p tip>最大30个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>内容：</div>
                        <div class="info">
	                        <textarea name="content" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"><%StringHelper.format(out,record.content, fileStore); %></textarea>
	                        <p id="errorContent">&nbsp;</p>
                        </div>
                        <div class="clear"></div>
                    </li>
                          
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" class="btn4 mr30 sumbitForme" style="cursor: pointer;" fromname="form1" value="提交" />
                    	<a href="<%=controller.getURI(request, HcList.class) %>" class="btn4">返回</a>
                    </div>
                	<div class="clear"><input type="hidden" id="post_url" value="<%=controller.getURI(request, SubLevel.class)%>"/></div>
                    </form>
                    <div class="clear"></div>                    
                  </div>
                </div>
              <div class="box2 clearfix"></div>
            </div>
        </div>   
    </div>
    <div class="l_main">
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
						$("#errorContent").html("公告内容不能为空");	
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
				$("#errorContent").html("公告内容不能为空");
				return false;
			}
			else
			{
				$("#errorContent").removeClass("red");
				$("#errorContent").html("&nbsp;");
				return true;
			}
		}
		$("#sel_id").change(function(){
			onLoad();
		});
		onLoad=function(){
			jQuery.ajax({
				   type: "post",
				   cache:false,
				   async:false,
				   url: $("#post_url").val(),
				   data: "pid="+$("#sel_id").val(),
				   success: function(html){
					  $("#pid").empty();
					  $("#pid").append(html);
				   }
				});
		}
		onLoad();
	</script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>