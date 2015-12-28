<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.BidDywsx"%>
<%@page import="com.dimeng.p2p.S62.entities.T6234"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.UpdateDywsx"%>
<%@page import="com.dimeng.p2p.S62.entities.T6214"%>
<%@page import="com.dimeng.p2p.S62.entities.T6213"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddDyw"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddDywsx"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
			CURRENT_CATEGORY = "YWGL";
			CURRENT_SUB_CATEGORY = "XXZQGL";
			T6234 t6234 = ObjectHelper.convert(request.getAttribute("t6234"), T6234.class);
			BidDywsx[] t6235s =ObjectHelper.convertArray(request.getAttribute("t6235s"), BidDywsx.class);
			int loanId=IntegerParser.parse(request.getParameter("loanId"));
			int userId = IntegerParser.parse(request.getParameter("userId"));
			int id = IntegerParser.parse(request.getParameter("id"));
			if(t6234==null)
			{
				t6234=new T6234();
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
								<h3>修改抵押物</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, UpdateDywsx.class)%>" method="post" class="form1">
									<input type="hidden" name="loanId" value="<%=loanId%>"/>
									<input type="hidden" name="userId" value="<%=userId%>"/>
									<input type="hidden" name="id" value="<%=id%>"/>
									<ul class="cell xc_jcxx ">
										<li>
											<div class="til">
												<span class="red">*</span>抵押物类型：
											</div>
											<div class="info">
											<%StringHelper.filterHTML(out, t6234.F04); %>
											</div>
										</li>
										<%
											if(t6235s!=null)
											{
												int i=0;
												for(BidDywsx t6235:t6235s)
												{
													if(t6235==null){continue;}
										%>
										<li>
											<br/>
											<div class="til">
												<%
													StringHelper.filterHTML(out, t6235.name);
												%>：
											</div>
											<div class="info">
												<input type="hidden" name="t6235s[<%=i %>].F02" value="<%=id%>"/>
												<input type="hidden" name="t6235s[<%=i %>].F03" value="<%=t6235.F03%>"/>
												<textarea cols="40" rows="2" name="t6235s[<%=i %>].F04"><%StringHelper.format(out,t6235.F04, fileStore); %></textarea>
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
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
		<script type="text/javascript">
			function changeDyw()
			{
				var typeId=$("#dywsx").val();
				location.href="<%=controller.getURI(request, AddDywsx.class)%>?loanId=<%=loanId%>&userId=<%=userId%>&typeId="+typeId;
			}
		</script>
</body>
</html>