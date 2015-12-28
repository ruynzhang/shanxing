<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<%@page import="java.util.List"%>
<%
ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
T5011  article = articleManage.get(IntegerParser.parse(request.getParameter("id")),T5011_F02.MTBD);
if(article==null){
	response.sendError(HttpServletResponse.SC_NOT_FOUND);
	return;
}
articleManage.view(article.F01);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%if(article!=null)StringHelper.filterHTML(out, article.html_title); %></title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=resourceProvider.getCharset() %>" />
<meta name="keywords" content="<%if(article!=null)StringHelper.filterHTML(out, article.html_keywords); %>"/>
<meta name="description" content="<%if(article!=null)StringHelper.filterHTML(out, article.html_description); %>"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp"%>
                <!--banner-->
<div class="zq_banner">
<div class="banner"></div>
</div>
<%CURRENT_CATEGORY = "ZXDT";CURRENT_SUB_CATEGORY = "MTBD";%>
		<%@include file="/WEB-INF/include/gywm/left.jsp"%>
<div class="contain clearfix">
	<div class="about">
		<div class="container">
        <div class="public_detail" style="text-align:center;">
        <span style="float:left; font-size:16px;"><a class="blueLink" href="/zxdt/mtbd/<%=request.getParameter("currentPage") == null? 1 : request.getParameter("currentPage")%>">返回列表</a></span>
        <%if(article!=null)StringHelper.filterHTML(out, article.F06); %><span class="tr fr f14"><%if(article!=null){out.print(DateParser.format(article.F12));} %></span></div>
        <div class="bdsharebuttonbox" style="text-align:right; padding:10px 0px;"><a href="#" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone"></a><a href="#" class="bds_tsina" data-cmd="tsina"></a><a href="#" class="bds_tqq" data-cmd="tqq"></a><a href="#" class="bds_renren" data-cmd="renren"></a><a href="#" class="bds_weixin" data-cmd="weixin"></a></div>
        <div class="info_cont detail">
			<p><%if(article!=null)StringHelper.format(out, articleManage.getContent(article.F01),fileStore); %></p>
			<br/><br/><br/>
			<p>来源：<%if(article != null)StringHelper.filterHTML(out, article.F07); %></p>
			<%
			  // 上一篇和下一篇
			   T5011  befor5011 = articleManage.selectBeforT5011(T5011_F02.MTBD.name(),article.F04,article.F11);
			   T5011  next5011 =articleManage.selectAfterT5011(T5011_F02.MTBD.name(),article.F04,article.F11);	
		    %>
			<p align="center">
			<%if(befor5011!=null){ %>
			上一篇:&nbsp;<a class="blueLink" href="<%=controller.getPagingItemURI(request, Mtbd.class,befor5011.F01)%>"><%=befor5011.F06 %></a><%} %>&nbsp;
		   <%if(next5011!=null){ %>
		            下一篇:&nbsp;<a class="blueLink" href="<%=controller.getPagingItemURI(request, Mtbd.class,next5011.F01)%>"><%=next5011.F06 %></a><%} %></p>
         </div>
       </div>
   </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdPic":"","bdStyle":"0","bdSize":"16"},"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
</body>
</html>
