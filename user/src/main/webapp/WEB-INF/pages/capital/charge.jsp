<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.S61.entities.T6101"%>
<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Unpay"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.TradingRecord"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Safetymsg"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Charge"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的<%configureProvider.format(out,SystemVariable.SITE_NAME);%>_充值管理
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
	
		UserInfoManage manage = serviceSession.getService(UserInfoManage.class);
		T6101 balance = manage.search();
		String type = ObjectHelper.convert(request.getAttribute("type"), String.class);
		String amount = ObjectHelper.convert(request.getAttribute("amount"), String.class);
		boolean smrz = manage.isSmrz();
		boolean txmm = manage.isTxmm();
		int _min = IntegerParser.parse(configureProvider.getProperty(SystemVariable.CHARGE_MIN_AMOUNT));
		int _max = IntegerParser.parse(configureProvider.getProperty(SystemVariable.CHARGE_MAX_AMOUNT));
		double _p = DoubleParser.parse(configureProvider.getProperty(SystemVariable.CHARGE_RATE));
		int _pMax = IntegerParser.parse(configureProvider.getProperty(SystemVariable.CHARGE_MAX_POUNDAGE));
		T6110 userInfo=	manage.getUserInfo(serviceSession.getSession().getAccountId());
		UserManage userManage = serviceSession.getService(UserManage.class);
		String usrCustId = userManage.getUsrCustId();
		boolean tg = BooleanParser.parse(configureProvider.getProperty(SystemVariable.SFZJTG));
		
		CURRENT_CATEGORY = "WDWDW";
		CURRENT_SUB_CATEGORY = "WDWDW";
	%>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<form action="<%=configureProvider.format(URLVariable.PAY_CHARGE)%>" target="_blank" method="post" onsubmit="return onSubmit();">
			<input name="paymentInstitution" value="HUICHAO" type="hidden">
			<div class="container fr bor1">
				<div class="p15">
				
					<%if(tg && StringHelper.isEmpty(usrCustId)){ %>
						<div class="f16 mt30 pt50 pb50 tc ml20 mr20 mb10" style="background:#f3f3f3;">
				            	 您需要在第三方托管平台上进行注册，才可申请充值提现！请<a target="_blank" href="/user/account/safetymsg2.html" class="red">立即注册</a>！
				        </div>
					<%} else { %>
					<%-- <div class="user_lsjt mb20">
						选择充值方式
						<a class="fr f14" href="<%=controller.getViewURI(request, Unpay.class) %>">查询末完成充值记录&gt;&gt;</a>
					</div>
					<ul class="cz_li mb30">
						<li>
						<label>
							<input name="paymentInstitution" type="radio" value="ALLINPAY" <%if(!"ALLINPAY".equals(type)){ %>checked="checked"<%} %> class="mr10" />
							<img src="<%=controller.getStaticPath(request) %>/images/logo_01.jpg" width="148" height="38" class="border mr20" />
						</label>
						</li>
						<li>
						<label>
							<input name="paymentInstitution" type="radio" value="SHUANGQIAN" <%if("SHUANGQIAN".equals(type)){ %>checked="checked"<%} %> class="mr10" />
							<img src="<%=controller.getStaticPath(request) %>/images/logo_02.jpg" width="148" height="38" class="border mr20" />
						</label>
						</li>
						<div class="clear"></div>
					</ul>	 --%>
					<div class="user_lsjt mb15">填写充值金额<a class="fr f14" href="<%=controller.getViewURI(request, Unpay.class) %>">查询未完成充值记录&gt;&gt;</a>
					</div>
					<div class="bom mb20" style="border:none;">
						<ul class="noborder" >
							<li>
								<div class="til">可用金额：</div>
								<div class="info">
									<span class="f24"><%=Formater.formatAmount(balance.F06) %></span>元
								</div>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>充值金额：
								</div>
								<div class="info">
									<input name="amount" type="text" class="text yhgl_ser fl mr5 required min-size-1" onKeyUp="value=(value=value.replace(/[^\d\.]/g,''))==''?'':value" value="<%StringHelper.filterQuoter(out, amount); %>" />
									<span class="fl">元</span>
                                    <div class="sx_tip_box"><a class="ml20 tx_an1" href="javascript:void(0)"></a><div class="sx_tip_info" style="top:-28px; right:-152px; width:300px;">充值金额不能低于<%=_min %>元，不能高于<%=_max/10000 %>万元<span></span></div></div>
								</div>
								<!--<div class="pop-con" style="margin-left:460px;display: none;">
		                           <div class="fl pop-pic"></div>
		                           <div class="pop-info">充值金额不能低于<%=_min %>元，不能高于<%=_max/10000 %>万元</div>
		                        </div>-->
		                        <div class="clear"></div>
							</li>
							<li>
								<div class="til">充值手续费：</div>
								<div class="info">
									<span id="poundage" class="fl">0.00</span>
									<span class="fl">元</span>
									 <div class="sx_tip_box"><a class="ml20 tx_an1" href="javascript:void(0)"></a><div class="sx_tip_info" style="top:-28px; right:-252px;">充值费用按充值金额的<%=_p*100 %>%由第三方平台收取，上限<%=_pMax %>元，超出部分由<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>支付<span></span></div></div>
									<div class="clear"></div>
								</div>
								<!--<div class="pop-con" style="margin-left:325px; margin-top:-26px;display: none;">
									<div class="fl pop-pic"></div>
									<div class="pop-info">充值费用按充值金额的<%=_p*100 %>%由第三方平台收取，上限<%=_pMax %>元，超出部分由<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>支付</div>
								</div>-->
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">实际到账金额：</div>
								<div class="info">
									<span class="f24 red" id="paySum">0.00</span>元
								</div>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">&nbsp;</div>
								<div class="info">
									<input type="submit" style="cursor: pointer;"  value="充值" class="btn01 mb15 mt15" />
									<div class="ln30 pl20">
									<font style="color: red;font-size: 16px;">*充值前须开通网银；</font><br> 
									<font style="color: red;font-size: 16px;">*充值的额度不能高出您银行卡单笔 / 日消费的最高限额。</font>
									</div>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</div>
					<%} %>
                    <div class="clear"></div>
					<div class="ln30 pl20 mb40">
						<p class="blue f16">温馨提示：</p>
						1、为了您的账户安全，请在充值前进行身份认证、手机绑定以及提现密码设置。<br> 2、您的账户资金将由第三方平台托管。<br>
						3、请注意您的银行卡充值限制，以免造成不便。<br>
						4、禁止洗钱、信用卡套现、虚假交易等行为，一经发现并确认，将终止该账户的使用。<br>
						5、如果充值金额没有及时到账，请联系客服，<%=configureProvider.getProperty(SystemVariable.SITE_CUSTOMERSERVICE_TEL) %>。<br>
						<div class="mt10">
							<a href="#" id="001"></a>
				            <span class="blue_ls f16">付款遇到问题了？先看看是不是由于下面的原因。</span><br />
				              <strong>· 要求开通网上银行？ <br /></strong>
				              建议选择银联在线支付付款，如果是信用卡还可选择快捷支付，再选择对应银行支付。
				              <br />
				              <strong>· 所需支付金额超过了银行支付限额？</strong>
				              <br />
				              建议先分若干次充值到本平台余额，或登录网上银行提高上限额度，即可轻松支付。
				              <br />
				              <strong>· 收不到银行的短信验证码？</strong>
				              <br />
				              建议重新获取短信验证码，如果还是收不到短信，直接打各银行的客服电话获取短信验证码。
				              <br />
				              <strong>· 网银页面显示错误或者空白？</strong>
				              <br />
				              建议更换到IE浏览器进行支付操作，或使用银联在线支付或支付宝付款。
				              <br />
				              <strong>· 网上银行扣款后，<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>充值单仍显示&quot;未付款&quot;怎么办？</strong>
				              <br />
				              可能是由于银行的数据没有即时传输，请您不要担心，稍后刷新页面查看。如较长时间仍显示未付款，可先向银行或支付平台获取支付凭证（扣款订单号/第三方交易号），请联系<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>客服(<%=configureProvider.getProperty(SystemVariable.SITE_CUSTOMERSERVICE_TEL) %>)为您解决。<br />
				              </div>
					</div>
				</div>
			</div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
	<div id="dialog" style="display: none;">
		<div class="popup_bg"></div>
		<div class="dialog w510 thickpos" style="margin:-80px 0 0 -255px;">
		  <div class="dialog_close fr"><a href="javascript:void(0);"></a></div>
		  <div class="con clearfix">
		    <div class="d_perfect fl"></div>
		    <div class="info fr">
		      <p class="f20 gray33" id="con_error"></p>
		    </div>
		  </div>
		</div>
	</div>
	<div id="problem" style="display: none;">
		<div class="popup_bg"></div>
		<div class="dialog w510 thickpos" style="margin:-120px 0 0 -255px;">
		  <div class="dialog_close fr"><a href="javascript:void(0)"></a></div>
		  <div class="con clearfix">
		    <div class="d_perfect fl"></div>
		    <div class="info fr">
		      <p class="f20 gray33">请您在新打开的页上完成付款。</p>
		      <p>付款完成前请不要关闭此窗口。<br/>完成付款后请根据您的情况点击下面的按钮：</p>
		      <p><a href="<%=controller.getViewURI(request, TradingRecord.class) %>" class="btn06 tc f14 fl mr10 mt5" >已完成付款</a>
		      <a href="#001" class="btn06 tc f14 fl mt5" >付款遇到问题</a></p>
		      <div class="clear"></div>
		      <%--
		      <p class="mt5"><a href="javascript:void(0);" id="otherPay" class="blue">返回选择其他支付方式</a></p>
		       --%>
		    </div>
		    <div class="clear"></div>
		  </div>
		</div>
	</div>
	<%
		String mPhone = configureProvider.getProperty(PayVariavle.CHARGE_MUST_PHONE);
		String mRealName = configureProvider.getProperty(PayVariavle.CHARGE_MUST_NCIIC);
		String mWithPsd = configureProvider.getProperty(PayVariavle.CHARGE_MUST_WITHDRAWPSD);
		List<String> list = new ArrayList<>();
		if(BooleanParser.parse(mPhone)){
			list.add("手机号认证");
		}
		if(BooleanParser.parse(mRealName)){
			list.add("实名认证");
		}
		if(BooleanParser.parse(mWithPsd)){
			list.add("设置提现密码");
		}
		StringBuilder authStr = new StringBuilder("");
		if(list.size()>0){
			authStr.append("充值必须先");
			int i = 0;
			authStr.append("<span class='red'>");
			for(String str : list){
				i++;
				if(i == 1){
					authStr.append(str);
					continue;
				}
				authStr.append("、");
				authStr.append(str);
			}
			authStr.append("</span>，请到<a class='blue' href='");
			authStr.append(controller.getViewURI(request, Safetymsg.class));
			authStr.append("'>安全信息</a>设置");
		}
		boolean mAuth = true;
		if(BooleanParser.parse(mPhone) && userInfo.F04 == null){
			mAuth = false;
		}else if(BooleanParser.parse(mRealName) && !smrz){
			mAuth = false;
		}else if(BooleanParser.parse(mWithPsd) && !txmm){
			mAuth = false;
		}
	%>
	<script type="text/javascript">
		var p = <%=_p %>;
		var pMax = <%=_pMax %>;
		var min = <%=_min %>;
		var max = <%=_max %>
		var auth = false;
		<%if(mAuth){%>
			auth = true;
		<%}%>
		var authText = "<%=authStr.toString() %>";
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/charge.js"></script>
</body>
</html>