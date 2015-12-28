<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="contain clearfix">
		<div class="contain_main">
			<div class="product_intr">
				<div class="pub_title"><%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>借款 - 产品介绍</div>
				<ul class="w800 con clearfix">
					<li>
						<div class="tit">薪金贷</div>
						<div class="info f14"><%configureProvider.format(out,HTMLVariable.LOAN_PRODUCTS_XJD);%></div>
						<div class="f14 more">
						 	<p><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.credit.xjd.Index.class)%>" class="blue">查看详细信息</a></p>
                			<p><a target="_blank" href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.credit.Jkjsq.class)%>" class="blue">借款费用计算器</a></p>
						</div>
						<div><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.credit.xjd.Index.class)%>" class="big_btn01 big_btn ml80 tc mt20 f18">立即申请</a></div>
					</li>
					 <li>
						<div class="tit">个人借款意向</div>
						<div class="info f14"><%configureProvider.format(out,HTMLVariable.GRJKYXJS);%></div>
						<div class="f14 more">
						</div>
						<div><a href="<%configureProvider.format(out,URLVariable.CREDIT_DKYX);%>" class="big_btn01 big_btn ml80 tc mt20 f18">立即申请</a></div>
					</li>
					<li>
						<div class="tit">企业借款意向</div>
						<div class="info f14"><%configureProvider.format(out,HTMLVariable.QYJKYXJS);%></div>
						<div class="f14 more">
						</div>
						<div><a href="<%configureProvider.format(out,URLVariable.CREDIT_QYDKYX);%>" class="big_btn01 big_btn ml80 tc mt20 f18">立即申请</a></div>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>
