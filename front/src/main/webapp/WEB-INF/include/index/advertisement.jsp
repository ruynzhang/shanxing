<%@page import="com.dimeng.p2p.modules.base.front.service.NoticeManage"%>
<%@page import="com.dimeng.p2p.S50.entities.T5015"%>
<%@page import="com.dimeng.p2p.S50.entities.T5016"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.AdvertisementManage"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript">
	var isNull = /^[\s]{0,}$/;
	var verify = /^\d{<%=systemDefine.getVerifyCodeLength() %>}$/;
	var loginName = /^[a-z]([\w]*)$/i;
    var loginErrorTip;
    
	function accountCheck() {
		var val = $("input[name='accountName']").val();
		var loginErrorTip = $("#loginErrorTip");
		loginErrorTip.html("&nbsp;");
		loginErrorTip.removeClass("red");
		if (isNull.test(val)) {
			loginErrorTip.html("用户名不能为空");
			loginErrorTip.addClass("red");
			return false;
		}
		return true;
	}
	function passwordCheck() {
		var val = $("input[name='password']").val();
		var loginErrorTip = $("#loginErrorTip");
		loginErrorTip.html("&nbsp;");
		loginErrorTip.removeClass("red");
		if (isNull.test(val)) {
			loginErrorTip.html("密码不能为空");
			loginErrorTip.addClass("red");
			return false;
		}
		return true;
	}
	function verifyCheck() {
		var val = $("input[name='verifyCode']").val();
		var loginErrorTip = $("#loginErrorTip");
		loginErrorTip.html("&nbsp;");
		loginErrorTip.removeClass("red");
		if (isNull.test(val)) {
			loginErrorTip.html("验证码不能为空");
			loginErrorTip.addClass("red");
			return false;
		} else if (!verify.test(val)) {
			loginErrorTip.html("您输入的验证码有误");
			loginErrorTip.addClass("red");
			return false;
		}
		return true;
	}
	function onSubmit() {
		return accountCheck() && passwordCheck() && verifyCheck();
	}
	</script>
<!--banner-->
<div class="w1002">
 <%String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR); %>
 <%--if (dimengSession == null || !dimengSession.isAuthenticated()) {%>
<div class="login" style="display:none;">
			    <div class="bd hsbg"></div>
                <!--登录前-->  
                <div class="bd_nr">
       			<div class="title">登录<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="fr">免费注册</a></div> 
                    <form action="/user/login.htm" method="post" onsubmit="return onSubmit();">
                    <input type="hidden" name="type" value="index"/>
                    <div class="mb10 ml10 bot pt10">账号：</div>          	
                    <div class="mb10"><input name="accountName" type="text" class="inp1"  maxlength="20" onblur="accountCheck();"/></div> 
                    <div class="mb10 ml10"><a href="<%configureProvider.format(out, URLVariable.GET_PASSWORD);%>" class="fr blue f12">忘记密码? </a>密码：</div> 
                    <div class="mb10"><input name="password" type="password" class="inp2"  maxlength="20" onblur="passwordCheck();"/></div> 
                    <div class="mb10 ml10">验证码：</div> 
                    <div class="mb10"><input name="verifyCode" type="text" class="inp3"  maxlength="6" /><img id="_verifyImg" src="/user/loginVerify.htm" onclick="$('#_verifyImg').attr('src','/user/loginVerify.htm?'+Math.random())" width="80" height="40" /></div> 
                   <span id="loginErrorTip" class="red">&nbsp;<%StringHelper.filterHTML(out, errorMessage); %></span>
                   <div><input type="submit" class="put" value="登  录" /></div> 
    			   </form>
    			</div>  
</div>
<%} --%>   
</div>
<%--{
	AdvertisementManage advertisementManage = serviceSession.getService(AdvertisementManage.class);
	T5016[] advertisements = advertisementManage.getAll();
	if (advertisements != null && advertisements.length > 0) {
%>
<div class="focus" style="display:none;">
  <ul class="rslides f426x240">
  <%for(T5016 advertisement : advertisements){
      if (advertisement == null) {continue;}%>
      
    <li style="background: url(<%=fileStore.getURL(advertisement.F05)%>) no-repeat top center; width:100%; height:460px;" title="<%StringHelper.filterHTML(out, advertisement.F03);%>" <%if(!StringHelper.isEmpty(advertisement.F04)){%>onclick="location.href='<%StringHelper.filterHTML(out, advertisement.F04);%>';"<%}%>></li>
  <%}%>
  </ul>
</div>
<div class="clear"></div>
<!--banner-->
<%}}--%>
	<%--<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/focus.js"></script>--%>
<!--------幻灯栏-------->
<div class="sx_wrap">
<div id="sx_regwrapper">
       <h1>善行创投历史年化收益率</h1>
       <p>平均<b class="b1">8%-15%</b></p>
       <p><b class="b2">40</b>倍活期存款收益</p>
       <p><b class="b2">4</b>倍货币基金收益</p>
       <a href="<%configureProvider.format(out, URLVariable.REGISTER);%>" class="sx_regbt">立即注册</a>
       <p class="sx_login">已有账号？<a href="<%configureProvider.format(out, URLVariable.LOGIN);%>">立即登录</a></p>
   </div>
</div>
<div id="sx_phototurn">
   
   <div class="fullSlide">
  <div class="bd">
    <ul>
      <li _src="url(images/banner01.jpg)" style="background:#ffffff center 0 no-repeat;"><a target="_blank" href="/active/surprise.html"></a></li>
      <li _src="url(images/banner08.jpg)" style="background:#4bb08e center 0 no-repeat;"><a target="_blank" href="/active/grade.html"></a></li>
      <li _src="url(images/banner02.jpg)" style="background:#245983 center 0 no-repeat;"><a target="_blank" href="http://www.shanlinhui.com"></a></li>
    </ul>
  </div>
  <div class="hd">
    <ul>
    </ul>
  </div>
  <span class="prev"></span> <span class="next"></span> </div>
</div>

<div class="sx_sysnews">
	<div class="t_news">
		<i></i><b>平台公告</b>
		<ul class="sx_news_li">
		<%
		NoticeManage noticeManage = serviceSession.getService(NoticeManage.class);
		PagingResult<T5015> results1 = noticeManage.search(
				new Paging() {
						public int getCurrentPage() {
							return 1;
						}

						public int getSize() {
							return 3;
						}
					});
		T5015[] notices = results1.getItems();
			if (notices != null && notices.length > 0) {
				for (T5015 notice : notices) {%>
				<li><a href="<%configureProvider.format(out,URLVariable.WZGG_XQ);%><%=notice.F01%>.html" target="_blank"><%=notice.F05%></a></li>
		<%		}
			}
		%>
		</ul>
		<ul class="sx_swap"></ul>
        <span class="sx_news_more"><a href="<%configureProvider.format(out,URLVariable.WZGG_XQ);%>">更多&gt;&gt;</a></span>
	</div>
</div>
