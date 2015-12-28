<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.statistics.AddTradeRecord"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
	CURRENT_CATEGORY = "TJGL";
	CURRENT_SUB_CATEGORY = "TRADERECORDLIST";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>添加线下交易记录</h3>
                    </div>
                 </div>
                  <div class="border p30 Men_bt no_table">
                    <form action="<%=controller.getURI(request, AddTradeRecord.class)%>" method="post" class="form1"  onsubmit="return onSumbit();">
                    <ul class="cell noborder no_wi">
                    <li>
                        <div class="til"><span class="red">*</span> 合同编号：</div>
                        <div class="info">
                        	<input name="num" type="text" maxlength="12" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("num"));%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 姓名：</div>
                        <div class="info">
                        	<input name="name" type="text" maxlength="18" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til">员工编号：</div>
                        <div class="info">
                        	<input name="empNo" type="text" maxlength="18" class="text yhgl_ser" value="<%StringHelper.filterHTML(out, request.getParameter("empNo"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 性别：</div>
                        <div class="info">
                        	<select class="text yhgl_ser required" name="sex">
                        		<option value="女">女</option>
                        		<option value="男">男</option>
                        	</select>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 身份证号码：</div>
                        <div class="info">
                        	<input name="idcard" type="text" maxlength="18" class="text yhgl_ser required idcard" value="<%StringHelper.filterHTML(out, request.getParameter("idcard"));%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                   <li>
                        <div class="til"><span class="red">*</span> 产品名称：</div>
                        <div class="info">
                        	<input name="product_Name" type="text" maxlength="18" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("product_Name"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 产品期限（月）：</div>
                        <div class="info">
                        	<input name="product_qx" type="text" maxlength="18"  mtest="/^([1-9][0-9]*)$/" mtestmsg="必须为数字格式(且大于0)" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("product_qx"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 出借金额：</div>
                        <div class="info">
                        	<input name="cj_amount" type="text" maxlength="18" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)"  class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("cj_amount"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 回款利息：</div>
                        <div class="info">
                        	<input name="lx_amount" type="text" maxlength="18" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)"  class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("lx_amount"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 本息和：</div>
                        <div class="info">
                        	<input name="sum_amount" type="text" maxlength="18" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)"  class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("sum_amount"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 出借日期：</div>
                        <div class="info">
                        	<input name=cj_date type="text" id="datepicker1" readonly="readonly" class="text yhgl_ser required date" value="<%StringHelper.filterHTML(out, request.getParameter("cj_date"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 回款日期：</div>
                        <div class="info">
                        	<input name="hk_date" type="text" id="datepicker2" readonly="readonly" class="text yhgl_ser required date" value="<%StringHelper.filterHTML(out, request.getParameter("hk_date"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 开户行：</div>
                        <div class="info">
                        	<input name="branch" type="text" maxlength="18" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("branch"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 回款账号：</div>
                        <div class="info">
                        	<input name="cardNum" type="text" maxlength="18" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("cardNum"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"> 债权类型：</div>
                        <div class="info">
                        	<input name="zq_type" type="text" maxlength="18" class="text yhgl_ser" value="<%StringHelper.filterHTML(out, request.getParameter("zq_type"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    
                    <li>
                      <div class="info">
                      </div>
                    </li> 
                    <li>
                      <div class="clear"></div>
                    </li>         
                    </ul>
                    <div class="tc w220">
                    	<input type="submit" class="btn4 mr30 sumbitForme" value="确认" fromname="form1" />
                    	<input type="button" id="back" class="btn4" onclick="window.location.href='<%=controller.getURI(request, TradeRecordList.class)%>'" value="返回" /></div>
                    <div class="clear"></div>
                    </form>                  
                    </div>
            	<div class="mb15"></div>
                <div class="box2 clearfix"></div>
            </div>
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
	<%@include file="/WEB-INF/include/left.jsp"%>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	$(function(){
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
    </script>
</body>
</html>