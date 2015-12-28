<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S61.entities.T6161"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.ccxx.ViewListCcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.fcxx.ViewListFcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.lxxx.ViewLxxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.cwzk.ViewCwzk"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.jscl.ViewJscl"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.QyList"%>
<%@page import="com.dimeng.p2p.console.servlets.Region"%>
<%@page import="com.dimeng.p2p.S61.entities.T6164"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "YHGL";
		CURRENT_SUB_CATEGORY = "QY";
		T6161 entity = ObjectHelper.convert(
					request.getAttribute("info"), T6161.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>企业信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
								<div class="Menubox">
									<ul>
										<li  class="hover">企业信息</li>
										<li><a href="<%=controller.getURI(request, ViewJscl.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">介绍资料</a></li>
										<li><a href="<%=controller.getURI(request, ViewCwzk.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">财务状况</a></li>
										<li><a href="<%=controller.getURI(request, ViewLxxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">联系信息</a></li>
										<li><a href="<%=controller.getURI(request, ViewListCcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">车产信息</a></li>
										<li><a href="<%=controller.getURI(request, ViewListFcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">房产信息</a></li>
									</ul>
								</div>
							</div>
							<div class="border p30 Men_bt no_table">
								<form action="<%=controller.getURI(request, ViewLxxx.class)%>"
									method="post" class="form1">
									<input type="hidden" id="id" name="id" value="<%=request.getParameter("id")%>">
									<ul class="cell noborder">
					<li>
                        <div class="til"><span class="red">*</span> 企业名称：</div>
                        <div class="info"><%StringHelper.filterHTML(out, entity.F04); %></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 营业执照登记注册号：</div>
                        <div class="info"><%StringHelper.filterHTML(out, entity.F03); %></div>
                        <div class="clear"></div>
                    </li>
                        <li>
                        <div class="til"><span class="red">*</span>企业纳税号：</div>
                        <div class="info"><%StringHelper.filterHTML(out,  entity.F05);%></div>
                        <div class="clear"></div>
                    </li>
                       <li>
                        <div class="til"><span class="red">*</span>组织机构代码：</div>
                        <div class="info"><%StringHelper.filterHTML(out, entity.F06);%></div>
                        <div class="clear"></div>
                    </li>
                           <li>
                        <div class="til"><span class="red">*</span>注册年份：</div>
                        <div class="info"><%=entity.F07%>年
                        </div>
                        <div class="clear"></div>
                    </li>
                    
                             <li>
                        <div class="til"><span class="red">*</span>注册资金：</div>
                        <div class="info"><%=entity.F08%>万元</div>
                        <div class="clear"></div>
                    </li>
                             <li>
                        <div class="til"><span class="red">*</span>行业：</div>
                        <div class="info"><%StringHelper.filterHTML(out,  entity.F09);%></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>企业规模：</div>
                        <div class="info"><%=entity.F10%>人</div>
                        <div class="clear"></div>
                    </li>
                    
                         <li>
                        <div class="til"><span class="red">*</span>法人：</div>
                        <div class="info"><%StringHelper.filterHTML(out, entity.F11);%></div>
                        <div class="clear"></div>
                    </li>
                       <li>
                        <div class="til"><span class="red">*</span>法人身份证号：</div>
                        <div class="info"><%StringHelper.filterHTML(out,StringHelper.decode(entity.F13));%></div>
                        <div class="clear"></div>
                    </li>
                      <li>
                        <div class="til"><span class="red">*</span>资产净值：</div>
                        <div class="info"><%=entity.F14%>万元</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>上年度经营现金流入：</div>
                        <div class="info"><%=entity.F15%>万元</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>贷款卡证书编号：</div>
                        <div class="info"><%StringHelper.filterHTML(out,  entity.F16);%></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>企业信用证书编号：</div>
                        <div class="info"><%StringHelper.filterHTML(out,  entity.F17);%></div>
                        <div class="clear"></div>
                    </li>
					</ul>
									<div class="tc w220">
										 <input type="button" class="btn4" style="cursor: pointer;"
											onclick="window.location.href='<%=controller.getURI(request, QyList.class)%>'"
											value="返回" />
									</div>
									<div class="clear"></div>
								</form>
							</div>
							<div class="mb15"></div>
							<div class="box2 clearfix"></div>
						</div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>