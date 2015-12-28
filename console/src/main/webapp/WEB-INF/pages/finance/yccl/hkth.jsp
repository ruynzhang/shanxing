<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.xxczgl.AddXxcz"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="CWGL";
	CURRENT_SUB_CATEGORY="HKTH";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>还款</h3>
                    </div>
                    <div class="con">
                    <form action="<%=controller.getURI(request, Hkth.class) %>" method="post" class="form1">
                    <ul class="cell noborder yxjh ">
                    <li>
                        <div class="til"><span class="red">*</span>投标订单号：</div>
                        <div class="info">
                        	<input name="ordId" type="text" class="yhgl_ser required isint minf-size-0" maxlength="10" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="clear"></div>
                    </li>                    
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" class="btn4 mr30 sumbitForme" value="提交" fromname="form1" />
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
<%
	String info = controller.getPrompt(request, response, PromptLevel.INFO);
%>
<div id="dialog" style="<%=StringHelper.isEmpty(info)?"display: none;":"" %>">
<div class="popup_bg"></div>
<div class="w440 thickbox thickpos" style="margin:-50px 0 0 -150px; width:300px;">
     <div class="tit">
     	<span class="fl pl15">提示</span>
        <span class="fr pr15 close"><a href="#">关闭</a></span>
     </div>
     <div class="info clearfix">
     	<div class="clearfix">
           <span class="icon_cw" style="display:none;"></span>
           <span class="icon_yw" style="display:none;"></span>
           <span class="icon_cg" style="display:none;"></span>							            
           <span class="fl tips f16"><span class="icon_gt" ></span><%StringHelper.filterHTML(out, info); %></span>
       </div>
    	<div class="clear"></div>				        
     </div>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
		$(function(){
			$("div.w440 div.tit span.close").click(function(){
				$("#dialog").hide();
			});
		});
	</script>
</body>
</html>