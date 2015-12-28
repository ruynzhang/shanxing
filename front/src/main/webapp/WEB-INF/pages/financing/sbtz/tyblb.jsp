<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.enums.SURPRISE_STATUS"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Xxzqlb"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.query.BidQueryAccount"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.BdxqTyj"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Tbjl"%>
<%@page import="com.dimeng.p2p.S51.entities.T5124"%>
<%@page import="com.dimeng.p2p.common.enums.CreditTerm"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.query.BidQuery"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdlb"%>
<%@page import="com.dimeng.util.http.URLParameter"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Tztjxx"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.dimeng.p2p.common.Expemonyinfo"%>
<%@page import="com.dimeng.p2p.common.enums.Tyjbdinfo_status"%>
<html>
<head>
<title>我要投资-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<link rel="icon" href="favicon.ico">
<link href="<%=controller.getStaticPath(request)%>/css/style_sx.css" rel="stylesheet" type="text/css">
<link type="text/css" rel="stylesheet" href="<%=controller.getStaticPath(request)%>/css/layer.css" id="skinlayercss">
<link href="<%=controller.getStaticPath(request)%>/css/owl.carousel.css" rel="stylesheet" type="text/css">
<link href="<%=controller.getStaticPath(request)%>/css/owl.theme.css" rel="stylesheet" type="text/css">
</head>
<%!static final String TYPE_KEY="p"; static final String TERM_KEY="m";static final String LEVEL_KEY="l";static final String MULTISELECT_KEY="s";static final String WAY="w";%>
	<%
		BidManage bidManage = serviceSession.getService(BidManage.class);
		final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
		final String way = requestWrapper.getParameter(WAY);
	    String w = "";
	    if (!StringHelper.isEmpty(way)) {
	    	w = "?w="+way;
	    }
		Tztjxx total=bidManage.getStatisticsGr();
		boolean multiSelect = "1".equals(request.getParameter(MULTISELECT_KEY));
		URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Grlb.class),multiSelect,MULTISELECT_KEY,TYPE_KEY,TERM_KEY,LEVEL_KEY,WAY);
		parameter.set(WAY, way);
		String[] values=requestWrapper.getParameterValues(TYPE_KEY);
		PagingResult<Expemonyinfo> result = bidManage.searchtyjbid(new Paging() {
			public int getCurrentPage() {return IntegerParser.parse(requestWrapper.getParameter("paging.current"));}public int getSize() {return 10;}
		});
	%>
<body>
<!-- 顶部栏 -->
<%@include file="/WEB-INF/include/header.jsp" %>

<!--------菜单栏-------->
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.cookie.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/zzsc1016.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/layer.min.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.lazyload.min.js"></script> 
<script src="<%=controller.getStaticPath(request)%>/js/public.min.js" type="text/javascript" ></script>
<script  src="<%=controller.getStaticPath(request)%>/js/jquery.SuperSlide.2.1.js" type="text/javascript"></script>
<!--内容-->
<div class="wrapper">
  <!--banenr-->
  <div class="Middle">
	<div class="wanto"><a href="<%configureProvider.format(out,URLVariable.INDEX);%>">首页</a>&nbsp;&gt;&nbsp;<a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">我要投资</a>&nbsp;&gt;&nbsp;体验标</div>
        <div class="Investmentlist">
        	<ul>
          		<li ><a href="javascript:;;">散标投资</a></li> 
          		<li><a href="/financing/sxbao/list.html">善行宝</a></li>
         		<li><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Zqzrlb.class)%>">债权转让</a></li>
          	</ul>
        </div>
        <div class="items">

		<div class="Head">
			<div class="Head_L">
				<h2>项目</h2>
				<a href="javascript:;" onclick="Calc()">理财计算器</a>
			</div>
			<div class="Head_R">
			</div>
		</div>
		<div class="order">
			<ul>
				<li class="er_san">项目名称</li>
				<li>年化利率</li>
				<li>金额</li>
				<li>期限</li>
				<li>还款方式</li>
				<li>进度</li>
				<li>状态</li>
			</ul>
		</div>
		<div class="list">
		<ul>
        <%
        	boolean tag = true;
                Expemonyinfo[] creditInfos=result.getItems();
                  if(creditInfos!=null){
                	  for (int i=0;i<creditInfos.length;i++) {
                		  Expemonyinfo tyjbid = creditInfos[i];
                		  if (tyjbid == null) {continue;}
        %>
        <li><span class="hehe">
						<p class="fen_hu">
                          <i></i>
							<a href=""<%=controller.getPagingItemURI(request, BdxqTyj.class,tyjbid.id)%>">
								<%StringHelper.filterHTML(out, StringHelper.truncation(tyjbid.title, 10));%>
							</a>
						</p>
				</span>
				<span><%=Formater.formatAmount(tyjbid.borrint)%>%</span>
				<span><%=Formater.formatAmount(tyjbid.borrmoney)%>元</span>
				<span><%=tyjbid.borrterm%>天</span>
				<span>利息到期一次付清</span>
				<span>
						<div class="progress">
							<div class="wi_o">
								<div class="in_you_uo" style="width:<%=tyjbid.invetstment.doubleValue()/tyjbid.borrmoney.doubleValue()*100 %>%;"></div>
							</div>
							<div class="in_you"><%=Formater.formatProgress(tyjbid.invetstment.doubleValue()/tyjbid.borrmoney.doubleValue())%></div>
						</div>
				</span>
				<%if(tyjbid.estatus == Tyjbdinfo_status.TBZ){%>
                 <%
            	//筹款时间比较
            	 Calendar caldar = Calendar.getInstance();
            	 caldar.setTime(tyjbid.releasetime);
            	 caldar.add(Calendar.DAY_OF_MONTH, tyjbid.fundraterm);
            	 Date date = new Date();
            	 //如果当前时间大于筹款的结束日期，则投标结束
            	if(date.compareTo(caldar.getTime())>0){%>
            	   <span ><a class="unun" href="<%=controller.getPagingItemURI(request, BdxqTyj.class,tyjbid.id)%>" >已结束</a></span>
            	<%}else{ %>
            	<span ><a class="unun" href="<%=controller.getPagingItemURI(request, BdxqTyj.class,tyjbid.id)%>" >立刻体验</a></span>
            	<%}
              }else{%>
            	<% if(tyjbid.estatus == Tyjbdinfo_status.HKZ) {%>
            	<span ><a class="unun" href="<%=controller.getPagingItemURI(request, BdxqTyj.class,tyjbid.id)%>" >还款中</a></span>
            	<%}else{%><span ><a class="unun" href="<%=controller.getPagingItemURI(request, BdxqTyj.class,tyjbid.id)%>" ><%=tyjbid.estatus.getChineseName() %></a></span><%}%><%}%></span>
            	<%}}%>
             </li>
			</ul>
		</div>
	</div> 
        <%AbstractFinancingServlet.rendPaging(out, result,controller.getPagingURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Tyblb.class),parameter.getQueryString());%>
</div>
<!--理财计算器-->
 <div id="calcDiv" style="display:none;">
    <h3 style="margin:5px;">理财计算器</h3>
    <table class="second_cal_table" style=" margin-left:5px;">
      <tbody>
        <tr>
          <td class="theader" style="width:90px;"><label for="investment_amount" class="qtip-item">投资金额</label></td>
          <td><div class="prel">
              <input type="text" name="investment_amount" id="investment_amount" value="" class="normalInput" style="border:solid 1px #999; height:22px; margin:0 5px 5px 0;">
              <span class="unit">元</span> </div></td>
        </tr>
        <tr>
          <td class="theader"><label for="annualized_rate" class="qtip-item">年化收益率</label></td>
          <td><div class="prel">
              <input type="text" name="annualized_rate" id="annualized_rate" value="" class="normalInput" style="border:solid 1px #999; height:22px; margin:0 5px 5px 0;">
              <span class="unit">%</span> </div></td>
        </tr>
        <tr>
          <td class="theader"><label for="investment_days" class="qtip-item">投资期限</label></td>
          <td><div class="prel">
              <select name="investment_days" id="investment_days" class="normalInput">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
                <option value="7">7</option>
                <option value="8">8</option>
                <option value="9">9</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
                <option value="13">13</option>
                <option value="14">14</option>
                <option value="15">15</option>
                <option value="16">16</option>
                <option value="17">17</option>
                <option value="18">18</option>
              </select>
              <span class="unit">个月</span> </div></td>
        </tr>
        <tr>
          <td colspan="2"><input class="middle_input" type="button" id="fb_calc_btn" value="计算" style="background:#ff7900;border-radius: 15px;margin:8px 0 8px 90px; padding:5px 15px; border:0px; color:#FFF;" onclick="CalcIt()">
            <input id="fb_calc_cbtn" style="margin-left:5px;background:#29a9df;border-radius: 15px; padding:5px 15px; border:0px; color:#FFF;" type="button" onclick="ResetCalc()" value="重置" class="middle_input btn_cjs"></td>
        </tr>
        <tr id="tr_retirement_insurance">
          <td class="theader"><label for="revenue_amount" class="qtip-item">收益金额</label></td>
          <td><div class="prel">
              <input type="text" name="revenue_amount" id="revenue_amount" value="" class="normalInput" readonly style="border:solid 1px #999; height:22px; margin:0 5px 5px 0;">
              <span class="unit">元</span> </div></td>
        </tr>
        <tr id="tr_retirement_insurance">
          <td class="theader"><label for="revenue_sum" class="qtip-item">总计</label></td>
          <td><div class="prel">
              <input type="text" name="revenue_sum" id="revenue_sum" value="" class="normalInput" readonly style="border:solid 1px #999; height:22px; margin:0 5px 5px 0;">
              <span class="unit">元</span> </div></td>
        </tr>
      </tbody>
    </table>
  </div>
  <script>
function Calc(){
	var calc = $.layer({
	    type : 1,
	    title : false,
	    fix : false,
	    offset:['50px' , ''],
	    area : ['280px','400px'],
	    page : {dom : '#calcDiv'}
	});
}

function ResetCalc(){
	var money = $("#investment_amount").val("");
	var day = $("#investment_days").val("");
	var rate = $("#annualized_rate").val("");
	$("#revenue_amount").val("");
	$("#revenue_sum").val("");
}

function CalcIt(){
	var money = $("#investment_amount").val();
	var day = $("#investment_days").val();
	var rate = $("#annualized_rate").val();
	var re=/^(\d+\.\d{1,2}|\d+)$/ ;
	if(!re.test(money)){
		layer.alert("提示消息：请输入数字，小数点保留2位小数" );
		return false;
	}

	$("#revenue_amount").val(Number(money * rate / 1200 * day).toFixed(2));
	$("#revenue_sum").val(Number(money * rate / 1200 * day + Number(money)).toFixed(2));
}
</script> 



<!--内容-->
<%@include file="/WEB-INF/include/footer.jsp"%>
</div>
</body>
</html>