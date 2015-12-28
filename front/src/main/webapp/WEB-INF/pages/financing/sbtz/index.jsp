<!doctype html>
<%@page import="com.dimeng.p2p.S62.enums.SURPRISE_STATUS"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.joda.time.DateTime"%>
<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Xxzqlb"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.query.BidQueryAccount"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq"%>
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
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<html>
<head>
<title>我要投资-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<link rel="icon" href="<%=controller.getStaticPath(request)%>/favicon.ico">
<link href="<%=controller.getStaticPath(request)%>/css/style_sx.css" rel="stylesheet" type="text/css"/>
<link type="text/css" rel="stylesheet" href="<%=controller.getStaticPath(request)%>/css/layer.css" id="skinlayercss"/>
<link href="/css/dialoglink.css" rel="stylesheet" id="dialoglink"/>
</head>
<%!static final String TYPE_KEY="p"; static final String TERM_KEY="qx";static final String LEVEL_KEY="status";static final String MULTISELECT_KEY="s";static final String WAY="w";static final String RATE_KEY="r";%>
<%
	BidManage bidManage = serviceSession.getService(BidManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	final String way = requestWrapper.getParameter(WAY);
	final String rate = requestWrapper.getParameter(RATE_KEY);
	//选择期限
	String qx=requestWrapper.getParameter(TERM_KEY);
	if(qx==null || (qx!=null && Integer.parseInt(qx)>6 || Integer.parseInt(qx)<1)){
		qx="0";
	}
	String status=requestWrapper.getParameter(LEVEL_KEY);;
	if(status==null || (status!=null && Integer.parseInt(status)>4 || Integer.parseInt(status)<1)){
		status="0";
	}
    String w = requestWrapper.getParameter(WAY);
    if (w==null || (status!=null && !w.equals("x") && !w.equals("z") && !w.equals("v"))){
    	w = "0";
    }
    String r = requestWrapper.getParameter(RATE_KEY);
    if(r==null || (r!=null && Integer.parseInt(r)>5 || Integer.parseInt(r)<1)){
    	r = "0";
    }
	boolean multiSelect = "1".equals(request.getParameter(MULTISELECT_KEY));
	URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Grlb.class),multiSelect,MULTISELECT_KEY,TYPE_KEY,LEVEL_KEY,TERM_KEY,WAY,RATE_KEY);
	parameter.set(WAY, way);
	String[] values=requestWrapper.getParameterValues(TYPE_KEY);
	PagingResult<Bdlb> result = bidManage.searchAccount(
			new BidQueryAccount() {
				public T6211[] getType() {
					String[] values=requestWrapper.getParameterValues(TYPE_KEY);
					if(values==null||values.length==0){
						return null;
					}
					T6211[] types = new T6211[values.length];
					for(int i=0;i<values.length;i++){
						types[i]=new T6211();
						types[i].F01 = IntegerParser.parse(values[i]);
					}
					return types;}
				public CreditTerm[] getTerm() {
					String[] values=requestWrapper.getParameterValues(TERM_KEY);
					if(values==null||values.length==0){
						return null;
					}
					CreditTerm[] terms = new CreditTerm[values.length];
					for(int i=0;i<values.length;i++){
						if("1".equals(values[i])){
							values[i]="YGYYN";
						}else if("2".equals(values[i])){
							values[i]="YDSGY";
						}else if("3".equals(values[i])){
							values[i]="SDLGY";
						}else if("4".equals(values[i])){
							values[i]="LDJGY";
						}else if("5".equals(values[i])){
							values[i]="JDSEGY";
						}else if("6".equals(values[i])){
							values[i]="SEGYYS";
						}
						terms[i] = EnumParser.parse(CreditTerm.class,values[i]);
					}
					return terms;
					}
				public T6230_F20[] getStatus() { 
					String[] values=requestWrapper.getParameterValues(LEVEL_KEY);
					
					if(values==null||values.length==0){
						return null;
					}
					T6230_F20[] levels = new T6230_F20[values.length];
					for(int i=0;i<values.length;i++){
						if("1".equals(values[i])){
							values[i]="YFB";
						}else if("2".equals(values[i])){
							values[i]="TBZ";
						}else if("3".equals(values[i])){
							values[i]="HKZ";
						}else if("4".equals(values[i])){
							values[i]="YJQ";
						}
						levels[i] =EnumParser.parse(T6230_F20.class,values[i]);
					}
					return levels;
					}
				public String getWay(){
					return way;
				}
				public String getRate(){
					return rate;
				}
			}, new Paging() {
				public int getCurrentPage() {return IntegerParser.parse(requestWrapper.getParameter("paging.current"));}public int getSize() {return 10;}
			});
%>
<body>
<!--------顶部栏-------->
<%@include file="/WEB-INF/include/header.jsp"%>
<!--------菜单栏-------->
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.cookie.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/zzsc1016.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/layer.min.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.lazyload.min.js"></script>
<script src="<%=controller.getStaticPath(request)%>/js/public.min.js" type="text/javascript" ></script>
<script  src="<%=controller.getStaticPath(request)%>/js/owl.carousel.js" type="text/javascript"></script>
<script  src="<%=controller.getStaticPath(request)%>/js/jquery.SuperSlide.2.1.js" type="text/javascript"></script>
<script  src="/js/lhgdialog.min.js" type="text/javascript"></script>

<script>
$(function(){
	$("img.lazy").lazyload({effect : "fadeIn",threshold : 200});
});
</script>

<div class="wrapper">
  <script type="text/javascript">
	//sdfsdf2015年06月25日 09时07分

	function amm(obj) {
		var pp;
		var pp2;
		$('.yst').children('span').removeClass("lisl");
		$(".maog").hide();
		document.getElementById("shah_" + obj).style.display = "block";
			try{
			 $("#channlViews img.lazy").trigger("sporty");
			}catch(e){}
	}
	function amm2(obj) {
		var pp;
		var pp2;
		$('.yst').children('span').removeClass("lisl");
		$(".maog").hide();
		document.getElementById("shah_x_" + obj).style.display = "block";
	try{
			 $("#channlViews img.lazy").trigger("sporty");
			}catch(e){}
	}
</script>

  <!--图片延时加载-->
  <script>
$().ready(function(){
	$("#focusa img.lazy").lazyload({effect : "fadeIn",event : "sporty"});
	$("#channlViews img.lazy").lazyload({effect : "fadeIn",event : "sporty"});
		try{
			 $("#channlViews img.lazy").trigger("sporty");
			}catch(e){}

});
</script>

  <!--图片延时加载end-->
    <style>
    #owl-demo .item img{
        display: block;
        width: 100%;
        height: auto;
    }
    </style>

    <script>
    $(document).ready(function() {
      $("#owl-demo").owlCarousel({

      navigation : false,
      slideSpeed : 300,
      paginationSpeed : 400,
	  lazyLoad : true,
	  autoPlay : true,
      singleItem : true

      // "singleItem:true" is a shortcut for:
      // items : 1,
      // itemsDesktop : false,
      // itemsDesktopSmall : false,
      // itemsTablet: false,
      // itemsMobile : false

      });
    });
    </script>
  <!--banenr-->
  <div class="Middle">
	<div class="wanto"><a href="<%configureProvider.format(out,URLVariable.INDEX);%>">首页</a>&nbsp;&gt;&nbsp;<a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">我要投资</a>&nbsp;&gt;&nbsp;散标投资</div>
        <div class="Investmentlist">
        	<ul>
          		<li class="inenow"><a href="javascript:;;">散标投资</a></li> 
          		<li><a href="/financing/sxbao/list.html">善行宝</a></li>
         		<li><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Zqzrlb.class)%>">债权转让</a></li>
          	</ul>
        </div>
	<div class="invest">

		<div class="Vote">
			<ul>
<li> 
    <span class="bao_ni">
      	 项目状态
    </span>
   
   	<a href="/financing/sbtz/index.html?status=0&qx=<%=qx%>&w=<%=w%>&r=<%=r%>">
   		<span <%if(status.equals("0")){out.print("class=\"bao_two\"");}%>>全部 </span>
   	</a>
  	<a href="/financing/sbtz/index.html?status=1&qx=<%=qx%>&w=<%=w%>&r=<%=r%>">
  		<span <%if(status.equals("1")){out.print("class=\"bao_two\"");}%>>预发布</span>
  	</a>
  	<a href="/financing/sbtz/index.html?status=2&qx=<%=qx%>&w=<%=w%>&r=<%=r%>">
  		<span <%if(status.equals("2")){out.print("class=\"bao_two\"");}%>>融资中</span>
  	</a>
  	<a href="/financing/sbtz/index.html?status=3&qx=<%=qx%>&w=<%=w%>&r=<%=r%>">
  		<span <%if(status.equals("3")){out.print("class=\"bao_two\"");}%>>还款中</span>
  	</a>
  	<a href="/financing/sbtz/index.html?status=4&qx=<%=qx%>&w=<%=w%>&r=<%=r%>">
  		<span <%if(status.equals("4")){out.print("class=\"bao_two\"");}%>>已还款</span>
  	</a>
</li>

<li>
    <span class="bao_ni">
       	 项目期限
    </span>
    <a href="/financing/sbtz/index.html?status=<%=status%>&qx=0&w=<%=w%>&r=<%=r%>">
    	<span <%if(qx.equals("0")){out.print("class=\"bao_two\"");}%>> 全部</span>
    </a>
    <a href="/financing/sbtz/index.html?status=<%=status%>&qx=1&w=<%=w%>&r=<%=r%>">
    	<span <%if(qx.equals("1")){out.print("class=\"bao_two\"");}%>>1个月以内</span> 
    </a>
    <a href="/financing/sbtz/index.html?status=<%=status%>&qx=2&w=<%=w%>&r=<%=r%>"><span <%if(qx.equals("2")){out.print("class=\"bao_two\"");}%>>1~3个月</span></a>
    <a href="/financing/sbtz/index.html?status=<%=status%>&qx=3&w=<%=w%>&r=<%=r%>"><span <%if(qx.equals("3")){out.print("class=\"bao_two\"");}%>>3~6个月</span></a>
    <a href="/financing/sbtz/index.html?status=<%=status%>&qx=4&w=<%=w%>&r=<%=r%>"><span <%if(qx.equals("4")){out.print("class=\"bao_two\"");}%>>6~9个月</span></a>
    <a href="/financing/sbtz/index.html?status=<%=status%>&qx=5&w=<%=w%>&r=<%=r%>"><span <%if(qx.equals("5")){out.print("class=\"bao_two\"");}%>>9~12个月</span></a>
    <a href="/financing/sbtz/index.html?status=<%=status%>&qx=6&w=<%=w%>&r=<%=r%>"><span <%if(qx.equals("6")){out.print("class=\"bao_two\"");}%>>12个月以上</span></a>
</li>
<li>
    <span class="bao_ni">
       	 项目规模
    </span>
    <a href="/financing/sbtz/index.html?status=<%=status%>&qx=<%=qx%>&w=0&r=<%=r%>">
    	<span <%if(w.equals("0")){out.print("class=\"bao_two\"");}%>> 全部</span>
    </a>
    <a href="/financing/sbtz/index.html?status=<%=status%>&qx=<%=qx%>&w=x&r=<%=r%>"><span <%if(w.equals("x")){out.print("class=\"bao_two\"");}%>>50万以下</span></a>
    <a href="/financing/sbtz/index.html?status=<%=status%>&qx=<%=qx%>&w=z&r=<%=r%>"><span <%if(w.equals("z")){out.print("class=\"bao_two\"");}%>>50万~100万</span></a>
    <a href="/financing/sbtz/index.html?status=<%=status%>&qx=<%=qx%>&w=v&r=<%=r%>"><span <%if(w.equals("v")){out.print("class=\"bao_two\"");}%>>100万以上</span></a>
    </li>
<li>
    <span class="bao_ni">
      	 项目收益
    </span>
   
   	<a href="/financing/sbtz/index.html?status=<%=status%>&qx=<%=qx%>&w=<%=w%>&r=0">
   		<span <%if(r.equals("0")){out.print("class=\"bao_two\"");}%>>全部 </span>
   	</a>
  	<a href="/financing/sbtz/index.html?status=<%=status%>&qx=<%=qx%>&w=<%=w%>&r=1">
  		<span <%if(r.equals("1")){out.print("class=\"bao_two\"");}%>>5%以下</span>
  	</a>
  	<a href="/financing/sbtz/index.html?status=<%=status%>&qx=<%=qx%>&w=<%=w%>&r=2">
  		<span <%if(r.equals("2")){out.print("class=\"bao_two\"");}%>>5%~8%</span>
  	</a>
  	<a href="/financing/sbtz/index.html?status=<%=status%>&qx=<%=qx%>&w=<%=w%>&r=3">
  		<span <%if(r.equals("3")){out.print("class=\"bao_two\"");}%>>8%~12%</span>
  	</a>
  	<a href="/financing/sbtz/index.html?status=<%=status%>&qx=<%=qx%>&w=<%=w%>&r=4">
  		<span <%if(r.equals("4")){out.print("class=\"bao_two\"");}%>>12%~16%</span>
  	</a>
  	<a href="/financing/sbtz/index.html?status=<%=status%>&qx=<%=qx%>&w=<%=w%>&r=5">
  		<span <%if(r.equals("5")){out.print("class=\"bao_two\"");}%>>16%以上</span>
  	</a>
</li>
			</ul>
		</div>
	</div>
	<div class="items">

		<div class="Head">
			<div class="Head_L">
				<h2>项目</h2>
				<a href="javascript:;" class="calculator">理财计算器</a>
			</div>
			<div class="Head_R">
				<a href="/user/financing/zdtb/index.html">设置自动投标</a>
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
			<%boolean tag = true;
			  String statusButtonTemp = null;
	          Bdlb[] creditInfos=result.getItems();
	          if(creditInfos!=null){
	        	  for (Bdlb creditInfo:creditInfos) {
	        		  if (creditInfo == null) {continue;}
             
	        		  T6230_F20 statusF20 = creditInfo.F11;
	                  if(statusF20 == T6230_F20.TBZ || statusF20 == T6230_F20.DFK){if(new DateTime(creditInfo.F13).plusDays(creditInfo.F09).getMillis() - System.currentTimeMillis() <= 0){statusButtonTemp = "已完结";} else if(statusF20 == T6230_F20.DFK){statusButtonTemp = statusF20.getChineseName();}else{statusButtonTemp = "立即投资";}}else{statusButtonTemp = statusF20.getChineseName();}
	        %>
				<li><span class="hehe">
						<p class="fen_hu">
							<%if(creditInfo.investName!=null){%><img src="<%=controller.getStaticPath(request)%>/images/yuyue_03.png"alt="预约"/><%}%> <%else {%><i></i><%}%>
							<%if(creditInfo.isActivity == T6230_F13.S){%>
						<a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>">
							<%StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.F04, 12));%>
						</a>
						<a href="javascript:;" class="index_note">当天满标，第二天回款</a>
							<%}else{ %>
						<a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>" class="index_note_none">
							<%StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.F04, 12));%>
						</a>
							<%} %>
						</p>
				</span>
				<span  class="index_font"><%=Formater.formatRate(creditInfo.F07.subtract(creditInfo.bonus.divide(new BigDecimal("100"))),false)%>% <b class="index_font_big"><%if(creditInfo.bonus.compareTo(BigDecimal.ZERO)==1){out.print("+ "+creditInfo.bonus+"%");}%></b></span>
				<span><%=Formater.formatAmount(creditInfo.F06)%>元</span>
				<span><%if(T6231_F21.S == creditInfo.F19){out.print(creditInfo.F20 + "天");}else{out.print(creditInfo.F10 + "个月");} %></span>
				<span><%=creditInfo.F21.getChineseName()%></span> 
					<span>
						<div class="progress">
							<div class="wi_o">
								<div class="in_you_uo" style="width:<%=(int)(creditInfo.proess*100)%>%;"></div>
							</div>
							<div class="in_you"><%=Formater.formatProgress(creditInfo.proess)%></div>
						</div>
				</span> <span investmentstatus="">
						<a class="unun" href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>">
						<%if(creditInfo.F11 == T6230_F20.TBZ){
							  if(statusButtonTemp!=null&&statusButtonTemp.equals("立即投资")){out.print("立即投标");}
							  else{out.print(statusButtonTemp);}
							}else if(creditInfo.F11 == T6230_F20.HKZ){
								out.print("还款中");
						  	}else{
						  		out.print(creditInfo.F11.getChineseName());
							}
						%>
						</a>
				</span></li>
				<%}}%>
			</ul>
		</div>
	</div> 
	<%AbstractFinancingServlet.rendPaging(out, result,controller.getPagingURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class),parameter.getQueryString());%>
		<script>
	function ReSetPageWidth(){
		var alink = $("#Pagination").find("a");
		var w = 71*2+(alink.length-2)*41;
		$("#Pagination").css("width",w+"px");
	}
	ReSetPageWidth()
	</script>
</div>
<%@include file="/WEB-INF/include/footer.jsp"%>
</div>

<script type="text/javascript">
jQuery(".fullSlide").hover(function() {
    jQuery(this).find(".prev,.next").stop(true, true).fadeTo("show", 0.3)
},
function() {
    jQuery(this).find(".prev,.next").fadeOut()
});
jQuery(".fullSlide").slide({
    titCell: ".hd ul",
    mainCell: ".bd ul",
    effect: "fold",
    autoPlay: true,
    autoPage: true,
    trigger: "click",
    startFun: function(i) {
        var curLi = jQuery(".fullSlide .bd li").eq(i);
        if ( !! curLi.attr("_src")) {
            curLi.css("background-image", curLi.attr("_src")).removeAttr("_src")
        }
    }
});

</script>

</body>
</html>
