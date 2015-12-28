<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.entities.T6214"%>
<%@page import="com.dimeng.p2p.S62.entities.T6213"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddDyw"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddDywsx"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.info.aqbz.bxdb.UpdateBxdb"%>
<%@page import="com.dimeng.p2p.variables.FileType"%>
<%@page import="com.dimeng.p2p.console.servlets.upload.Upload"%> 
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
			CURRENT_CATEGORY = "YWGL";
			CURRENT_SUB_CATEGORY = "BDGL";
			T6213[] t6213s = ObjectHelper.convertArray(request.getAttribute("t6213s"), T6213.class);
			T6214[] t6214s = ObjectHelper.convertArray(request.getAttribute("t6214s"), T6214.class);
			String typeName=ObjectHelper.convert(request.getAttribute("typeName"), String.class);
			int loanId=IntegerParser.parse(request.getParameter("loanId"));
			int userId = IntegerParser.parse(request.getParameter("userId"));
			int typeId=IntegerParser.parse(request.getParameter("typeId")); 
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>添加抵押物</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, AddDywsx.class)%>" method="post" class="form1">
									<input type="hidden" name="loanId" value="<%=loanId%>"/>
									<input type="hidden" name="userId" value="<%=userId%>"/>
									<input type="hidden" name="F04" value="<%=typeName%>"/>
									<input type="hidden" name="typeId" value="<%=typeId%>"/>
									<ul class="cell xc_jcxx ">
										<li>
											<div class="til">
												<span class="red">*</span>抵押物类型：
											</div>
													<div class="info">
											<select class="text yhgl_ser" name="F03" id="dywsx" onchange="changeDyw()">
														<option value="0">全部</option>
														<%
														  int type = IntegerParser.parse(request.getParameter("F03")); 
														%>
															<%
															if(t6213s!=null){
																for(T6213 t6213:t6213s)
																{
																	if(t6213==null)
																	{
																		continue;
																	}
															%>
															<option value="<%=t6213.F01 %>" <%if(type==t6213.F01||t6213.F01==typeId){ %>selected="selected"<%} %>><%StringHelper.filterHTML(out, t6213.F02); %></option>
												       <%}}%>
											</select>
											</div>
										</li>
										<%
											if(t6214s!=null)
											{
												int i=0;
												for(T6214 t6214:t6214s)
												{
													if(t6214==null){continue;}
										%>
										<li>
											<br/>
											<div class="til">
												<%
													StringHelper.filterHTML(out, t6214.F03);
												%>：
											</div>
											<div class="info orange">
												<input type="hidden" name="t6235s[<%=i %>].F03" value="<%=t6214.F01%>"/>
												 <textarea id="t6235s<%=i %>" name="t6235s[<%=i %>].F04" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"><%StringHelper.format(out,request.getParameter("t6235s["+i+"].F04"), fileStore); %></textarea>
                       		                     <p id="errorContent">&nbsp;</p>
											</div>
											<div class="clear"></div>
										</li>
										<%i++;}} %>
									</ul>
									<div class="tc w220 pt20">
										<%
											if (dimengSession.isAccessableResource(AddDywsx.class)) {
										%>
										<input type="submit" class="btn4 mr30 sumbitForme" fromname="form1" value="确认" />
										<%
											} else {
										%>
										<input type="button" class="disabled" value="确认" />
										<%
											}
										%>
										<input type="button" onclick="location.href='<%=controller.getURI(request, AddDyw.class) %>?loanId=<%=loanId %>&userId=<%=userId %>'" class="btn4" value="返回" />
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
	<%@include file="/WEB-INF/include/kindeditor.jsp" %>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
		<script type="text/javascript">
		var editor1;
		KindEditor.ready(function(K) {
			<%
			if(t6214s!=null)
			{
				int i=0;
				for(T6214 t6214:t6214s)
				{
					if(t6214==null){continue;}
		%>
			editor1 = K.create('textarea[id="t6235s<%=i%>"]', {
				uploadJson : '<%=controller.getURI(request, Upload.class)%>?type=<%=FileType.ARTICLE_ATTACHMENT.ordinal()%>',
				allowFileManager : false,
				formatUploadUrl: false,
				afterBlur:function(){
					this.sync();
					if(this.count('text')=='')
					{
						$("#errorContent").addClass("red");
						$("#errorContent").html("借款描述内容不能为空");	
					}
					else
					{
						$("#errorContent").removeClass("red");
						$("#errorContent").html("&nbsp;");
					}
				}
			});
			<%i++;}} %>
			
			prettyPrint();
		});
			function changeDyw()
			{
				var typeId=$("#dywsx").val();
				location.href="<%=controller.getURI(request, AddDywsx.class)%>?loanId=<%=loanId%>&userId=<%=userId%>&typeId="+typeId;
			}
		</script>
</body>
</html>