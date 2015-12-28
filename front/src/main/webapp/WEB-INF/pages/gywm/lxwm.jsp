<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="oscache" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>联系我们 关于我们</title>
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
				CURRENT_SUB_CATEGORY = "LXWM";
			%>
<oscache:cache key="sl-p2p-front-lxwm" time="1" scope="application">
<%@include file="/WEB-INF/include/gywm/left.jsp"%>
	<div class="contain clearfix">
		<div class="about">
			<div class="container">
				<div class="public_tit"><%=ArticleType.LXWM.getName()%></div>
				<div class="info_cont">
					<!--<%
						ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
						T5011 article = articleManage.get(T5011_F02.LXWM);
						if (article != null) {
							articleManage.view(article.F01);
							StringHelper.format(out,articleManage.getContent(article.F01),fileStore);
						}
					%>-->
                    <div class="sx_map"><%@include file="/WEB-INF/include/gywm/map.jsp"%></div><br />
                    <p>
	<strong><span style="color:#024783;">深圳市前海善林资产管理有限公司（总部）</span></strong><br />
电话：（86-755）33188585<br />
传真：（86-755）33188556<br />
地址：深圳市罗湖区深南东路5016号京基100大厦41楼<br />
全国理财专线：4000166277
</p>
<p>
	<strong><span style="color:#024783;"></span></strong>&nbsp;
</p>
<p>
	<strong><span style="color:#024783;">深圳市前海善林资产管理有限公司 财富管理中心</span></strong><br />
电话：（86-755）82998809<br />
传真：（86-755）82998890<br />
地址：深圳市罗湖区深南东路5016号京基100大厦41楼
</p>
<p>&nbsp;</p>
<p>
	<span style="color:#024783;"><strong>客服服务</strong></span><br />
如果您在使用善行创投的过程中有任何疑问请您与客服人员联系。<br />
客服热线：&nbsp;4000-166-277<br />
工作时间：&nbsp;9:00-21:00
</p>
<p>&nbsp;</p>
<p>
	<span style="color:#024783;"><strong>商务合作</strong></span><br />
如果贵公司希望与我们建立商务合作关系，形成优势互补，请将合作意向进行简要描述并发送邮件至以下邮箱，我们会尽快与您联系。<br />
邮箱地址：<a href="mailto:service@myshanxing.com" class="blueLink">service@myshanxing.com</a>
</p>
<p>&nbsp;</p>
<p>
	<span style="color:#024783;"><strong>媒体咨询</strong></span><br />
如果你希望与我们进行媒体合作，或有采访需求，请发送邮件至以下邮箱，我们会尽快与您联系。<br />
邮箱地址：<a href="mailto:cooperation@myshanxing.com" class="blueLink">cooperation@myshanxing.com</a>
</p>
<p>&nbsp;</p>
<p>
	<span style="color:#024783;"><strong>关注我们</strong></span><br />
欢迎您关注我们的新浪微博、微信公众平台，获取关于善行创投的最新信息与资讯。<br />
新浪微博：<a href="http://weibo.com/myshanxing" class="blueLink" target="_blank">weibo.com/myshanxing</a><br />
微信公众号：<span class="blue_ls">myshanxing(扫描下方二维码关注善行创投)</span><br />
<img src="/images/wechat_shanxing.png" alt="" width="150" height="150" style="margin-left:0px;"/>
</p>
<p>

                    
				</div>
			</div>
		</div>
	</div>
    
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</oscache:cache>
</body>
</html>