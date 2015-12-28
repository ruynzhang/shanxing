<!doctype html>
<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.account.front.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Xxzqlb"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Tbjl"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.common.enums.CreditTerm"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.query.TransferQueryAccount"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Zqzqlb"%>
<%@page import="com.dimeng.util.http.URLParameter"%>
<%@page import="com.dimeng.p2p.S51.entities.T5124"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Zqzrtj"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.TransferManage"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<html>
<head>
<title>我要投资-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<link rel="icon" href="favicon.ico">
<link href="<%=controller.getStaticPath(request)%>/css/common.css" rel="stylesheet" type="text/css">
<link href="<%=controller.getStaticPath(request)%>/css/style_sx.css" rel="stylesheet" type="text/css">
<link type="text/css" rel="stylesheet" href="<%=controller.getStaticPath(request)%>/css/layer.css" id="skinlayercss">
<link href="<%=controller.getStaticPath(request)%>/css/owl.carousel.css" rel="stylesheet" type="text/css">
<link href="<%=controller.getStaticPath(request)%>/css/owl.theme.css" rel="stylesheet" type="text/css">
<link href="/css/dialoglink.css" rel="stylesheet" id="dialoglink"/>
</head>
<%!static final String TYPE_KEY="p"; static final String TERM_KEY="qx";static final String LEVEL_KEY="status";static final String MULTISELECT_KEY="s";static final String WAY="w";static final String RATE_KEY="r";%>
<%
	TransferManage service = serviceSession.getService(TransferManage.class);
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
	Zqzrtj total=service.getStatistics();
	boolean multiSelect = "1".equals(request.getParameter(MULTISELECT_KEY));
	BidManage bidManage = serviceSession.getService(BidManage.class);
	T6211[] t6211s= bidManage.getBidType();
	T5124[] t5124s= bidManage.getLevel();
	URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Zqzrlb.class),multiSelect,MULTISELECT_KEY,TYPE_KEY,TERM_KEY,LEVEL_KEY,WAY,RATE_KEY);
	parameter.set(WAY, way);
	PagingResult<Zqzqlb> results = service.searchAccount(
			new TransferQueryAccount() {
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
				public T5124[] getCreditLevel() {
					
					return null;
					}
				public String getWay(){
					return way;
				}
				public String getRate(){
					return rate;
				}
			}, new Paging() {
				public int getCurrentPage() {
			return IntegerParser.parse(requestWrapper.getParameter("paging.current"));
				}
				public int getSize() {
			return 10;
				}
			});
	
	BigDecimal zqMoney = new BigDecimal(0);
	BigDecimal zfMoney = new BigDecimal(0);
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
<script  src="<%=controller.getStaticPath(request)%>/js/jquery.SuperSlide.2.1.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/zqzr.js"></script>
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

<!--漂浮广告-->
<!--  <script>
$().ready(function(){
				var lay=$.layer({
					type: 1,
					title: false,
					area : ['800px','587px'],
					fix: false,
					shadeClose: true,
					//closeBtn: true,
					//offset: [($(window).height() - 700)/2+'px', ''], //上下垂直居中
					border : true,
					shade : [0.2, '#000'],
					page: {
						dom : '#lsightlei' 
					}
				});
				
				setTimeout(function(){ layer.close(lay); }, 5000);
				
      });          
               
				
</script> 
<div class="lsightlei" id="lsightlei" style="display:none;"><a class="lsight" href="page/picit"> </a></div>-->
<!--漂浮广告end-->  
  
  
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
    <div id="info"></div>
  <!--banenr-->
  <div class="Middle">
	<div class="wanto"><a href="<%configureProvider.format(out,URLVariable.INDEX);%>">首页</a>&nbsp;&gt;&nbsp;<a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">我要投资</a>&nbsp;&gt;&nbsp;债权转让</div>
        <div class="Investmentlist"><ul>
          <li><a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">散标投资</a></li>
          <li><a href="/financing/sxbao/list.html">善行宝</a></li>
          <li class="inenow"><a href="javascript:;;">债权转让</a></li>
          </ul></div>
	<div class="invest">

		<div class="Vote">
			<ul>
<li>
    <span class="bao_ni">
       	 项目期限
    </span>
    <a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=0&w=<%=w%>&r=<%=r%>">
    	<span <%if(qx.equals("0")){out.print("class=\"bao_two\"");}%>> 全部</span>
    </a>
    
    <a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=1&w=<%=w%>&r=<%=r%>"><span <%if(qx.equals("1")){out.print("class=\"bao_two\"");}%>>1个月以内</span></a>
    
    <a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=2&w=<%=w%>&r=<%=r%>"><span <%if(qx.equals("2")){out.print("class=\"bao_two\"");}%>>1~3个月</span></a>
    <a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=3&w=<%=w%>&r=<%=r%>"><span <%if(qx.equals("3")){out.print("class=\"bao_two\"");}%>>3~6个月</span></a>
    <a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=4&w=<%=w%>&r=<%=r%>"><span <%if(qx.equals("4")){out.print("class=\"bao_two\"");}%>>6~9个月</span></a>
    <a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=5&w=<%=w%>&r=<%=r%>"><span <%if(qx.equals("5")){out.print("class=\"bao_two\"");}%>>9~12个月</span></a>
    <a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=6&w=<%=w%>&r=<%=r%>"><span <%if(qx.equals("6")){out.print("class=\"bao_two\"");}%>>12个月以上</span></a>
    </li>
<li>
    <span class="bao_ni">
       	 项目规模
    </span>
    <a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=<%=qx%>&w=0&r=<%=r%>">
    	<span <%if(w.equals("0")){out.print("class=\"bao_two\"");}%>> 全部</span>
    </a>
    <a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=<%=qx%>&w=x&r=<%=r%>"><span <%if(w.equals("x")){out.print("class=\"bao_two\"");}%>>50万以下</span></a>
    <a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=<%=qx%>&w=z&r=<%=r%>"><span <%if(w.equals("z")){out.print("class=\"bao_two\"");}%>>50万~100万</span></a>
    <a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=<%=qx%>&w=v&r=<%=r%>"><span <%if(w.equals("v")){out.print("class=\"bao_two\"");}%>>100万以上</span></a>
    </li>
<li>
    <span class="bao_ni">
      	 项目收益
    </span>
   
   	<a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=<%=qx%>&w=<%=w%>&r=0">
   		<span <%if(r.equals("0")){out.print("class=\"bao_two\"");}%>>全部 </span>
   	</a>
  	<a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=<%=qx%>&w=<%=w%>&r=1">
  		<span <%if(r.equals("1")){out.print("class=\"bao_two\"");}%>>5%以下</span>
  	</a>
  	<a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=<%=qx%>&w=<%=w%>&r=2">
  		<span <%if(r.equals("2")){out.print("class=\"bao_two\"");}%>>5%~8%</span>
  	</a>
  	<a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=<%=qx%>&w=<%=w%>&r=3">
  		<span <%if(r.equals("3")){out.print("class=\"bao_two\"");}%>>8%~12%</span>
  	</a>
  	<a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=<%=qx%>&w=<%=w%>&r=4">
  		<span <%if(r.equals("4")){out.print("class=\"bao_two\"");}%>>12%~16%</span>
  	</a>
  	<a href="/financing/sbtz/zqzrlb.html?status=<%=status%>&qx=<%=qx%>&w=<%=w%>&r=5">
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
				<li>剩余期限</li>
				<li>债权价值</li>
				<li>待收本息</li>
				<li>转让价格</li>
				<li>状态</li>
			</ul>
		</div>
		<div class="list">
			<ul>
				<%
	              Zqzqlb[] creditAssignments=results.getItems();
	                  if(creditAssignments!=null){
	            	      for (Zqzqlb creditAssignment:creditAssignments) {
	            		      if (creditAssignment == null) {
	            		    	  continue;
	            		      }
	           %>
				<li>
				<span class="hehe">
					<p class="fen_hu">
							<a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditAssignment.F24)%>"><%StringHelper.filterHTML(out, StringHelper.truncation(creditAssignment.F12, 12));%></a>
					</p>
				</span>
				<span><%=Formater.formatRate(creditAssignment.F14,false)%>%</span>
				<span><%=creditAssignment.F23%>/<%=creditAssignment.F22%>个月</span>
				<span><%=Formater.formatAmount(creditAssignment.F11)%>元</span>
				<span><%=Formater.formatAmount(creditAssignment.dsbx)%>元</span>
				<span><%=Formater.formatAmount(creditAssignment.F02)%></span> 
				<span>
				<%if(!(dimengSession!=null && dimengSession.isAuthenticated())){%>
				<a href="<%configureProvider.format(out,URLVariable.LOGIN);%>" style="cursor: pointer;">购买</a>
				 <%}else{ 
					 	UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
		                T6110 t6110 = userInfoManage.getUserInfo(serviceSession.getSession().getAccountId());
		                if(t6110.F06 == T6110_F06.ZRR) {
				 %>
				 <a onclick="buy(<%=creditAssignment.F02%>,<%=creditAssignment.F11%>,<%=creditAssignment.F25%>)" style="cursor:pointer;">购买</a>
				  <%}} %>
				</span>
				</li>
				<%}} %>
			</ul>
		</div>
	</div> 
	<%AbstractFinancingServlet.rendPaging(out, results,controller.getPagingURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Zqzrlb.class),parameter.getQueryString());%>
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
<%
UserManage userManage = serviceSession.getService(UserManage.class);
String usrCustId = null;
boolean tg = BooleanParser.parse(configureProvider.getProperty(SystemVariable.SFZJTG));
String action = "";
if(dimengSession!=null && dimengSession.isAuthenticated()){
	usrCustId = userManage.getUsrCustId();
}
if(tg){
	action = configureProvider.format(URLVariable.ESCROW_URL_EXCHANGE);
}else{
	action = configureProvider.format(URLVariable.TB_ZQZR);
}
%>
<form method="post" class="form1" action="<%=action %>" >
<input type="hidden" id="zqSucc" name="zqSucc" value="<%configureProvider.format(out, URLVariable.USER_ZQYZR);%>">
<input type="hidden" name="zqzrId" id="zqzrId">
<div class="popup_bg"  style="display: none;"></div>
<div class="dialog d_error w510" style="margin:-150px 0 0 -255px; display: none;" >
<%if(tg && StringHelper.isEmpty(usrCustId)){ %>
	<div class="dialog_close fr"><a></a></div>
	<div class="f16 mt30 pt50 pb50 tc ml30 mr30" style="background:#f3f3f3;">
       	 您需要在第三方托管平台上进行注册，才可购买债权！<br/>请<a target="_blank" href="<%=configureProvider.format(URLVariable.ESCROW_URL_USERREGISTER) %>" class="red">立即注册</a>！
   	</div>
<%}else{ %>
	<div class="dialog_close fr"><a></a></div>
    <div class="con clearfix">
      <div class="d_succeed fl"></div>
      <div class="info fr">
          <p class="f20 gray33">债权购买确认</p>
          	您此次购买债权为<i class="red"><span id="zqjz"><%=zqMoney%></span></i>元，需支付金额<i class="red"><span id="zrjg"><%=zfMoney%></span></i>,确认购买？
      </div>  
      <div class="clear" ></div>
      <div class="dialog_btn">
      <a href="javascript:void(0)" id="ok" class="btn btn01">确 定</a>
      <a href="javascript:void(0)" id="cancel" class="btn btn05">取 消</a></div>
    </div>
   <%} %>
</div>
</form>
</div>	
<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#zqSucc").val()));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
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
<script type="text/javascript">
$(".fullSlide").hover(function() {
    jQuery(this).find(".prev,.next").stop(true, true).fadeTo("show", 0.3)
},
function() {
    jQuery(this).find(".prev,.next").fadeOut()
});
$(".fullSlide").slide({
    titCell: ".hd ul",
    mainCell: ".bd ul",
    effect: "fold",
    autoPlay: true,
    autoPage: true,
    trigger: "click",
    startFun: function(i) {
        var curLi = $(".fullSlide .bd li").eq(i);
        if ( !! curLi.attr("_src")) {
            curLi.css("background-image", curLi.attr("_src")).removeAttr("_src")
        }
    }
});

</script>

</body>
</html>
