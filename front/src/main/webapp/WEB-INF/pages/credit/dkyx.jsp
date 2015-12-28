<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.Region"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidWillManage"%>
<%@page import="com.dimeng.p2p.common.enums.IntentionType"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.Dkyx"%>
<%-- <%@include file="/WEB-INF/include/authenticatedSession.jsp" %> --%>
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>

<%@include file="/WEB-INF/include/style.jsp"%>
<link href="<%=controller.getStaticPath(request)%>/css/style_sx.css" rel="stylesheet" type="text/css">

</head>
<%
String ermsg = controller.getPrompt(request, response,PromptLevel.ERROR);

%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<!--内容-->
<!--banner-->
<div class="jk_banner">
</div>
<!--banner-->
<!--借款类型-->
<div class="sx_overlay"></div>
<div class="sx_popupbox">
   <div class="sx_close"></div>
   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="sx_pop_tab">
  <tr>
    <td width="15%" align="right"><span>申请条件：</span></td>
    <td width="85%">针对个人或公司名下的车辆（小轿车）自愿将车辆做抵押借款的客户。年龄须大于等于18周岁，且具备完全民事行为能力，同时借款人实际年龄与借款年限相加不得大于60。
</td>
  </tr>
  <tr>
    <td align="right"><span>放款原则：</span></td>
    <td>放款原则：客户的借款金额不超过现车评价的七成，原则上评估价在八万元以下的车辆不予借款。全款车借款不超过车价的60%。</td>
  </tr>
  <tr>
    <td align="right"><span>所需资料：</span></td>
    <td>1、二代身份证（非本地户籍需同时提供居住证）户口本，结婚证；<br />
2、借款人本人的银行借记卡，二周内的个人征信报告；<br />
3、机动车登记证（本地车管所核发的正式机动车登记证）；<br />
4、机动车行驶证（本地车管所核发的正式机动车行驶证）；<br />
5、车辆商业保险全险保单（必须在有效期内）交强险保单；<br />
6、购车发票，车辆照片；<br />
7、对公或对私银行流水（3—6个月）<br />
8、工作证明/收入证明<br />
</td>
  </tr>
  <tr>
    <td align="right"><span>公司押车资料另需：</span></td>
    <td>1、单位证明（盖公章）<br />
2、营业执照复印件（盖公章）<br />
3、法人授权委托证明书<br />
4、组织机构代码证<br />
5、法人身份证<br />
6、机动车变更、过户、审批申请表（盖公章）
</td>
  </tr>
</table>  
<a href="#sx_load_info" class="sx_bluebt1">申请借款</a>     
</div>
<!--借款申请流程-->
<div style="background:#edeeef">
	<div class="w1002 pt30">
    	<div class="jk_title">借款申请流程</div>
        <div class="sx_load_ctbox">
   <ul>
     <li>
        <div class="sx_load_icon sxLoad1"></div>
        <div class="sx_load_text">
          <h1>1.提交借款申请</h1>
          <p>借款人尽量详细填写申请表中<br />的相关信息并在线提交借款申请</p>
        </div>
     </li>
     <li>
        <div class="sx_load_icon sxLoad2"></div>
        <div class="sx_load_text">
          <h1>2.初步审核</h1>
          <p>审核部门将在三个工作日内完成第一步审核<br />（如通过将以电话或邮件形式通知）</p>
        </div>
     </li>
     <li>
        <div class="sx_load_icon sxLoad3"></div>
        <div class="sx_load_text">
          <h1>3.进行复审</h1>
          <p>如通过初审，将预约您带齐相关资料<br />到善行创投进行复审</p>
        </div>
     </li>
     <li>
        <div class="sx_load_icon sxLoad4"></div>
        <div class="sx_load_text">
          <h1>4.登门核实</h1>
          <p>如通过复审，将前往您提供的抵押物<br />所在地进行现场复核与评估</p>
        </div>
     </li>
     <li>
        <div class="sx_load_icon sxLoad5"></div>
        <div class="sx_load_text">
          <h1>5.办理手续</h1>
          <p>如通过复核，将签署抵押及保证合同并前往<br />公证处办理相关手续</p>
        </div>
     </li>
     <li>
        <div class="sx_load_icon sxLoad6"></div>
        <div class="sx_load_text">
          <h1>6.项目发标</h1>
          <p>借款手续全部完成后，将在网站上<br />发布你的借款标</p>
        </div>
     </li>
   </ul>
   <div class="clear"></div>
</div>
    </div>
</div>
<!--借款申请流程-->

<!--快速提交借款信息-->
<div style="background:#fff; padding-top:0" class="all100" id="sx_load_info">
<form action="<%=controller.getURI(request, Dkyx.class)%>" id="form1" class="form1" method="post">
	<div class="w1002 pt30">
    	<div class="jk_title">借款申请流程</div>
    	<span id="message" style="color: red;"><%StringHelper.filterHTML(out, ermsg);%></span>
        <div class="jk_li">
        	<ul>
            <li>
            	<div class="f18 mb10 orange">1.填写个人资料</div>   
                <div>姓名</div>
                <div class="mt10"><input name="" type="text" value="" class="sx_inp"/></div>
                <div class="mt15">联系电话</div>
                <div class="mt10"><input name="" type="text" class="sx_inp" value=""/></div>
		<div class="mt15">借款类型<span class="ml20"><input checked="checked" name="daikuanway" type="radio" value="" class="mr5 F03" />个人</span><span class="ml15"><input name="daikuanway" type="radio" onclick="jk(3)" value="" class="mr5" />企业</span></div>
                <div class="mt15"><span style="margin-left:28px;">性别</span><span class="ml20"><input name="sex" checked="checked" type="radio" value="" class="mr5" />男</span><span class="ml15"><input name="sex" type="radio" value="" class="mr5" />女</span></div>
                <div class="mt15">年龄（岁）</div>
                <div class="mt10"><input name="" type="text" class="sx_inp" value=""/></div>
            </li>
            
            <li class="middle">
            	<div class="f18 mb10 orange">2、填写借款需求</div>
                <div>联系人</div>
                <div class="mt10">
                  <input name="F03" type="text" class="required sx_inp" />
                  <p tip>不超过32个字</p>
			      <p errortip class="" style="display: none"></p>
                </div>
                <div class="mt15">手机号码</div>
                <div class="mt10">
                   <input name="F04" type="text" class="required sx_inp" />
                   <p tip></p>
			       <p errortip class="" style="display: none"></p>
                </div>
                <div class="mt15">意向借款金额</div>
                <div class="mt10">
                  <input name="F06" type="text" class="required sx_inp" />元
                 <p tip></p>
			     <p errortip class="" style="display: none"></p>
                </div>
                <div class="mt15">借款类型</div>
                  <div class="mt10">
                    <input type="checkbox" name="F15" class="mr5" value="S"/>抵押
                    <input type="checkbox" name="F16" class="mr5" value="S"/>实地认证
                    <input type="checkbox" name="F17" class="mr5" value="S"/>担保
                    </div>
            </li>
            <li style="margin-right:0">
            	<div class="f24 mb10">3、填写抵押物资料</div>
                <div>所在城市</div>
                <div class="mt10">
                 <select name="sheng" style="width:83px;" class="sx_inp2">
				</select> 
				<select name="shi" style="width:83px;" class="sx_inp2">
				</select>
				<select name="xian" style="width:83px;" class="required sx_inp2">
				</select>
				 <p tip></p>
			    <p errortip class="" style="display: none"></p> 
				</div>
                <div class="mt15">预期筹款期限</div>
                <div class="mt10">
                  <select name="F09" class="sx_inp" style="width:260px;">
                    <option value=" ">全部</option>
                    <option value="7天之内">7天之内</option>
                    <option value="15天之内">15天之内</option>
                    <option value="15-30天">15-30天</option>
                    <option value="1-3个月">1-3个月</option>
                    <option value="其他期限">其他期限</option>
                  </select>
                </div>
                
                
                <div class="mt15">借款描述</div>
                <div class="mt10">
                  <textarea name="F10" cols="" rows="" style="height:120px;" class="area required min-length-20 max-length-500 sx_inp" placeholder="输入20-500个字"></textarea>
                  <p tip></p>
			      <p errortip class="" style="display: none"></p>
                </div>
            </li>
            </ul>
        </div>
        <div class="clear"></div>
        <div style="width:260px; margin:auto;">
            <input type="submit" class="jk_btn  sumbitForme" fromname="form1"  value="提交申请"/>
        </div>   
              
    </div>
    </form>
</div>
<!--快速提交借款信息-->

<!--相关问题答疑-->
<div style="background:#e3e3e3; padding-top:0" class="all100">
  <div class="w1002 pt30">
        <div class="jk_faq_icon"></div>
    	<div class="jk_title">相关问题答疑</div>
        <div class="jk_problem">
        	<ul>
            <li>
            <div class="ico_wen">为什么只受理广东本地借款申请？</div>
            <div class="ico_da">由于善行创投的性质属于为投资人与融资方搭建提供保障服务的平台，其核心竞争力还是控制风险的能力，为让自身的本金保障承诺具备可行性，更好的控制资金风险，我们目前只受理广东本地三个区的借款申请，后期将根据业务发展情况，在其他城市开发借款服务，请关注公告。</div>
            </li>
            <li class="jk_sx_pl">
            <div class="ico_wen">提交借款申请后会有人跟我联系吗？</div>
            <div class="ico_da">由于审核部门每天要对大量的借款信息做审核工作，因此我们仅对通过初审的借款申请进行电话回访，并告知接下来的借款流程。</div>
            </li>
            <li>
            <div class="ico_wen">借款资金由善行创投提供吗？</div>
            <div class="ico_da">善行创投只为投资人与融资方搭建提供保障服务的平台，本身并不提供任何资金，所有资金均来自善行创投的注册投资理财用户。</div>
            </li>
            <li class="jk_sx_pl">
            <div class="ico_wen">如何申请成为出资人?</div>
            <div class="ico_da">注册账户即可成为投资者，完成账户充值即可立即开始投资历程。</div>
            </li>	
            </ul>
            <div class="clear"></div>
        </div>
    <div class="clear"></div>
	</div>
	

		<a href="<%configureProvider.format(out,URLVariable.CREDIT_CENTER);%>"><span id="indexBtn"></span></a>
		<a href="<%configureProvider.format(out,URLVariable.CREDIT_QYDKYX);%>#sx_load_info"><span id="qydkyxBtn"></span></a>
</div>
<!--相关问题答疑-->

<!--内容-->
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
 	<script type="text/javascript">
 	var msg=$("#message").text();
 	if(msg!=""){
 		$("#message").text("");
 		alert(msg);
 	}
 	function jk(key){
		switch (key) {
        case 1:
        	$("#indexBtn").click();
			break;
        case 3:
        	$("#qydkyxBtn").click();
			break;
		}
	} 
	</script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript" src="<%=controller.getURI(request, Region.class)%>"></script>
	
</body>
</html>
