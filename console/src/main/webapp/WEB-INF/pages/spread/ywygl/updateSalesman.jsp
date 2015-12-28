<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.spread.ywygl.SalesmanList"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.ywygl.Update"%>
<%@page import="com.dimeng.p2p.modules.salesman.console.service.entity.Salesman"%>
<%@page import="com.dimeng.p2p.modules.salesman.console.service.SalesmanManage"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY = "TGGL";
	CURRENT_SUB_CATEGORY = "YWYGL";
	Salesman salesman = (Salesman)request.getAttribute("salesman");
%>
<%@include file="/WEB-INF/include/header.jsp"%> 
<div class="w_main">

  <div class="main clearfix">

   <form action="<%=controller.getURI(request, Update.class) %>" method="post" class="form1">
   <div class="wrap">

        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改业务员账号</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <div class="con">
                       
                    <ul class="cell noborder no_wi">
                    <li class="clearfix">
                        <div class="til">业务员ID：</div>
                        <div class="info">
                        	<input type="hidden" name="ywyId" id="ywyId" value="<%StringHelper.filterHTML(out, salesman.ywyId); %>"/>
                        	<%StringHelper.filterHTML(out, salesman.ywyId); %></div>                        
                    </li>
                     <li class="clearfix">
                        <div class="til">业务员姓名：</div>
                        <div class="info">
                          <input type="text" name="name" id="name" class="text yhgl_ser required max-length-10" value="<%StringHelper.filterHTML(out, salesman.name); %>"/>
                          <p tip></p>
						  <p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li class="clearfix">
                        <div class="til">业务员手机号码：</div>
                        <div class="info">
                        <input type="text" name="tel" id="tel" class="text yhgl_ser required phonenumber" value="<%StringHelper.filterHTML(out, salesman.tel); %>"/>
                        <p tip></p>
						<p errortip class="" style="display: none"></p>
						</div>
						<div class="clear"></div>
                    </li>                                       
                    </ul>
                    <div class="tc w220">
                      <input type="submit" class="btn4 mr30 sumbitForme" fromname="form1"  style="cursor: pointer;" value="确认" />
                      <a class="btn5" style="cursor: pointer;" href="<%=controller.getURI(request, SalesmanList.class)%>">返回</a>
                    </div>
                    <div class="clear"></div>
                    </div>
                                      
                  </div>
                </div>
                <div>                
            </div>
              <div class="box2 clearfix"></div>
            </div>
        </div>   
    </div>
    </form>
	<%@include file="/WEB-INF/include/left.jsp"%>
  </div>
</div>


	<%
		String warringMessage=controller.getPrompt(request, response, PromptLevel.ERROR);
		if(!StringHelper.isEmpty(warringMessage))
		{
	%>
	<div class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;" id="showDiv">
      <div class="info clearfix">
        <div class="clearfix">
            <span class="fl tips"><%StringHelper.filterHTML(out, warringMessage); %></span>
        </div>
        <div class="dialog_btn"><input type="button" name="button2" onclick="$('#showDiv').hide()" value="确认"  class="btn4 ml50"/></div> 
      </div>
	</div>
	<%} %>


<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>