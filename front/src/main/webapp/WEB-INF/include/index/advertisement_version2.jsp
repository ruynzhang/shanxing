<%@page import="com.dimeng.p2p.modules.base.front.service.NoticeManage"%>
<%@page import="com.dimeng.p2p.S50.entities.T5015"%>
<%@page import="com.dimeng.p2p.S50.entities.T5016"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.AdvertisementManage"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<div class="sx_wrap">
<div id="sx_regwrapper">
         <h1>善行创投历史年化收益率</h1>
       <p class="reg_focous"><font style="font-size: 18px;">平均</font><b class="b1">15%</b></p>
       <p><span class="reg_left"><b class="b2">40</b>倍活期存款收益</span><span class="reg_right"><b class="b2">4</b>倍货币基金收益</span></p>
       
       <p><a href="<%configureProvider.format(out, URLVariable.REGISTER);%>" class="sx_regbt c1">注册</a><a href="<%configureProvider.format(out, URLVariable.LOGIN);%>" class="sx_regbt2 c2">登录</a></p>
       <p><a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>" class="sx_regbt c3">投资</a><a href="<%configureProvider.format(out, URLVariable.USER_CHARGE);%>" class="sx_regbt2 c4">充值</a></p>
   </div>
</div>
<%{
	AdvertisementManage advertisementManage = serviceSession.getService(AdvertisementManage.class);
	T5016[] advertisements = advertisementManage.getAll();
	if (advertisements != null && advertisements.length > 0) {
%>
<div id="sx_phototurn">  
   <div class="fullSlide">
  <div class="bd"> 
    <ul>
      <%for(T5016 advertisement : advertisements){if (advertisement == null) {continue;}%>
	<li _src="url(<%=fileStore.getURL(advertisement.F05)%>)" style="background:#ffffff center 0 no-repeat;" title="<%StringHelper.filterHTML(out, advertisement.F03);
	%>"><%if(!StringHelper.isEmpty(advertisement.F04)){%><a target="_blank" href="<%StringHelper.filterHTML(out, advertisement.F04);%>"></a><%}%></li>
	<%}%>
    </ul>
  </div>
  <div class="hd">
    <ul>
    </ul>
  </div>
  <span class="prev"></span> <span class="next"></span> </div>
</div>
<%}}%>

<script>
$(function(){
    $(".c1").hover(function(){
     $(this).html("注册送50元红包");
    $(this).css({'font-size':'16px','height':'23px','display':'inline'});
    },function(){
    $(this).html("注册");
    $(this).css('font-size','18px');
    })
    })
 </script>