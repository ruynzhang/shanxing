<%@page import="com.dimeng.p2p.common.enums.CustomerServiceType"%>
<%@page import="com.dimeng.p2p.console.servlets.info.kfzx.AddKfzx"%>
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
	CURRENT_SUB_CATEGORY = "KFZX";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
	 <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>添加客服中心</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form action="<%=controller.getURI(request, AddKfzx.class) %>" method="post" enctype="multipart/form-data" onsubmit="return checkImage();" class="form1">
                    <ul class="cell noborder yw_jcxx">
                    <li>
                        <div class="til"><span class="red">&nbsp;</span></div>
                        <div class="info orange">
                        <%StringHelper.filterHTML(out, controller.getPrompt(request, response, PromptLevel.ERROR));%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    
                    <li>
                        <div class="til"><span class="red">*</span>客服名称：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 required max-length-30" name="name" value="<%StringHelper.filterHTML(out,request.getParameter("name"));%>"/>
                        	<p tip>最大30个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>客服类型：</div>
                        <div class="info">
                          <select name="type" class="yhgl_ser">
                          	<%String type =request.getParameter("type");  %>
                            <option value="<%=CustomerServiceType.QQ %>" <%if(!StringHelper.isEmpty(type) && type.equals(CustomerServiceType.QQ.name())){ %>selected="selected" <%} %>><%=CustomerServiceType.QQ.getName() %> </option>
                          </select>
                      </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>客服号码：</div>
                        <div class="info">
                          	<input type="text" class="text yhgl_ser yw_w4 required max-length-30" name="number" value="<%StringHelper.filterHTML(out,request.getParameter("number"));%>"/>
                         	<p tip></p>
							<p errortip class="" style="display: none"></p>
                      </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>排序值：</div>
                        <div class="info orange">
                        	<input type="text" class="text yhgl_ser yw_w4 required isint max-length-10" name="sortIndex" value="<%StringHelper.filterHTML(out,request.getParameter("sortIndex"));%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>客服图片：</div>
                        <div class="info orange">
                        <input type="file" name="image" /><p id="errorImage">&nbsp;</p>
                        </div>
                        <div class="clear"></div>
                    </li>                    
               		</ul>
                    <div class="tc w220 pt20"><input type="submit" class="btn4 mr30 sumbitForme" style="cursor: pointer;" fromname="form1" value="确认" />
                    	<a href="<%=controller.getURI(request, SearchKfzx.class) %>" class="btn4">返回</a>
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