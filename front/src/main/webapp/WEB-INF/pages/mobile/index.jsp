<!DOCTYPE html>
<%@page import="java.sql.Timestamp"%>
<%@page import="org.joda.time.DateTime"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sxbao.Index"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.entities.SxbaoType"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.service.SxbaoManage"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.query.QyBidQueryAccount"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdlb"%>
<%@page import="com.dimeng.util.http.URLParameter"%>
<%@page import="com.dimeng.p2p.S51.entities.T5124"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Tztjxx"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
<%@page import="com.dimeng.p2p.account.front.service.UserManage"%>
<%@page import="com.dimeng.p2p.front.servlets.UpdatePassword"%>
<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@taglib uri="http://www.opensymphony.com/oscache" prefix="oscache" %>

<% 
String path = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
CURRENT_CATEGORY="INDEX";
%>
<html lang="en">
<head>
    <title><%configureProvider.format(out,SystemVariable.SITE_TITLE);%></title>
	<%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
</head>
<body>

<input type="hidden" id="path" value="<%=path %>" />

 <!---top--->
   <%@ include file="header.jsp"%>

    <!----container-->
   <div class="index_wrap">
       <!----banner-->
           <ul id="lunboUl" class="bxslider">
           </ul>
   </div>
<!--end banner--->
   <!---标--->
   <div class="index-list" style="display:none">
      
           <span class="list-item-icon wx_icon_new">活期</span>
           <input type="hidden" id="borrowJd" value="93">
           
           <%SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
             List<SxbaoType> types = sxbaoManage.findAllType();
             for(int i=0;i<types.size();i++) {
            	 SxbaoType sxbaoType = types.get(i);
                 if(i==0){
           %>
          <ul>
           <li class="index-list-title clearfix">
               <span><%=sxbaoType.name%></span>
              <!--  <em class="wx_icon_box"><ins class="wx_icon wx_limited">限额</ins><ins class="wx_icon wx_transfer">可转</ins></em>-->
           </li>
           
           <li class="index-list-state">
               <div class="index-list-rate"> <p>状态</p> <p><em class="index-list-p"><%=sxbaoType.sellStatus == T6230_F13.S?"在售":"停售"%></em></p> </div>
               <div> <p>已售总额</p> <p><em class="index-list-p">￥<%=Formater.formatAmount(sxbaoType.totalAmount)%>元</em></p> </div>
               <!--  <div> <p>规模</p> <p><em class="index-list-p">20.00万元</em></p> </div>-->
               <div class="index-hq-btn"> <a <%=sxbaoType.sellStatus == T6230_F13.S?"href=\""+controller.getPagingItemURI(request, Index.class, sxbaoType.id)+"\"":"style=\"background:#ccc !important; color:#333;\" href=\"javascript:void(0);\""%> class="index-btn">立即投资</a> </div>
           </li>
           </ul>
           <%
                 }
             }
           %>
       </ul>
   </div>
   <!--end -->
 <!---标--->

<!--end -->
   <!---标--->
   <div class="index-list" >
       
   <%!static final String RATE_KEY = "r";
	static final String PROGRESS_KEY = "p";
	static final String TYPE_KEY = "t";
	static final String MULTISELECT_KEY = "s";
	static final String ORDER_KEY = "o";
	static final String WAY = "w";%>

   <%
   	    BidManage bidManage = serviceSession.getService(BidManage.class);
   		final HttpServletRequestWrapper requestWrapper = new HttpServletRequestWrapper(request);
   		final String way = requestWrapper.getParameter(WAY);
   		String w = "";
   		if (!StringHelper.isEmpty(way)) {
   			w = "?w=" + way;
   		}
   		Tztjxx total = bidManage.getStatisticsQy();
   		T6211[] t6211s = bidManage.getBidType();
   		T5124[] t5124s = bidManage.getLevel();
   		boolean multiSelect = "1".equals(request.getParameter(MULTISELECT_KEY));
   		URLParameter parameter = new URLParameter(request, controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class), multiSelect, MULTISELECT_KEY, TYPE_KEY, RATE_KEY, PROGRESS_KEY, WAY);
   		parameter.set(WAY, way);
   		String[] values = requestWrapper.getParameterValues(TYPE_KEY);
   		PagingResult<Bdlb> result = bidManage.searchQyAccount(new QyBidQueryAccount() {
   			public int getRate() {
   				int rate = IntegerParser.parse(requestWrapper.getParameter(RATE_KEY));
   				return rate;
   			}

   			public int getJd() {
   				int progress = IntegerParser.parse(requestWrapper.getParameter(PROGRESS_KEY));
   				return progress;
   			}

   			public T6230_F20 getStatus() {
   				return EnumParser.parse(T6230_F20.class, requestWrapper.getParameter(TYPE_KEY));
   			}

   			public int getOrder() {
   				return 0;
   			}

   			public String getWay() {
   				return way;
   			}
   		}, null, new Paging() {
   			public int getCurrentPage() {
   				return IntegerParser.parse(requestWrapper.getParameter("paging.current"));
   			}
   			public int getSize() {
   				return 5;
   			}
   		});
   %>

   <!-- <span class="list-item-icon wx_icon_new">新手</span>-->
           <input type="hidden" id="borrowJd" value="93">

           <%
             boolean tag = true;
             String statusButtonTemp = null;
             Bdlb[] bdlbs=result.getItems();
             if(bdlbs!=null){
              for (int i=0;i<bdlbs.length;i++) {
               Bdlb bdlb = bdlbs[i];
               if (bdlb == null) {continue;}
               
               T6230_F20 status = bdlb.F11;
               
               if(status == T6230_F20.TBZ || status == T6230_F20.DFK){
           	   if(new DateTime(bdlb.F13).plusDays(bdlb.F09).getMillis() - System.currentTimeMillis() <= 0){
           	    statusButtonTemp = "已完结";
           	   }else if(status == T6230_F20.DFK){
           	    statusButtonTemp = status.getChineseName();
           	   }else{
           	    statusButtonTemp = "立即投资";
           	   }
           	  }else{
           	   statusButtonTemp = status.getChineseName();
           	  }
           %>
           <a style="color:#666" href="/mobile/bidDetail.html?id=<%=bdlb.F02 %>">
          <ul>
           <li class="index-list-title clearfix">
               <span><%StringHelper.filterHTML(out, StringHelper.truncation(bdlb.F04, 12));%></span>
           </li>
           <li class="lastLi">
               <div class="index-list-rate"> <p>年化收益率</p> <p><em class="index-list-p"><%=Formater.formatRate(bdlb.F07.subtract(bdlb.bonus.divide(new BigDecimal("100"))),false)%>% <%if(bdlb.bonus.compareTo(BigDecimal.ZERO)==1){out.print("+ "+bdlb.bonus+"%");}%></em></p> </div>
               <div> <p>期限</p> <p><em class="index-list-p"><%if(T6231_F21.S == bdlb.F19){out.print(bdlb.F20 + "天");}else{out.print(bdlb.F10 + "个月");} %></em></p> </div>
               <!--  <div> <p>规模</p> <p><em class="index-list-p">20.00万元</em></p> </div>-->
               
               <%if(bdlb.F11 == T6230_F20.HKZ || bdlb.F11 == T6230_F20.YJQ || bdlb.F11 == T6230_F20.YDF) {
            	   bdlb.F06 = bdlb.F06.subtract(bdlb.F08);
            	   bdlb.proess = 1;
            	   bdlb.F08 = new BigDecimal(0);
               }%>
               <div class="index-list-btn">
                   <%if(bdlb.F11 != T6230_F20.YFB) {%>
                    <div class="index-progress"><div class="wx_progress"><span style="width:<%=(int)(bdlb.proess*100)%>%"></span></div><ins><%=(int)(bdlb.proess*100)%>%</ins></div>
                    
                    <%if(bdlb.F11 == T6230_F20.TBZ){%>
                     <%if(statusButtonTemp!=null&&statusButtonTemp.equals("立即投资")){ %>
                    <a class="index-btn" href="/mobile/bidDetail.html?id=<%=bdlb.F02 %>">立即投资</a>
                     <%}else{ %>
                     <a class="index-btn repay"><%=statusButtonTemp %></a>
                     <%} %>
                    <%}else{ %>
                     <%if(bdlb.F11 == T6230_F20.HKZ) {%><a class="index-btn repay">还款中</a>
                     <%}else{%><a class="index-btn repay"><%=statusButtonTemp %></a><%}%>
                    <%} %>
                   
                   <%} %>
                   <%else{ %>

                     <div class="index_list_start"><p style="width:100%"><%=TimestampParser.format(bdlb.F13,"yyyy-MM-dd HH:mm")%></p><p><em class="index-list-p">即将开启</em></p></div>

                   <%} %>
                   
               </div>
           </li>
           </ul></a>
          <%
           }}
          %>
   </div>
   <!--end -->

   <!----更多项目----->
   <div class="index-more"><a href="<%=path %>/mobile/list.html">更多项目</a></div>
   <%@include file="/WEB-INF/pages/mobile/download.jsp" %>
   <!----end----->

   <!---footer-->
   <%@ include file="footer.jsp"%>
<!--end footer-->

   <script type="text/javascript" src="/mobile/js/jquery.js"></script>
   <!--轮播切换-->
   <script type="text/javascript" src="/mobile/js/jquery.bxslider.js"></script>
   <script>
       $(function(){
    	   var url = $("#path").val()+"/proxy/app/home/banner.action";
           
           $.post(url, {
            jsonData : null
           }, function(data) {
         	  console.info("回调数据" + data);
         	  if(data.sc==200){
         		  var body = data.body;
         		  
         		  $("#lunboUl").empty();
         		  console.info("body:" + body);
         		  for(var i=0;i<body.length;i++){
          			  var single =  body[i];
          			  var title = single.title;
             		  var singleUrl = single.url;
             		  var picturePath = single.picturePath;
             		  
             		  console.info("title["+i+"]:" + title);
             		  $("#lunboUl").append("<li><a href=\""+singleUrl+"\"><img src=\""+picturePath+"\" alt="+title+"/></a></li>");
         		  }
         		 $('.bxslider').bxSlider();
         	  }
           });
       });
   </script>
</body>
</html>