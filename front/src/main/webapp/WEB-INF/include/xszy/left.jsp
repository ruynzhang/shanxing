<%@page import="com.dimeng.p2p.common.enums.ArticleType"%>
<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
<div class="bar fl clearfix">
	<ul class="barlist clearfix">
		<li<%="XSZY".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %> style="display:none;"><a href="<%=controller.getViewURI(request, Index.class)%>"><i></i><%=ArticleType.XSZY.getName()%></a></li>
		<li<%="MCJS".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getURI(request, Help.class)%>"><i></i><%=ArticleType.MCJS.getName()%></a></li>
		<li<%="PTJS".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getURI(request, Help.class)%>?id=2"><i></i><%=ArticleType.PTJS.getName()%></a></li>
		<li<%="LXHFY".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getURI(request, Help.class)%>?id=3"><i></i><%=ArticleType.LXHFY.getName()%></a></li>
		<li<%="WYJK".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getURI(request, Help.class)%>?id=4"><i></i><%=ArticleType.WYJK.getName()%></a></li>
		<li<%="WYLC".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getURI(request, Help.class)%>?id=5"><i></i><%=ArticleType.WYLC.getName()%></a></li>
		<li<%="WDWZH".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getURI(request, Help.class)%>?id=6"><i></i><%=ArticleType.PTZH.getName()%></a></li>
	</ul>
	<div class="clear"></div>
</div>
