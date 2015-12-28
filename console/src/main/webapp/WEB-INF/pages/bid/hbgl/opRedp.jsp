<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.hbgl.OpRedp"%>
<%@page import="com.dimeng.p2p.S10.entities.RedPacket"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/kindeditor.jsp"%>
</head>
<body>
	<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="REDPLIST";
	RedPacket record=(RedPacket)request.getAttribute("record");
	String content=ObjectHelper.convert(request.getAttribute("content"), String.class);
	if(record==null){
		record=new RedPacket();
	}
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>操作配置</h3>
                    </div>
                 </div>
                  <div class="border p30 Men_bt no_table">
                    <form action="<%=controller.getURI(request, OpRedp.class)%>" method="post" class="form1"  onsubmit="return onSubmit();">
                    <ul class="cell noborder no_wi">
                    <li>
                        <div class="til"><span class="red">*</span> 发放类型：</div>
                        <div class="info">
                        	<select class="text yhgl_ser required" name="source">
                        		<option value="2" <%=2==record.source?"selected":"" %>>注册</option>
                        		<option value="3" <%=3==record.source?"selected":"" %>>推广</option>
                        	</select>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span> 红包类型：</div>
                       	<div class="info">
                        	<select class="text yhgl_ser required" name="type">
                        		<option value="1" <%=1==record.type?"selected":"" %>>投资红包</option>
                        		<!-- <option value="2" <%=2==record.type?"selected":"" %>>现金红包</option> -->
                        	</select>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 红包金额：</div>
                        <div class="info">
                        	<input name="amount" type="text" maxlength="6" class="text yhgl_ser required isNum" id="amount" value="<%if(record.amount.intValue()>0){out.print(record.amount.intValue());}%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                   <li>
                        <div class="til"><span class="red">*</span> 有效天数：</div>
                        <div class="info">
                        	<input name="effectiveDays" type="text" maxlength="50" class="text yhgl_ser required isNum" value="<%if(record.effectiveDays>0){out.print(record.effectiveDays);}%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span> 起投金额：</div>
                        <div class="info">
                        	<input name="ranges" type="text" maxlength="50" class="text yhgl_ser required isNum" value="<%if(record.ranges.intValue()>0){out.print(record.ranges.intValue());}%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="info">
                      		<input type="hidden" name="id"  value="<%=record.id%>"/>
                      </div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 状态：</div>
                        <div class="info">
                        	<select class="text yhgl_ser required" name="state">
                        		<option value="1" <%=1==record.state?"selected":"" %>>启用</option>
                        		<option value="2" <%=2==record.state?"selected":"" %>>关闭</option>
                        	</select>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
						<div class="til">
							<span class="red">*</span>红包规则内容：
						</div>
						<div class="info orange">
							<textarea name="content" id="content" cols="80" rows="9"
								style="width: 700px; height: 200px; visibility: hidden;"><%StringHelper.filterHTML(out, record.content!=null?record.content:"");%>
							</textarea>
							<p id="errorContent">&nbsp;</p>
						</div>
						<div class="clear"></div>
					</li>
                    <li>
                      <div class="clear"></div>
                    </li>         
                    </ul>
                    <div class="tc w220">
                    	<input type="submit" class="btn4 mr30 sumbitForme" value="确认" fromname="form1" />
                    	<input type="button" id="back" class="btn4" onclick="window.location.href='<%=controller.getURI(request, RedpList.class)%>'" value="返回" /></div>
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
	</script>
</body>
</html>