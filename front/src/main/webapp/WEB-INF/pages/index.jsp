<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.Timestamp"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sxbao.Index"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.entities.SxbaoType"%>
<%@page import="java.util.List"%>
<%@page import="org.joda.time.DateTime"%>
<%@page import="com.dimeng.p2p.service.SxbaoManage"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.query.QyBidQueryAccount"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdlb"%>
<%@page import="com.dimeng.util.http.URLParameter"%>
<%@page import="com.dimeng.p2p.S51.entities.T5124"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Tztjxx"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
<%@page import="com.dimeng.p2p.account.front.service.UserManage"%>
<%@page import="com.dimeng.p2p.front.servlets.UpdatePassword"%>
<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="oscache" %>
<html>
<head>
<title>
	<%
		configureProvider.format(out,SystemVariable.SITE_TITLE);
	%>
</title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<link href="<%=controller.getStaticPath(request)%>/css/style_sx.css" rel="stylesheet" type="text/css">
<link type="text/css" rel="stylesheet" href="<%=controller.getStaticPath(request)%>/css/layer.css" id="skinlayercss">
<link href="/css/dialoglink.css" rel="stylesheet" id="dialoglink"/>
<meta name="360-site-verification" content="821138001aae974381149ac69bb5bec7" />
</head>
<%
	BidManage bidManage = serviceSession.getService(BidManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	PagingResult<Bdlb> result = bidManage.index(1, new Paging() {
		public int getCurrentPage() {return IntegerParser.parse(requestWrapper.getParameter("paging.current"));}public int getSize() {return 5;}
	}); 
	
	PagingResult<Bdlb> result2 = bidManage.index(2, new Paging() {
		public int getCurrentPage() {return IntegerParser.parse(requestWrapper.getParameter("paging.current"));}public int getSize() {return 1;}
	});
	 
%>
<body>
<!--------顶部栏-------->
<%@include file="/WEB-INF/include/header.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/layer.min.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.lazyload.min.js"></script> 
<script src="<%=controller.getStaticPath(request)%>/js/public.min.js" type="text/javascript" ></script>
<script  src="<%=controller.getStaticPath(request)%>/js/jquery.SuperSlide.2.1.js" type="text/javascript"></script>
<script  src="/js/lhgdialog.min.js" type="text/javascript"></script>
<script>
$(function(){
	$("img.lazy").lazyload({effect : "fadeIn",threshold : 200});
	var a=screen.width;
	if (a<1200) a=1200;
	$("#sx_phototurn").css("width",a);
});
</script> 
<!--------幻灯栏-------->
<%@include file="/WEB-INF/include/index/advertisement_version2.jsp"%>
<%
UserManage mag = serviceSession.getService(UserManage.class);
Integer countInv=mag.countInvestAmount();
Integer countAcc=mag.countAccount();
BigDecimal userIncome=mag.userInvestTotalIncome();
BigDecimal dueIn=mag.userInvestDuein();
NoticeManage noticeManage = serviceSession.getService(NoticeManage.class);
%>
<!-----公告---->

    <div class="wrap_news">
      <div class="container">
         <div class="notice-list speleft">
           <div style="border-right:1px solid #e6e6e6;height:40px;" class="notice">
             <div id="scrollDiv">
                   <div class="pos_news" id="pos_news">
                    </div>
             </div>
        </div>

        <div class="IsYuR"> <h3>善粉：<%=countAcc%>人<span><a href="/graphic.html">查看统计数据</a></span></h3></div>
      </div>

    </div>
</div>
    <!----end 公告---->
<div class="wrapper">
<link href="<%=controller.getStaticPath(request)%>/css/owl.carousel.css" rel="stylesheet" type="text/css">
<link href="<%=controller.getStaticPath(request)%>/css/owl.theme.css" rel="stylesheet" type="text/css">
  <script type="text/javascript">
	//sdfsdf2015年06月25日 09时07分

	function amm(obj) {
		var pp;
		var pp2;
		$('.yst').children('span').removeClass("lisl");
		$(".maog").hide();
		document.getElementById("shah_" + obj).style.display = "block";
			try{
			 $("#channlViews img.lazy").trigger("sporty");
			}catch(e){}
	}
	function amm2(obj) {
		var pp;
		var pp2;
		$('.yst').children('span').removeClass("lisl");
		$(".maog").hide();
		document.getElementById("shah_x_" + obj).style.display = "block";
	try{
			 $("#channlViews img.lazy").trigger("sporty");
			}catch(e){}
	}
</script> 

<!--漂浮广告-->
<!--  <script>
$().ready(function(){
				var lay=$.layer({
					type: 1,
					title: false,
					area : ['800px','587px'],
					fix: false,
					shadeClose: true,
					//closeBtn: true,
					//offset: [($(window).height() - 700)/2+'px', ''], //上下垂直居中
					border : true,
					shade : [0.2, '#000'],
					page: {
						dom : '#lsightlei' 
					}
				});
				
				setTimeout(function(){ layer.close(lay); }, 5000);
				
      });          
               
				
</script> 
<div class="lsightlei" id="lsightlei" style="display:none;"><a class="lsight" href="page/picit"> </a></div>-->
<!--漂浮广告end-->  
  
  
  <!--图片延时加载--> 
  <script>
$().ready(function(){
	$("#focusa img.lazy").lazyload({effect : "fadeIn",event : "sporty"});
	$("#channlViews img.lazy").lazyload({effect : "fadeIn",event : "sporty"});
		try{
			 $("#channlViews img.lazy").trigger("sporty");
			}catch(e){}
	
});
</script> 
  <!--图片延时加载end--> 
    <style>
    #owl-demo .item img{
        display: block;
        width: 100%;
        height: auto;
    }
    </style>

    <script>
    $(document).ready(function() {
      $("#owl-demo").owlCarousel({

      navigation : false,
      slideSpeed : 300,
      paginationSpeed : 400,
	  lazyLoad : true,
	  autoPlay : true,
      singleItem : true 
      });
    });
    </script>  
  <!--banenr-->
  <div class="Middle">
    <div class="IsYun"> <a href="/gywm/gsjj.html">
      <h2>什么是善行创投？</h2>
      </a>
	  <p>善行创投 （ www.myshanxing.com ) 是由深圳市前海善林资产管理有限公司倾力打造的互联网投资理财平台，注册资金3亿元人民币。平台致力于为国内外投资人与融资方提供高效、安全
的综合金融信息服务，由专业的理财顾问为客户私人定制最佳资本解决方案。... <a href="<%configureProvider.format(out, URLVariable.GYWM_GSJJ);%>">了解更多 &gt;&gt;</a></p>
    </div>
    <div class="IsYuR">
    <div class="Total">
    <span class="ze">用户累计投资总金额</span>
    <span class="zq">待收余额</span>
    <span class="zq">为用户累计赚取</span>
    </div>
    <div class="Yuan">
    <span><b>￥<%=Formater.formatAmount(countInv-134942)%></b>元</span>
    <span><b>￥<%=Formater.formatAmount(dueIn)%></b>元</span>
    <span><b>￥<%=Formater.formatAmount(userIncome)%></b>元</span>
    </div>
    </div>
    <div class="clear"></div>
    <div class="Earnings">
      <ul>
        <li> 
             <div class="tu3"><a href="<%=controller.getStaticPath(request)%>/guide/"><img src="<%=controller.getStaticPath(request)%>/images/tu3.png" alt="新手指引" width="44" height="45" /></a></div>
           <p>新手指引</p>
         </li>
         <li>
            <div class="tu3"><a href="<%=controller.getStaticPath(request)%>/safe/keep.html"><img src="<%=controller.getStaticPath(request)%>/images/tu4.png"  alt="安全保障" width="44" height="45" /></a></div>
             <p>安全保障</p>
            
         </li>
         <li>
             <div class="tu3"><a href="<%=controller.getStaticPath(request)%>/xszy/help.html"><img src="<%=controller.getStaticPath(request)%>/images/tu5.png" alt="帮助中心"  width="44" height="45" /></a></div>
             <p>帮助中心</p>
         </li>
         <li>
            <div class="tu3"><a href="<%=controller.getStaticPath(request)%>/sx/kindness.html"><img src="<%=controller.getStaticPath(request)%>/images/tu6.png"  alt="善行公益" width="44" height="45" /></a></div>
             <p>善行公益</p>
         </li>
         <li class="righ">
             <div class="tu3"><a href="<%=controller.getStaticPath(request)%>/safe/keep.html#baozhan"><img src="<%=controller.getStaticPath(request)%>/images/tu7.png"  alt="1000万本息保障金"   width="44" height="45" /></a></div>
             <p>1000万本息保障金</p>
        </li>
      </ul>
    </div>
    <!--   day project start  -->
    <div class="items items2">
      <div class="Head">
        <div class="Head_L">
          <h2>善行宝</h2></div>
          <div class="head_w"><a href="/active/sxbao.html">什么是善行宝?</a></div>
          <div class="Head_R"> <span>百元门槛，投资灵活，按月收息，到期还本</div>
        <div class="clear"></div>
      </div>
      <div class="order">
        <ul>
          <li class="er_san">项目名称</li>
          <li>状态</li>
          <li class="er_total">已售总额</li>
          <li class="er_buy">操作</li>
        </ul>
      </div>
      <%SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
      List<SxbaoType> types = sxbaoManage.findAllType();
      for(SxbaoType sxbaoType : types){%>
      <div class="order order2">
        <ul>
          <li class="er_san"><%=sxbaoType.name%></li>
          <li><%=sxbaoType.sellStatus == T6230_F13.S?"在售":"停售"%></li>
          <li class="er_total">￥<%=Formater.formatAmount(sxbaoType.totalAmount)%>元</li>
          <li class="er_buy"><a class="buyBt" <%=sxbaoType.sellStatus == T6230_F13.S?"href=\""+controller.getPagingItemURI(request, Index.class, sxbaoType.id)+"\"":"style=\"background:#ccc !important; color:#333;\" href=\"javascript:void(0);\""%> >立即购买</a></li>
        </ul>
      </div>  
      <div class="clear"></div>
      <%}%>
   </div>
	<!--   day project end  -->
    <div class="Cobrand">合作伙伴</div>
    <div id="focusa">
      <ul style="left: 0px; width: 2400px;">
        <li class="yst">  
              <span class="" id="showbox_19" onmouseover="amm(19)"> <a href="javascript:void();"><img class="lazy" src="<%=controller.getStaticPath(request)%>/images/partner_wansy.png" alt="深圳市万盛宇家具有限公司"  data-original="<%=controller.getStaticPath(request)%>/images/partner_wansy.png" width="190" height="70" style="display: inline;"></a> </span>
              <span class="" id="showbox_21" onmouseover="amm(21)"> <a href="javascript:void();"><img class="lazy" src="<%=controller.getStaticPath(request)%>/images/partner_taocheba.png" alt="深圳淘车吧汽车贸易有限公司" data-original="<%=controller.getStaticPath(request)%>/images/partner_taocheba.png" width="190" height="70" style="display: inline;"></a> </span>
              <span class="" id="showbox_15" onmouseover="amm(15)"> <a href="javascript:void();"><img class="lazy" src="<%=controller.getStaticPath(request)%>/images/partner_shanlingzc.png" alt="深圳市前海善林资产管理有限公司" data-original="<%=controller.getStaticPath(request)%>/images/partner_shanlingzc.png" width="190" height="70" style="display: inline;"></a> </span>
              <span class="" id="showbox_14" onmouseover="amm(14)"> <a href="javascript:void();"><img class="lazy" src="<%=controller.getStaticPath(request)%>/images/partner_gaotongsr.png"alt="高通盛融"  data-original="<%=controller.getStaticPath(request)%>/images/partner_gaotongsr.png" width="190" height="70" style="display: inline;"></a> </span>
               <span class="" id="showbox_18" onmouseover="amm(18)"> <a href="javascript:void();"><img class="lazy" src="<%=controller.getStaticPath(request)%>/images/partner_huichaozf.png" alt="汇潮支付" data-original="<%=controller.getStaticPath(request)%>/images/partner_huichaozf.png" width="190" height="70" style="display: inline;"></a> </span>
               <span class="" id="showbox_22" onmouseover="amm(22)"> <a href="javascript:void();"><img class="lazy" src="<%=controller.getStaticPath(request)%>/images/hezuologo_05.png" alt="广东德纳律师事务所"  data-original="<%=controller.getStaticPath(request)%>/images/hezuologo_05.png" width="190" height="70" style="display: inline;"></a> </span>
              </li>
      </ul>
    <div class="btnBg" style="opacity: 0.5;"></div><div class="btn"><span style="opacity: 1;"></span><span style="opacity: 0.4;"></span></div><div class="preNext pre" style="opacity: 0.1;"></div><div class="preNext next" style="opacity: 0.1;"></div></div>
    <div id="channlViews">
    <div class="maog" id="shah_19" style="display: block;">
      <dl>
        <dt><img src="<%=controller.getStaticPath(request)%>/images/hezuo_pic1.jpg" alt="万盛宇家具"  data-original="<%=controller.getStaticPath(request)%>/images/hezuo_pic1.jpg" class="lazy" width="320" height="220" style="display: inline;"></dt>
        <dd>
          <h3>深圳市万盛宇家具有限公司</h3>
          <p> 深圳市万盛宇家具有限公司成立于1996年，是一家已有二十多年专业生产红木家具经验的企业，总部设于广东省深圳市观澜。该公司不仅在深圳市各个区拥有多家专卖店，在观澜还设有总部旗舰店、工厂及木材基地，厂房总面积六万多平方米。尤其是观澜展厅总面积达10000多平方米，是深圳单体最大的红木家具展厅。此外，在国内外还拥有十几家红木原材料工厂以及在东莞建有全国最大的红木交易市场。</p>
        </dd>
        <div class="clear"></div>
      </dl>
    </div>
    <div class="maog" id="shah_21" style="display: none;">
      <dl>
        <dt><img src="<%=controller.getStaticPath(request)%>/images/hezuo_pic2.jpg" alt="淘车吧汽车" data-original="<%=controller.getStaticPath(request)%>/images/hezuo_pic2.jpg" class="lazy" width="320" height="220" style="display: inline;"></dt>
        <dd>
          <h3>深圳淘车吧汽车贸易有限公司</h3>
          <p> 淘车吧是由深圳淘车吧汽车贸易有限公司鼎力打造开发运营的全新二手车交易平台，淘车吧有多年二手车运营管理经验，在深圳拥有多家分店，以全国连锁。
          <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公司以品牌化管理，标准化操作流程为发展方向，以质量保证为主导，以公平、公开、公正为经营理念，以规范化管理为市场定位，是一个透明、安全和专业化的二手车交易市场。场内具备交易、过户、评估、置换、转籍和车辆保险等功能，集旧车交易双向全过程服务的综合性交易市场。场内硬件设施完善，技术设备先进，环境优雅，具备大型展厅，近千个车辆展位和顾客停车区，交易车辆品种齐全，可满足各行业标准消费者的需求，在这里进行交易和办理过户手续的消费者和场内商户均可享受周到、热情、便捷、全方位的优质服务，具有良好的经济效益和社会效应。</p>
        </dd>
        <div class="clear"></div>
      </dl>
    </div>
    <div class="maog" id="shah_15" style="display: none;">
      <dl>
        <dt><img src="<%=controller.getStaticPath(request)%>/images/hezuo_pic3.jpg" alt="善林资产" data-original="<%=controller.getStaticPath(request)%>/images/hezuo_pic3.jpg" class="lazy" width="320" height="220" style="display: inline;"></dt>
        <dd>
          <h3>深圳市前海善林资产管理有限公司</h3>
          <p>深圳市前海善林资产管理有限公司系高通盛融(北京）投资基金管理有限公司旗下品牌，注册资本金8888万元。总部位于深圳罗湖区京基100大厦。<br />
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;深圳市前海善林资产管理有限公司是一家集投资咨询、资产管理，财富管理，风险管理为一体的综合性金融服务企业，致力于通过匹配长期战略性、中期财务性、短期流动性三个阶段的投资，为客户提供全面、稳健的资本市场解决方案。
          <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公司拥有各类高级管理人员和专家顾问团队等三十余人，同时拥有一批具有成功创业经历，先进投资理念，扎实管理经验和专业技术背景的管理团队。依靠自身以及战略合作者雄厚的资金及资金运转能力，公司按照国际规范进行市场运作，为国内各企业及合作伙伴提供多品种、全方位、信息对称的各项资产管理、基金管理及投资银行等业务。</p>
        </dd>
        <div class="clear"></div>
      </dl>
    </div>
    <div class="maog" id="shah_14" style="display: none;">
      <dl>
        <dt><img src="<%=controller.getStaticPath(request)%>/images/gaotong_pic.jpg" alt="高通盛融" data-original="<%=controller.getStaticPath(request)%>/images/gaotong_pic.jpg" class="lazy" width="320" height="220" style="display: inline;"></dt>
        <dd>
          <h3>高通盛融</h3>
          <p>高通盛融（北京）投资基金管理有限公司，经北京市工商行政管理局核准，2014年10月8日注册资本增资为拾亿元人民币，是国内集财富管理、咨询等业务于一体的专门从事收购、兼并、产业投资、资金重组、资源整合和公司治理的综合性服务企业。<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公司拥有成熟的、具有丰富的国内国际股权投资和资本运作经验的基金管理团队，共同发起成立专业的投融资平台，并秉承“诚信、创新、专业、共赢”的宗旨服务于客户。致力于为中小微企业提供前期资金的支持，并依据不同的客户需求，提供个性化资金解决方案。</p>
        </dd>
        <div class="clear"></div>
      </dl>
    </div>
    <div class="maog" id="shah_18" style="display: none;">
      <dl>
        <dt><img src="<%=controller.getStaticPath(request)%>/images/luchao.jpg" alt="汇潮支付"  data-original="<%=controller.getStaticPath(request)%>/images/luchao.jpg" class="lazy" width="320" height="220" style="display: inline;"></dt>
        <dd>
          <h3>汇潮支付</h3>
          <p>汇潮支付有限公司是一家由央行颁发的第三方支付牌照的支付公司，公司总部在上海天地软件园。公司2006年成立，至今有6年的成长，公司前期为上海汇潮信息技术有限公司，2013年获得央行第三方支付牌照，更名为汇潮支付有限公司，汇潮支付主要业务是互联网收单，经营范围全国。</p>
        </dd>
        <div class="clear"></div>
      </dl>
    </div>
    <div class="maog" id="shah_22" style="display: none;">
      <dl>
        <dt><img src="<%=controller.getStaticPath(request)%>/images/hezuo_pic5.jpg" alt="广东德纳律师事务所" data-original="<%=controller.getStaticPath(request)%>/images/hezuo_pic5.jpg" class="lazy" width="320" height="220" style="display: inline;"></dt>
        <dd>
          <h3>广东德纳律师事务所</h3>
          <p>广东德纳律师事务所是广东省司法厅依法批准设立的一家专业化、高层次、精品化的合伙制律师事务所。律师事务所执业许可证：19022007101358。德纳律师所位于深圳市政治、文化、金融CBD商务中心区，现有执业律师40多人，实习律师10多人，律师助理30多人。业务范围包括但不限于国内诉讼与仲裁业务、公司法务（公司筹组、并购、重组、治理、债务等）、外商投资、项目融资、房地产业、金融证券与保险、税务、劳动管理、知识产权、婚姻家庭、刑事辩护、上市辅导、工商代理及海外投资业务、政府机关和企事业单位法律顾问等。</p>
        </dd>
        <div class="clear"></div>
      </dl>
    </div>
    </div>
		
<div class="height10"></div>
<div class="items">
      <div class="Head">
        <div class="Head_L">
          <h2>体验区</h2>
        </div>
        <div class="clear"></div>
      </div>
      <div class="order">
        <ul>
          <li class="er_san">项目名称</li>
          <li>年化利率</li>
          <li>金额</li>
          <li>期限</li>
          <li class="wen">还款方式</li>
          <li>进度</li>
          <li>状态</li>
        </ul>
      </div>
      <div class="list">
        <ul>

   <%
          boolean tag = true;
          String statusButtonTemp = null;
          Bdlb[] creditInfos2=result2.getItems();
          if(creditInfos2!=null){
        	  for (int i=0;i<creditInfos2.length;i++) {
        		  Bdlb creditInfo = creditInfos2[i];
        		  if (creditInfo == null) {continue;}
            
        		  T6230_F20 status = creditInfo.F11;
                  if(status == T6230_F20.TBZ || status == T6230_F20.DFK){if(new DateTime(creditInfo.F13).plusDays(creditInfo.F09).getMillis() - System.currentTimeMillis() <= 0){statusButtonTemp = "已完结";} else if(status == T6230_F20.DFK){statusButtonTemp = status.getChineseName();}else{statusButtonTemp = "立即投资";}}else{statusButtonTemp = status.getChineseName();}
        %>
          <li> <span class="hehe">
               <p class="fen_hu">
                            <%if(creditInfo.investName!=null){%><img src="<%=controller.getStaticPath(request)%>/images/yuyue_03.png"alt="预约"/><%}%> <%else {%><i></i><%}%>
						<%if(creditInfo.isActivity == T6230_F13.S){%>
						<a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>">
							<%StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.F04, 12));%>
						</a>
						<a href="javascript:;" class="index_note">当天满标，第二天回款</a>
							<%}else{ %>
						<a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>" class="index_note_none">
							<%StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.F04, 12));%>
						</a>
							<%} %>
			    </p>
            </span>
            <span class="index_font"><%=Formater.formatRate(creditInfo.F07.subtract(creditInfo.bonus.divide(new BigDecimal("100"))),false)%>% <b class="index_font_big"><%if(creditInfo.bonus.compareTo(BigDecimal.ZERO)==1){out.print("+ "+creditInfo.bonus+"%");}%></b></span>
            <span>￥<%=Formater.formatAmount(creditInfo.F06)%>元</span>
            <span><%if(T6231_F21.S == creditInfo.F19){out.print(creditInfo.F20 + "天");}else{out.print(creditInfo.F10 + "个月");} %> </span>
            	 <%
	                    BidManage investManage = serviceSession.getService(BidManage.class);
	                    com.dimeng.p2p.modules.bid.front.service.entity.Bdxq credit = investManage.get(creditInfo.F02);%>
            <span><%=credit.F10.getChineseName()%></span> <span>
            <%if(creditInfo.F11 == T6230_F20.HKZ || creditInfo.F11 == T6230_F20.YJQ || creditInfo.F11 == T6230_F20.YDF){
            		creditInfo.F06 = creditInfo.F06.subtract(creditInfo.F08);
            		creditInfo.proess = 1;
            		creditInfo.F08 = new BigDecimal(0);
            	}%>
            <div class="progress">
              <div class="wi_o">
                 <%if(creditInfo.F11 != T6230_F20.YFB) {%>
                <div class="in_you_uo" style="width:<%=(int)(creditInfo.proess*100)%>%;"></div>
                <%}else{ %>
	            <span class="ln24"><%=TimestampParser.format(creditInfo.F13,"yyyy-MM-dd HH:mm")%>即将开启</span>
	            <%} %>
              </div>
              <div class="in_you"><%=Formater.formatProgress(creditInfo.proess)%></div>
            </div>
            </span> <span>
				  <%if(creditInfo.F11 == T6230_F20.TBZ){%>
                  <%if(statusButtonTemp!=null&&statusButtonTemp.equals("立即投资")){ %>
                   <span><a class="unun" href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>" >立即投标</a></span>
                  <%}else{ %>
                   <span><a class="unun"><%=statusButtonTemp %></a></span>
                  <%} %>
            	<%}else{%>
            	     <%if(creditInfo.F11 == T6230_F20.HKZ) {%><a class="unun">还款中</a>
            	     <%}else{%><a class="unun"><%=creditInfo.F11.getChineseName() %></a><%}%>
            	<%}%>
		
             </span></li>
           <%
        	  }
        	  }
          %>
        </ul>
      </div>
    </div>	
    <div class="items">
      <div class="Head">
        <div class="Head_L">
          <h2>推荐项目</h2>
          <a href="javascript:;" class="calculator">理财计算器</a> </div>
        <div class="Head_R"> <span>100元起投,工作日
        <em style="font-size: 18px;color: #fc8936;font-family: 'Tahoma';">10:00、14:30</em> 更新，周末随机</span> <a href="/user/financing/zdtb/index.html">设置自动投标</a> </div>
        <div class="clear"></div>
      </div>
      <div class="order">
        <ul>
          <li class="er_san">项目名称</li>
          <li>年化利率</li>
          <li>金额</li>
          <li>期限</li>
          <li class="wen">还款方式</li>
          <li>进度</li>
          <li>状态</li>
        </ul>
      </div>
      <div class="list">
        <ul>

   <%
          tag = true;
          statusButtonTemp = null;
          Bdlb[] creditInfos=result.getItems();
          if(creditInfos!=null){
        	  for (int i=0;i<creditInfos.length;i++) {
        		  Bdlb creditInfo = creditInfos[i];
        		  if (creditInfo == null) {continue;}
            
        		  T6230_F20 status = creditInfo.F11;
                  if(status == T6230_F20.TBZ || status == T6230_F20.DFK){if(new DateTime(creditInfo.F13).plusDays(creditInfo.F09).getMillis() - System.currentTimeMillis() <= 0){statusButtonTemp = "已完结";} else if(status == T6230_F20.DFK){statusButtonTemp = status.getChineseName();}else{statusButtonTemp = "立即投资";}}else{statusButtonTemp = status.getChineseName();}
        %>
          <li> <span class="hehe">
               <p class="fen_hu">
                            <%if(creditInfo.investName!=null){%><img src="<%=controller.getStaticPath(request)%>/images/yuyue_03.png"alt="预约"/><%}%> <%else {%><i></i><%}%>
							<a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>">
								<%StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.F04, 12));%>
							</a>
			    </p>
            </span>
            <span class="index_font"><%=Formater.formatRate(creditInfo.F07.subtract(creditInfo.bonus.divide(new BigDecimal("100"))),false)%>% <b class="index_font_big"><%if(creditInfo.bonus.compareTo(BigDecimal.ZERO)==1){out.print("+ "+creditInfo.bonus+"%");}%></b></span>
            <span>￥<%=Formater.formatAmount(creditInfo.F06)%>元</span>
            <span><%if(T6231_F21.S == creditInfo.F19){out.print(creditInfo.F20 + "天");}else{out.print(creditInfo.F10 + "个月");} %> </span>
            	 <%
	                    BidManage investManage = serviceSession.getService(BidManage.class);
	                    com.dimeng.p2p.modules.bid.front.service.entity.Bdxq credit = investManage.get(creditInfo.F02);%>
            <span><%=credit.F10.getChineseName()%></span> <span>
            <%if(creditInfo.F11 == T6230_F20.HKZ || creditInfo.F11 == T6230_F20.YJQ || creditInfo.F11 == T6230_F20.YDF){
            		creditInfo.F06 = creditInfo.F06.subtract(creditInfo.F08);
            		creditInfo.proess = 1;
            		creditInfo.F08 = new BigDecimal(0);
            	}%>
            <div class="progress">
              <div class="wi_o">
                 <%if(creditInfo.F11 != T6230_F20.YFB) {%>
                <div class="in_you_uo" style="width:<%=(int)(creditInfo.proess*100)%>%;"></div>
                <%}else{ %>
	            <span class="ln24"><%=TimestampParser.format(creditInfo.F13,"yyyy-MM-dd HH:mm")%>即将开启</span>
	            <%} %>
              </div>
              <div class="in_you"><%=Formater.formatProgress(creditInfo.proess)%></div>
            </div>
            </span> <span>
				  <%if(creditInfo.F11 == T6230_F20.TBZ){%>
                  <%if(statusButtonTemp!=null&&statusButtonTemp.equals("立即投资")){ %>
                   <span><a class="unun" href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>" >立即投标</a></span>
                  <%}else{ %>
                   <span><a class="unun"><%=statusButtonTemp %></a></span>
                  <%} %>
            	<%}else{%>
            	     <%if(creditInfo.F11 == T6230_F20.HKZ) {%><a class="unun">还款中</a>
            	     <%}else{%><a class="unun"><%=creditInfo.F11.getChineseName() %></a><%}%>
            	<%}%>
		
             </span></li>
           <%
        	  }
        	  }
          %>
          <li><a href="/financing/sbtz/" class="pro_more">更多</a></li>
        </ul>
      </div>
    </div>
   <!-- 媒体报道 -->
   <%@include file="/WEB-INF/include/index/info_version2.jsp"%>
   

<!---中奖列表--->
    <div id="awardDiv" style="display:none"></div>
  <script>
$(function(){
	$.ajax({
        url: "/getAwardRecord.htm",
        type: "GET",
        data: {"page":1, "size":3},
        dataType: "json",
        success: function(data){
            var html = '<div class="pos_bg"></div><ul class="looplist" >';
            for(var i=0;i<data.length;i++){
            html += '<li><a href="javascript:;" onclick="awardList();" title="'+data[i].content+'" class="text_news">'+
            '<span>【获奖公告】'+(data[i].content.length > 40 ?(data[i].content.substr(0,40)+'...') :data[i].content) +'</span>'+
            '</a><span class="time_news">'+data[i].time+'</span></li>';
            }
            html += '</ul>';
            $('#pos_news').html(html);
            $("#scrollDiv").textSlider({line:1,speed:500,timer:3000});
       }
    });
});
 function awardList(){
        var calc = $.layer({
            type : 1,
            title : false,
            fix : false,
            offset:['50px' , ''],
            area : ['950px','500px'],
            page : {dom : '#awardDiv'}
        });
    $('#awardDiv').html("<p><img src='/images/loading.gif' />正在加载中,请稍候。。。</p>");
        $.ajax({
            url: "/getAwardRecord.htm",
            data: {"page":1, "size":10000},
            type: "GET",
            dataType: "json",
            success: function(data){
                var html = '';
                $('#awardDiv').html("");
                var head = '<h2>获奖公告</h2>';
                for(var i=0;i<data.length;i++){
                    html += '<p class="prizeList">' + data[i].content
                    + '<span>'+data[i].time +'</span>' + '</p>';
                }
                  $('#awardDiv').html(head+html);
           }
        });
}
</script> 

<%@include file="/WEB-INF/include/footer.jsp"%>

<script type="text/javascript">

jQuery(".fullSlide").hover(function() {
    jQuery(this).find(".prev,.next").stop(true, true).fadeTo("show", 0.3)
},
function() {
    jQuery(this).find(".prev,.next").fadeOut()
});
jQuery(".fullSlide").slide({
    titCell: ".hd ul",
    mainCell: ".bd ul",
    effect: "fold",
    autoPlay: true,
    autoPage: true,
    trigger: "click",
    startFun: function(i) {
        var curLi = jQuery(".fullSlide .bd li").eq(i);
        if ( !! curLi.attr("_src")) {
            curLi.css("background-image", curLi.attr("_src")).removeAttr("_src")
        }
    }
});
   
</script>
</body>
</html>