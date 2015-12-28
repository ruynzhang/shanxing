<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.entities.T6237"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddGuarantee"%>
<%@page import="com.dimeng.p2p.S62.entities.T6236"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddDyw"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddEnterpriseXq"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddUserInfoXq"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Jg"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Dbxx"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.UpdateProject"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddGuaranteeXq"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddAnnexWz"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddAnnexMsk"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.p2p.S70.entities.T7029"%>
<%@page import="com.dimeng.p2p.S60.entities.T6215"%>
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
		int loanId = IntegerParser
				.parse(request.getParameter("loanId"));
		int userId = IntegerParser
				.parse(request.getParameter("userId"));
		int jgId=IntegerParser
				.parse(request.getParameter("jgId"));
		String des=ObjectHelper.convert(request.getAttribute("des"), String.class);
		Jg[] jgs=ObjectHelper.convertArray(request.getAttribute("jgs"), Jg.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>添加担保信息</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, AddGuarantee.class)%>" method="post" onsubmit="return submitForm()">
									<input type="hidden" name="loanId" value="<%=loanId%>"/>
									<input type="hidden" name="userId" value="<%=userId%>"/>
									<input type="hidden" name="jgId" value="<%=jgId%>"/>
									<div class="border p30 Men_bt no_table">
									<div class="f16">风险控制</div>
									<div class="hsxt"></div>
									<div class="mb20">
										<div class="yw_jcxx">
											<ul class="cell noborder">
												<li>
													<div class="til">
														<span class="red">*</span>担保公司：
													</div>
													<div class="info">
														<select name="F03" class="text yhgl_ser" id="dbgs" onchange="changeDbgs()">
															<option value="">全部</option>
															<%
																int id=IntegerParser.parse(request.getAttribute("F03"));
															%>
															<%
																if(jgs!=null)
																{
																	for(Jg jg:jgs)
																	{
																		if(jg==null)
																		{
																			continue;
																		}
															%>
															<option value="<%=jg.id%>" <%if(jg.id==jgId||jg.id==id){ %> selected="selected" <%} %>><%StringHelper.filterHTML(out, jg.name); %></option>
															<%} }%>
														</select>
														<p id="errortip"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">担保资质描述：</div>
													<div class="info">
														<%StringHelper.filterHTML(out, des); %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">担保情况：</div>
													<div class="info">
														<textarea name="F05" id="textarea3" cols="45" rows="5" class="border w650 mb10"><%StringHelper.format(out,request.getParameter("F05"), fileStore); %></textarea>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">反担保情况：</div>
													<div class="info">
														<textarea name="fdbqk" id="textarea3" cols="45" rows="5" class="border w650 mb10"><%StringHelper.format(out,request.getParameter("fdbqk"), fileStore); %></textarea>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">风险控制综述：</div>
													<div class="info">
														<textarea name="fxkzzs" id="textarea4" cols="45" rows="5" class="border w650 mb10"><%StringHelper.format(out, request.getParameter("fxkzzs"), fileStore); %></textarea>
													</div>
													<div class="clear"></div>
												</li>
											</ul>
										</div>
										<div class="tc w350 pt20">
											<input type="submit" class="btn4 mr30" value="保存"/>
											<a href="<%=controller.getURI(request, AddGuaranteeXq.class) %>?loanId=<%=loanId %>&userId=<%=userId %>" class="btn5 tc">返回</a>
										</div>
									</div>
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
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
			function changeDbgs()
			{
				var jgId=$("#dbgs").val();
				location.href="<%=controller.getURI(request, AddGuarantee.class)%>?loanId=<%=loanId%>&userId=<%=userId%>&jgId="+jgId;
			}
			function submitForm()
			{
				var typeId=$("#dbgs").val();
				if(typeId=='')
				{
					$("#errortip").text("请选择担保公司");
					$("#errortip").addClass("red");
					return false;	
				}
				return true;
			}
		</script>
</body>
</html>