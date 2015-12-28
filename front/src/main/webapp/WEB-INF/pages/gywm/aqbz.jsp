<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>安全保障 关于我们</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="contain clearfix">
		<div class="about">
			<%
				CURRENT_CATEGORY = "GYWM";
				CURRENT_SUB_CATEGORY = "AQBZ";
			%>
			<%@include file="/WEB-INF/include/gywm/left.jsp"%>
			<div class="container fr">
				<div class="public_tit"><%=ArticleType.AQBZ.getName()%></div>
				<div class="info_cont">
					<%
						ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
						T5011 article = articleManage.get(T5011_F02.AQBZ);
						if (article != null) {
							articleManage.view(article.F01);
							StringHelper.format(out,articleManage.getContent(article.F01),fileStore);
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>