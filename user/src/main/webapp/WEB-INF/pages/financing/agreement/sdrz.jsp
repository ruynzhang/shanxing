<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.user.servlets.financing.agreement.Sdrz"%>
<%@page import="com.dimeng.p2p.modules.financing.user.service.entity.Organization"%>
<%@page import="com.dimeng.p2p.modules.financing.user.service.entity.CreditTrs"%>
<%@page import="com.dimeng.p2p.modules.financing.user.service.entity.CreditDetail"%>
<%@page import="com.dimeng.p2p.modules.financing.user.service.entity.Borrower"%>
<%@page import="com.dimeng.p2p.modules.financing.user.service.entity.JoinedUser"%>
<%@page import="com.dimeng.p2p.modules.financing.user.service.AgreementManage"%>
<%@page import="java.util.Calendar"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"></meta> 
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/other.css" />
<title>协议_实地认证</title>
</head>
<body style="width:900px; margin:0 auto;font-size:14px;">
<%
	int creditId = IntegerParser.parse(request.getParameter("id"));
	if(creditId <= 0){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}
	String siteName = configureProvider.getProperty(SystemVariable.SITE_NAME);
	AgreementManage manage = serviceSession.getService(AgreementManage.class);
	
	JoinedUser[] joinedUsers = manage.getJoinedUser(creditId);
	Borrower borrower = manage.getBorrower(creditId);
	CreditDetail creditDetail = manage.getCreditDetail(creditId);
	CreditTrs[] transfers = manage.getCreditTransfers(creditId);
	Organization org = manage.getOrganization(creditId);
	
	Calendar calendar = Calendar.getInstance();
	calendar.setTime(creditDetail.startDate);
%>
<div class="protocol">
  <p class="clearfix pt10">
  	<%if(1 != IntegerParser.parse(request.getParameter("s"))){ %>
  	<a href="<%=controller.getURI(request, Sdrz.class)%>?id=<%=creditId%>&s=1" class="btn btn01 fr">点击下载</a>
  	<%} %>
  </p>
  <div class="tit">
     <h2><strong>借款协议</strong></h2>
     <p class="tr">编号：SD-<%=creditId %></p>
  </div>
<div class="con">
<strong>甲方（出借人）： </strong><br/>
<table width="80%" class="tab_two">
  <tr>
    <td width="17%">用户名</td>
    <td width="17%">借出金额</td>
    <td width="21%">借款期限</td>
    <td width="25%">每月应收本息</td>
  </tr>
  <%
  	BigDecimal totalAmount = new BigDecimal(0);
    BigDecimal totalMonthAmount = new BigDecimal(0);
    if(joinedUsers != null){
    		for(JoinedUser joinedUser : joinedUsers){
    			totalAmount = totalAmount.add(joinedUser.amount);
   			totalMonthAmount = totalMonthAmount.add(joinedUser.monthAmount);
  %>
  <tr>
    <td><%
    	StringHelper.filterHTML(out, joinedUser.userName);
    %></td>
    <td>￥<%=Formater.formatAmount(joinedUser.amount)%></td>
    <td><%=joinedUser.limitMonth%></td>
    <td>￥ <%=Formater.formatAmount(joinedUser.monthAmount)%></td>
  </tr>
  <%
  	}}
  %>
  <tr>
    <td>总计</td>
    <td>￥<%=Formater.formatAmount(totalAmount)%></td>
    <td>&nbsp;</td>
    <td>￥ <%=Formater.formatAmount(totalMonthAmount)%></td>
  </tr>
  </table><br />
  	<strong>乙方（借款人）：</strong><br/>
	真实姓名： <%
  		StringHelper.filterHTML(out, borrower.realName);
  	%><br/>
   	 身份证号：<%
  		StringHelper.filterHTML(out, borrower.identifyId);
  	%><br/>
    <%=siteName%>用户名：<%
    	StringHelper.filterHTML(out, borrower.accountName);
    %><br/><br/>
    <p align="left"><strong>丙方（服务商）：<%
    	StringHelper.filterHTML(out, org.name);
    %> </strong><br />
      联系方式：<%
 	StringHelper.filterHTML(out, org.address);
 %><br /><br />
  <strong>丁方（见证人/服务商）：<%
  	StringHelper.filterHTML(out, configureProvider.getProperty(SystemVariable.COMPANY_NAME));
  %></strong><br />
      联系方式：<%
  	StringHelper.filterHTML(out, configureProvider.getProperty(SystemVariable.COMPANY_ADDRESS));
  %></p>
    <br/><br/>
    <p align="left"><strong>鉴于： </strong><br />
      1. 丁方是一家在深圳市合法成立并有效存续的有限责任公司，拥有<%=configureProvider.getProperty(SystemVariable.SITE_DOMAIN)%>网站（下称“<%=siteName%>”）的经营权，提供信用咨询，为交易提供信息服务 <br />
      2. 乙方已在<%=siteName%>注册，并承诺其提供给丁方的信息是完全真实的； <br />
      3. 甲方承诺对本协议涉及的借款具有完全的支配能力，是其自有闲散资金，为其合法所得；并承诺其提供给丁方的信息是完全真实的； <br />
      4. 乙方有借款需求，甲方亦同意借款，双方有意成立借贷关系；<br />
      5. 丙方是一家在上海市合法成立并有效存续的有限责任公司；负责协助丁方，对乙方在<%=siteName%>平台上的借款申请进行调查核实（包括但不限于实地调查等）；协助乙方完成其在<%=siteName%>平台上借款信息的发布，承诺保证乙方信息的真实性并协助甲方进行本协议项下的借款回收及日常管理工作。 <br />
      <strong>各方经协商一致，于</strong><strong>【<%=calendar.get(Calendar.YEAR)%>】年【<%=calendar.get(Calendar.MONTH)+1%>】月【<%=calendar.get(Calendar.DAY_OF_MONTH)%>】日 </strong><strong>签订如下协议，共同遵照履行：</strong></p>
<br/>
<strong>1. </strong><strong>借款基本信息 </strong>
<table width="80%" class="tab_two">
  <tr>
    <td width="23%"><strong>借款详细用途</strong></td>
    <td width="26%"><%
    	StringHelper.filterHTML(out, creditDetail.use);
    %></td>
    </tr>
  <tr>
    <td><strong>借款本金数额</strong></td>
    <td>￥<%=Formater.formatAmount(creditDetail.amount)%>（各出借人借款本金数额详见本协议文首表格）</td>
    </tr>
  <tr>
    <td><strong>借款年利率</strong></td>
    <td><%=Formater.formatRate(creditDetail.rate)%></td>
    </tr>
  <tr>
    <td><strong>借款期限</strong></td>
    <td><%=creditDetail.limitMonth%> 个月， <%=DateParser.format(creditDetail.startDate)%> 起，至 <%=DateParser.format(creditDetail.endDate)%> 止</td>
    </tr>
  <tr>
    <td><strong>月偿还本息数额</strong></td>
    <td>￥<%=Formater.formatAmount(creditDetail.monthAmount)%> （各出借人借款本金数额详见本协议文首表格）</td>
    </tr>
  <tr>
    <td><strong>还款分期月数</strong></td>
    <td><%=creditDetail.limitMonth%> 个月</td>
    </tr>
  <tr>
    <td><strong>还款日</strong></td>
    <td>自<%=DateParser.format(creditDetail.startDate)%> 起，每月<%=calendar.get(Calendar.DAY_OF_MONTH)%>日  （若当月没有该日，则还款日为当月最后一天，节假日不顺延）</td>
    </tr>
</table>
<br/>
<strong>2. 协议的订立及支付&nbsp;&nbsp;</strong><br />
<p align="left">2.1 各方同意并确认，各方通过自行或授权有关方根据<%=siteName%>有关规则和说明，在<%=siteName%>进行借款申请和投标操作等方式确认签署本协议。 <br />
  2.2 各方通过上述方式接受本协议且丁方审核通过时，本协议立即成立；协议成立的同时甲方不可撤销地授权丁方将出借款项在扣除相关费用后划转、支付给乙方，出借款项由丁方根据授权划转完毕时本协议正式生效。 </p>
2.3 甲方同意并授权丁方按本协议及<%=siteName%>有关规则的约定对出借款项和相关费用进行划扣和支付，并由丁方代为收取乙方支付的借款本息及有关费用。<br /><br />
<p align="left"><strong>3. </strong><strong>各方权利和义务 </strong><br />
  <strong>3.1 </strong><strong>甲方的权利和义务</strong> <br />
  3.1.1 甲方保证其所用于出借的资金来源合法，甲方是该资金的合法所有人，如果第三人对资金归属、合法性问题发生争议，由甲方负责解决。如甲方未能解决，则放弃享有其所出借款项所带来的利息收益。 <br />
  3.1.2 甲方享有其所出借款项所带来的利息收益，并应主动缴纳由利息所得带来的可能的税费。 <br />
  3.1.3 如根据本协议约定的顺序清偿时，乙方还款不足以偿还约定本金、利息及逾期罚息等款项的，甲方同意各自按照其借出款项比例收取还款。 <br />
  3.1.4 就甲方在本协议项下对乙方的部分或全部债权，甲方有权根据自己的意愿对外转让，并授权丙方或丁方可以视情况（必要时）将债权转让事项通知乙方。 <br />
  3.1.5 如乙方违约，甲方有权要求丁方提供其已获得的乙方信息。 <br />
  3.1.6 甲方承诺对依据本协议获得的乙方信息或资料予以保密，除用于本协议目的进行出借与合理催收外，不得向外转让或披露。 </p>
<br />
<p align="left"><strong>3.2 </strong><strong>乙方权利和义务</strong> <br />
  3.2.1 乙方必须按期足额向甲方归还每期应还本金和利息，向丙方及丁方支付相关服务费用，并支付与乙方逾期及提前还款有关的费用。 <br />
  3.2.2 乙方承诺所借款项不用于任何违法用途。 <br />
  3.2.3 乙方确认甲方可以根据自己的意愿进行本协议下其对乙方的部分或全部债权的转让，并特此同意甲方届时转让债权无需另行通知乙方；同时承诺若届时需要，将采取必要措施配合债权的一次或多次转让或届时债权人债权的实现。在债权转让后，甲方在本协议项下的权利和义务转移到债权受让人名下，乙方应按照本协议的约定向债权受让人支付每期应还借款本息，不得以未接到债权转让通知为由拒绝履行还款义务。 <br />
  3.2.4 乙方应确保其提供的信息和资料的真实性，不得提供虚假信息或隐瞒重要事实。若乙方违反本协议约定，丙方和丁方有权根据本协议及有关条款对乙方的信息和资料予以合理的披露。 <br />
  3.2.5 乙方同意，甲方、丙方和丁方有权使用乙方提供的或其他方自行收集的乙方资料和信息用于以下用途（包括但不限于）： <br />
  （1）为了达成本协议，将乙方的有关必要资料和信息在<%=siteName%>进行发布； <br />
  （2）为了完成向甲方提供本协议项下的服务，丙方和丁方向有关的合作机构提供必要之资料； <br />
  （3）用于解决争议、对纠纷进行调停等。 <br />
  3.2.6 乙方有权了解其在丙方和丁方的信用评审进度及结果。 <br />
  3.2.7 乙方不得将本协议项下的任何权利义务转让给任何其他方。 <br />
  3.2.8 乙方同意并确认，本协议如涉及两人以上借款，任一借款人均应履行本合同项下的义务，对全部借款承担连带清偿责任，甲方和丁方有权向任一借款人追索本息及其他相关费用。 </p>
<br />

<strong>3.3 </strong><strong>丙方的权利和义务</strong> <br />
  3.3.1 丙方必须保证其向丁方提供的乙方信息的真实性。 <br />
  3.3.2 丙方应负责协助丁方核实乙方的借款申请，各方授权丙方负责处理本协议项下的借款催收、回收及日常管理工作。 <br />
  3.3.3 乙方在本协议中向甲方返还的借款本金、利息和其他与甲方逾期或提前还款有关的所有费用均由丙方代为收集后，直接支付给丙方、丁方或通过丁方和<%=siteName%>向甲方支付。 <br />
  3.3.4 丙方有权就为本协议借款所提供的服务向乙方收取咨询费，咨询费的收取方式由乙丙双方另行约定。 <br />
  3.3.5 未经丁方同意，丙方不得将本协议项下的任何权利义务转让给任何其他方。 <br />
  3.3.6 丙方应在乙方逾期还款时，以其风险准备金为限先行垫付乙方应偿还给甲方的本息（下称“垫付的借款本息”），丙方在向甲方进行垫付的同时，即刻自动取得甲方对乙方的相应债权及其他权利，包括但不限于就前述债权向乙方追偿的权利，且甲方不再就前述已让渡给丙方的债权向乙方主张任何权利，或向丙方主张任何权利，同时甲方在此授权丙方或丁方可以视情况（必要时）将垫付等相关事项通知乙方。此后乙方应直接向丙方偿还其垫付的借款本息，并按照双方签署的《信用咨询及管理服务协议》向丙方支付垫付服务费用和逾期违约金。甲方同意并认可丙方前述垫付的行为并不代表有关逾期应归责于丙方，亦不代表丙方须为此承担其他任何责任。 <br />
  3.3.7 丙方按照本协议及其他有关协议的约定，将通过其合作的银行每月从乙方还款账户中划扣相应的数额；若出现非因乙方原因而多划扣的情形时，由丙方负责解决，丙方对多划扣的部分按照同期银行存款利息对乙方进行赔偿。 <br /><br />
  <strong>3.4 </strong><strong>丁方的权利和义务</strong> <br />
  3.4.1 丁方有权根据乙方和丙方提供的各项信息及丁方独立获得的信息评定乙方在丁方处所拥有的个人信用等级，并根据对乙方个人信息的评审结果，决定是否审核通过并将乙方的借款需求向甲方进行推荐。 <br />
  3.4.2 甲方同意向乙方出借相应款项时，已委托丁方在本协议成立后将该笔借款直接划付至乙方收款账户，并根据有关约定和授权在出借资金中扣除向丙方支付咨询费。 <br />
  3.4.3 丁方有权就为本协议借款所提供的服务向乙方收取服务费。借款达成时，服务费由甲方在交付借款本金的当日一次性从借款本金中扣除，并根据本协议向丁方进行支付。 <br />
  3.4.4 甲乙双方同意丁方有权代甲方在必要时对乙方或丙方进行贷款的违约提醒及催收工作，包括但不限于电话通知、上门通知、发律师函、对乙方提起诉讼等。甲方在此确认委托丁方为其进行以上工作，并授权丁方可以将此工作委托给其他方进行。乙方和丙方对前述委托的提醒、催收事项已明确知晓并应积极配合，同时应承担因乙方逾期还款而产生的催收费用。 <br />
  3.4.5 丁方接受甲乙双方的委托行为所产生的法律后果由相应委托方承担。如因乙方或甲方或其他方（包括但不限于技术问题）造成的延误或错误，丁方不承担任何责任。 <br />
  3.4.6 丁方应对甲方和乙方的信息及本协议内容保密；如任何一方违约，或因相关权力部门要求（包括但不限于法院、仲裁机构、金融监管机构等），丁方有权披露。 <br /><br />
  <strong>4. </strong><strong>借款服务费等费用 </strong><br />
  4.1 在本协议中，“服务费”是指因丁方为乙方提供信用咨询、评估、还款提醒、账户管理、还款特殊情况沟通等系列信用相关服务而由乙方支付给丁方的报酬，具体金额以乙方和丙方签署的《信用咨询及管理服务协议》为准。 <br />
  4.2 在借款达成时，服务费由甲方在交付借款本金的当日一次性从借款本金中扣除，并根据本协议向丁方进行支付。 <br /><br />
  <strong>5. </strong><strong>违约责任 </strong><br />
  5.1 合同各方均应严格履行合同义务，非经各方协商一致或依照本协议约定，任何一方不得解除本协议。 <br />
  5.2 任何一方违约，违约方应承担因违约使得其他各方产生的费用和损失，包括但不限于调查、诉讼费、律师费等，应由违约方承担。如违约方为乙方的，甲方有权立即解除本协议，并要求乙方立即偿还未偿还的本金、利息、罚息。 <br />
  5.3 本协议提前解除时，若乙方在<%=siteName%>的账户里有任何资金余款，丁方有权按照本协议第5.4条的清偿顺序将乙方的余款用于清偿，并要求乙方支付因此产生的相关费用。 <br />
  5.4 乙方的每期还款应将包括以下款项全部还清： <br />
  （1）根据本协议产生的其他全部费用； <br />
  （2）罚息； <br />
  （3）逾期管理费； <br />
  （4）拖欠的利息； <br />
  （5）拖欠的本金； <br />
  （6）正常的利息； <br />
  （7）正常的本金； <br />
  5.5 乙方应严格履行还款义务，如乙方逾期还款且丙方未替乙方垫付应还本息时，则应按照下述条款向甲方支付逾期罚息，自逾期开始之后，逾期本金的正常利息停止计算；如乙方逾期还款但丙方替乙方先行垫付应还本息时，在甲方收到丙方代为垫付的应还本息后，甲方不再向乙方收取罚息。 
<p><br />
  <br />
  <span class="tc">罚息总额 = 逾期本息总额×对应罚息利率×逾期天数；</span><br/>
</p>
<table width="80%" class="tab_two">
  <tr>
    <td width="23%"><strong>逾期天数</strong></td>
    <td width="26%">1— 30 天</td>
    <td width="22%">31 天及以上</td>
    </tr>
  <tr>
    <td><strong>罚息利率</strong></td>
    <td><%=Formater.formatRate(new BigDecimal(configureProvider.getProperty(SystemVariable.YU_QI_FAXI_RATE_1_30)))%></td>
    <td><%=Formater.formatRate(new BigDecimal(configureProvider.getProperty(SystemVariable.YU_QI_FAXI_RATE_31_)))%></td>
    </tr>
</table>
5.6 乙方应严格履行还款义务，如乙方逾期还款且丙方未替乙方垫付应还本息时，则应按照下述条款向丁方支付逾期管理费；如乙方逾期还款但丙方替乙方先行垫付应还本息时，在甲方收到丙方代为垫付的应还本息后，丁方不再向乙方收取逾期管理费。
<p><br /></p>
<p class="tc">逾期管理费总额 = 逾期本息总额×对应逾期管理费率×逾期天数；</p>
<table width="80%" class="tab_two">
  <tr>
    <td width="23%"><strong>逾期天数</strong></td>
    <td width="26%">1— 30 天</td>
    <td width="22%">31 天及以上</td>
  </tr>
  <tr>
    <td><strong>逾期管理费费率</strong></td>
    <td><%=Formater.formatRate(new BigDecimal(configureProvider.getProperty(SystemVariable.YU_QI_RATE_1_30)))%></td>
    <td><%=Formater.formatRate(new BigDecimal(configureProvider.getProperty(SystemVariable.YU_QI_RATE_31_)))%></td>
  </tr>
</table>
<p align="left">5.7 如果乙方逾期支付任何一期还款超过30天，或连续逾期三期以上（含三期），或累计逾期达五期以上（含五期），或甲方/丁方发现乙方出现逃避、拒绝沟通或拒绝承认欠款事实、故意转让资金、信用情况恶化等危害本协议借款的情形，则本协议项下的全部借款本息提前到期，同时： <br />
  （1）乙方应立即清偿本协议下尚未偿付的全部本金、利息、罚息及根据本协议产生的其他全部费用； <br />
  （2）丁方有权将乙方的“逾期记录”、“恶意行为”或“不良情况”记入公民征信系统； <br />
  （3）丁方有权将乙方违约失信的相关信息及乙方其他信息向包括但不限于媒体、用人单位、公安机关、检查机关、法律机关及有关逾期款项催收服务机构披露。对此丁方不承担任何责任。 <br />
  5.8 在乙方还清全部本金、利息、罚息、逾期管理费之前，罚息及逾期管理费的计算不停止。 <br />
  5.9 本借款协议中的所有甲方与乙方之间的借款均是相互独立的，一旦乙方逾期未归还借款本息，甲方中的任何一方均有权单独向乙方追索或者提起诉讼。如乙方逾期支付借款管理费或提供虚假信息的，丁方亦可单独向乙方追索或者提起诉讼。 <br /><br />
  <strong>6. </strong><strong>提前还款 </strong><br />
  6.1 乙方可在借款期间任何时候提前偿还全部剩余借款。乙方委托丙方代为处理提前还款的相关事项，并通过<%=siteName%>相关系统板块申请提前还款。 <br />
  6.2 乙方提前清偿全部剩余借款时，乙方委托丙方代为处理提前结清的相关事项。乙方应向甲方支付当期应还本息和剩余本金。 <br /><br />
  <strong>7. </strong><strong>法律适用及争议解决 </strong><br />
  7.1 本协议的签订、履行、终止、解释均适用中华人民共和国法律。 <br />
  7.2 本协议在履行过程中，如发生任何争执或纠纷，双方应友好协商解决；若协商不成，任何一方均有权向丁方所在地的人民法院提起诉讼。 <br /><br />
  <strong>8. </strong><strong>附则 </strong><br />
  8.1 本协议根据第2条的规定成立和生效。在乙方将本协议项下的全部本金、利息、逾期罚息、逾期管理费及其他所有相关费用全部偿还完毕后，本协议自动终止。 <br />
  8.2 各方可以书面协议方式对本协议作出修改和补充。经过各方签署的有关本协议的修改协议和补充协议是本协议组成部分，具有与本协议同等的法律效力。 <br />
  8.3 本协议及其修改或补充均采用通过<%=siteName%>以电子文本形式制成，可以有一份或者多份并且每一份具有同等法律效力，并永久保存在丁方为此设立的专用服务器上备查和保管。双方均认可该形式的协议效力。 <br />
  8.4 如果本协议中的任何一条或多条违反适用的法律法规，则该条将被视为无效，但该无效条款并不影响本协议其他条款的效力。 <br />
  8.5 本协议签订之日起至借款本息和有关费用全部清偿之日止，甲方或乙方的下列信息如发生变更的，其应当在相关信息发生变更三日内将更新后的信息提供给丁方：本人、本人的家庭联系人及紧急联系人、工作单位、居住地址、住所电话、手机号码、电子邮箱、银行账户的变更。若因任何一方不及时提供上述变更信息而带来的损失或额外费用应由该方自行承担。 <br />
  8.6 各方同意，本协议项下的借款或债权发生转让时，为便于各方明确责任主体更好地履行本协议，丁方可以视情况按附件所列格式制作债权转让交易记录并作为本协议的附件。 </p>
  <%
  	if(transfers != null){
  %>
    附件：债权转让交易记录
  <table width="80%" class="tab_two">
  <tr>
    <td width="23%"><strong>债权买入者</strong></td>
    <td width="26%"><strong>债权卖出者</strong></td>
    <td width="22%"><strong>交易金额</strong></td>
    <td width="22%"><strong>交易时间</strong></td>
  </tr>
  <%
  	for(CreditTrs transfer : transfers){
  %>
  	<tr>
  		<td><%StringHelper.filterHTML(out, transfer.in); %></td>
  		<td><%StringHelper.filterHTML(out, transfer.out); %></td>
  		<td><%=Formater.formatAmount(transfer.amount) %></td>
  		<td><%=DateParser.format(transfer.time) %></td>
  	</tr>
  <%} %>
  </table>
  <%} %>
</div>
</div>
</body>
</html> --%>