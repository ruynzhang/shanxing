<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.UpdatePassword"%>
<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
<html>
<head>
<title>
	<%
		configureProvider.format(out,SystemVariable.SITE_TITLE);
	%>
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/index.css" />
<meta name="baidu-site-verification" content="sg4sAuDLhd" />
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp"%>
    <!------sitemap-------->
<div class="sx_sitemanp sx_commonbox">
   <div class="sx_contentbox">
    <div class="sx_item_title">网站地图</div>
    <div class="sx_sitemap_list">
      <ul>
        <li>
          <div class="sx_sitemap_A"><a href="javascript:;;">我要理财</a></div>
          <div class="sx_sitemap_B">
	          <a href="<%configureProvider.format(out,URLVariable.FINANCING_GRB);%>">个人标</a>
	          <a href="<%configureProvider.format(out,URLVariable.FINANCING_QYB);%>">企业标</a>
	          <a href="<%configureProvider.format(out,URLVariable.FINANCING_ZQZR);%>">线上债权转让</a>
	          <a href="<%configureProvider.format(out,URLVariable.LC_LCJSQ);%>">理财计算器</a>
          </div>
          <div class="clear"></div>
        </li>
        <li>
          <div class="sx_sitemap_A"><a href="<%configureProvider.format(out,URLVariable.CREDIT_DKYX);%>">我要借款</a></div>
          <div class="clear"></div>
        </li>
        <li>
          <div class="sx_sitemap_A"><a href="<%configureProvider.format(out,URLVariable.GUIDE_URL);%>">新手指引</a></div>
          <div class="clear"></div>
        </li>
        <li>
          <div class="sx_sitemap_A"><a href="<%=controller.getStaticPath(request)%>/safe/keep.html">安全保障</a></div>
          <div class="clear"></div>
        </li>
        <li>
          <div class="sx_sitemap_A"><a href="javascript:;;">关于我们</a></div>
          <div class="sx_sitemap_B">
	          	<a href="<%configureProvider.format(out, URLVariable.GYWM_GSJJ);%>">公司简介</a>
	          	<a href="<%configureProvider.format(out, URLVariable.GYWM_GLTD);%>">管理团队</a>
	          	<a href="<%configureProvider.format(out, URLVariable.GYWM_HZJG);%>">合作伙伴</a>
	          	<a href="<%configureProvider.format(out, URLVariable.ZXDT_MTBD);%>">媒体报道</a>
	          	<a href="<%configureProvider.format(out, URLVariable.GYWM_ZXNS);%>">招贤纳士</a>
	          	<a href="<%configureProvider.format(out, URLVariable.GYWM_LXWM);%>">联系我们</a>
	          	<a href="<%configureProvider.format(out, URLVariable.ZXDT_WDHYZX);%>">行业资讯</a>
	          	<a href="<%configureProvider.format(out, URLVariable.WZGG_XQ);%>">平台公告</a>
	          	<a href="http://www.szslzc.com/">公司官网</a>
          	</div>
          <div class="clear"></div>
        </li>
        <li>
          <div class="sx_sitemap_A"><a href="<%=controller.getStaticPath(request)%>/sx/kindness.html">善行公益</a></div>
          <div class="clear"></div>
        </li>
        <li>
          <div class="sx_sitemap_A"><a href="javascript:;;">帮助中心</a></div>
          <div class="sx_sitemap_B">
	          <a href="/xszy/help.htm">名词解析</a>
	          <a href="/xszy/help.htm?id=2">常见疑问</a>
	          <a href="/xszy/help.htm?id=3">利息和费用</a>
	          <a href="/xszy/help.htm?id=4">我要借款</a>
	          <a href="/xszy/help.htm?id=5">我要理财</a>
	          <a href="/xszy/help.htm?id=6">平台账户</a>
          </div>
          <div class="clear"></div>
        </li>
        <li>
          <div class="sx_sitemap_A"><a href="javascript:;;">快捷操作</a></div>
          <div class="sx_sitemap_B">
	          <a href="<%configureProvider.format(out,URLVariable.REGISTER);%>">注册</a>
	          <a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">登录</a>
	          <a href="<%configureProvider.format(out,URLVariable.GET_PASSWORD);%>">找回密码</a>
          </div>
          <div class="clear"></div>
        </li>
      </ul>
    </div>
   </div>
</div>
<!-----end sitemap----->
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>