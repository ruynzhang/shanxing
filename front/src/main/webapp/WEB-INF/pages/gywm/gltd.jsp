<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="oscache" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>股东背景 关于我们</title>
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
				CURRENT_SUB_CATEGORY = "GLTD";
			%>
<oscache:cache key="sl-p2p-front-gltd" time="1" scope="application">
<%@include file="/WEB-INF/include/gywm/left.jsp"%>
<div class="sx_about_ctbox">
    <h1 class="sx_about_title">平台股东介绍</h1>
    <p class="sx_about_desc">善行创投是善林互联网金融服务有限公司推出的一款P2P投资理财平台，善林互联网金融服务有限公司注册资金为3亿元人民币，注册地为深圳市前海深港合作区，股东包括高通盛融（北京）投资基金管理有限公司、善林(上海)金融信息服务有限公司、深圳市前海善林资产管理有限公司等多家实力雄厚的公司。</p>
    <div class="sx_about_text2">
        <ul class="sx_team_list">
           <li>
              <div class="sx_team_intro">
                 <h2>高通盛融</h2>
                 <p>高通盛融（北京）投资基金管理有限公司，以下简称“高通盛融”，经北京市工商行政管理局核准，2014年10月8日注册资本增资为拾亿元人民币，是国内集财富管理、咨询等业务于一体的专门从事收购、兼并、产业投资、资金重组、资源整合和公司治理的综合性服务企业。</p>
                 <p>公司拥有成熟的、具有丰富的国内国际股权投资和资本运作经验的基金管理团队，共同发起成立专业的财富管理和咨询平台，并秉承“诚信、创新、专业、共赢”的宗旨服务于客户。致力于为中小微企业提供前期资金的支持，并依据不同的客户需求，提供个性化资金解决方案。</p>
                <p>2013年12月，高通盛融与中国城市科学研究会签订了战略合作协议，共同致力于推动智慧城市相关领域的健康发展，加强投资建设项目合作；2014年8月，又与兵团十二师国有资产监督管理委员会签订战略合作意向书，为更好的依托强大资源、资本优势，明确市场定位，参与优质产业基金及BT项目，实现公司稳步发展奠定了坚实的基础。</p>
                 <p>高通盛融同时投身社会慈善事业，慈善事业是经济发展取得一定成就后精神文明建设的重要内容，同时慈善事业也是社会财富再分配的一种方式，有利于促进社会公平。公司作为天津市全民国防教育协会理事单位，为天津SOS儿童村捐赠价值数万元慰问品。此举在满足受益儿童物质生活水平的基础上，也丰富了其精神文化生活，达到双向平衡发展。2014年8月，高通盛融投资基金管理有限公司举行了“心系鲁甸，为地震灾区的捐款”活动，在董事长周伯云的带领下，全体员工尽自己所能，同时也感召了各界爱心人士的参与，用实际行动向地震灾区人民伸出援手，传递爱心。企业还积极投身国防教育事业，响应政府号召，成功举办情系国防教育爱国红色经典京剧红灯记的专场演出，并得到市领导的高度认可。</p>
                 <p>公司官网：<a href="http://www.gtsrbj.com">http://www.gtsrbj.com</a></p>
               </div>
              <div class="clear"></div>
           </li>
           <li>
              <div class="sx_team_intro">
                 <h2>善林（上海）金融</h2>
                  <p>善林(上海)金融信息服务有限公司是一家大型的专业互联网金融公司，旗下拥有包括善林资产 、善林金融 、善林商务咨询等多家子公司。善林金融注册于上海自贸区，注册资本人民币12亿元，公司总部位于繁华的上海陆家嘴金融商业区。目前，善林公司在北京 、上海 、广州 、深圳 、天津 、杭州 、苏州 、南京 、成都 、重庆 、大连 、沈阳 、青岛 、济南 、烟台 、武汉 、西安 、郑州 、吉林 、哈尔滨、厦门等地设有超百家分支机构。</p>
                  <p>善林(上海)金融信息服务有限公司主要从事的金融信息服务包括P2P、P2B、P2G等，平台两端分为财富管理和普惠金融。财富管理致力于为投资者提供集专业化投资咨询、个性化财富管理方案、VIP尊享会员俱乐部于一体的一站式金融咨询服务，助投资者合理配置资产以达到财富稳健增长的需求。普惠金融凭借创新的金融理念、专业的信审团队和严格的风控体系，为有借款需求的个人及能提供抵押担保的中小微企业，提供专业的借款咨询服务。</p>
                  <p>公司官网：<a href="http://www.shanlinjinrong.com">http://www.shanlinjinrong.com</a></p>
                 </div>
              <div class="clear"></div>
           </li>
            <li>
               <div class="sx_team_intro">
                  <h2>深圳善林资产</h2>
                  <p>深圳市前海善林资产管理有限公司于2014年4月18日在前海成立，注册资本8888万元，总部位于深圳罗湖区京基100大厦。</p>
                  <p>善林资产是一家集投资咨询、资产管理、财富管理、风险管理为一体的综合性金融服务企业，致力于通过匹配长期战略性、中期财务性、短期流动性三个阶段的投资，为客户提供全面、稳健的资本市场解决方案。</p>
                  <p>公司拥有各类管理人员和专家顾问团队等三十余人，同时拥有一批具有成功创业经历、先进投资理念、扎实管理经验和专业技术背景的管理团队。依靠自身及战略合作者雄厚的资金及资金运作能力，公司按照国际规范进行市场运作，为国内各企业及合作伙伴提供多品种、全方位、信息对称的各项资产管理、基金管理及投资银行等业务。</p>
                  <p>公司官网：<a href="http://www.szslzc.com">http://www.szslzc.com</a></p>

              </div>
            <div class="clear"></div>
            </li>
   </ul>
    </div>
    <div class="clear"></div>
</div>
<%--
	<div class="contain clearfix" style="display:none;">
		<div class="about">
			<%
				CURRENT_CATEGORY = "GYWM";
				CURRENT_SUB_CATEGORY = "GLTD";
			%>
			<%@include file="/WEB-INF/include/gywm/left.jsp"%>
			<div class="container fr">
				<div class="public_tit"><%=ArticleType.GLTD.getName()%></div>
				<div class="info_cont team_manage">
					<%
						final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
						ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
						PagingResult<T5011> results = articleManage.search(
								T5011_F02.GLTD, new Paging() {
							public int getCurrentPage() {
								return currentPage;
							}

							public int getSize() {
								return 10;
							}
						});
						T5011[] articles = results.getItems();
						if (articles != null && articles.length > 0) {
							for (T5011 article : articles) {
					%>
					<dl>
						<dt><%if(!StringHelper.isEmpty(article.F09)){%><img src="<%=fileStore.getURL(article.F09)%>" width="240" height="135"/><%}%></dt>
						<dd>
							<p class="tit"><%StringHelper.filterHTML(out, article.F06);%></p>
							<p class="clearfix">
								<span class="fl"><%StringHelper.filterHTML(out, article.F07);%></span>
								<span class="fr"><%=TimestampParser.format(article.F12)%></span>
							</p>
							<p class="h150" id="connent"><%StringHelper.format(out, articleManage.getContent(article.F01), fileStore);%>
							</p>
						</dd>
					</dl>
					<%}}%>
				</div>
				<%Gltd.rendPaging(out, results,controller.getPagingURI(request, Gltd.class)); %>
			</div>
		</div>
	</div>
 --%>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
		<script type="text/javascript">
	$(function(){
	     var element = $("#connent");
	     var temp =  element.text().replace(/\n/g,'<br/>');
	     element.html(temp);
	});
	</script>
</oscache:cache>
</body>
</html>