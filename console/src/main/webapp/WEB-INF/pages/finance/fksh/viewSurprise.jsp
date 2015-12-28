<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.SurpriseLoan"%>
<%@page import="com.dimeng.p2p.service.SurpriseManage"%>
<%@page import="com.dimeng.p2p.S62.entities.SurpriseConfig"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.S62.entities.SurpriseLucre"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="CWGL";
		CURRENT_SUB_CATEGORY="FKGL";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>查看惊喜奖</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
							<a href="<%=controller.getURI(request, FkshList.class)%>"
									class="btn4 tc" style="float: right;margin-bottom: 8px;" >返回</a>
							</div>
							<div class="border p30 Men_bt no_table">
								<div class="mb20">
									<div class="yw_jcxx">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
											<tr class="hsbg">
												<td>序号</td>
												<td>投资人</td>
												<td>投标金额</td>
												<td>惊喜奖类型</td>
												<td>收益百分比</td>
												<td>收益金额</td>
											</tr>
											<%
												List<SurpriseLucre> list=(List<SurpriseLucre>)request.getAttribute("list");
												SurpriseManage manage=serviceSession.getService(SurpriseManage.class);
												if(list!=null)
												{int i=1;
												for(SurpriseLucre vo:list)
												{	
													SurpriseConfig cvo=manage.getSurpriseConfigByid(vo.config.id);
											%>
											<tr>
												<td><%=i++%></td>
												<td><%StringHelper.filterHTML(out, vo.accountName);%></td>
												<td><%=Formater.formatAmount(vo.investAmount)%></td>
												<td><%=cvo.name.getChineseName()%></td>
												<td><%=Formater.formatRate(cvo.rate)%></td>
												<td><%=Formater.formatAmount(vo.lucreAmount)%></td>
											</tr>
											<%}} %>
										</table>
											<a href="javascript:void(0)" onclick="load('<%=controller.getURI(request, SurpriseLoan.class)%>?id=<%=request.getParameter("id")%>')" class="btn4 tc" style="float: right;">发放惊喜奖</a>
									</div>
								</div>
								<div class="clear"></div>
							</div>
							
						</div>
						<div class="clear"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
	function load(url)
	{
		if (!window.confirm("是否确认发放惊喜奖？")) {
			return;
		}
		location.href=url;
	}
	</script>
</body>
</html>