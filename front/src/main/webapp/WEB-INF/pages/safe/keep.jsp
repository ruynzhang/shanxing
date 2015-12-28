<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.Region"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidWillManage"%>
<%@page import="com.dimeng.p2p.common.enums.IntentionType"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.Dkyx"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="oscache" %>
<%-- <%@include file="/WEB-INF/include/authenticatedSession.jsp" %> --%>
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/inside.css" />
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
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
<%
String ermsg = controller.getPrompt(request, response,PromptLevel.ERROR);

%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<oscache:cache key="sl-p2p-front-keep" time="21600" scope="application">
	<div class="ks_banner">
   <div class="banner"><img src="/images/sx_safeBanner.jpg" alt="" /></div>
</div>

<div class="sx_ksbox sx_ks_tab">
           <div class="tab_menu2">
			<ul>
				<li class="current">本息有保障</li>
				<li>技术安全</li>
				<li>政策法规保障</li>
				<li>温馨提醒</li>
                <li>1000万本息保障金</li>
			</ul>
            <div class="clear"></div>
            </div>
			<div class="tab_box2">
				<div>
					<h1>本息有保障（试行）</h1><br />
                    “本息保障计划”是善行创投(www.myshanxing.com)为保护平台全体理财人的共同权益而建立的信用风险共担机制。当出借人通过善行创投平台所出借的借款出现逾期时，平台将根据“本息保障金资金使用规则”，使用“本息保障金”向出借人垫付该借款逾期的本金和利息，善行创投平台取得相应债权。<br /><br />

                    <h2>怎样实行本息有保障？</h2>
                                                   借款标逾期30天内(含)，根据“风险备用金账户使用规则”，通过“风险备用金”向理财人垫付此笔借款的剩余出借本金或本息。<br /><br />
                    
                    <h2>逾期本息垫付</h2>
                                                  借款标逾期30天内(含)或达到担保合同约定担保条件成立时，由担保机构进行代偿或债权收购，投资人收到担保机构代偿或债权收购资金的金额等于投资人应收未收到的全部投资本息之和。（目前正在完善，即将推出）<br /><br />
                    
                    <h2>项目审核</h2>
                    <b>实地考察：</b>合作机构线下实地考察借款人<br />
                    <b>资料审核：</b>审核包括银行流水、征信报告等多种必备材料<br />
                    <b>背景调查：</b>借款人背景、联系人详尽调查<br />
                    <b>还款能力：</b>借款人还款能力压力测试<br />
                    <b>黑名单管理：</b>借款人黑名单动态数据管理<br /><br />
                    
                    <h2>贷款审核保障</h2>
                    <b>严格的贷前审核</b><br />
                    在客户提出借款申请后，善行创投贷会对客户的基本资料进行分析。通过网络、电话及其他可以掌握的有效渠道进行详实、仔细的调查。避免不良客户的欺诈风险。在资料信息核实完成后，根据个人信用风险分析系统进行评估，由经验丰富的借款审核人员进行双重审核确认后最终决定批核结果。<br /><br />
                    
                    <b>完善的贷后管理</b><br />
                    自完成放款后，贷款管理部门开始全程跟踪，严密跟踪借款人的借款使用情况，定期核查借款人提供的担保财产情况，到期还款前，贷款管理部门将通过短信、电话等方式提醒用户还款。如果用户仍未还款，交由专业的高级催收团队与第三方专业机构合作进行包括上门等一系列的催收工作，直至采取法律手段。<br />
				</div>
				<div class="hide">
				 <h1>技术安全</h1><br />
为确保投资人在平台上投资的安全性，采用了更为安全的超文本传输技术。网站传输数据都用公钥进行加密，必须使用私钥来解密，即使黑客截取了用户的数据包，也无法读取数据内容。大大提高了投资人资金操作的
安全性。和国内外的很多知名网站都使用相同的技术。 此外，善行创投采用的是银行级别的软硬件系统安全机制。全部的交易流水信息均实时秒级同步备份，应用、数据、服务功能隔离。即便遭受攻击，系统也可以恢复至受攻击前的状态，投资人的任何信息都不会丢失。<br /><br />

善行创投技术团队来自国内各大银行，在信息安全和数据安全方面有着非常丰富的经验，让您享受银行级别的安全保障；三层防火墙隔离系统的访问层、应用层和数据层集群；有效的入侵防范及容灾备份，确保交易数据安全无虞<br />
				</div>
				<div class="hide">
				      <h1>政策法规保障</h1><br />
                      <h2>善行创投提供居间撮合服务的合法性</h2>
                      《合同法》第23章专门对"居间合同"作出规定，其第424条明确定义为："居间合同是居间人向委托人报告订立合同的机会或者提供订立合同的媒介服务，委托人支付报酬的合同"。善行创投平台是合法设立的中介服务机构，致力于为民间借贷业务提供优质高效的撮合服务，以促成借贷双方形成借贷关系，然后收取相关报酬。此种居间服务有着明确的法律依据。
                      出借人及借款人之间的借贷关系的合法性<br />
                      《合同法》第196条规定："借款合同是借款人向贷款人借款，到期返还借款并支付利息的合同"；根据《合同法》第十二章"借款合同"和最高人民法院《关于人民法院审理借贷案件的若干意见》，我国法律允许自然人等普通民事主体之间发生借贷关系，并允许出借方到期可以收回本金和符合法律规定的利息。理财人作为借款人，与贷款人之间形成的借贷关系受到法律保护。<br /><br />
                      <h2>理财人通过善行创投平台获得的出借理财收益的合法性</h2>
                      根据最高人民法院《关于人民法院审理借贷案件的若干意见》第6条："民间借贷的利率可以适当高于银行的利率，各地人民法院可以根据本地区的实际情况具体掌握，但最高不得超过银行同类贷款利率的四倍（包含利率本数）。超出此限度的，超出部分的利息不予保护。"善行创投平台上理财人向借款人出借资金并按照约定利率收取利息，该等利率未超过银行同类贷款利率的四倍，为合法利息收益，受到法律保护。 <br /><br />
                      <h2>电子合同合法 </h2>
                      根据《合同法》第11条的规定，当事人可以采用合同书、信件和数据电文（包括电报、电传、传真、电子数据交换和电子邮件）等形式订立合同。电子合同是法律认可的书面合同形式之一。善行创投采取用户网上点击确认的方式签署电子合同。点击确认后的电子合同符合《中华人民共和国合同法》规定的合同成立、生效的要件，其有效性也被人民法院的司法实践所接受。<br />
				</div>
				<div class="hide">
				     <h1>温馨提醒</h1><br />
                     为了客户账户安全需要网站和用户的共同努力。在网站使用过程中，注意以下几点<br />
                      1、牢记善行创投官方网址：http://www.myshanxing.com （不要点击来历不明的链接访问善行创投，谨防网站钓鱼和欺诈。我们建议您将善行创投官方网址加入浏览器收藏夹，以方便您的下次登录。）<br />
                      2、设置高强度密码 （您在密码设置时，最好使用数字和字母混合，不要使用纯数字或纯字母，且密码长度要在6位以上。）<br />
                      3、时刻注意保护私人信息，不要向其他任何用户透漏自己个人信息 <br />
                      4、使用电脑安全（在确保电脑安全的情况下登录账户）<br />
				</div>
                <div class="hide">
				     <h1>1000万本息保障金</h1><br />
                     <p><a href="/images/u12.jpg" class="highslide" onclick="return hs.expand(this)"><img src="/images/u12.jpg" alt=""  width="475" style="margin-right:50px" title="点击放大" /></a><a href="/images/u14.jpg" class="highslide" onclick="return hs.expand(this)"><img src="/images/u14.jpg" alt="" width="475" title="点击放大" /></a></p>
				</div>
			</div>
		</div>
     
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script src="<%=controller.getStaticPath(request)%>/js/jquery.tabs2.js"></script>
<script type="text/javascript">
$(function(){
	$('.sx_ks_tab').Tabss({
		event:'click'
	});
	if(location.href.indexOf('baozhan')!=-1)
	    {
		 $('.tab_menu2 li:first').removeClass("current");
		 $('.tab_box2 div:first').addClass("hide");
		 $('.tab_menu2 li:last').addClass("current");
		 $('.tab_box2 div:last').removeClass("hide");
		};
});	
</script>
	</oscache:cache>
</body>
</html>