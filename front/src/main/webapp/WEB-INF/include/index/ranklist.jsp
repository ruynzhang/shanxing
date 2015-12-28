<%@page import="com.dimeng.p2p.S62.enums.SURPRISE_STATUS"%>
<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Xxzqlb"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.query.QyBidQueryAccount"%>
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
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/inside.css" />
<%!static final String RATE_KEY="r"; static final String PROGRESS_KEY="p";static final String TYPE_KEY="t";static final String MULTISELECT_KEY="s";
	static final String ORDER_KEY="o";static final String WAY="w";%>
	<%
	
	BidManage bidManage = serviceSession.getService(BidManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	final String way = requestWrapper.getParameter(WAY);
	String w = "";
    if (!StringHelper.isEmpty(way)) {
    	w = "?w="+way;
    }
	Tztjxx total=bidManage.getStatisticsQy();
	T6211[] t6211s= bidManage.getBidType();
	T5124[] t5124s= bidManage.getLevel();
	boolean multiSelect = "1".equals(request.getParameter(MULTISELECT_KEY));
	URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class),multiSelect,MULTISELECT_KEY,TYPE_KEY,RATE_KEY,PROGRESS_KEY,WAY);
	parameter.set(WAY, way);
	String[] values=requestWrapper.getParameterValues(TYPE_KEY);
	PagingResult<Bdlb> result = bidManage.searchQyAccount(
	new QyBidQueryAccount() {
		public int getRate() {
			int rate=IntegerParser.parse(requestWrapper.getParameter(RATE_KEY));
			return rate;
			}
		public int getJd() {
			int progress=IntegerParser.parse(requestWrapper.getParameter(PROGRESS_KEY));
			return progress;
			}
		public T6230_F20 getStatus() {
			return EnumParser.parse(T6230_F20.class, requestWrapper.getParameter(TYPE_KEY));
			}
		public int getOrder(){
			return 0;
		}
		public String getWay(){
			return way;
		}
	},null, new Paging() {
		public int getCurrentPage() {return IntegerParser.parse(requestWrapper.getParameter("paging.current"));}public int getSize() {return 4;}
	}); 
	 
%>

<!--标栏-->
   <div class="sx_normal_box mt22 sx_mh">
     <div class="sx_box_title"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class)%>" class="sx_info_more">更多&gt;&gt;</a>最新投资列表</div>
     <div class="sx_box_subtitle">惊喜奖是标的满标放款后按照您预期收益的奖励百分比直接转账到您账户，投资金额越大，返现越多</div>
     <div class="sx_biao_list">
       <ul>
       <%
          Bdlb[] creditInfos=result.getItems();
       	  int i=0;
          if(creditInfos!=null){
        	  for (Bdlb creditInfo:creditInfos){
        		  i++;
        %>
         <li <%if(i==4){out.print("class=\"biao_end\"");} %>>
           <div class="sx_biao_redTag" style="left:400px;"></div>
           <div class="sx_biao_img"><img src="<%if(StringHelper.isEmpty(creditInfo.F12)){%><%=controller.getStaticPath(request)%>/images/details_image.jpg<%}else{%><%=fileStore.getURL(creditInfo.F12) %><%}%>" /></div>
           <div class="sx_biao_titlebox">
              <div class="sx_biao_bt">
              	<%if(creditInfo.F11 == T6230_F20.TBZ){%>
                <span><a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>" class="btn btn01">投标</a></span>
                <%}else if(creditInfo.F11 == T6230_F20.YJQ){%>
                <span class="btn btn02">已结清</span>
                <%}else{%>
                <span class="btn btn03"><%=creditInfo.F11.getChineseName()%></span>
                <%} %>
              </div>
              <p class="sx_biao_txt"><%if(creditInfo.investName!=null){%><font style="color: red;font-weight: bold;">[预约标]</font><%}%><a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>"><a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>"><%StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.F04, 10));%></a></p>
           </div>
           <div class="sx_biao_ele">
              <div class="sx_biao_item sx_brr w200">
                 <p>
                 <span class="sx_pink f18"><%=Formater.formatRate(creditInfo.F07.subtract(creditInfo.bonus.divide(new BigDecimal("100"))),false)%></span><span>%</span> + <span class="sx_pink f18"><%=creditInfo.bonus%></span><span>%</span>
                <%if(creditInfo.surpriseStatus != null && creditInfo.surpriseStatus != SURPRISE_STATUS.WPZ){ %> + <span class="sx_pink f18">惊喜奖</span><%}%>
                 </p>
                 <p class="f12">年利率 + 鼓励奖 <%if(creditInfo.surpriseStatus != null && creditInfo.surpriseStatus != SURPRISE_STATUS.WPZ){ %>+ 惊喜奖<%}%></p>
              </div>
              <div class="sx_biao_item sx_brr">
                <p><%if(T6231_F21.S == creditInfo.F19){out.print("<span class=\"sx_blue f18\">"+creditInfo.F20 + "</span> 天");}else{out.print("<span class=\"sx_blue f18\">"+creditInfo.F10 + "</span> 个月");} %></p>
                <p>项目期限</p>
              </div>
              <div class="sx_biao_item sx_biao_progress">
                <p>
                 <%if(creditInfo.F08.intValue()==0){%>
                 <span class="sx_blue">融资完成 <%if(creditInfo.F06.doubleValue()>=10000){out.print(creditInfo.F06.doubleValue()/10000+"万");}else{out.print(Formater.formatAmount(creditInfo.F06)+"元");}%></span>
                 <%}else{ if(creditInfo.F08.doubleValue()>=10000){%> 
                 <span class="sx_blue">剩余<%=creditInfo.F08.doubleValue()/10000%>万元</span>
                 <%}else{%>
                  <span class="sx_blue">剩余<%=Formater.formatAmount(creditInfo.F08)%>元</span>
                 <%}if(creditInfo.F11 == T6230_F20.HKZ || creditInfo.F11 == T6230_F20.YJQ || creditInfo.F11 == T6230_F20.YDF){
            		creditInfo.F06 = creditInfo.F06.subtract(creditInfo.F08);
            		creditInfo.proess = 1;
            	   }
            	if(creditInfo.F06.doubleValue()>=10000){out.print("/ "+creditInfo.F06.doubleValue()/10000+"万");}else{out.print("/ "+Formater.formatAmount(creditInfo.F06)+"元");}}%>
                </p>
                <div class="sx_progress_box"><div class="sx_progress" style="width:<%=(int)(creditInfo.proess*100)%>%"></div></div><%=Formater.formatProgress(creditInfo.proess)%>
              </div>
           </div>
           <div class="clear"></div>
         </li>
         <%}} %>
       </ul>
     </div>
   </div>
<div class="clearfix invest" style="display:none;">
	<div class="invest_ico1"></div>
    <div class="fl invest_title">理财风云榜</div>
    <div class="invest_ico2"></div>
</div>
<!--理财风云榜-->
<!--------广告栏-------->
<div id="sx_adbox" style="display:none;">
  <a href="#"><img src="images/ad1.jpg" alt="" /></a>
</div>
<!--------广告栏-------->
<script type="text/javascript">
		<%
		 long end = 1418176800000l - System.currentTimeMillis();
		%>
		var endTime =<%=end%>;
		var clearTime = null;
		function time() {
			var leftsecond = parseInt(endTime / 1000);
			if (leftsecond <= 0) {
				clearInterval(clearTime);
				location.reload(true);
			}
			var day = Math.floor(leftsecond/ (86400)) < 0 ? 0 : Math.floor(leftsecond / (86400));
			var hour = Math.floor((leftsecond - day * 86400) / 3600) < 0 ? 0: Math.floor((leftsecond - day * 86400) / 3600);
			var minute = Math.floor((leftsecond - day* 86400 - hour * 3600) / 60) < 0 ? 0: Math.floor((leftsecond - day* 86400 - hour * 3600) / 60);
			var second = Math.floor(leftsecond - day* 86400 - hour * 3600- minute * 60) < 0 ? 0 : Math.floor(leftsecond - day * 86400 - hour * 3600 - minute* 60);
			if(hour<10)
			{
				hour="0"+hour;	
			}
			if(minute<10)
			{
				minute="0"+minute;	
			}
			if(second<10)
			{
				second="0"+second;	
			}
			$("#tian").html("    ("+day+'天)');
			$(".time").html('<p class="orange mt10"><span class="details_bg">'+hour+'</span><span class="details_ico"></span><span class="details_bg">'+minute+'</span><span class="details_ico"></span><span class="details_bg">'+second+'</span><div class="clear"></div></p>');
		}
		<%if(end > 0l){%>
			clearTime = setInterval(function() {
			endTime = endTime - 1000;
			time();
		}, 1000);
		<%}else{%>
			clearInterval(clearTime);
		<%}%>
</script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/common.js"></script>
