<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.agreement.Yxlc"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.YxDetail"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.YxJoined"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.YxUser"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.AgreementManage"%>
<%@page import="java.util.Calendar"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"></meta>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/other.css" />
<title>协议_优选理财</title>
</head>
<body style="width:900px; margin:0 auto;font-size:14px;">
<%
	int yxID = IntegerParser.parse(request.getParameter("id"));
	int userId= IntegerParser.parse(request.getParameter("userId"));
	if(yxID <= 0){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}
 	AgreementManage manage = serviceSession.getService(AgreementManage.class);
	YxUser yxUser = manage.getYxUser(userId);
	YxJoined[] joineds = manage.getYxJoineds(yxID,userId);
	YxDetail detail = manage.getYxDeadline(yxID);
	if(yxUser==null || joineds==null || detail==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}
	String siteName = configureProvider.getProperty(SystemVariable.SITE_NAME); 
%>
<div class="protocol">
  <%if(1 != IntegerParser.parse(request.getParameter("s"))){ %>
  	<p class="clearfix pt10"><a target="_blank" href="<%=controller.getURI(request, Yxlc.class)%>?id=<%=yxID%>&s=1" class="btn btn01 fr">点击下载</a></p>
  <%} %>
  <div class="tit">
    <h2><strong>优选理财协议书</strong></h2>
    <p class="tr">协议编号：YX-<%=yxID %></p>
  </div>
<div class="con">  
    <strong>甲方：</strong><%StringHelper.filterHTML(out, yxUser.name); %><br/>
	    身份证件号码：<%StringHelper.filterHTML(out, yxUser.identifyId); %><br/>
	    联系电话：<%StringHelper.filterHTML(out, yxUser.phone); %><br/><br/>
    <strong>乙方：<%StringHelper.filterHTML(out, configureProvider.getProperty(SystemVariable.COMPANY_NAME)); %></strong><br/>
	地址：<%StringHelper.filterHTML(out, configureProvider.getProperty(SystemVariable.COMPANY_ADDRESS)); %><br/>
	邮编：<%StringHelper.filterHTML(out, configureProvider.getProperty(SystemVariable.SITE_POSTCODE)); %><br/>
	咨询电话：<%StringHelper.filterHTML(out, configureProvider.getProperty(SystemVariable.SITE_CUSTOMERSERVICE_TEL)); %><br/>
	甲乙双方经友好协商，本着平等自愿、诚实信用的原则，达成如下协议：
   <h3>1. 服务计划意向</h3>
    1.1 在P2P模式下，乙方推出"出借人优先自动投标及到开放期按相关规则退出"的服务计划（下称“优选理财计划”）。加入的出借人可以享受<%StringHelper.filterHTML(out, siteName); %>提供的更加贴切、便捷的服务。<br/><br/>
    1.2 甲方同意加入本次服务计划，并自愿遵守<%StringHelper.filterHTML(out, siteName); %>网站（<%StringHelper.filterHTML(out, configureProvider.getProperty(SystemVariable.SITE_DOMAIN)); %>）的相关协议及规则。<br/>
    <h3>2. 服务计划金额</h3>
    2.1 甲方以下列自有合法资金加入本次服务计划：
    <table width="80%" class="tab_two">
      <tr><td width="31%">申请加入时间（年月日）</td><td>加入金额（单位:元）</td></tr>
      <%
      	Calendar calendar = Calendar.getInstance();
      	for(YxJoined joined : joineds){ 
      		calendar.setTimeInMillis(joined.time.getTime());
      %>
      <tr>
      	<td><%=calendar.get(Calendar.YEAR) %>年<%=calendar.get(Calendar.MONTH)+1 %>月<%=calendar.get(Calendar.DAY_OF_MONTH) %>日</td>
      	<td><%=Formater.formatAmount(joined.amount) %></td>
      </tr>
      <%} %>
    </table><br/>
	2.2 甲方加入本次服务计划后，将视为自动委托乙方代为理财，乙方将对甲方加入的服务计划金额按首次加入计划的时间先后顺序，在<%StringHelper.filterHTML(out, siteName); %>网站平台安排根据本协议及<%StringHelper.filterHTML(out, siteName); %>网站相关协议、规则进行优先自动投标。<br/>
    <h3>3. 服务计划具体内容和要求如下：</h3>
    3.1 名称： <%StringHelper.filterHTML(out, detail.title); %>（上下文均称"本次服务计划"）。<br/><br/>
    3.2 描述：甲方可以通过在<%StringHelper.filterHTML(out, siteName); %>网站操作确认加入理财计划等方式签署本协议，同时在签署本协议时不可撤销地委托并授权乙方及<%StringHelper.filterHTML(out, siteName); %>网站代甲方根据网站有关规则并通过自动系统进行优先投标，根据<%StringHelper.filterHTML(out, siteName); %>网站的相关协议及规则以包括但不限于原始出借或受让债权等方式对加入本次服务计划的资金进行出借和理财；并且在此过程中不可撤销地委托并授权乙方及<%StringHelper.filterHTML(out, siteName); %>网站代甲方签署电子合同形式的相关协议并收付、划扣有关款项。甲方加入本次服务计划后，在锁定期内，加入服务计划的金额将被优先安排自动投标，乙方及<%StringHelper.filterHTML(out, siteName); %>网站将按照计划预期的年收益率每月自动将相应收益返至用户平台账户。锁定期结束，甲方加入计划的全部本金以及最后一期收益将会一次性返至平台账户。<br/><br/>
    3.3 加入金额要求：最低加入金额为人民币【<%=Formater.formatAmount(detail.low) %>】元，并以人民币【<%=Formater.formatAmount(detail.low) %>】元整数倍递增，最高不超过人民币【<%=Formater.formatAmount(detail.upper) %>】元。<br/><br/>
    3.4 申请期：自【<%=DateParser.format(detail.sqks) %>】至【<%=DateParser.format(detail.sqjs) %>】。<br/><br/>
    3.5 锁定期：自首次计划加入日期至【<%=DateParser.format(detail.lcjs) %>】。锁定期内，甲方加入的服务计划金额不能转让或提现。<br/><br/>
    3.6 计划截止：锁定期结束日中午12:00。<br/><br/>
    3.7 退出情形：锁定期内甲方不可将本次服务计划金额提前退出。计划截止，用户加入某计划的全部本金以及最后一期利息收益将全部自动返至用户平台账户。<br/><br/>
    3.8 退出方式：退出时，用户加入某计划的全部本金以及最后一期利息收益将全部返至用户平台账户。（回款总额=加入本金+最后一期利息收益-退出费用）。<br/><br/>
    3.9 甲方收益及支付：甲方的收益将按照计划预期年收益以及每月返息，计划截止还本的方式，自动返至用户平台账户。<br/><br/>
    3.10 相应费用：甲方以服务计划金额的<%=Formater.formatRate(detail.jrfl) %>向乙方支付咨询费，乙方将另行收取，不在本次服务计划金额中扣除；甲方以本次计划所投标的利息收入的<%=Formater.formatRate(detail.fwfl) %>向乙方支付管理服务费，从甲方利息中扣除；甲方退出时，按退出服务计划金额<%=Formater.formatRate(detail.tcfl) %>向乙方支付退出费用。以上费用的收取和支付方式按<%StringHelper.filterHTML(out, siteName); %>网站有关规则执行。<br/><br/>
    <h3>4. 服务计划保障</h3>
    4.1 为降低甲方因投资标的过于集中而所带来的信用违约风险，乙方将对甲方加入本次服务计划金额根据网站有关规则安排分散化的优先自动投标。<br/><br/>
    4.2 为保证本次服务计划的及时性，在计划额满后，开始为甲方加入计划金额安排优先投标。<br/><br/>
    4.3 为增加投标的优先性，乙方将为甲方加入的服务计划金额安排优先自动投标，保障甲方加入计划金额可以通过<%StringHelper.filterHTML(out, siteName); %>网站系统优先进行自动投标。
    <h3>5. 意外事件</h3>
    5.1 如因司法机关或行政机关对甲方采取强制措施导致其本次服务计划金额对应的资金被全部或部分扣划，视为甲方提前退出本次服务计划并就全部本息进行了提前支取，本协议自动终止。本协议因此而自动终止的，甲方将不再享有相应收益。
    <h3>6. 税费</h3>
    6.1 甲方承担本服务计划所获收益的应纳税额。
    <h3>7. 甲方声明和保证</h3>
    7.1 在签署本协议书以前，乙方已就本协议书及有关交易文件的全部条款和内容向甲方进行了详细的说明和解释，甲方已认真阅读本协议有关条款，对有关条款不存在任何疑问或异议，并对协议双方的权利、义务、责任与风险有清楚和准确的理解。<br/><br/>
    7.2 甲方保证所使用的资金为合法取得，且具有排他性的支配权。<br/><br/>
    7.3 甲方保证为履行本协议而向乙方提供的全部资料均真实、有效。
    <h3>8. 其他</h3>
    8.1 本次服务计划不提供纸质账单。甲方需要通过<%StringHelper.filterHTML(out, siteName); %>网站或客服人员、网站平台查询等方式了解相关信息。如未及时查询，或由于通讯故障、系统故障以及其他不可抗力等因素影响使甲方无法及时了解相关信息，由此产生的责任和风险由甲方自行承担。<br/><br/>
    8.2 本次服务计划并非独立于甲方在注册、使用<%StringHelper.filterHTML(out, siteName); %>网站时需要遵守的相应规则和订立的相关协议。甲方必须遵守<%StringHelper.filterHTML(out, siteName); %>的相关规则和签署的相关协议，如违背的，将自行承担相应后果。<br/><br/>
    8.3 由于地震、火灾、战争、电力中断、黑客攻击、计算机病毒、系统或网络故障等不可抗力导致的交易中断、延误的，甲乙双方互不追究责任。但应在条件允许的情况下，应采取一切必要的补救措施以减小不可抗力造成的损失。<br/><br/>
    8.4 本次服务计划内，如甲方追加服务计划金额，则甲方与乙方之间的权利义务约定及甲方加入本次服务计划的总金额应以最后生成的协议书所约定的内容为准。<br/><br/>
    8.5 本协议项下产生的纠纷，双方先行协商解决，协商不成的，任何一方可向乙方所在地法院提起诉讼。<br/><br/>
    8.6 本协议自甲方在<%StringHelper.filterHTML(out, siteName); %>网站操作确认并成功加入本次服务计划时生效。本协议采用电子文本形式制成，可以有一份或者多份并且每一份具有同等法律效力，并永久保存在乙方为此设立的专用服务器上备查，对各方均具有法律约束力。<br/><br/>
    <%
    	Calendar cal = Calendar.getInstance();
    	cal.setTimeInMillis(detail.mesj.getTime());
    %>
    <p class="tr"><%=cal.get(Calendar.YEAR) %>年<%=cal.get(Calendar.MONTH)+1 %>月<%=cal.get(Calendar.DAY_OF_MONTH) %>日</p>
  </div>
</div>
</body>
</html>