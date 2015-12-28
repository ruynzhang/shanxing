<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "XCGL";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="con">
								<ul class="yw_li">
									<li>
										<p class="f18">安全保障</p> <span class="dian"></span>编辑前台“安全保障”内容，子栏有：本息担保、项目风控、资金安全、法律合规、过程透明、合作机构。
									</li>
									<li>
										<p class="f18">最新动态</p> <span class="dian"></span>资讯类文章撰写和发布，子栏有：网贷行业资讯、互联网金融研究、媒体报道、社会责任 。
									</li>
									<li>
										<p class="f18">关于我们</p> <span class="dian"></span>介绍公司相关信息，子栏有：公司简介、管理团队、专家顾问、合作伙伴、招贤纳士、联系我们、安全保障 。
									</li>
									<li>
										<p class="f18">运营管理</p> <span class="dian"></span>运营管理包含有广告管理、业绩报告、网站公告、友情链接、客服中心。
									</li>
									<li>
										<p class="f18">投资攻略</p> <span class="dian"></span> 编辑前台静态页面的文字和图片，子栏有：新手指引、名词解释、平台介绍、利息和费用、我要借款、我要理财、<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>账户 。
									</li>
									<li>
										<p class="f18">帮助中心</p> <span class="dian"></span> 编辑前台“帮助中心”内容，子栏有：充值与提现、投资与回款、账户与安全、注册与登录 。
									</li>
								</ul>
								<div class="clear"></div>
							</div>
						</div>
						<div class="box2 clearfix"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>