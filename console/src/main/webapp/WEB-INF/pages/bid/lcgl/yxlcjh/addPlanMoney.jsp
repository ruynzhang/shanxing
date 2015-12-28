<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.S64.enums.T6410_F14"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.yxlcjh.AddPlanMoney"%>
<html>
<link href="<%=controller.getStaticPath(request) %>/css/hhmmss.css" rel="stylesheet">
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%	
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="YXLCJH";
	T6211[] t6211s = ObjectHelper.convertArray(request.getAttribute("t6211s"), T6211.class);
	String applyStartTime=request.getParameter("applyStartTime");
	String applyEndTime=request.getParameter("applyEndTime");
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>优选理财计划</h3>
                    </div>
                    <div class="con">
                    <form action="<%=controller.getURI(request, AddPlanMoney.class)%>" method="post" class="form1">
                    <ul class="cell noborder yxjh ">
                    <li>
                        <div class="til"><span class="red">*</span>计划名称：</div>
                        <div class="info">
                        	<input name="planName" type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("planName"));%>"/>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
						</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>用户投资下限：</div>
                        <div class="info">
                        	<input id="investFloor" name="investFloor" type="text" value="<%StringHelper.filterHTML(out, request.getParameter("investFloor"));%>" class="text yhgl_ser required lcjexx-size minf-size-<%=configureProvider.getProperty(SystemVariable.YXLCTZXX) %>" mtest="/^[-\+]?\d+(\.\d+)?$/" mtestmsg="金额格式不正确"/>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>用户投资上限：</div>
                        <div class="info">
                        	<input id="investCeiling" name="investCeiling" type="text" value="<%StringHelper.filterHTML(out, request.getParameter("investCeiling"));%>" class="text yhgl_ser required lcjesx-size minf-size-<%=configureProvider.getProperty(SystemVariable.YXLCTZXX) %>"  mtest="/^[-\+]?\d+(\.\d+)?$/" mtestmsg="金额格式不正确"/>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
							<p id="investFloorError" class="fl"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>计划金额：</div>
                        <div class="info">
                        	<input id="planMoneys" name="planMoneys" type="text" value="<%StringHelper.filterHTML(out, request.getParameter("planMoneys"));%>" class="text yhgl_ser required jkje-size minf-size-<%=configureProvider.getProperty(SystemVariable.YXLCTZXX) %>" mtest="/^[-\+]?\d+(\.\d+)?$/" mtestmsg="金额格式不正确" />
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
							<p class="fl" id="planMoneysError"></p>
                      </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>收益年利率：</div>
                        <div class="info">
                        	<input name="earningsYearRate" type="text" value="<%StringHelper.filterHTML(out, request.getParameter("earningsYearRate"));%>" class="text yhgl_ser required min-size-0 maxf-size-99.9" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1}))$/" mtestmsg="格式不正确,只能有一位小数" />
                        	<span class="fl">%</span>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                   <li>
                        <div class="til"><span class="red">*</span>加入费率：</div>
                        <div class="info">
                        	<input name="addYearRate" type="text" value="<%StringHelper.filterHTML(out, request.getParameter("addYearRate"));%>" class="text yhgl_ser required min-size-0 maxf-size-99.9" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1}))$/" mtestmsg="格式不正确,只能有一位小数" />
                        	<span class="fl">%</span>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>服务费率：</div>
                        <div class="info">
                        	<input name="serveRate" type="text" value="<%StringHelper.filterHTML(out, request.getParameter("serveRate"));%>" class="text yhgl_ser required min-size-0 maxf-size-99.9" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1}))$/" mtestmsg="格式不正确,只能有一位小数" />
                        	<span class="fl">%</span>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>退出费率：</div>
                        <div class="info">
                        	<input name="quitRate" type="text" value="<%StringHelper.filterHTML(out, request.getParameter("quitRate"));%>" class="text yhgl_ser required min-size-0 maxf-size-99.9" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1}))$/" mtestmsg="格式不正确,只能有一位小数" />
                        	<span class="fl">%</span>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>投标范围：</div>
                        <div class="info">
                        	<span class="tir required">
                          		<select name="tenderScope" class="yhgl_sel" style="width:300px;">
                          		<%
                          			int type=IntegerParser.parse(request.getParameter("tenderScope"));
                          		%>
                            		<%
									for (T6211 signType : t6211s) {
									%>
									<option value="<%=signType.F01%>" <%if(type==signType.F01) {%> selected="selected" <%} %>><%=signType.F02%></option>
									<%
										}
									%>
                          		</select>
                        	</span>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>锁定时间：</div>
                        <div class="info">
                        	<select name="lockTime" class="yhgl_sel yw_w3">
                        		<%
                        			int lockTime=IntegerParser.parse(request.getParameter("lockTime"));
                        		%>
								<option value="3" <%if(lockTime==3) {%> selected="selected" <%} %>>3个月</option>
								<option value="6" <%if(lockTime==6) {%> selected="selected" <%} %>>6个月</option>
								<option value="9" <%if(lockTime==9) {%> selected="selected" <%} %>>9个月</option>
								<option value="12" <%if(lockTime==12) {%> selected="selected" <%} %>>12个月</option>
								<option value="18" <%if(lockTime==18) {%> selected="selected" <%} %>>18个月</option>
								<option value="24" <%if(lockTime==24) {%> selected="selected" <%} %>>24个月</option>
							</select>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>申请开始时间：</div>
                        <div class="info">
                        	<input name="applyStartTime" id="datepicker1" type="text" class="yhgl_ser date required kssj-size"  />
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
                        </div>
                        <div class="tir"></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>申请截止时间：</div>
                        <div class="info">
                        	<input name="applyEndTime" id="datepicker2" type="text" class="yhgl_ser date required jzsj-size" />
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
                        </div>
                        <div class="tir"></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>收益方式：</div>
                        <div class="tir">
                        	<select name="earningsWay" class="yhgl_sel required" style="width:300px;">
                        		<%
									for (T6410_F14 earningsWay : T6410_F14.values()) {
								%>
								<option value="<%=earningsWay.name()%>" <%if(earningsWay.name().equals(request.getParameter("earningsWay"))){ %> selected="selected" <%} %>><%=earningsWay.getChineseName()%></option>
								<%
									}
								%>
                        	</select>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>状态：</div>
                        <div class="tir">
                        	待申请
                        	<input type="hidden" name="state" value="YFB" />
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>计划介绍：</div>
                        <div class="info">
                        	<textarea name="planDesc" rows="5" cols="10" class="text yhgl_ser required max-length-200" style="height:100px;">
                        	<%StringHelper.filterHTML(out, request.getParameter("planDesc")); %>
                        	</textarea>
                        	<p tip></p>
							<p errortip class="fl" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="info"></div>
                      <div class="clear"></div>
                    </li>
                    <li>
                      <div class="clear"></div>
                    </li>                    
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" onclick="return onSubmit();" class="btn4 mr30 sumbitForme" fromname="form1" value="保存" />
                    	<input type="button" onclick="window.location.href='<%=controller.getURI(request, PlanMoneyList.class)%>'" class="btn4" value="返回列表页" />
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
		String warringMessage=controller.getPrompt(request, response, PromptLevel.WARRING);
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
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-ui-1.10.4/js/time.js"></script>
	<script type="text/javascript">
	$(function() {
		 $('#datepicker1').datetimepicker({
				timeFormat: 'HH:mm:ss',
				dateFormat:'yy-mm-dd'
				});
		 $('#datepicker2').datetimepicker({
				timeFormat: 'HH:mm:ss',
				dateFormat:'yy-mm-dd'
				});
		<%
	   		if(!StringHelper.isEmpty(applyStartTime))
	   		{
	   	%>
	   	$("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("applyStartTime"));%>");
	   	<%}%>
	   	<%
   		if(!StringHelper.isEmpty(applyEndTime))
   		{
   		%>
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("applyEndTime"));%>");
	    <%}%>
	});
	
	var tempA = false;
	$("#investCeiling").blur(function(){
		var investCeiling = $("#investCeiling").val();
		var investFloor = $("#investFloor").val();
		if(parseInt(investCeiling) % parseInt(investFloor) != 0){
			$("#investFloorError").html("必须是"+investFloor+"的倍数");
			$("#investFloorError").addClass("error_tip");
			$("#investFloorError").show();
			tempA = false;
		}else{
			$("#investFloorError").hide();
			tempA = true;
		}
	});
	
	var tempB = false;
	$("#planMoneys").blur(function(){
		var investCeiling = $("#investCeiling").val();
		var investFloor = $("#planMoneys").val();
		if(parseInt(investFloor) % parseInt(investCeiling) != 0){
			$("#planMoneysError").html("必须是"+investCeiling+"的倍数");
			$("#planMoneysError").addClass("error_tip");
			$("#planMoneysError").show();
			tempB = false;
		}else{
			$("#planMoneysError").hide();
			tempB = true;
		}
	});
	
	function onSubmit(){
		$("#investFloor").trigger("blur");
		$("#planMoneys").trigger("blur");
		
		if(tempA && tempB){
			return true;
		}else{
			return false;
		}
	}

	</script>
</body>
</html>