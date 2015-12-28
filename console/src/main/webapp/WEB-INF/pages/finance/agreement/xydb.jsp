<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.agreement.Xydb"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.CreditTrs"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.CreditDetail"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Borrower"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.JoinedUser"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.AgreementManage"%>
<%@page import="java.util.Calendar"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"></meta> 
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/other.css" />
<title>协议_信用担保</title>
</head>
<body style="width:900px; margin:0 auto;font-size:14px;">
<%
	int creditId = IntegerParser.parse(request.getParameter("id"));
	if(creditId <= 0){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}
	String siteName = configureProvider.getProperty(SystemVariable.SITE_NAME);
	AgreementManage manage = serviceSession.getService(AgreementManage.class);
	try{
	JoinedUser[] joinedUsers = manage.getJoinedUser(creditId);
	Borrower borrower = manage.getBorrower(creditId);
	CreditDetail creditDetail = manage.getCreditDetail(creditId);
	CreditTrs[] transfers = manage.getCreditTransfers(creditId);
	
	Calendar calendar = Calendar.getInstance();
	calendar.setTime(creditDetail.startDate);
%>
<div class="protocol">
  <%if(1 != IntegerParser.parse(request.getParameter("s"))){ %>
  <p class="clearfix pt10"><a target="_blank" href="<%=controller.getURI(request, Xydb.class)%>?id=<%=creditId%>&s=1" class="btn btn01 fr">点击下载</a></p>
  <%} %>
  <div class="tit">
     <h2><strong>借款协议</strong></h2>
     <p class="tr">编号：DB-<%=creditId %></p>
  </div>
<div class="con">
<strong>甲方（出借人）： </strong><br/>
<table width="80%" class="tab_two">
  <tr>
    <td width="23%"><%=siteName%>用户名</td>
    <td width="26%">借出金额</td>
    <td width="22%">借款期限</td>
    <td width="29%">每月应收本息</td>
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
  	%> <br/>
    身份证号：<%
 	StringHelper.filterHTML(out, borrower.identifyId);
 %><br/>
    <%=siteName%>用户名：<%
    	StringHelper.filterHTML(out, borrower.accountName);
    %><br/><br/>

    <strong>丙方（担保人）：</strong><%
    	StringHelper.filterHTML(out, configureProvider.getProperty(SystemVariable.COMPANY_NAME));
    %><br/>
    联系方式：<%
    	StringHelper.filterHTML(out, configureProvider.getProperty(SystemVariable.COMPANY_ADDRESS));
    %><br/><br/>
    
    <strong>丁方（见证人）：</strong>深圳市迪蒙网络科技有限公司<br/>
    联系方式：广东省深圳市罗湖区振业大厦28楼<br/><br/>
	鉴于：<br />
  1、丁方是一家在深圳市罗湖区合法成立并有效存续的有限责任公司，拥有<%=configureProvider.getProperty(SystemVariable.SITE_DOMAIN)%>网站（以下简称“该网站”）的经营权，提供信用咨询，为交易提供信息服务；<br />
  2、乙方已在该网站注册，并承诺其提供给丁方的信息是完全真实的；<br />
  3、甲方承诺对本协议涉及的借款具有完全的支配能力，是其自有闲散资金，为其合法所得；并承诺其提供给丁方的信息是完全真实的；<br />
  4、乙方有借款需求，甲方亦同意借款，双方有意成立借贷关系；<br />
  5、丙方是一家在广东省深圳市合法成立并有效存续的有限责任公司；负责审查审批乙方的借款申请及资质、承诺保证乙方信息的真实性并负责本合同项下的借款回收及日常管理工作，并为甲方对乙方的借款提供担保。
<br/>
<strong>各方经协商一致，于</strong><strong>【<%=calendar.get(Calendar.YEAR)%>】年【<%=calendar.get(Calendar.MONTH)+1%>】月【<%=calendar.get(Calendar.DAY_OF_MONTH)%>】日 签订如下协议，共同遵照履行：</strong><br/><br/>
<strong>第一条 借款基本信息</strong><br/>
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
<strong>第二条 各方权利和义务</strong><br/><br />
<strong>甲方的权利和义务&nbsp;&nbsp;</strong><br />
1、  甲方应按合同约定的借款日或乙丙双方另行约定的其他日期将足额的借款本金支付给乙方。<br />
  2、  甲方保证其所用于出借的资金来源合法，甲方是该资金的合法所有人，如果第三人对资金归属、合法性问题发生争议，由甲方负责解决。如甲方未能解决，则放弃享有其所出借款项所带来的利息收益。<br />
  3、  甲方享有其所出借款项所带来的利息收益。<br />
  4、  如乙方违约，甲方有权要求丁方提供其已获得的乙方信息。<br />
  5、  无须通知乙方和丙方，甲方可以根据自己的意愿进行本协议下其对乙方债权的转让。在甲方的债权转让后，乙方仍应按照本协议的约定向债权受让人支付每期应还贷款本息，不得以未接到债权转让通知为由拒绝履行还款义务，丙方需对债权受让人继续履行本协议下其对甲方的担保义务。<br />
  6、  甲方应主动缴纳由利息所得带来的可能的税费。<br />
  7、  如乙方还款不足以偿还约定本金、利息及违约金的，甲方同意各自按照其借出款项比例收取还款。<strong>  </strong><br /><br />
<p><strong>乙方权利和义务 </strong><br />
  1、  乙方必须按期足额向甲方支付每期应还本金和利息。<br />
  2、  乙方必须按期足额向丁方支付借款管理费用。<br />
  3、  乙方承诺所借款项不用于任何违法用途。<br />
  4、  乙方应确保其提供的信息和资料的真实性，不得提供虚假信息或隐瞒重要事实。<br />
  5、  乙方有权了解其在丁方的信用评审进度及结果。<br />
  6、  乙方不得将本协议项下的任何权利义务转让给任何其他方。<br /><br />
  <strong>丙方的权利和义务 </strong><br />
  1、  丙方必须保证其向丁方提供的乙方信息的真实性。<br />
  2、  丙方应负责审查审批乙方的借款申请及资质并负责本合同项下的借款回收及日常管理工作。<br />
  3、  乙方在本合同中向甲方、丁方支付的借款本金、利息、借款管理费等所有的费用均由丙方代为收集后支付予丁方。<br />
  4、  丙方承诺对乙方的借款承担连带保证责任，如乙方逾期归还借款本息的，由丙方代其偿还，乙方需向丙方支付代偿费用。代偿费用由乙丙双方另行约定。<br />
  5、  丙方有权就为本合同借款所提供的服务向乙方收取服务费，账户管理费的收取方式由乙丙双方另行约定。<br />
  6、  丙方有权了解乙方的信息和借款进展情况。<br />
  7、  丙方不得将本协议项下的任何权利义务转让给任何其他方。<br /><br />
  <strong>丁方的权利和义务 </strong><br />
  1、  甲方委托丁方，且丁方接受该等委托代甲方每期收取甲方出借款项所对应的乙方每期偿还的本息，代收后按照甲方的要求进行处置。自乙方将还款本息支付给丁方时，即视为乙方已经履行本协议项下对甲方的相应还款义务。<br />
  2、  甲方同意向乙方出借相应款项时，已委托丁方在本协议生效时将该笔借款直接划付至乙方账户。如因甲方资金来源合法性问题而致该借款行为被取消的，丁方自行承担该笔借款所产生的借款管理费。<br />
  3、  甲乙双方同意丁方有权代甲方在有必要时对乙方或丙方进行贷款的违约提醒及催收工作，包括但不限于电话通知、发律师函、对乙方提起诉讼等。甲方在此确认明确委托丁方为其进行以上工作，并授权丁方可以将此工作委托给其他方进行。乙方和丙方对前述委托的提醒、催收事项已明确知晓并应积极配合。<br />
  4、  丁方有权按月向乙方收取双方约定的借款管理费，并在有必要时对乙方或丙方进行违约提醒及催收工作，包括但不限于电话通知、发律师函、对乙方提起诉讼等。  丁方有权将此违约提醒及催收工作委托给其他方进行。<br />
  5、  丁方接受甲乙双方的委托行为所产生的法律后果由相应委托方承担。如因乙方或甲方或其他方（包括但不限于技术问题）造成的延误或错误，丁方不承担任何责任。<br />
  6、  丁方应对甲方和乙方的信息及本协议内容保密；如任何一方违约，或因相关权力部门要求（包括但不限于法院、仲裁机构、金融监管机构等），丁方有权披露。<br /><br />
  <strong>第三条 </strong><strong>借款管理费及居间服务费 </strong><br />
  1、  在本协议中，“借款管理费”是指因丁方为乙方提供信用咨询、评估、还款提醒、账户管理、还款特殊情况沟通等系列信用相关服务而由乙方支付给丁方的报酬。<br />
  2、  对于丁方向乙方提供的一系列信用服务。 在还款期间，乙方每月向丁方支付借款管理费用，共需支付[ ]期，借款管理费的缴纳时间与乙方向甲方支付利息或本金的还款日一致。<br />
  本条所称的“借款成功时”系指本协议签署日。<br />
  3、  如乙方和丁方协商一致调整借款管理费时，无需经过甲方同意。<br /><br />
  <strong>第四条 </strong><strong>违约责任 </strong><br />
  1、合同各方均应严格履行合同义务，非经各方协商一致或依照本协议约定，任何一方不得解除本协议。<br />
  2、任何一方违约，违约方应承担因违约使得其他各方产生的费用和损失，包括但不限于调查、诉讼费、律师费等，应由违约方承担。如违约方为乙方的，甲方有权立即解除本协议，并要求乙方立即偿还未偿还的本金、利息、罚息、违约金。<br />
  如本协议提前解除时，乙方在网站的账户里有任何余款，丁方有权按照本协议第四条第3项的清偿顺序将乙方的余款用于清偿，并要求乙方支付因此产生的相关费用。<br />
  3、乙方的每期还款应将包括以下款项全部还清：<br />
  （1）根据本协议产生的其他全部费用；<br />
  （2）罚息；<br />
  （3）逾期管理费；<br />
  （4）拖欠的利息；<br />
  （5）拖欠的本金；<br />
  （6）拖欠丁方的借款管理费；<br />
  （7）正常的利息；<br />
  （8）正常的本金；<br />
  （9）丁方的借款管理费；<br />
  4、乙方应严格履行还款义务，如乙方逾期还款且丙方未按约定履行代偿责任时，则应按照下述条款向甲方支付逾期罚息，自逾期开始之后，逾期本金的正常利息停止计算。<br />
  罚息总额 = 逾期本息总额×对应罚息利率×逾期天数；<br />
<table width="80%" class="tab_two">
  <tr>
    <td width="23%"><strong>逾期天数</strong></td>
    <td width="26%">1— 30 天</td>
    <td width="22%">31 天及以上</td>
    </tr>
  <tr>
    <td><strong>罚息利率</strong></td>
    </tr>
</table><br />
  5、乙方应严格履行还款义务，如乙方逾期还款且丙方未按约定履行代偿责任时，则应按照下述条款向丁方支付逾期管理费：<br />
  逾期管理费总额 = 逾期本息总额×对应逾期管理费率×逾期天数；<br />
<table width="80%" class="tab_two">
  <tr>
    <td width="23%"><strong>逾期天数</strong></td>
    <td width="26%">1— 30 天</td>
    <td width="22%">31 天及以上</td>
  </tr>
  <tr>
    <td><strong>逾期管理费费率</strong></td>
  </tr>
</table><br />
  6、如果乙方逾期支付任何一期还款超过30天，或连续逾期三期以上（含三期），或累计逾期达五期以上（含五期），或乙方在逾期后出现逃避、拒绝沟通或拒绝承认欠款事实等恶意行为，本协议项下的全部借款本息及借款管理费提前到期，乙方应立即清偿本协议下尚未偿付的全部本金、利息、罚息、借款管理费及根据本协议产生的其他全部费用。<br />
  7、如果乙方逾期支付任何一期还款超过30天，或连续逾期三期以上（含三期），或累计逾期达五期以上（含五期），或乙方在逾期后出现逃避、拒绝沟通或拒绝承认欠款事实等恶意行为，丁方有权将乙方的“逾期记录”记入公民征信系统，丁方不承担任何法律责任。<br />
  8、如果乙方逾期支付任何一期还款超过30天，或连续逾期三期以上（含三期），或累计逾期达五期以上（含五期），或乙方在逾期后出现逃避、拒绝沟通或拒绝承认欠款事实等恶意行为，丁方有权将乙方违约失信的相关信息及乙方其他信息向媒体、用人单位、公安机关、检查机关、法律机关披露，丁方不承担任何责任。<br />
  9、在乙方还清全部本金、利息、借款管理费、罚息、逾期管理费之前，罚息及逾期管理费的计算不停止。<br />
  10、本借款协议中的所有甲方与乙方之间的借款均是相互独立的，一旦乙方逾期未归还借款本息，任何一个甲方有权单独向乙方或丙方追索或者提起诉讼。如乙方逾期支付借款管理费或提供虚假信息的，丁方亦可单独向乙方或丙方追索或者提起诉讼。<br /><br />
  <strong>第五条 提前还款</strong><br />
  1、乙方可在借款期间任何时候提前偿还剩余借款。<br />
  2、提前偿还全部剩余借款<br />
  1）乙方提前清偿全部剩余借款时，甲方委托丙方代为处理提前结清的相关事项。如乙方提前清偿的要求得到允许时，乙方应向甲方支付当期应还本息，剩余本金；丙方应向甲方支付提前还款补偿（补偿金额为剩余本金的1.0%）。因提前清偿所产生的提请结清服务费由乙丙双方另行决定，与甲方无关。<br />
  2）乙方提前清偿全部剩余借款时，应向丁方支付当期借款管理费，乙方无需支付剩余还款期的借款管理费。<br />
  3、提前偿还部分借款<br />
  1）乙方提前偿还部分借款，仍应向甲方支付全部借款利息。<br />
  2）乙方提前偿还部分借款，仍应向丁方支付全部应付的借款管理费。<br /><br />
  <strong>第六条 担保</strong><br />
  1、  丙方为乙方向甲方借款提供担保。<br />
  2、  担保义务<br />
  1）担保方式：连带保证责任；<br />
  2）丙方提供的保证责任范围包括：本笔借款的本息及由此产生的相关罚息和管理费。<br /><br />
  <strong>第七条 法律及争议解决</strong><br />
  本协议的签订、履行、终止、解释均适用中华人民共和国法律，并由丙方所在地的人民法院管辖。<br /><br />
  <strong>第八条 附则</strong><br />
  1、本协议采用电子文本形式制成，并永久保存在丁方为此设立的专用服务器上备查，各方均认可该形式的协议效力。<br />
  2、本协议自文本最终生成之日生效。<br />
  3、本协议签订之日起至借款全部清偿之日止，甲方或乙方的下列信息如发生变更的，其应当在相关信息发生变更三日内将更新后的信息提供给丁方：本人、本人的家庭联系人及紧急联系人、工作单位、居住地址、住所电话、手机号码、电子邮箱、银行账户的变更。若因任何一方不及时提供上述变更信息而带来的损失或额外费用应由该方承担。<br />
  4、如果本协议中的任何一条或多条违反适用的法律法规，则该条将被视为无效，但该无效条款并不影响本协议其他条款的效力。
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
<%}catch(Throwable throwable){
	resourceProvider.log(throwable);
	response.sendError(HttpServletResponse.SC_FORBIDDEN);
} %>
</body>
</html>