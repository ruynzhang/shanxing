<%@page import="com.dimeng.p2p.S71.enums.T7166_F03"%>
<%@page import="com.dimeng.p2p.S71.entities.T7166"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "XTGL";
		CURRENT_SUB_CATEGORY = "KHGH";
		T7166 t7166 = ObjectHelper.convert(request.getAttribute("entity"), T7166.class);
		
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>查看客户关怀</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
									<ul class="cell yw_jcxx ">
										<li>
											<div class="til">
												<span class="red"></span>关怀类型：
											</div>
											<div class="info">
												<%=t7166.F03.getChineseName() %>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red"></span>关怀形式：
											</div>
											<div class="info">
												<%=t7166.F04.getChineseName() %>
											</div>
											<div class="clear"></div>
										</li>
										<%if(T7166_F03.SR != t7166.F03){ %>
										<li>
												<div class="til">
													<span class="red"></span>关怀发送时间：
												</div>
												<div class="info">
													<%=SQLDateParser.format(t7166.F09) %>
												</div>
												<div class="clear"></div>
										</li>
											<%} %>
										<li>
											<div class="til">
												<span class="red"></span>状态：
											</div>
											<div class="info">
												<%=t7166.F07.getChineseName() %>
											</div>
											<div class="clear"></div>
										</li>		
										<li>
											<div class="til">
												<span class="red"></span>关怀标题：
											</div>
											<div class="info">
												<%StringHelper.filterHTML(out, t7166.F05); %>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red"></span>关怀内容：
											</div>
											<div class="info">
												<%StringHelper.filterHTML(out, t7166.F06); %>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
										<a href="<%=controller.getURI(request, Search.class)%>" class="btn4 tc" style="float: right;">返回</a>
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
	<%@include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>