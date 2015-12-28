<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="oscache" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>合作机构 关于我们</title>
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
				CURRENT_SUB_CATEGORY = "HZJG";
			%>
<oscache:cache key="sl-p2p-front-hzjg" time="1" scope="application">
<%@include file="/WEB-INF/include/gywm/left.jsp"%>
<div class="sx_about_ctbox">
    <h1 class="sx_about_title">投资人和合作伙伴</h1>
    <p class="sx_about_desc">善行创投携手投资人与合作伙伴共同探索P2P行业的挖掘与创新，以高效互联网技术影响金融，共同成长，砥砺共赢</p>
    <div class="sx_about_text3">
        <ul class="sx_partner_list">
           <li style="display:none;"><div class="sx_partner_pic"><img src="/images/sx_partner01.jpg" alt="" /></div>
              <div class="sx_partner_intro">
                 <p>深圳巨灵信息技术有限公司公司成立于1994年，是国内最早提供大中华金融信息服务的专业机构。2006年加入China Finance Online Co., Ltd（NASDAQ：JRJC），集团全资拥有巨灵信息、金融界、证券之星、深圳新兰德、证星国际五家公司，是唯一在美国上市的金融信息服务商；经过20余年的发展，巨灵财经构建了符合国际行业标准的新一代金融数据库，涵盖宏观行业经济库、股票、指数、银行理财、券商集合理财、信托及阳光私募、保险理财、基金、债券、港股、中华概念股、盈利预测及评级、新闻、公告和法律法规等内容，品种齐全、内容完整，并基于精准的基础参考数据加工了深入的统计衍生数据供用户选择使用。</p>
              </div>
              <div class="clear"></div>
           </li>
           <li><div class="sx_partner_pic"><img src="/images/sx_partner02.jpg" alt="" /></div>
              <div class="sx_partner_intro">
                 <p>鹏元征信有限公司成立于2005年，是专门开展个人征信、企业征信、企业评级、企业及个人信用管理的专业征信机构。公司通过了高新技术企业认定、双软企业认定、国家信息安全认证及国际软件成熟度（CMMI）认证，在个人及企业征信领域一直处于领先地位。 公司自主研发的“鹏元征信系统”，以其自有核心征信技术的先进性、创新性和实用性，获得了中国国家版权局颁发的软件著作权证书，整体技术处于国内领先水平。鹏元征信系统还荣获了2007年度深圳市金融创新二等奖。2009年，系统被国家发改委评为“国家信息化试点项目”，为全国其他地区征信系统的建设树立了良好的榜样示范作用。</p>
              </div>
              <div class="clear"></div>
           </li>
           <li><div class="sx_partner_pic"><img src="/images/sx_partner03.jpg" alt="" /></div>
              <div class="sx_partner_intro">
                 <p>中信银行是中国的全国性商业银行之一，总部位于北京，主要股东是中国中信股份有限公司。西班牙对外银行（Banco Bilbao Vizcaya Argentaria,S.A BBVA）斥资5.01亿欧元（约50.2亿港元）购入中信银行5%的股权，还可选择增持中信银行的持股比例至10.07%。2007年4月27日，中信银行在上海证券交易所上市。中信银行为中国大陆第七大银行，其总资产为12000逾亿港元，共有16000多名员工及540余家分支机构。它是香港中资金融股的六行三保之一。</p>
              </div>
              <div class="clear"></div>
           </li>
           <li><div class="sx_partner_pic"><img src="/images/sx_partner04.jpg" alt="" /></div>
              <div class="sx_partner_intro">
                 <p>平安银行中国平安保险（集团）股份有限公司控股的一家跨区域经营的股份制商业银行，为中国大陆12家全国性股份制商业银行之一。中国平安是国内领先的综合金融服务集团，《福布斯》世界500强暨中国非国有企业第一，注册资本为人民币51.2335亿元，总资产近1.37万亿元，总部位于广东省深圳市。平安银行以公司、零售、同业、投行“四轮”驱动,打造“专业化、集约化、综合金融、互联网金融”四大特色。 </p>
              </div>
              <div class="clear"></div>
           </li>
           <li><div class="sx_partner_pic"><img src="/images/sx_partner05.jpg" alt="" /></div>
              <div class="sx_partner_intro">
                 <p>建设银行成立于1954年10月1日，是股份制商业银行， 是国有五大商业银行之一。中国建设银行主要经营领域包括公司银行业务、个人银行业务和资金业务，在香港，台湾，墨尔本等地设有分行，拥有建信基金、建信租赁、建信信托、建信人寿、中德住房储蓄银行、建行亚洲、建行伦敦、建行俄罗斯、建行迪拜、建银国际等多家子公司，为客户提供全面的金融服务。中国建设银行拥有广泛的客户基础，与多个大型企业集团及中国经济战略性行业的主导企业保持银行业务联系，营销网络覆盖全国的主要地区，于2013年6月末，市值为1,767 亿美元，居全球上市银行第五位。2014年5月8日，2014福布斯全球企业2000强榜单出炉，建行蝉联全球第二大企业。</p>
              </div>
              <div class="clear"></div>
           </li>
           <li><div class="sx_partner_pic"><img src="/images/sx_partner06.jpg" alt="" /></div>
              <div class="sx_partner_intro">
                 <p>广东德纳律师事务所是广东省司法厅依法批准设立的一家专业化、高层次、精品化的合伙制律师事务所。律师事务所执业许可证：19022007101358。德纳律师所位于深圳市政治、文化、金融CBD商务中心区，现有执业律师40多人，实习律师10多人，律师助理30多人。业务范围包括但不限于国内诉讼与仲裁业务、公司法务（公司筹组、并购、重组、治理、债务等）、外商投资、项目融资、房地产业、金融证券与保险、税务、劳动管理、知识产权、婚姻家庭、刑事辩护、上市辅导、工商代理及海外投资业务、政府机关和企事业单位法律顾问等。</p>
              </div>
              <div class="clear"></div>
           </li>
           <li><div class="sx_partner_pic"><img src="/images/sx_partner07.jpg" alt="" /></div>
              <div class="sx_partner_intro">
                 <p>凤凰网是全球领先的跨平台网络新媒体公司凤凰新媒体旗下的综合门户网站。凤凰网不仅是控股的凤凰卫视传媒集团优质电视内容的网络传播渠道，更整合了众多专业媒体机构生产的内容、用户生成的内容、以及自身生产的专业内容，提供含文图音视频的全方位综合新闻资讯、深度报道、观点评论、财经产品、互动应用、分享社区、在线网页游戏等服务，满足主流人群浏览、表达、交流、分享、娱乐、理财等多元化与个性化的诉求，并反向传输给凤凰卫视的电视平台，形成创新的网台联动组合传播模式，为互联网、移动互联网及视频用户提供丰富的内容与随时随地随身的服务。凤凰网日均覆盖用户数（UV）超过3500万，月度覆盖用户数超越2.6亿，稳居中国第四大门户网站。</p>
              </div>
              <div class="clear"></div>
           </li>
           <li><div class="sx_partner_pic"><img src="/images/sx_partner08.jpg" alt="" /></div>
              <div class="sx_partner_intro">
                 <p>新浪财经创建于1999年8月，经过近10年的发展壮大，已经成为全球华人的首选财经门户。新浪财经在财经类网站中占有超过三分之一的市场份额，始终保持绝对领先优势，市场占有率为第二名的三倍。作为国内第一大财经网络媒体，新浪财经打造高端新闻资讯，深度挖掘业内信息，全程报道80%以上的业界重要会议及事件，独家率达90%，是最具影响力的主流媒体平台。除此之外，新浪财经为网友搭建互动、交流、学习的财经大平台。财经博客、财经吧、模拟股市、模拟汇市等均成为业界最早、人气最旺、最知名的财经互动社区。</p>
              </div>
              <div class="clear"></div>
           </li>
           <li><div class="sx_partner_pic"><img src="/images/sx_partner09.jpg" alt="" /></div>
              <div class="sx_partner_intro">
                 <p>深圳报业集团于2002年9月30日组建，由深圳特区报业集团和深圳商报社合并而成，以事业法人登记注册。旗下有深圳特区报、深圳商报、深圳晚报、晶报、《ShenZhen Daily》、深圳青少年报、深圳都市报、香港商报等十报和深圳周刊、汽车导报、焦点、游遍天下等六刊及十多家二级公司。是全国文化体制改革试点单位之一。集团报刊日总发行量超过200万份，约为深圳报刊市场总量的90%以上，覆盖率达到100%，并在北京、上海、成都等地设有分印点。</p>
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
				CURRENT_SUB_CATEGORY = "HZJG";
			%>
			<%@include file="/WEB-INF/include/gywm/left.jsp"%>
			<div class="container fr">
				<div class="public_tit"><%=ArticleType.HZJG.getName()%></div>
				<div class="info_cont">
					<%
						ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
						T5011 article = articleManage.get(T5011_F02.HZJG);
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