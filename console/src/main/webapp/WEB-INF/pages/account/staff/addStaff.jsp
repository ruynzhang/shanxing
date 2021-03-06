<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.staff.AddStaff"%>
<%@page import="com.dimeng.p2p.console.servlets.account.staff.GetStaff"%>
<%@page import="com.dimeng.p2p.console.servlets.account.staff.IsExist"%>
<%@page import="com.dimeng.p2p.console.servlets.account.staff.AddYg"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.StaffMap"%>
<%@page import="java.util.Map"%>
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
                    	<h3>添加员工信息</h3>
                    </div>
                 </div>
                  <div class="border p30 Men_bt no_table">
                    <form action="<%=controller.getURI(request, AddStaff.class)%>" method="post" class="form1"  onsubmit="return onSumbit();">
                    <input name="ucode" type="hidden" id="ucode"/>
                    <ul class="cell noborder no_wi">
                    <li>
                        <div class="til"><span class="red">*</span> 手机号：</div>
                        <div class="info">
                        	<input name="moblie" type="text" maxlength="11" class="text yhgl_ser required phonenumber" id="moblie" onblur="checkPhone();" value="<%StringHelper.filterQuoter(out, request.getParameter("moblie"));%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 用户名：</div>
                        <div class="info">
                        	<input name="userName" type="text" maxlength="18" class="text yhgl_ser required username" id="userName" value="<%StringHelper.filterQuoter(out, request.getParameter("userName"));%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 内外勤：</div>
                        <div class="info">
                        	<select class="text yhgl_ser required" name="inSign" id="inSign">
                        		<option value="1">内勤</option>
                        		<option value="2">外勤</option>
                        	</select>
                        </div>
                        <div class="clear"></div>
                    </li>
                   <li>
                        <div class="til"><span class="red">*</span> 所属部门：</div>
                        <div class="info">
                        	<select id="deptNum" name="deptNum" class="text yhgl_ser required">
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
                        	<input name="empNo" type="text" maxlength="50" class="text yhgl_ser" value="<%StringHelper.filterQuoter(out, request.getParameter("empNo"));%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li id="li_jobNo">
                        <div class="til">客服专员工号：</div>
                        <div class="info">
                        	<input name="jobNo" type="text" maxlength="50" class="text yhgl_ser" value="<%StringHelper.filterQuoter(out, request.getParameter("jobNo"));%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="info">
                      		<input id="post_url" type="hidden" value="<%=controller.getURI(request, IsExist.class)%>"/>
                      		<input id="post_url2" type="hidden" value="<%=controller.getURI(request, GetStaff.class)%>"/>
                      </div>
                    </li> 
                    <li>
                      <div class="clear"></div>
                    </li>         
                    </ul>
                    <div class="tc w220">
                    	<input type="submit" class="btn4 mr30 sumbitForme" value="确认" fromname="form1" />
                    	<input type="button" id="back" class="btn4" onclick="window.location.href='<%=controller.getURI(request, YgList.class)%>'" value="返回" /></div>
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
	$("#inSign option[value="+<%=request.getParameter("inSign")%>+"]").attr("selected",true);
	$("#deptNum option[value="+<%=request.getParameter("deptNum")%>+"]").attr("selected",true);
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
		return checkSel() && checkPhone();
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
	function checkPhone(){
   		var flag=false;
   		var val=$("#moblie").val();
   		if(val!="" && val.length>0){
   			$.ajax({
   			   type: "POST",
   			   cache:false,
   				async:false,
   			   url: $("#post_url").val(),
   			   data: "num=3&str="+val,
   			   success: function(msg){
   			     if(msg=="true"){
   			    	alert("此手机号码已被占用,请用其他的手机号码!");
   			     	return;
   			     }else{
   			    	flag=true;
   			    	$.ajax({
   		   			   type: "POST",
   		   			   cache:false,
   		   			   url: $("#post_url2").val(),
   		   			   data: "str="+val,
   		   			   success: function(josn){
   		   				  if(josn!="1"){
   		   				   $(":input").removeAttr("disabled").removeAttr("style");
   		   				 	var entity=josn.split(",");
   		   					$("#userName").attr("readonly","readonly").attr("style","color:gray");
   		   					$("#userName").val(entity[0]);
   		   					$("#ucode").val(entity[1]);
   		   				   }else{
   		   					$(":input").removeAttr("disabled").removeAttr("style");
   		   					$("#userName").removeAttr("readonly");
		   					$("#userName").val("")
		   					$("#ucode").val("");
   		   				   }
   		   			   }
   		   			});
   			     }
   			   }
   			});
   		}
   		
   		return flag;
   	 }
    </script>
</body>
</html>