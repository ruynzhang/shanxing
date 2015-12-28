<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S61.entities.T6101"%>
<%@page import="com.dimeng.p2p.S64.entities.T6411"%>
<%@page import="com.dimeng.p2p.account.front.service.UserInfoManage"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.dimeng.p2p.S64.enums.T6410_F07"%>
<%@page import="com.dimeng.p2p.modules.financial.front.service.entity.YxxqEntity"%>
<%@page import="com.dimeng.p2p.modules.financial.front.service.FinancialManage"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.yxlc.Yxlb"%>
<%@page import="com.dimeng.p2p.common.enums.TermType"%>
<%@page import="com.dimeng.p2p.front.servlets.Term"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Date"%>
<html>
<head>
<title>优选理财计划<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		FinancialManage service = serviceSession.getService(FinancialManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		YxxqEntity caInfo= service.getPlan(id);
		if(caInfo==null){
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		BigDecimal gmMoney= new BigDecimal(0);
		BigDecimal jrfMoney= new BigDecimal(0);
	%>
	
<div class="contain clearfix">
   <div class="w1002 top_title">
      <span class="fl"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.Index.class)%>">我要理财</a> &gt;   <a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.yxlc.Index.class)%>">优选理财计划</a>&gt;  优选理财计划详情</span>
      <span class="fr">
      </span>
   </div>
   
	<div class="contain_main clearfix">
		<div class="pub_title clearfix">
		  <span class="fl"><%=caInfo.F02 %></span>
		  <span class="fr f14"><a href="<%=controller.getPagingItemURI(request, Term.class, TermType.YXLCXY.name())%>" class="blue">NO.56 优选理财服务计划协议范本</a></span>
		</div>
        <div class="plan_given clearfix">
        	<ul class="tender w620 fl clearfix">
            <li>
               <div class="list01">计划金额</div>
               <div class="list02">
                  <em class="f20"><%=Formater.formatAmount(caInfo.F03) %></em>元
                </div>
               <div class="list01">预期收益</div>
               <div class="list02"><em class="f20"><%=caInfo.F05 == null? "0%":Formater.formatRate(caInfo.F05.doubleValue())%></em>每年</div>
            </li>
            
            <li>
				<div class="list01">投标范围</div>
				<div class="list02">
				<em class="xin mt15 mr10">保</em>
					 
				</div>
				<div class="list01">保障方式</div>
				<div class="list02">
					参见<a href="<%=controller.getPagingItemURI(request, Term.class, TermType.BXBZ.name())%>" class="ml5 blue">本息保障计划</a>
				</div>
			</li>
			<li>
				<div class="list01">计划状态</div>
						<div class="list02">
							<div class="list02">
							<%if(caInfo.F07 == T6410_F07.YFB && caInfo.F09.after(caInfo.currentTime)){%>
								预售中
							<%}else if(caInfo.F07 == T6410_F07.YFB && !caInfo.F09.after(caInfo.currentTime)){%>
								申请中
							<%}else if(caInfo.F07 == T6410_F07.YSX){%>
								已满额
							<%}else if(caInfo.F07 == T6410_F07.YJZ){%>
								已截止
							<%}%>
						</div>
						</div>
						
						
						<%if(caInfo.F07 == T6410_F07.YFB && caInfo.F09.after(caInfo.currentTime)){
												long hm=1000*3600*24;
												long time =	caInfo.F09.getTime() - System.currentTimeMillis();
												long day=time/hm;
												long hour=(time-day*hm)/(1000*3600);
												long min=(time-day*hm-hour*1000*3600)/(1000*60);
						%>
						<div class="list01">距离发售</div>
						<div class="list02"><%=day%>天<%=hour%>小时<%=min%>分</div>
						<%
							}else if(caInfo.F07 == T6410_F07.YSX || caInfo.F07 == T6410_F07.YJZ){	
												long hm=3600*24;
												long time =	caInfo.F08;
												long day=time/hm;
												long hour=(time-day*hm)/3600;
												long min=(time-day*hm-hour*3600)/60;
												long ss=time-day*hm-hour*3600-min*60;
						%>
					<div class="list01">满额用时</div>
					<div class="list02"><%=day%>天<%=hour%>时<%=min%>分<%=ss%>秒</div>
						<%
							}else if(caInfo.F07 == T6410_F07.YFB && !(caInfo.F09.after(caInfo.currentTime))){
												long hm=1000*3600*24;
												long time =	caInfo.F10.getTime()-System.currentTimeMillis();
												long day=time/hm;
												long hour=(time-day*hm)/(1000*3600);
												long min=(time-day*hm-hour*1000*3600)/(1000*60);
						%>
						<div class="list01">距离截止</div>
						<div class="list02"><%=day%>天<%=hour%>小时<%=min%>分</div>
						<%
							}
						%>
			</li>
			<li>
				<div class="list01">锁定期限</div>
				<div class="list02">
					<em class="f20"><%=caInfo.F11 %></em>个月
				</div>
				
				<%
						Calendar calendar = Calendar.getInstance();
						calendar.setTimeInMillis(caInfo.F13.getTime());
						int year=calendar.get(Calendar.YEAR); 
						int month=calendar.get(Calendar.MONTH)+1; 
						int date=calendar.get(Calendar.DATE); 
				%>
				<div class="list01">锁定结束</div>
				<div class="list02"><%=year%>年<%=month%>月<%=date%>日</div>
			</li>
			<li>
				<div class="list01">收益处理</div>
				<div class="list02"><%StringHelper.filterHTML(out, caInfo.F14.getChineseName()); %></div>
				<div class="list01">费率说明</div>
				<div class="list02">本期计划费用如下</div>
			</li>
			<li style="border-bottom: none">
				<ul class="plan_charge clearfix fl">
					<li>
						<div class="fl list03">
							<i></i>
						</div>
						<div class="list04">
									<span class="fl">加入费率 <%=Formater.formatRate(caInfo.F15)%></span>
									<div class="tips_content">
										<span class="ui_plan_bj ui_i_tips ml5" style="margin-top: 7px;" onmouseover="mouseOver(3)" onmouseout="mouseOut(3)"></span>
										<div class="ui-pop-con" style="display: none;" id="txfy3">
											<div class="fl ui-pop-pic"></div>
											<div class="ui-pop-info">
											初期额外收取加入计划金额的<%=Formater.formatRate(caInfo.F15)%>作为加入费用，归<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>所有。
											</div>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="fl list03">
								</div>
								<div class="list04">
									<span class="fl">服务费率 <%=Formater.formatRate(caInfo.F16)%></span>
									<div class="tips_content">
										<span class="ui_plan_bj ui_i_tips ml5" style="margin-top: 7px;" onmouseover="mouseOver(2)" onmouseout="mouseOut(2)"></span>
										<div class="ui-pop-con" style="display: none;" id="txfy2">
											<div class="fl ui-pop-pic"></div>
											<div class="ui-pop-info">
											计划中收取投标所得利息收益的<%=Formater.formatRate(caInfo.F16)%>作为服务费，归<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>所有。</div>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="list04">
									<span class="fl">退出费率 <%=Formater.formatRate(caInfo.F17)%></span>
									<div class="tips_content">
										<span class="ui_plan_bj ui_i_tips ml5" style="margin-top: 7px;" onmouseover="mouseOver(0)" onmouseout="mouseOut(0)"></span>
										<div class="ui-pop-con" style="display: none;" id="txfy0">
											<div class="fl ui-pop-pic"></div>
											<div class="ui-pop-info">
												退出计划时收取退出计划金额的<%=Formater.formatRate(caInfo.F17)%>作为退出费，归<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>所有。</div>
										</div>
									</div>
								</div>
					</li>
				</ul>
			</li>
			</ul>
			<div></div>
         
			<div class="fr m_invest w240 mt15">
			<form  method="post" action="<%configureProvider.format(out,URLVariable.TB_YXLC);%>">
				<input type="hidden" id="yxId" name="yxId" value="<%=id%>">
				<input type="hidden" id="syMoney" name="syMoney" value="<%=caInfo.F04 == null ?0 : caInfo.F04%>">
				<input type="hidden" id="maxMoney" name="maxMoney" value="<%=caInfo.F23 == null ?0 : caInfo.F23%>">
				<input type="hidden" id="minMoney" name="minMoney" value="<%=caInfo.F22 == null ?0 : caInfo.F22%>">
				<input type="hidden" id="yxlcSucc" name="yxlcSucc" value="<%configureProvider.format(out, URLVariable.USER_YXLC);%>">
				<input type="hidden" id="yxlcSqz" name="yxlcSqz" value="<%configureProvider.format(out, URLVariable.USER_YXLC_SQZ);%>">
			
				<div class="text">
					剩余金额<br /> <em class="f20"> <%= Formater.formatAmount(caInfo.F04)%></em>元
				</div>
				<div class="text mb20 clearfix">
					<span class="f12 fl mr15"><em>每人可加入金额上限</em><br /> <em class="f16"><%=Formater.formatAmount(caInfo.F23)%></em>元</span>
					
					<%if(!(dimengSession==null || !dimengSession.isAuthenticated())){
						UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
						T6101 userInfo= userInfoManage.search();
					%>
					<span class="f12 fl"><em>可用金额（<a href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>" class="blue">充值</a>）
					<input type="hidden" id="kyMoney" name="kyMoney" value="<%=userInfo.F06%>">
					</em><br />
					<em class="f16"><%=Formater.formatAmount(userInfo.F06)%></em>元
					</span>
					<%}else{%>
					<span class="f12 fl"><em>可用金额</em><br />
						<em><a href="<%configureProvider.format(out, URLVariable.LOGIN);%>" class="blue">登录</a>后可见</em>
					</span>
					<%}%>
				</div>
				<%
					if(caInfo.F07 == T6410_F07.YFB && caInfo.F09.after(caInfo.currentTime)){
				%>
				<div class="text">
					<div class="yuan">元</div>
					<input  type="text" maxlength="10" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))" class="input_border w240"  value="" />
					<p>不低于<%=caInfo.F22%>元</p>
					<p class="mt15">
						<i class="btn02">敬请期待</i>
					</p>
				</div>
				<%
					}else if(caInfo.F07 == T6410_F07.YFB && !(caInfo.F09.after(caInfo.currentTime))){
						if(!(dimengSession==null || !dimengSession.isAuthenticated())){
							UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
							String isYuqi =  userInfoManage.isYuqi();			
							BigDecimal tzMoney =  service.tzMoney(id);	
				%>
					<input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
					<input type="hidden" id="tzMoney" name="tzMoney" value="<%=tzMoney%>">
					<input type="hidden" id="jrfl" name="jrfl" value="<%=caInfo.F15%>">
					<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
					
					
					<div class="text">
						<div class="yuan">元</div>
						<input name="gmMoney" type="text" maxlength="10" class="input_border w240" id="gmMoney" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))"  value=""  />
						<p>不低于<%=caInfo.F22%>元</p>
						<p class="mt15">
							<button type="button" id="tbButton"  style="cursor: pointer;" class="btn01">申 请</button>
						</p>
					</div>
					<%}else{%>
					<div class="text">
						<div class="yuan">元</div>
						<input name="gmMoney1" type="text" maxlength="10" class="input_border w240" id="gmMoney1" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))"  value="" />
						<p>不低于<%=caInfo.F22%>元</p>
						<p class="mt15">
							<a href="<%configureProvider.format(out, URLVariable.LOGIN);%>" class="btn01">申 请 </a>
						</p>
					</div>
				<%
					}}else if(caInfo.F07 == T6410_F07.YJZ){
				%>
				<div class="text">
					<div class="yuan">元</div>
					<input name="textfield" type="text" maxlength="10" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))" class="input_border w240" id="textfield" value="" />
					<p>不低于<%=caInfo.F22%>元</p>
					<p class="mt15">
						<i class="btn02">已截止</i>
					</p>
				</div>
				<%
					}else if(caInfo.F07 == T6410_F07.YSX){
				%>
				<div class="text">
					<div class="yuan">元</div>
					<input name="textfield" type="text" maxlength="10" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))" class="input_border w240" id="textfield" value="" />
					<p>不低于<%=caInfo.F22%>元</p>
					<p class="mt15">
						<i class="btn02">已满额</i>
					</p>
				</div>
				<%
					}
				%>
				
			</form>
		</div>

        </div>     
   	</div>
  
	<div class="plan_tab clearfix">
		<ul>
			<%if(caInfo.F07 == T6410_F07.YFB && caInfo.F09.after(caInfo.currentTime)){%>
			<li id="one1" onclick="setTab('one',1,1)"  class="hover">计划介绍</li>
			<li style="border-left:1px solid #d1dfea;padding:0;"></li>
			<%}else{%>
			<li id="one1" onclick="setTab('one',1,2)"  class="hover">计划介绍</li>
			<li id="one2" onclick="setTab('one',2,2)" >加入记录</li>
			<li style="border-left:1px solid #d1dfea;padding:0;"></li>
			<%}%>
        </ul>
        <a href="<%=controller.getViewURI(request, Yxlb.class) %>" class="blue fr pt5">查看往期优选理财计划 &gt;&gt;</a>
	</div>
	<div class="contain_main clearfix plan_intr" id="con_one_1">
		<div class="pub_title pt10">计划介绍</div>
		<div class="pt10"><%StringHelper.filterHTML(out, caInfo.F18);%></div>
	</div>

	<%if(dimengSession==null|| !dimengSession.isAuthenticated()){%>
	<div class="contain_main clearfix add_record" id="con_one_2" style="display:none;">
			<div class="plan_tab_con01 clearfix">
				<div class="mt50 mb50 tc f18">请<a href="<%configureProvider.format(out,URLVariable.LOGIN);%>" class="blue mr10 ml10">登录</a>或<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="blue mr10 ml10">注册</a>后查看</div>
			</div>
	</div>  
	<%}else if(!(caInfo.F07 == T6410_F07.YFB && caInfo.F09.after(caInfo.currentTime)) ){%>
	<div class="contain_main clearfix add_record" id="con_one_2" style="display:none;">
	     <div class="clearfix">
		      <div class="table pt10 fl">
		        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr class="tit">
	                   <td width="26%" align="center">投资人</td>
	                   <td width="41%" align="center">投资金额 </td>
	                   <td width="33%" align="center">投资时间</td>
                	 </tr>
		                  <%
		                  UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
		                  T6411[] planRecodes = service.search(id);
		                  if (planRecodes!= null && planRecodes.length>0) {for (T6411 planRecode : planRecodes) {if (planRecode == null) {continue;}%>
		                  <tr>
		                    <td align="center"><%StringHelper.filterHTML(out,  userInfoManage.getUserName(planRecode.F03).substring(0,4)+"***");%></td>
		                    <td align="center"><%=Formater.formatAmount(planRecode.F04) %>元 </td>
		                    <td align="center"><%=TimestampParser.format(planRecode.F06, "yyyy-MM-dd") %></td>
		                  </tr>
		                  <%}} %>
		                </table>
		      </div>
		      <div class="plan_record"><span class="f20">加入总人次</span><br/><span class="f30 orange"><%=planRecodes==null?0:planRecodes.length %></span>人次</div>
	     </div> 
	</div>
	<%} %>
 </div>
 
 <div class="popup_bg"   style="display: none;"></div>
<div class="dialog d_error w510" id="gmDialog" style="margin:-150px 0 0 -255px; display: none;" >
	<div class="dialog_close fr" id="gmClose"><a></a></div>
    <div class="con clearfix">
      <div class="d_succeed fl"></div>
      <div class="info fr">
          <p class="f20 gray33">购买确认</p>
          		您此次购买金额为<i class="red"><span id="zxMoney"><%=gmMoney%></span></i>元，加入费为<i class="red"><span id="jrfMoney"><%=jrfMoney%></span></i>元，总需为<i class="red"><span id="zgxMoney"><%=Formater.formatAmount(gmMoney.add(jrfMoney)) %></span></i>确认购买？

      </div>  
      <div class="clear" ></div>    
      <div class="dialog_btn"><a href="javascript:void(0)" id="ok" class="btn btn01">确 定</a><a href="javascript:void(0)" id="cancel" class="btn btn05">取 消</a></div> 
    </div>
</div>


<div id="info"></div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/yxlc.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>
	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
				if(caInfo.F07 == T6410_F07.YSX){
	%>
	<script type="text/javascript">
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#yxlcSucc").val()));	
		$("div.popup_bg").show();
	</script>
	<%}else{%>
	<script type="text/javascript">
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#yxlcSqz").val()));	
		$("div.popup_bg").show();
	</script>
	<%}}%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=errorMessage%>","error"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String warnMessage = controller.getPrompt(request, response , PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warnMessage)) {
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=warnMessage%>","perfect"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
</body>
</html>