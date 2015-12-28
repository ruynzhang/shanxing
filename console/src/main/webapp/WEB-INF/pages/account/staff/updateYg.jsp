<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.StaffMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.dimeng.p2p.console.servlets.account.staff.UpdateYg"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Staff"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="YGXX";
	Staff user = ObjectHelper.convert(request.getAttribute("entity"), Staff.class);
	int mapSize=StaffMap.deptMap.size();
	Object s[] = StaffMap.deptMap.keySet().toArray();
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改员工信息</h3>
                    </div>
                 </div>
                  <div class="border p30 Men_bt no_table">
                    <form action="<%=controller.getURI(request, UpdateYg.class)%>" method="post" class="form1" onsubmit="return onSumbit();">
                    <ul class="cell noborder no_wi">
                    <li> 
                        <div class="til"><span class="red">*</span> 用户名：</div>
                        <div class="info"><%StringHelper.filterHTML(out, user.userName);%></div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span> 手机号：</div>
                        <div class="info"><%StringHelper.filterHTML(out,user.moblie);%></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 内外勤：</div>
                        <div class="info">
                        	<select class="text yhgl_ser required" name="inSign" disabled="disabled" >
                        		<option value="1" <%=user.inSign==1?"selected":"" %>>内勤</option>
                        		<option value="2" <%=user.inSign==2?"selected":"" %>>外勤</option>
                        	</select>
                        </div>
                        <div class="clear"></div>
                    </li>
                   <li>
                        <div class="til"><span class="red">*</span> 所属部门：</div>
                        <div class="info">
                        	<select id="deptNum" name="deptNum" class="text yhgl_ser required" disabled="disabled" onblur="checkSel();">
                        	 <option value="0">请选择部门</option>
                        	<%for(int i = 0; i < mapSize; i++) {%>
                            <option value="<%=s[i]%>"><%=StaffMap.deptMap.get(s[i])%></option>
                    		<%}%>
                        	</select>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til">员工编号：</div>
                        <div class="info">
                        	<input name="empNo" type="text" maxlength="50" disabled="disabled" class="text yhgl_ser" value="<%StringHelper.filterHTML(out, user.empNo);%>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li id="li_jobNo">
                        <div class="til">客服专员工号：</div>
                        <div class="info">
                        	<input name="jobNo" type="text" maxlength="50" class="text yhgl_ser" disabled="disabled" value="<%StringHelper.filterHTML(out, user.jobNo);%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="info"><input name="id" type="hidden" value="<%=user.id%>"/></div>
                    </li> 
                    <li>
                      <div class="clear"></div>
                    </li>         
                    </ul>
                    <div class="tc w220">
                    	<%--<input type="submit" class="btn4 mr30 sumbitForme" value="确认" fromname="form1" /> --%>
                    	<input type="button" class="btn4" onclick="javascript:history.back();" value="返回" /></div>
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
	<script type="text/javascript">
   	 $("#deptNum option[value="+<%=user.deptNum%>+"]").attr("selected",true);
 	$(document).ready(function(){
		jobNo();
		$("#deptNum").change(function(){
			jobNo();
		});
	});
	
	function jobNo(){
		var val=$("#deptNum").val();
		if(val==12){
			$("#li_jobNo").attr("style","display: block;");
		}else{
			$("#li_jobNo").attr("style","display: none;");
		}
	}
   	function onSumbit(){
		return checkSel();
	}
	function checkSel(){
		var flag=false;
		var val=$("#deptNum").val();
		if(val==0){
			alert("请选择部门!");
		}else{
			flag=true;
		}
		return flag;
	}
    </script>
</body>
</html>