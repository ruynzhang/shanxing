<%@page import="com.dimeng.p2p.front.servlets.gywm.*"%>
<%@page import="com.dimeng.p2p.front.servlets.zxdt.*"%>
<%@page import="com.dimeng.p2p.common.enums.ArticleType"%>
<%--
<div class="sidebar fl " style="display:none;">
	<span class="tit_info clearfix"><i class="a_ui a_ui_tit"></i>关于我们</span>
	<ul class="barlist">
		<li<%="GSJJ".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getViewURI(request, Gsjj.class)%>"><i></i><%=ArticleType.GSJJ.getName() %></a></li>
		<li<%="GLTD".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getViewURI(request, Gltd.class)%>"><i></i><%=ArticleType.GLTD.getName() %></a></li>
		<li<%="ZJGW".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getViewURI(request, Zjgw.class)%>"><i></i><%=ArticleType.ZJGW.getName() %></a></li>
		<li<%="HZJG".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getViewURI(request, Hzjg.class)%>"><i></i><%=ArticleType.HZJG.getName() %></a></li>
		<li<%="ZXNS".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getViewURI(request, Zxns.class)%>"><i></i><%=ArticleType.ZXNS.getName() %></a></li>
		<li<%="LXWM".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getViewURI(request, Lxwm.class)%>"><i></i><%=ArticleType.LXWM.getName() %></a></li>
		<li<%="AQBZ".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getViewURI(request, Aqbz.class)%>"><i></i><%=ArticleType.AQBZ.getName() %></a></li>
		<li class="a_tit"><span><i class="a_ui a_ui_icon"></i>最新动态</span></li>
		<li<%="MTBD".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getViewURI(request, Mtbd.class)%>"><i></i><%=ArticleType.MTBD.getName() %></a></li>
		<li<%="SHZR".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getViewURI(request, Shzr.class)%>"><i></i><%=ArticleType.SHZR.getName() %></a></li>
		<li<%="HLWJRYJ".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getViewURI(request, Hlwjryj.class)%>"><i></i><%=ArticleType.HLWJRYJ.getName() %></a></li>
		<li<%="WDHYZX".equals(CURRENT_SUB_CATEGORY)?" class=\"on\"":"" %>><a href="<%=controller.getViewURI(request, Wdhyzx.class)%>"><i></i><%=ArticleType.WDHYZX.getName() %></a></li>
		<li<%="YJBG".equals(CURRENT_SUB_CATEGORY)?" class=\"s_tit on\"":" class=\"s_tit\"" %>><a href="<%=controller.getViewURI(request, Yjbg.class)%>"><i></i>业绩报告</a></li>
		<li<%="WZGG".equals(CURRENT_SUB_CATEGORY)?" class=\"b_tit on\"":" class=\"b_tit\"" %>><a href="<%=controller.getViewURI(request, Wzgg.class)%>"><i></i>网站公告</a></li>
	</ul>
</div>
 --%>
<div class="sx_about_container">
   <div class="sx_about_menubox">
         <a href="<%=controller.getViewURI(request, Gsjj.class)%>" <%="GSJJ".equals(CURRENT_SUB_CATEGORY)?" class=\"chose\"":"" %>><span></span>公司简介</a>
         <a href="<%=controller.getViewURI(request, Gltd.class)%>" <%="GLTD".equals(CURRENT_SUB_CATEGORY)?" class=\"chose\"":"" %>><span></span>股东背景</a>
         <a href="<%=controller.getViewURI(request, Hzjg.class)%>" <%="HZJG".equals(CURRENT_SUB_CATEGORY)?" class=\"chose\"":"" %>><span></span>合作伙伴</a>
         <a href="<%=controller.getViewURI(request, Mtbd.class)%>" <%="MTBD".equals(CURRENT_SUB_CATEGORY)?" class=\"chose\"":"" %>><span></span>媒体报道</a>
         <a href="<%=controller.getViewURI(request, Zxns.class)%>" <%="ZXNS".equals(CURRENT_SUB_CATEGORY)?" class=\"chose\"":"" %>><span></span>招贤纳士</a>
         <a href="<%=controller.getViewURI(request, Lxwm.class)%>" <%="LXWM".equals(CURRENT_SUB_CATEGORY)?" class=\"chose\"":"" %>><span></span>联系我们</a>
         <a href="<%=controller.getViewURI(request, Wdhyzx.class)%>" <%="WDHYZX".equals(CURRENT_SUB_CATEGORY)?" class=\"chose\"":"" %>><span></span>行业资讯</a>
         <a href="<%=controller.getViewURI(request, Wzgg.class)%>" <%="WZGG".equals(CURRENT_SUB_CATEGORY)?" class=\"chose\"":"" %>><span></span>平台公告</a>
         <a href="http://www.szslzc.com/" target="_blank"><span></span>公司官网</a>
   </div>
</div>