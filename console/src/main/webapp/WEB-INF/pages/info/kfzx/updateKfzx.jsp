<%@page import="com.dimeng.p2p.common.enums.CustomerServiceType"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.CustomerServiceManage"%>
<%@page import="com.dimeng.p2p.console.servlets.info.kfzx.UpdateKfzx"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.CustomerServiceRecord"%>
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
	<%
		CustomerServiceRecord record = ObjectHelper.convert(request.getAttribute("record"), CustomerServiceRecord.class); 
	%>
	 <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改客服中心</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form action="<%=controller.getURI(request, UpdateKfzx.class) %>" method="post" enctype="multipart/form-data" class="form1">
                    <input type="hidden" value="<%=record.id %>" name="id"/>
                    <ul class="cell noborder yw_jcxx">
                    <li>
                        <div class="til"><span class="red">&nbsp;</span></div>
                        <div class="info orange">
                        <%StringHelper.filterHTML(out, controller.getPrompt(request, response, PromptLevel.ERROR));%>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red"></span>&nbsp;</div>
                        <div class="info orange">
							<p errortip class="""><%StringHelper.filterHTML(out, controller.getPrompt(request, response,PromptLevel.ERROR));  %></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>客服名称：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 required max-length-30" name="name" value="<%StringHelper.filterHTML(out, record.name); %>"/>
                        	<p tip>最大30个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>客服类型：</div>
                        <div class="info orange">
                          <select name="type" class="yhgl_ser">
                            <option value="<%=CustomerServiceType.QQ %>" <%if(record.type.equals(CustomerServiceType.QQ)){ %>selected="selected" <%} %>><%=CustomerServiceType.QQ.getName() %> </option>
                          </select>
                      </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>客服号码：</div>
                        <div class="info orange">
                          <input type="text" class="text yhgl_ser yw_w4 required max-length-30" name="number" value="<%StringHelper.filterHTML(out, record.number); %>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                      </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>排序值：</div>
                        <div class="info orange">
	                        <input type="text" class="text yhgl_ser yw_w4 required isint max-length-10" name="sortIndex" value="<%=record.sortIndex%>"/>
	                        	<p tip></p>
								<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>客服图片：</div>
                        <div class="info orange">
                        <p class="mb10">
                        <img src="<%=fileStore.getURL(record.imageCode) %>"   width="158" height="100"/>
                        </p>
                        <p><input type="file" name="image" />
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
</body>
</html>