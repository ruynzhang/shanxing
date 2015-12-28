<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.system.jpush.ImportJpush"%>
<%@page import="com.dimeng.p2p.console.servlets.system.jpush.AddJpush"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.common.enums.SendType"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/kindeditor.jsp"%>
</head>
<body>
    <%
		String[] userNames = ObjectHelper.convertArray(
		request.getAttribute("userNames"), String.class);
			String sendType=request.getParameter("sendType");
			String content=ObjectHelper.convert(request.getAttribute("content"), String.class);
			if(StringHelper.isEmpty(sendType))
			{
		sendType=SendType.ZDR.name();
			}
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
			CURRENT_SUB_CATEGORY = "JGTS";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
						<div class="atil">
	              				<h3>APP推送</h3>
	           				 </div>
							<div class="con">
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, AddJpush.class)%>" method="post" class="form1" id="form1" onsubmit="return onSubmit();">
									<ul class="cell xc_jcxx ">
									     <li>
											<div class="til">
												<span class="red">*</span>发送对象：
											</div>
											<div class="info">
												<%
													for(SendType type:SendType.values())
													{
												%>
												<input type="radio" value="<%=type.name()%>" name="sendType"
													onchange="showLetter('<%=type%>')"
													<%if(type.name().equals(sendType)) {%> checked="checked"
													<%}%> /><%=type.getName()%>
												<%
													}
												%>
											</div>
											<div class="clear"></div>
										</li>
										<li id="letterLi">
											<div class="til">
												<span class="red">*</span>用户名：
											</div>
											<div class="info">
												<textarea name="userName" id="username" cols="45" rows="5" class="border fl mr10 yw_w5 required"><%if (userNames != null) {for (String s : userNames) {%><%=s+"\n"%><%}}%></textarea>
												<p tip></p>
												<p errortip class="" style="display: none"></p>
												<a href="javascript:void(0)" id="importUser" class="btn3 tc">导入用户名</a>
											</div>
											<div class="clear"></div>
										</li>
										<div id="drsm" style="padding-left: 169px;">支持导入csv、txt格式数据</div>
										<li>
											<div class="til">
												推送类型：
											</div>
											<div class="info">
												<select id="jtype" name="jtype" onchange="sjpushchan();">
														<option value="1">内部内容</option>
														<option value="2">内部模块</option>
														<option value="3">外部推送</option>
												</select>
												
											</div>
											<div class="clear"></div>
										</li>
										
										<li id="urlli" style="display: none">
											<div class="til">
												<span class="red">*</span>推送路径：
											</div>
											<div class="info">
												<input type="text" value="" id="url" name="url" maxlength="50" class="text yhgl_ser yw_w5 required"/>
											    <p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										
										<li id="insilli" style="display: none">
											<div class="til">
												<span class="red">*</span>内部模块：
											</div>
											<div class="info">
												主界面:<input type="radio" value="1"  name="insiModel"/>&nbsp;&nbsp;
												用户中心:<input type="radio" value="2"  name="insiModel"/>&nbsp;&nbsp;
												体验标:<input type="radio" value="3"  name="insiModel"/>&nbsp;&nbsp;
												普通标:<input type="radio" value="4"  name="insiModel"/>&nbsp;&nbsp;
												善行宝:<input type="radio" value="5"  name="insiModel"/>&nbsp;&nbsp;
												<p id="errorinContent" style="display: none">&nbsp;</p>
											</div>
											<div class="clear"></div>
										</li>
										
										
										
									    <li>
											<div class="til">
												<span class="red">*</span>推送标题：
											</div>
											<div class="info">
												<input type="text" value="" name="title" maxlength="30" class="text yhgl_ser yw_w5 required"/>
											    <p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										
										<li>
										    <div class="til">
												附加字段：
											</div>
											<div class="info">
												键:<input type="text" value="" name="jkey" maxlength="20" class="yhgl_input"/>
						&nbsp;&nbsp;&nbsp;&nbsp;值:<input type="text" value="" name="jvalue" maxlength="50" class="text yhgl_ser yw_w5 "/>
					    &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="添加" onclick="addjkeyvalu();"/>
					                &nbsp;&nbsp;<input type="button" value="删除" onclick="deljkeyvalu();"/>
											</div>
											<div class="clear"></div>
										     
										</li>
										<li>
											<ul id="extaddjpu">
											</ul>
										</li>
										
										<li>
											<div class="til">
												<span class="red">*</span>推送内容：
											</div>
											<div class="info orange">
												<textarea name="content" id="content" cols="80" rows="9"
													></textarea>
												<p id="errorContent">&nbsp;</p>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
										<input type="submit" class="btn4 mr30 sumbitForme" fromname="form1" value="确认" /><input type="button" onclick="location.href='<%=controller.getURI(request, JpushList.class) %>'" class="btn4" value="返回" />
									</div>
									<div class="clear"></div>
								</form>
							</div>
						</div>
						<div class="box2 clearfix"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	
		<div id="import" style="display: none">
			<div class="popup_bg"></div>
			<div class="w440 thickbox thickpos" style="margin: -80px 0 0 -220px;"
				id="showDiv">
				<div class="info clearfix">
					<form id="imform" action="<%=controller.getURI(request, ImportJpush.class)%>"
						method="post" enctype="multipart/form-data">
						<div class="clearfix">
							导入用户名:<input type="file" id="file1" name="file" value="导入用户名" />
						</div>
						<div class="dialog_btn">
							<input type="button" onclick="subimport();" value="提交" class="btn3 mr10" /> <input
								type="button" name="button2" onclick="$('#import').hide()"
								value="取消" class="btn5" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	//添加行
	function addjkeyvalu(){
		var html = "";
		html +='<li><div class="til">&nbsp;</div><div class="info">';
		html +='键:<input type="text" value="" name="jkey" maxlength="20" class="yhgl_input"/>';
		html +='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;值:<input type="text" value="" name="jvalue" maxlength="50" class="text yhgl_ser yw_w5 "/>';
		html +='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="添加" onclick="addjkeyvalu();"/>';
		html +='&nbsp;&nbsp;&nbsp;<input type="button" value="删除" onclick="deljkeyvalu(this);"/>';
		html +='</div><div class="clear"></div></li>';	
		 $("#extaddjpu").append(html);
		// console.info(html);
	}
	
  //删除行
   function deljkeyvalu(delua){
	    $(delua).parent().parent().remove();
		
	}
	
	  
		
    </script>
		
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
		<script type="text/javascript">
		$("#importUser").click(function() {
			$("#import").show();
		});
		$("#close").click(function() {
			$("#import").hide();
		});
		/**var editor1;
		KindEditor.ready(function(K) {
			    editor1 = K.create('textarea[name="content"]', {
			    resizeType : 1,
				allowPreviewEmoticons : false,
				allowImageUpload : false,
				filterMode: true,//是否开启过滤模式
				items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'emoticons', 'link'],
				afterBlur:function(){
					this.sync();
					if(this.count('text')=='')
					{
						$("#errorContent").addClass("red");
						$("#errorContent").html("站内信内容不能为空");	
					}
					else if(this.count('text')>250)
					{
						$("#errorContent").addClass("red");
						$("#errorContent").html("站内信内容不能超过250个字");
					}
					else
					{
						$("#errorContent").removeClass("red");
						$("#errorContent").html("&nbsp;");
					}
				}
			});
			prettyPrint();
		});**/
		function onSubmit()
		{
			
			if($('input:radio[name="insiModel"]:checked').val()==null && $("#insilli").is(":visible")==true ){
				$("#errorinContent").show();
				$("#errorinContent").addClass("red");
				$("#errorinContent").html("内部模块不能为空!");
				return false;
			}
			if($("#content").val()=='')
			{
				$("#errorContent").addClass("red");
				$("#errorContent").html("推送内容不能为空");
				return false;
			}
			else if($("#content").val().length>200)
			{
				$("#errorContent").addClass("red");
				$("#errorContent").html("推送内容不能超过200个字");
				return false;	
			}
			else
			{
				$("#errorContent").removeClass("red");
				$("#errorContent").html("&nbsp;");
				return true;
			}
		}
		//指定发送人和全部的chang事件 
		function showLetter(type)
		{
			if(type=='<%=SendType.ZDR%>')
			{
				$("#letterLi").show();
				$("#username").attr("value","")
				$("#drsm").show();
			}else if(type=='<%=SendType.SY%>') {
				$("#letterLi").hide();
				$("#username").attr("value", "all")
				$("#drsm").hide();
			}
		}
		
		//推送类型
		function sjpushchan(){
			if($("#jtype").val()==3){
				$("#urlli").show();
				$("#insilli").hide();	
			}else if($("#jtype").val()==2){
				$("#insilli").show();
				$("#urlli").hide();
			}else{
				$("#urlli").hide();
				$("#insilli").hide();	
			}
			
		}
		
	   //判断上传文件类型
	   function subimport(){
		   if($("#file1").val().indexOf('.csv')>=0 || $("#file1").val().indexOf('.txt')>=0){
			   $("#imform").submit(); 
		   }else{
			   alert('上传的文件类型不正确');
			   return false;
	        }   
	   }
		</script>
</body>
</html>