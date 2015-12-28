<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.common.enums.SendType"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.hbgl.ImportHbUser"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.hbgl.AddRedpRecord"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/kindeditor.jsp"%>
</head>
<body>
	<%
	String[] userNames = ObjectHelper.convertArray(request.getAttribute("userNames"), String.class);
	String content=ObjectHelper.convert(request.getParameter("content"), String.class);
	String msg=ObjectHelper.convert(request.getParameter("msg"), String.class);
	String sendType=request.getParameter("sendType");
	if(StringHelper.isEmpty(sendType))
	{
		sendType=SendType.ZDR.name();
	}
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="REDPRECORDLIST";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>发放红包</h3>
                    </div>
                 </div>
                  <div class="border p30 Men_bt no_table">
                    <form action="<%=controller.getURI(request, AddRedpRecord.class)%>" method="post" class="form1"  onsubmit="return onSumbit();">
                    <ul class="cell noborder no_wi">
                    <li>
						<div class="til">
							<span class="red">*</span>发送对象：
						</div>
						<div class="info">
							<%
								for(SendType type:SendType.values())
								{
							%>
							<input type="radio" value="<%=type.name()%>" name="sendType" onchange="showSms('<%=type %>')" <%if(type.name().equals(sendType)) {%> checked="checked" <%} %>/><%=type.getName() %>
							<%} %>
						</div>
						<div class="clear"></div>
					</li>
                    <li id="uNamesLi">
                        <div class="til"><span class="red">*</span> 用户名：</div>
                        <div class="info">
                       		<textarea name="uNames" id="uNames" cols="45" rows="5" class="border fl mr10 yw_w5 required"><%if (userNames != null) {for (String s : userNames) {%><%=s+"\n"%><%}}%></textarea>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
							<a href="javascript:void(0)" id="importUser" class="btn3 tc">导入用户名</a>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <div id="drsm" style="padding-left: 169px;">支持导入csv、txt格式数据</div>
                    <li>
                        <div class="til"><span class="red">*</span> 红包类型：</div>
                        <div class="info">
                        	<select class="text yhgl_ser required" name="type">
                        		<option value="1" <%="1".equals(request.getParameter("type"))?"selected":"" %>>投资红包</option>
                        		<option value="2" <%="2".equals(request.getParameter("type"))?"selected":"" %>>现金红包</option>
                        	</select>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 红包金额：</div>
                        <div class="info">
                        	<input name="amount" type="text" maxlength="6" class="text yhgl_ser required isNum" id="amount" value="<%StringHelper.filterQuoter(out,request.getParameter("amount"));%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 发放时间：</div>
                        <div class="info">
                        	<input type="text" name="startTime" readonly="readonly" id="datepicker1" class="yhgl_input required date" value="<%StringHelper.filterQuoter(out,request.getParameter("startTime"));%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 到期时间：</div>
                        <div class="info">
                        	<input readonly="readonly" type="text" name="endTime" id="datepicker2" class="yhgl_input required date" value="<%StringHelper.filterQuoter(out,request.getParameter("endTime"));%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span> 起投金额：</div>
                        <div class="info">
                        	<input name="ranges" type="text" maxlength="50" class="text yhgl_ser required isNum" value="<%StringHelper.filterQuoter(out,request.getParameter("ranges"));%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="info">
                      		<input type="hidden" name="state"  value="1"/>
                      		<input type="hidden" name="source"  value="1"/>
                      </div>
                    </li>
                    <li>
						<div class="til">
							<span class="red">*</span>红包规则内容：
						</div>
						<div class="info orange">
							<textarea name="content" id="content" cols="80" rows="9"
								style="width: 700px; height: 200px; visibility: hidden;"><%StringHelper.filterHTML(out, content);%>
							</textarea>
							<p id="errorContent">&nbsp;</p>
						</div>
						<div class="clear"></div>
					</li>
					<li>
						<div class="til">
							<span class="red">*</span>短信内容：
						</div>
						<div class="info orange">
							<textarea rows="7" cols="45" maxlength="200" name="msg" class="border required max-length-200"><%StringHelper.filterHTML(out, msg);%></textarea>
							<p tip></p>
							<p errortip class="" style="display: none"></p>
						</div>
						<div class="clear"></div>
					</li>
                    <li>
                      <div class="clear"></div>
                    </li>         
                    </ul>
                    <div class="tc w220">
                    	<input type="submit" class="btn4 mr30 sumbitForme" value="确认" fromname="form1" />
                    	<input type="button" id="back" class="btn4" onclick="window.location.href='<%=controller.getURI(request, RedpRecordList.class)%>'" value="返回" /></div>
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
<div id="import" style="display: none">
			<div class="popup_bg"></div>
			<div class="w440 thickbox thickpos" style="margin: -80px 0 0 -220px;"
				id="showDiv">
				<div class="info clearfix">
					<form action="<%=controller.getURI(request, ImportHbUser.class)%>"
						method="post" enctype="multipart/form-data">
						<div class="clearfix">
							导入用户名:<input type="file" name="file" value="导入用户名" />
						</div>
						<div class="dialog_btn">
							<input type="submit" value="提交" class="btn3 mr10" /> <input
								type="button" name="button2" onclick="$('#import').hide()"
								value="取消" class="btn5" />
						</div>
					</form>
				</div>
			</div>
		</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	var editor1;
	KindEditor.ready(function(K) {
		    editor1 = K.create('textarea[name="content"]', {
		    resizeType : 1,
			allowPreviewEmoticons : false,
			allowImageUpload : false,
			items : [
					'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
					'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
					'insertunorderedlist', '|', 'emoticons', 'link'],
			afterBlur:function(){
				this.sync();
				if(this.count('text')=='')
				{
					$("#errorContent").addClass("red");
					$("#errorContent").html("红包规则内容不能为空");	
				}
				else if(this.count('text')>300)
				{
					$("#errorContent").addClass("red");
					$("#errorContent").html("红包规则内容不能超过300个字");
				}
				else
				{
					$("#errorContent").removeClass("red");
					$("#errorContent").html("&nbsp;");
				}
			}
		});
	});
	function onSubmit()
	{
		if(editor1.count('text')=='')
		{
			$("#errorContent").addClass("red");
			$("#errorContent").html("红包规则内容不能为空");	
			return false;
		}
		else if(editor1.count('text')>300)
		{
			$("#errorContent").addClass("red");
			$("#errorContent").html("红包规则内容不能超过300个字");
			return false;	
		}
		else
		{
			$("#errorContent").removeClass("red");
			$("#errorContent").html("&nbsp;");
			return true;
		}
	}
	$("#importUser").click(function() {
		$("#import").show();
	});
	$("#close").click(function() {
		$("#import").hide();
	});
	$(function() {
		$("#datepicker1").datepicker({inline: true,
			onSelect : function(selectedDate) {
	            $("#datepicker2").datepicker("option", "minDate", selectedDate); 
	        }
		});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
	function showSms(type)
	{
		if(type=='<%=SendType.ZDR%>')
		{
			$("#uNamesLi").show();	
			$("#uNames").attr("value","");
			$("#drsm").show();
		}else if(type=='<%=SendType.SY%>')
		{
			$("#uNamesLi").hide();
			$("#uNames").attr("value","all");
			$("#drsm").hide();
		}
	}
	</script>
</body>
</html>