<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="oscache" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>公司简介-关于我们-善行创投</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/js/highslide.css" />
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/highslide-with-gallery.js"></script>
<script type="text/javascript">
	hs.graphicsDir = '<%=controller.getStaticPath(request)%>/js/graphics/';
	hs.align = 'center';
	hs.transitions = ['expand', 'crossfade'];
	hs.wrapperClassName = 'dark borderless floating-caption';
	hs.fadeInOut = true;
	hs.dimmingOpacity = .75;

	// Add the controlbar
	if (hs.addSlideshow) hs.addSlideshow({
		//slideshowGroup: 'group1',
		interval: 5000,
		repeat: false,
		useControls: true,
		fixedControls: 'fit',
		overlayOptions: {
			opacity: .6,
			position: 'bottom center',
			hideOnMouseOut: true
		}
	});
</script>
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
				CURRENT_SUB_CATEGORY = "GSJJ";
			%>
<oscache:cache key="sl-p2p-front-gsjj" time="1" scope="application">
<%@include file="/WEB-INF/include/gywm/left.jsp"%>
<div class="sx_about_ctbox">
    <ul class="sx_a_icolist">
      <li><span class="sx_a_icon sx_a1"></span><p>成立于</p><h1>2014年</h1></li>
      <li class="middle"><span class="sx_a_icon sx_a2"></span><p>善林人</p><h1>200名</h1></li>
      <li class="end"><span class="sx_a_icon sx_a3"></span><p>总部位于</p><h1>深圳</h1></li>
    </ul>
    <div class="clear"></div>
    <div class="sx_about_text1">
      <p style="padding-top:250px">
         <span class="orange f18"><a href="http://www.myshanxing.com">善行创投</a></span> （ www.myshanxing.com ) 是由深圳市<br />前海善林资产管理有限公司倾力打造的互联网投资理财平台，注<br />
         册资金3亿元人民币。平台致力于为国内外投资人与融资方提供高效、安全<br />的综合金融信息服务，由专业的理财顾问为客户私人定制最佳资本解决方案。<br /><br />
   公司总部位于深圳市地标性金融中心——京基100大厦，并在此设立了大型的平台管理中心。 善行创投管理团队集合银行、担保、<br />信息服务、电子商务、第三方支付等领域知名企业高级管理人才和专业信息技术人员，配合完善的产品体系、成熟的业务流程，全力打造了这个高效<br />便捷、安全稳定、诚信可靠的互联网投资理财平台，为个人和中小企业提供了丰富多元的网络投资理财渠道，让所有人都成为自己财富的主人。<br /><br />
      </p>
      <img src="/images/sx_company02.jpg" alt="" /><br /><br />
      <p><span class="orange">深圳市前海善林资产管理有限公司</span>于2014年4月18日在前海成立，注册资本金3亿元人民币，系高通盛融（北京）投资基金管理有限公司旗下品牌，总部位于深圳罗湖区京基100大厦。 <br /><br />
        </p>
      <ul class="sx_cf_list">
         <li><div class="sx_cf_picbox"><a href="/images/cf1.jpg" class="highslide" onclick="return hs.expand(this)"><img src="/images/sx_cf1.jpg" alt="" title="点击放大" /></a></div></li>
         <li><div class="sx_cf_picbox"><a href="/images/cf2.jpg" class="highslide" onclick="return hs.expand(this)"><img src="/images/sx_cf2.jpg" alt="" title="点击放大" /></a></div></li>
         <li><div class="sx_cf_picbox"><a href="/images/cf3.jpg" class="highslide" onclick="return hs.expand(this)"><img src="/images/sx_cf3.jpg" alt="" title="点击放大" /></a></div></li>
         <li><div class="sx_cf_picbox"><a href="/images/cf4.jpg" class="highslide" onclick="return hs.expand(this)"><img src="/images/sx_cf4.jpg" alt="" title="点击放大" /></a></div></li>
         <li class="sx_cf_last"><div class="sx_cf_picbox"><a href="/images/cf5.jpg" class="highslide" onclick="return hs.expand(this)"><img src="/images/sx_cf5.jpg" alt="" title="点击放大" /></a></div></li>
         <li><div class="sx_cf_picbox"><a href="/images/cf6.jpg" class="highslide" onclick="return hs.expand(this)"><img src="/images/sx_cf6.jpg" alt="" title="点击放大" /></a></div></li>
         <li><div class="sx_cf_picbox"><a href="/images/cf7.jpg" class="highslide" onclick="return hs.expand(this)"><img src="/images/sx_cf7.jpg" alt="" title="点击放大" /></a></div></li>
         <li><div class="sx_cf_picbox"><a href="/images/cf8.jpg" class="highslide" onclick="return hs.expand(this)"><img src="/images/sx_cf8.jpg" alt="" title="点击放大" /></a></div></li>
         <li><div class="sx_cf_picbox"><a href="/images/cf9.jpg" class="highslide" onclick="return hs.expand(this)"><img src="/images/sx_cf9.jpg" alt="" title="点击放大" /></a></div></li>
         <li class="sx_cf_last"><div class="sx_cf_picbox"><a href="/images/cf10.jpg" class="highslide" onclick="return hs.expand(this)"><img src="/images/sx_cf10.jpg" alt="" title="点击放大" /></a></div></li>
      </ul>
      <div class="clear"></div>
    </div>
    <div class="clear"></div>
</div>
<%--
	<div class="contain clearfix" style="display:none;">
		<div class="about">
			<%
				CURRENT_CATEGORY = "GYWM";
				CURRENT_SUB_CATEGORY = "GSJJ";
			%>
			
			<div class="container fr">
				<div class="public_tit"><%=ArticleType.GSJJ.getName()%></div>
				<div class="info_cont">
					<%
						ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
						T5011 article = articleManage.get(T5011_F02.GSJJ);
						if (article != null) {
							articleManage.view(article.F01);
							StringHelper.format(out,articleManage.getContent(article.F01),fileStore);
						}
					%>
				</div>
			</div>
		</div>
	</div>
 --%>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</oscache:cache>
</body>
</html>