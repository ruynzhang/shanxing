<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.agreement.Zqzr"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.ZqzrInfo"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.ZqzrCreditDetail"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.ZqzrUser"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.AgreementManage"%>
<%@page import="java.util.Calendar"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"></meta>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/other.css" />
<title>协议_债权转让</title>
</head>
<body style="width:900px; margin:0 auto;font-size:14px;">
<%
	int zcid = IntegerParser.parse(request.getParameter("id"));
	if(zcid <= 0){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}
	AgreementManage manage = serviceSession.getService(AgreementManage.class);
	ZqzrUser zcz = manage.getZcz(zcid);
	ZqzrUser zrz = manage.getZrz(zcid);
	ZqzrCreditDetail creditDetail = manage.getZqzrCreditDetail(zcid);
	ZqzrInfo info = manage.getZqzrInfo(zcid);
	if(zcz == null || zrz == null || creditDetail == null || info == null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}
	String siteName = configureProvider.getProperty(SystemVariable.SITE_NAME);
%>
<div class="protocol">
	<%if(1 != IntegerParser.parse(request.getParameter("s"))){ %>
	  <p class="clearfix pt10"><a href="<%=controller.getURI(request, Zqzr.class)%>?id=<%=zcid%>&s=1" class="btn btn01 fr">点击下载</a></p>
	<%} %>
  <div class="tit">
     <h2><strong>债权转让及受让协议</strong></h2>
     <p class="tr">编号：ZR-<%=zcid %></p>
  </div>
<div class="con">  
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本债权转让及受让协议（下称“本协议”）由以下双方于签署：</p>
    <div class="tab_one mt10 mb10"><table width="80%">
          <tr>
            <td><strong>甲方（转让人）：<%StringHelper.filterHTML(out, zcz.name); %></strong></td>
            <td>&nbsp;</td>
            <td><strong>乙方（受让人）：<%StringHelper.filterHTML(out, zrz.name); %></strong></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>身份证号：</td>
            <td><i><%StringHelper.filterHTML(out, zcz.identifyId); %></i></td>
            <td>身份证号：</td>
            <td><i><%StringHelper.filterHTML(out, zrz.identifyId); %></i></td>
          </tr>
          <tr>
            <td><%StringHelper.filterHTML(out, siteName); %>用户名： </td>
            <td><i><%StringHelper.filterHTML(out, zcz.account); %></i></td>
            <td><%StringHelper.filterHTML(out, siteName); %>用户名： </td>
            <td><i><%StringHelper.filterHTML(out, zrz.account); %></i></td>
          </tr>
     </table></div>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本债权转让及受让协议（下称“本协议”）由以下双方于签署：就甲方通过深圳市迪蒙网络科技有限公司（以下“<%StringHelper.filterHTML(out, siteName); %>”系指深圳市迪蒙网络科技有限公司和下述<%StringHelper.filterHTML(out, siteName); %>网站的统称）运营管理的<%StringHelper.filterHTML(out, configureProvider.getProperty(SystemVariable.SITE_DOMAIN)); %>网站（下称“<%StringHelper.filterHTML(out, siteName); %>网站”）向乙方转让债权事宜，双方经协商一致，达成如下协议：<br/>
   <h3>1. 债权转让</h3>
   1.1 标的债权信息及转让<br/>
    甲方同意将其通过<%StringHelper.filterHTML(out, siteName); %>的居间协助而形成的有关债权（下称“标的债权”）转让给乙方，乙方同意受让该等债权。标的债权具体信息如下：<br/>
    <strong>标的债权信息：</strong>
    <table width="80%" class="tab_two">
      <tr>
      	<td width="31%">借款ID</td>
      	<td><%=creditDetail.id %></td>
      </tr>
      <tr>
      	<td>借款人姓名</td>
      	<td><%StringHelper.filterHTML(out, creditDetail.bName); %></td>
      </tr>
      <tr>
      	<td>借款本金数额</td>
      	<td>¥ <%=Formater.formatAmount(creditDetail.amount) %></td>
      </tr>
      <tr>
      	<td>借款年利率</td>
      	<td><%=Formater.formatRate(creditDetail.rate) %></td>
      </tr>
      <%
      	Calendar c1 = Calendar.getInstance();
     	c1.setTimeInMillis(creditDetail.startDate.getTime());
     	Calendar c2 = Calendar.getInstance();
     	c2.setTimeInMillis(creditDetail.endDate.getTime());
      %>
      <tr>
      	<td>原借款期限</td>
      	<td><%=creditDetail.limitMonth %>个月，<%=c1.get(Calendar.YEAR) %>年<%=c1.get(Calendar.MONTH)+1 %>月<%=c1.get(Calendar.DAY_OF_MONTH) %>日起，
      	至<%=c2.get(Calendar.YEAR) %>年<%=c2.get(Calendar.MONTH)+1 %>月<%=c2.get(Calendar.DAY_OF_MONTH) %>日止</td>
      </tr>
      <tr><td>月偿还本息数额</td><td>¥ <%=Formater.formatAmount(creditDetail.monthAmount) %></td></tr>
      <tr><td>还款日</td><td>自<%=c1.get(Calendar.YEAR) %>年<%=c1.get(Calendar.MONTH)+1 %>月<%=c1.get(Calendar.DAY_OF_MONTH) %>日起，每月 <%=c1.get(Calendar.DAY_OF_MONTH) %>日（24:00前，节假日不顺延）</td></tr>
    </table>
    <strong><br/>标的债权转让信息</strong>
    <table width="80%" class="tab_two">
      <tr>
      	<td width="31%">标的债权价值</td>
      	<td width="69%"><%=Formater.formatAmount(info.zqjz) %></td>
      </tr>
      <tr>
      	<td>转让价款</td>
      	<td><%=Formater.formatAmount(info.zrjk) %></td>
      </tr>
      <tr>
      	<td>转让管理费</td>
      	<td><%=Formater.formatAmount(info.zrglf) %></td>
      </tr>
      <%
      	Calendar c3 = Calendar.getInstance();
      	c3.setTimeInMillis(info.zrsj.getTime());
      %>
      <tr>
      	<td>转让日期</td>
      	<td><%=c3.get(Calendar.YEAR) %>年<%=c3.get(Calendar.MONTH)+1 %>月<%=c3.get(Calendar.DAY_OF_MONTH) %>日</td>
      </tr>
      <tr>
      	<td>剩余还款分期月数</td>
      	<td><%=info.syqs %>个月，<%=c3.get(Calendar.YEAR) %>年<%=c3.get(Calendar.MONTH)+1 %>月<%=c3.get(Calendar.DAY_OF_MONTH) %>日起，
      	至<%=c2.get(Calendar.YEAR) %>年<%=c2.get(Calendar.MONTH)+1 %>月<%=c2.get(Calendar.DAY_OF_MONTH) %>日止</td>
      </tr>
    </table><br/>
    1.2 债权转让流程<br/>
    1.2.1 双方同意并确认，双方通过自行或授权有关方根据<%StringHelper.filterHTML(out, siteName); %>网站有关规则和说明，在<%StringHelper.filterHTML(out, siteName); %>网站进行债权转让和受让购买操作等方式确认签署本协议。<br/>
    1.2.2 双方接受本协议且<%StringHelper.filterHTML(out, siteName); %>审核通过时，本协议立即成立,并待转让价款支付完成时生效。协议成立的同时甲方不可撤销地授权<%StringHelper.filterHTML(out, siteName); %>自行或委托第三方支付机构或合作的金融机构，将转让价款在扣除甲方应支付给<%StringHelper.filterHTML(out, siteName); %>的转让手续费之后划转、支付给乙方，上述转让价款划转完成即视为本协议生效且标的债权转让成功；同时甲方不可撤销地授权<%StringHelper.filterHTML(out, siteName); %>将其代为保管的甲方与标的债权借款人签署的电子文本形式的《借款协议》（下称“借款协议”）及借款人相关信息在<%StringHelper.filterHTML(out, siteName); %>网站有关系统板块向乙方进行展示。<br/>
	1.2.3 本协议生效且标的债权转让成功后，双方特此委托<%StringHelper.filterHTML(out, siteName); %>将标的债权的转让事项及有关信息通过站内信等形式通知与标的债权对应的借款人。<br/><br/>
	1.3 自标的债权转让成功之日起，乙方成为标的债权的债权人，承继借款协议项下出借人的权利并承担出借人的义务。
    <h3>2. 保证与承诺</h3>
    2.1 甲方保证其转让的债权系其合法、有效的债权，不存在转让的限制。甲方同意并承诺按有关协议及<%StringHelper.filterHTML(out, siteName); %>网站的相关规则和说明向<%StringHelper.filterHTML(out, siteName); %>0支付债权转让管理费。<br/><br/>
	2.2 乙方保证其所用于受让标的债权的资金来源合法，乙方是该资金的合法所有人。如果第三方对资金归属、合法性问题发生争议，乙方应自行负责解决并承担相关责任。<br/>
    <h3>3. 违约</h3>
    3.1 双方同意，如果一方违反其在本协议中所作的保证、承诺或任何其他义务，致使其他方遭受或发生损害、损失等责任，违约方须向守约方赔偿守约方因此遭受的一切经济损失。<br/><br/>
    3.2 双方均有过错的，应根据双方实际过错程度，分别承担各自的违约责任。
    <h3>4. 适用法律和争议解决</h3>
    4.1 本协议的订立、效力、解释、履行、修改和终止以及争议的解决适用中国的法律。<br/><br/>
    4.2 本协议在履行过程中，如发生任何争执或纠纷，双方应友好协商解决；若协商不成，任何一方均有权向有管辖权的人民法院提起诉讼。
    <h3>5. 其他</h3>
    5.1 双方可以书面协议方式对本协议作出修改和补充。经过双方签署的有关本协议的修改协议和补充协议是本协议组成部分，具有与本协议同等的法律效力。<br/><br/>
    5.2 本协议及其修改或补充均通过<%StringHelper.filterHTML(out, siteName); %>网站以电子文本形式制成，可以有一份或者多份并且每一份具有同等法律效力；同时双方委托<%StringHelper.filterHTML(out, siteName); %>代为保管并永久保存在<%StringHelper.filterHTML(out, siteName); %>为此设立的专用服务器上备查。双方均认可该形式的协议效力。<br/><br/>
    5.3 甲乙双方均确认，本协议的签订、生效和履行以不违反中国的法律法规为前提。如果本协议中的任何一条或多条违反适用的法律法规，则该条将被视为无效，但该无效条款并不影响本协议其他条款的效力。<br/><br/>
    5.4 除本协议上下文另有定义外，本协议项下的用语和定义应具有<%StringHelper.filterHTML(out, siteName); %>网站服务协议及其有关规则中定义的含义。若有冲突，则以本协议为准。
  </div>
</div>
</body>
</html>