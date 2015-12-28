<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.Region"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidWillManage"%>
<%@page import="com.dimeng.p2p.common.enums.IntentionType"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.Dkyx"%>
<%@page  import="com.dimeng.p2p.account.front.service.UserManage"%>
<%@page import="com.dimeng.p2p.S61.entities.Rewarduser"%>
<%@page import="java.util.List"%>
<%-- <%@include file="/WEB-INF/include/authenticatedSession.jsp" %> --%>
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/inside.css" />
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
<style type="text/css">
body { margin:0px; padding:0px; font-size:14px; line-height:25px; font-family:"Microsoft YaHei",Arial;color:#646464;overflow-x:hidden;}
dl,dd,h1,h2,h3,h4,h5,h6,form,p { padding:0; margin:0;}
ul {list-style-type:none; padding:0; margin:0px;}
img { border:0px;}
table {padding:0; margin:0; border:0;}
.cl { clear:both;}
.width1920 { width:1920px; overflow:hidden; margin:0 auto;}
.width1200 { width:1200px; overflow:hidden; margin:0 auto;}
.content_01 { background:#f9f9f9;overflow:hidden;}
.content_02 { background:#fce9d2;overflow:hidden;}
.content_03 { background:#ddfffa;overflow:hidden;}
.content_04 { background:#fffcd9;overflow:hidden;}
.content_01 .content_tit { margin-top:70px;}
.content_01 .content_tit img { margin-left:70px;}
.content_01 .alist { margin-top:30px;}
.content_01 .alist ul li { float:left; width:176px; height:176px; margin-left:80px;}
.content_01 .cfp { margin-top:40px; padding:20px 0px 20px 100px; border-top:solid 1px #e0e0e0;}
.content_01 .ttable { margin-top:50px;}
.ttable .td1 { background:#ff6400; border:solid 1px #c84e00; border-right:none; color:#fff; font-size:16px;}
.ttable .td2 { background:#ff6400; border:solid 1px #c84e00; color:#fff; font-size:16px;}
.ttable .td3 { background:#ffeadc; border-left:solid 1px #c84e00; border-bottom:solid 1px #c84e00; color:#323232;}
.ttable .td4 { background:#ffeadc; border:solid 1px #c84e00; border-top:none; color:#323232;}
.cottp { float: left; width:400px;}
.content_02 .cottp img { margin:30px 0;}
.content_02 .cotlr { float: left;width:700px; margin-left:100px; padding-top:150px;}
.content_03 .cottp img { margin-top:200px;}
.content_03 .cotlr { float: left;width:750px; margin-right:50px; padding:60px 0;}
.cottit { width:270px; height:65px; text-align:center;border-radius:50px; font-size:38px; line-height:65px; color:#fff;}
.content_04 .cottp img { margin:30px 0 80px;} 
.content_04 .cotlr { float: left;width:700px; margin-left:100px; padding-top:80px;}
.yellow { border:solid 1px #ff6400; background:#ff6400; }
.green { border:solid 1px #05937d; background:#05937d; }
.beige { border:solid 1px #b78a00; background:#b78a00; }
a.blue2 {border:solid 1px #65caff; background:#65caff; color:#fff; display:inline-block; font-size:24px; line-height:24px; padding:10px 30px; border-radius:30px; float:right; }
a.blue2:hover {border:solid 1px #8be0ff; background:#8be0ff;}
  .header h1{font-size:32px;color:#fe6400;background-color:#fff;width:500px;height:57px;line-height:57px;text-align:center;position:absolute;top: 390px;left:530px;}
.alist li p{  width: 176px;text-align: center;margin-top: -45px;  font-size: 16px;font-weight: bold;}
  </style>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
    <div class="header width1920"><img src="/images/tp_01.jpg"/><h1>风&nbsp;险&nbsp;有&nbsp;控&nbsp;制&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;资&nbsp;金&nbsp;有&nbsp;托&nbsp;管</h1></div>
<div class="content_01">
  <div class="width1200"> 
  <div class="content_tit"><img src="/images/tp_11.jpg"/></div>
  <p style="margin-top:50px; font-size:16px;">善行宝是一款专为中小投资者设计投资门槛低、风险低、收益高的定期类的 “梦想”理财产品，每月付息到期还本。投资人投资生成的合同借款方都经过严格的信息认证和信用考核，每期产品都具有实物抵押或机构担保。</p>
  <p style="margin-top:50px; font-size:18px; color:#ff6400;">它有四个特点：</p>
  <div class="alist">
    <ul>
      <li><img src="/images/tp_02.jpg"/><p >年化率高达15%</p></li>
      <li><img src="/images/tp_03.jpg"/><p>100元即可投资</p></li>
      <li><img src="/images/tp_04.jpg"/><p>资金第三方托管</p></li>
      <li><img src="/images/tp_05.jpg"/><p>债权转让</p></li>
    </ul>
  </div>
  <div class="cl"></div>
  <div class="cfp"><a href="/financing/sxbao/list.html" class="blue2" >立即购买</a></div>
  <div class="ttable">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="20%" height="40" class="td1" align="center">理财产品</td>
        <td width="20%" height="40" class="td1" align="center">期限（定期）</td>
        <td width="20%" height="40" class="td1" align="center">年收益率</td>
        <td width="20%" height="40" class="td1" align="center">最低投资金额</td>
        <td width="20%" height="40" class="td2" align="center">还款方式</td>
      </tr>
      <tr>
        <td width="20%" height="40" class="td3" align="center">善行宝A</td>
        <td width="20%" height="40" class="td3" align="center">一个月</td>
        <td width="20%" height="40" class="td3" align="center">7.2%</td>
        <td width="20%" height="40" class="td3" align="center">100元</td>
        <td width="20%" height="40" class="td4" align="center">一次性还款</td>
      </tr>
      <tr>
        <td width="20%" height="40" class="td3" align="center">善行宝B</td>
        <td width="20%" height="40" class="td3" align="center">三个月</td>
        <td width="20%" height="40" class="td3" align="center">9%</td>
        <td width="20%" height="40" class="td3" align="center">100元</td>
        <td width="20%" height="40" class="td4" align="center">每月付息到期还本</td>
      </tr>
      <tr>
        <td width="20%" height="40" class="td3" align="center">善行宝C</td>
        <td width="20%" height="40" class="td3" align="center">六个月</td>
        <td width="20%" height="40" class="td3" align="center">10%</td>
        <td width="20%" height="40" class="td3" align="center">100元</td>
        <td width="20%" height="40" class="td4" align="center">每月付息到期还本</td>
      </tr>
      <tr>
        <td width="20%" height="40" class="td3" align="center">善行宝D</td>
        <td width="20%" height="40" class="td3" align="center">十二个月</td>
        <td width="20%" height="40" class="td3" align="center">13%</td>
        <td width="20%" height="40" class="td3" align="center">100元</td>
        <td width="20%" height="40" class="td4" align="center">每月付息到期还本</td>
      </tr>
    </table>
  </div><br />
  <p></p>
  <div class="content_tit"><img src="/images/tp_12.jpg"/></div>
  <p style="margin-top:50px; margin-bottom:50px; font-size:16px;">用户投资到善行宝的资金，被分散化投资于优质渠道机构提供的贷款项目中，通过极致分散的投资方式，充分降低用户的投资风险。并且，渠道机构将对客户的投
资承担本息有保障，如果原始借款人无法按期偿付本息，将由渠道机构自动代偿。</p>
  </div>
</div>
<div class="content_02">
  <div class="width1200">
  <div class="cottp"><img src="/images/tp_07.jpg"/></div>
  <div class="cotlr">
    <div class="cottit yellow">合作渠道</div>
    <p style="margin-top:50px; font-size:16px;">平台汇集了供应链金融，融资租赁，有牌照的小贷公司，融资性担保公司，典当行
等类金融机构，以及行业协会，专业市场，全国性交易市场，大型工业园区等各类
渠道资源。</p>
  </div>
  </div>
</div>
<div class="content_03">
  <div class="width1200">
  <div class="cotlr">
    <div class="cottit green">审核机制</div>
    <p style="margin-top:30px; font-size:18px;color:#03836f;"><b>第一重 &nbsp;渠道商做一次风控，渠道商及渠道法人代表承担连带责任担保</b></p>
    <p style="margin-top:10px; font-size:16px;color:#03836f;">渠道商实地审核每笔贷款均经过以下流程对借款人资质进行严格审核。</p>
    
    <p style="margin-top:30px; font-size:18px;color:#03836f;"><b>第二重  &nbsp;善行创投平台二次风控，专职会计师对项目进行审计并提供平台风险保证金分散风险</b></p>
    <p style="margin-top:15px; font-size:16px;color:#03836f;">善行创投精挑细选</p>
    <p style="line-height:20px;">善行创投会从渠道商提供的贷款项目中选择已按时完成3期以上的还本付息优质客户做为善行宝精选资产，并在
每个月对借款户还款情况进行跟踪核实。</p>

    <p style="margin-top:15px; font-size:16px;color:#03836f;">优秀的风控团队</p>
    <p style="line-height:20px;">善行创投建立了健全的《风控管理制度》。
贷前调查—贷时审查—贷后检查的原则，专业的的业务流程和操作规范，切实加强贷款管理，有效地规避风险。</p>
    <p style="margin-top:15px; font-size:16px;color:#03836f;">健全的法务部</p>
    <p style="line-height:20px;">按照善行创投贷款审批流程，严格管理执行风险控制方案，谨慎签署风险报告文书；
法务部与律师事务所（广东纳德律师事务所）建立战略合作关系。</p>
    <p style="margin-top:15px; font-size:16px;color:#03836f;">透明化财务活动</p>
    <p style="line-height:20px;">按照国家有关规定建立健全《企业财务会计制度》，真实记录和全面反映善行创投业务活动和财务活动。</p>
    <p style="margin-top:20px;"><img src="/images/tp_10.jpg"/></p>
  </div>
  <div class="cottp"><img src="/images/tp_08.jpg"/></div>
  
  </div>
</div>
<div class="content_04">
  <div class="width1200">
  <div class="cottp"><img src="/images/tp_09.jpg"/></div>
  <div class="cotlr">
    <div class="cottit beige">收益提现</div>
    <p style="margin-top:30px; font-size:22px;color:#b78a00;">收益计算</p>
    <p style="margin-top:10px; font-size:16px;">收益 = 本金 * 预期年化收益率 / 12 * 实际投资月数</p>
    <p style="margin-top:30px; font-size:22px;color:#b78a00;">提现费用</p>
    <p style="margin-top:10px; font-size:16px; margin-bottom:50px;">1.最少提现金额100元。</br>
2.收取提现金额的0.25%作为提现费（此部分为第三方支付平台收取的费用）。</br>
3.提现费用最低2元每笔（此部分为第三方支付平台收取的费用）。</br>
4.提现费用从账户余额中扣除，账户余额不足的从提现资金中扣除。</br>
  </div>
  </div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
