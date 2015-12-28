<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<%@page import="com.dimeng.framework.http.upload.FileStore"%>
<%
ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
T5011  article = articleManage.get(IntegerParser.parse(request.getParameter("id")),T5011_F02.HLWJRYJ);
if(article==null){
	response.sendError(HttpServletResponse.SC_NOT_FOUND);
	return;
}
articleManage.view(article.F01);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%if(article!=null)StringHelper.filterHTML(out, article.F06); %>互联网金融研究 关于我们</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="contain clearfix">
	<div class="about">
   		<%CURRENT_CATEGORY = "ZXDT";CURRENT_SUB_CATEGORY = "HLWJRYJ";%>
		<%@include file="/WEB-INF/include/gywm/left.jsp"%>
		<div class="container fr">
        <div class="public_detail"><%if(article!=null)StringHelper.filterHTML(out, article.F06); %></div>
        <div class="info_cont detail">
        	<p class="tr"><%if(article!=null){out.print(TimestampParser.format(article.F12));} %></p>
			<p><%if(article!=null)StringHelper.format(out, articleManage.getContent(article.F01),resourceProvider.getResource(FileStore.class)); %></p>
			<br/><br/><br/>
			<p>来源：<%if(article != null)StringHelper.filterHTML(out, article.F07); %></p>
         </div>
       </div>
   </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>
