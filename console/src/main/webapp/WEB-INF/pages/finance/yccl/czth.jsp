<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.escrow.huifu.entity.ChargeAmend"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="CWGL";
	CURRENT_SUB_CATEGORY="HKTH";
	
	ChargeAmend[] amends = ObjectHelper.convertArray(request.getAttribute("amends"), ChargeAmend.class); 
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>充值</h3>
                    </div>
                    <div class="con">
                    <form action="<%=controller.getURI(request, Czth.class) %>" method="post" class="form1">
                    <ul class="cell noborder yxjh ">
                    <li>
                        <div class="til"><span class="red">*</span>时间：</div>
                        <div class="info">
                        	<P>
								<input type="text" name="startDate" id="datepicker1" readonly="readonly" class="yhgl_input date" />至
								<input type="text" name="endDate" id="datepicker2" readonly="readonly" class="yhgl_input date" />
							</P>
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
                <div class="box box1 mb15">
                	<div class="atil">
                    	<h3>异常订单修正列表</h3>
                    </div>
                    <div class="con">
                    	<%if(amends == null || amends.length <= 0){ %>
                    		未对任何订单进行修正
                    	<%}else{ %>
                    	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                    		<tr class="hsbg">
								<td>订单编号</td>
								<td>用户名</td>
								<td>订单金额（元）</td>
								<td>订单时间</td>
							</tr>
							<%for(ChargeAmend amend : amends){ %>
							<tr>
								<td><%=amend.ordId %></td>
								<td><%StringHelper.filterHTML(out, amend.userName); %></td>
								<td><%=Formater.formatAmount(amend.amount) %></td>
								<td><%=DateTimeParser.format(amend.time) %></td>
							</tr>
							<%} %>
                    	</table>
                    	<%} %>
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
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
		$(function(){
			$("div.w440 div.tit span.close").click(function(){
				$("#dialog").hide();
			});
			$("#datepicker1").datepicker({inline: true});
		    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker2").datepicker({inline: true});
		    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startDate"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endDate"));%>");
		});
	</script>
</body>
</html>