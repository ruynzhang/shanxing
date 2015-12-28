
        <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>


        <!--顶部条-->
        <div class="bgBlock1">
        <div id="sx_topbox">
        <span class="sx_phone"><i></i>客服电话:&nbsp;<%configureProvider.format(out,SystemVariable.SITE_CUSTOMERSERVICE_TEL);%></span>
        <div class="sx_regbox">
            <%String accountName = null;
	   if (dimengSession == null || !dimengSession.isAuthenticated()) {%>
        <a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">登录</a>
        <a href="<%configureProvider.format(out,URLVariable.REGISTER);%>">注册</a>
            <%} else { accountName = serviceSession.getService(UserManage.class).getAccountName();%>
        <a  title="<%=accountName%>">您好：<%StringHelper.truncation(new HTMLFilter(out), accountName, 12);%></a>
        <a href="<%=configureProvider.format(URLVariable.USER_INDEX) %>">我的账户</a>
            <%
					UserInfoManage userInfoManage=serviceSession.getService(UserInfoManage.class);
        			T6110 t6110=userInfoManage.getUserInfo(serviceSession.getSession().getAccountId());
					if(t6110.F07==T6110_F07.HMD||t6110.F07==T6110_F07.SD)
					{
						controller.redirectLogin(request, response, controller.getURI(request, Logout.class));
						return;
					}
                	int count = 0;
                  	if (dimengSession != null && dimengSession.isAuthenticated()) {
						count = serviceSession.getService(LetterManage.class).getUnReadCount();
                  	}
				%>
        <a href="<%configureProvider.format(out, URLVariable.USER_LETTER);%>">站内信(<span class="red"><%=count %></span>)</a>
        <a href="http://test.myshanxing.com/loginoutDiscuz.html">安全退出</a>
            <%}%></div>
        <div class="sx_share"><a href="http://qm.qq.com/cgi-bin/qm/qr?k=tNDaYLzeTm6TmqbLe_dD9eyO5iwd1qRs" class="sx_s3" target="_blank" rel="nofollow">QQ</a><a href="http://weibo.com/u/5329738108" class="sx_s2" target="_blank" rel="nofollow">微博</a><a href="#" class="sx_s1">微信</a><div class="sx_wechat_box"><span></span><p><img src="/images/wechat_shanxing.png" alt="" /></p></div><div class="sx_qq_box"><span></span><p>点击加入善行创投QQ群</p></div></div>
        <div class="clear"></div>
        </div>
        </div>


        <!--logo导航栏-->
        <div class="bgblock_menu">
        <div id="sx_menubox">
        <div class="sx_logo"><a href="<%configureProvider.format(out,URLVariable.INDEX);%>"><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.QTLOGO))%>" title="<%configureProvider.format(out,SystemVariable.SITE_NAME);%>"></a></div>
        <div class="sx_menu">
        <a href="<%configureProvider.format(out,URLVariable.INDEX);%>" id="nav_1">首页</a>
        <a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>" id="nav_2">我要投资</a>
        <a href="<%configureProvider.format(out,URLVariable.CREDIT_DKYX);%>" id="nav_3">我要借款</a>
        <a href="/guide.html" id="nav_4">理财攻略</a>
        <a href="/safe/risk.html" id="nav_5">风险控制</a>
        <a target="_blank" href="http://192.168.3.189/shanlinclub" id="nav_6">善林荟</a>
        </div>
        <div class="clear"></div>
        </div>
        </div>

        <div class="clear"></div>