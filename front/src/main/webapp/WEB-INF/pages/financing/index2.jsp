<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>产品介绍-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<div class="contain clearfix">
   <div class="contain_main">
     <div class="product_intr">
       <div class="pub_title"><%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>理财 - 产品介绍</div>
       <ul class="w800 con clearfix">
       	    <li>
             <div class="tit">优选理财计划</div>
             <div class="info f14"><%configureProvider.format(out,HTMLVariable.FINANCIAL_PRODUCTS_YXLCJH);%></div>
             <div><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.yxlc.Index.class)%>" class="big_btn01 big_btn ml80 tc mt20 f18">去加入</a></div>
           </li>
           <li>
             <div class="tit">散标投资</div>
             <div class="info f14"><%configureProvider.format(out,HTMLVariable.FINANCIAL_PRODUCTS_SBTZ);%></div>
             <div><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class)%>" class="big_btn01 big_btn ml80 tc mt20 f18">去投标</a></div>
           </li>
           <li>
             <div class="tit">债权转让</div>
             <div class="info f14"><%configureProvider.format(out,HTMLVariable.FINANCIAL_PRODUCTS_ZQZR);%></div>
             <div><a href="<%=controller.getURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Zqzrlb.class)%>" class="big_btn01 big_btn ml80 tc mt20 f18">去购买</a></div>
           </li>
       </ul>
     </div>
   </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>