<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="oscache" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>招贤纳士 关于我们</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
                    <!--banner-->
<div class="zq_banner">
<div class="banner"></div>
</div>
<!--banner-->
<%
				CURRENT_CATEGORY = "GYWM";
				CURRENT_SUB_CATEGORY = "ZXNS";
			%>
<oscache:cache key="sl-p2p-front-zxns" time="1" scope="application">
<%@include file="/WEB-INF/include/gywm/left.jsp"%>
	<div class="contain clearfix">
		<div class="about">
			<div class="container">
				<div class="public_tit"><%=ArticleType.ZXNS.getName()%></div>
				<div class="info_cont">
					<%
						ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
						T5011 article = articleManage.get(T5011_F02.ZXNS);
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
</oscache:cache>
</body>
</html>