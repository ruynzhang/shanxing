<%@page import="com.dimeng.p2p.account.front.service.UserManage"%>
<%@page import="com.dimeng.p2p.S50.entities.T5015"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.NoticeManage"%>

<%
UserManage mag = serviceSession.getService(UserManage.class);
Integer countAcc=mag.countAccount();
Integer countInv=mag.countInvestAmount();
%>

<div class="sx_normal_box sx_databox">
       <ul>
         <li class="sx_data_bg"></li>
         <li>
           <p class="sx_data_title">善粉很爱我，共有粉丝</p>
           <p class="timer count-title f32 sx_pink count-number" data-to="<%=countAcc-2000%>" data-speed="1500"></p>
         </li>
         <li>
           <p class="sx_data_title">善粉很积极，共投了</p>
           <p style="float:right;" class="timer count-title f32 sx_pink count-number" data-to="<%=countInv-134942%>" data-speed="1500"></p><span class="f32 sx_pink" style="float:right;">￥</span>
         </li>
       </ul>
       <div class="clear"></div>
</div>
<%--
<div class="sx_introbox" style="display:none;"> 
    <div class="sx_outline1">
    <div class="sx_intro_wordbox">
     <h1 class="sx_t1">为什么要选择善行创投</h1>
     <div class="sx_txt1">善行创投 （ www.myshanxing.com ) 是由深圳市前海善林资产管理有限公司倾力打造的互联网投资理财平台，注册资金8888万元人民币。平台致力于为国内外投资人与融资方提供高效、安全的......<a href="<%configureProvider.format(out, URLVariable.GYWM_GSJJ);%>">了解更多&gt;&gt;</a>
     </div>
     <div class="sx_intro_numbox">
                              <h2 style="float:right;"class="timer count-title" id="count-number" data-to="<%=countInv-134942%>" data-speed="1500"></h2><h2 style="float:right;">￥</h2>
          <p class="clear"></p><p>投资已在善行创投完成</p>
     </div>
     <div class="sx_intro_numbox">
          <h2 class="timer count-title" id="count-number" data-to="<%=countAcc-2000%>" data-speed="1500"></h2>
          <p>投资人的首选</p>
     </div>
     <div class="clear"></div>
    </div>
    </div>
    <div class="sx_intro_advantage">
      <ul>
        <li>
           <span class="it1"></span>
           <h2>年化收益率8%-15%</h2>
           <p><b>40</b>倍银行存款利息，<br /><b>100</b>元起步</p>
        </li>
        <li class="sx_advantage_middle">
           <span class="it2"></span>
           <h2>最安全的网上理财</h2>
           <p><b>7道</b>独创审核体系，<br /><b>100%本息保障</b></p>
        </li>
        <li>
           <span class="it3"></span>
           <h2>随时随地赎回投资</h2>
           <p>突然急用钱想收回投资？<br />最快<b>当天到账</b></p>
        </li>
      </ul>
      <div class="clear"></div>
    </div>
</div>
 --%>
