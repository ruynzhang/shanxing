<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewDyw"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.BidDywsx"%>
<%@page import="com.dimeng.p2p.S62.entities.T6235"%>
<%@page import="com.dimeng.p2p.S62.entities.T6234"%>
<%@page import="com.dimeng.p2p.S62.entities.T6214"%>
<%@page import="com.dimeng.p2p.S62.entities.T6213"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
			CURRENT_CATEGORY = "CWGL";
			CURRENT_SUB_CATEGORY = "FKGL";
			T6234 t6234 = ObjectHelper.convert(request.getAttribute("t6234"), T6234.class);
			BidDywsx[] t6235s =ObjectHelper.convertArray(request.getAttribute("t6235s"), BidDywsx.class);
			int loanId=IntegerParser.parse(request.getParameter("loanId"));
			int userId = IntegerParser.parse(request.getParameter("userId"));
			int type=IntegerParser.parse(request.getParameter("type"));
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
								<h3>查看抵押物</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
									<ul class="cell xc_jcxx ">
										<li>
											<div class="til">
												<span class="red">*</span>抵押物类型：
											</div>
											<div class="info"><%StringHelper.filterHTML(out, t6234.F04);%>
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
												<%StringHelper.filterHTML(out, t6235.F04); %>
											</div>
											<div class="clear"></div>
										</li>
										<%i++;}} %>
									</ul>
									<div class="tc w220 pt20">
										<a href="<%=controller.getURI(request, ViewDyw.class) %>?loanId=<%=loanId %>&userId=<%=userId %>" class="btn4">返回</a>
									</div>
									<div class="clear"></div>
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
</body>
</html>