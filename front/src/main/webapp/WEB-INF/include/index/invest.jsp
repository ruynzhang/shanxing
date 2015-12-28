<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
<%@page import="com.dimeng.p2p.common.Expemonyinfo"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.BdxqTyj"%>
<%@page import="com.dimeng.p2p.common.enums.Tyjbdinfo_status"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>

<!--体验金-->
<% 
   BidManage bidge = serviceSession.getService(BidManage.class);
   Expemonyinfo tyjbid=bidge.getindexTyj();
%>
<%--
   <div class="sx_normal_box mt22 sx_ti_box">
      <div class="sx_ti_title"></div>
      <div class="sx_ti_picbox">
         <a href="<%=controller.getPagingItemURI(request, BdxqTyj.class,tyjbid.id)%>"><img src="images/ti_default.png" alt="" /></a>
      </div>
      <div class="sx_ti_ctbox">
        <div class="sx_ti_numTitle"><a href="<%=controller.getPagingItemURI(request, BdxqTyj.class,tyjbid.id)%>"><%StringHelper.filterHTML(out, tyjbid.title);%></a>
        <%if(tyjbid.estatus == Tyjbdinfo_status.YFB){%>
        <div class="sx_ti_time"></div>
        <%} %>
        </div>
        <div class="sx_ti_feature">
            <div class="sx_ti_feature_item sx_brr">
              <p><span class="f26 sx_pink"><%=Formater.formatAmount(tyjbid.borrint)%></span> %</p>
              <p>年利率 </p>
            </div>
            <div class="sx_ti_feature_item  sx_brr">
              <p><span class="f26 sx_pink"><%=Formater.formatAmount(tyjbid.borrmoney)%></span> 元</p>
              <p>体验金额</p>
            </div>
            <div class="sx_ti_feature_item">
              <p><span class="f26 sx_blue"><%=tyjbid.borrterm%></span> 天</p>
              <p>体验期限</p>
            </div>
        </div>
        <div class="sx_ti_processbox">
           <div class="sx_biao_item sx_biao_progress">
                <p><span class="sx_blue"><%=Formater.formatAmount(tyjbid.invetstment)%>元</span> / <%=Formater.formatAmount(tyjbid.borrmoney)%>元</p>
                <div class="sx_progress_box"><div class="sx_progress" style="width:<%=tyjbid.invetstment.doubleValue()/tyjbid.borrmoney.doubleValue()*100 %>%;"></div></div>
                <%=Formater.formatProgress(tyjbid.invetstment.doubleValue()/tyjbid.borrmoney.doubleValue()) %>
           </div>
           <div class="sx_ti_btbox">
                <%if(tyjbid.estatus == Tyjbdinfo_status.TBZ){%>
                 <%
            	//筹款时间比较
            	 Calendar caldar = Calendar.getInstance();
            	 caldar.setTime(tyjbid.releasetime);
            	 caldar.add(Calendar.DAY_OF_MONTH,tyjbid.fundraterm);
            	 Date date = new Date();
            	 //如果当前时间大于筹款的结束日期，则投标结束
            	if(date.compareTo(caldar.getTime())>0){%>
            	   <span class="btn btn02">已结束</span>
            	<%}else{ %>
            	<span><a href="<%=controller.getPagingItemURI(request, BdxqTyj.class,tyjbid.id)%>" class="ti_bt ti_bt01">立刻体验</a></span>
            	<%}
               }else{%>
            	<% if(tyjbid.estatus == Tyjbdinfo_status.HKZ) {%><span class="ti_bt ti_bt02">还款中</span><%}else{%><span class="ti_bt ti_bt03"><%=tyjbid.estatus.getChineseName() %></span><%}%>
               <%}%>
           </div>
        </div>
      </div>
   </div>
  <%} %>
<!--热门投资-->
<div class="bgBlock2" style="display:none;">
    <div class="sx_channels">
       <h1 class="sx_t1">投资频道</h1>
       <ul>
          <li>
             <h2>新手投资</h2>
             <p class="sx_ch_desc">善行创投为新手投资人挑选周期
短、最稳健的投资项目集。<a class="blueLink" href="<%configureProvider.format(out,URLVariable.GUIDE_URL);%>">查看详情</a></p>
             <p class="sx_baseMoney">起投资金<b>￥100</b></p>
             <p class="sx_ch_intro">目前已有<b class="sx_bluefont">1000</b>新手投资人加入，您也来加入尝试吧！</p>
             <a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class)%>?w=x" class="sx_joinBt">立即加入<span></span></a>
          </li>
          <li>
             <h2>资深投资</h2>
             <p class="sx_ch_desc">善行创投为有一定投资经验的投资人设立的投资板块，里面投资项目丰富、供您自由投资。<a class="blueLink" href="<%configureProvider.format(out,URLVariable.GUIDE_URL);%>">查看详情</a></p>
             <p class="sx_baseMoney">起投资金<b>￥500</b></p>
             <p class="sx_ch_intro">目前已有<b class="sx_bluefont">1200</b>位深投资人加入，您也来加入享受自由投资的乐趣吧！</p>
             <a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class)%>?w=z" class="sx_joinBt">立即加入<span></span></a>
          </li>
          <li>
             <h2>VIP投资</h2>
             <p class="sx_ch_desc">VIP投资频道，是善行创投为高端投资人精心设立的投资板块，里面投资项目金额较大，独享VIP高端投资服务。<a class="blueLink" href="<%configureProvider.format(out,URLVariable.GUIDE_URL);%>">查看详情</a></p>
             <p class="sx_baseMoney">起投资金<b>￥50,000</b></p>
             <p class="sx_ch_intro">目前已有<b class="sx_bluefont">999</b>位VIP投资人加入，您
也来加入享受高端私人订制的VIP投资服务吧！</p>
             <a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class)%>?w=v" class="sx_joinBt">立即加入<span></span></a>
          </li>
          <li class="last">
             <h2>更多投资专区</h2>
             <p>为您提供私人定制专享投资理财专
区，尽请期待！<a class="blueLink" href="<%configureProvider.format(out,URLVariable.GUIDE_URL);%>">查看详情</a></p>
             <a href="javascript:;" class="sx_onlineBt">即将上线</a>
          </li>
       </ul>
       <div class="clear"></div>
    </div>
</div> --%>
<!--热门投资-->