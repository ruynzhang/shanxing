
        <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>


        <!--������-->
        <div class="bgBlock1">
        <div id="sx_topbox">
        <span class="sx_phone"><i></i>�ͷ��绰:&nbsp;<%configureProvider.format(out,SystemVariable.SITE_CUSTOMERSERVICE_TEL);%></span>
        <div class="sx_regbox">
            <%String accountName = null;
	   if (dimengSession == null || !dimengSession.isAuthenticated()) {%>
        <a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">��¼</a>
        <a href="<%configureProvider.format(out,URLVariable.REGISTER);%>">ע��</a>
            <%} else { accountName = serviceSession.getService(UserManage.class).getAccountName();%>
        <a  title="<%=accountName%>">���ã�<%StringHelper.truncation(new HTMLFilter(out), accountName, 12);%></a>
        <a href="<%=configureProvider.format(URLVariable.USER_INDEX) %>">�ҵ��˻�</a>
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
        <a href="<%configureProvider.format(out, URLVariable.USER_LETTER);%>">վ����(<span class="red"><%=count %></span>)</a>
        <a href="http://test.myshanxing.com/loginoutDiscuz.html">��ȫ�˳�</a>
            <%}%></div>
        <div class="sx_share"><a href="http://qm.qq.com/cgi-bin/qm/qr?k=tNDaYLzeTm6TmqbLe_dD9eyO5iwd1qRs" class="sx_s3" target="_blank" rel="nofollow">QQ</a><a href="http://weibo.com/u/5329738108" class="sx_s2" target="_blank" rel="nofollow">΢��</a><a href="#" class="sx_s1">΢��</a><div class="sx_wechat_box"><span></span><p><img src="/images/wechat_shanxing.png" alt="" /></p></div><div class="sx_qq_box"><span></span><p>����������д�ͶQQȺ</p></div></div>
        <div class="clear"></div>
        </div>
        </div>


        <!--logo������-->
        <div class="bgblock_menu">
        <div id="sx_menubox">
        <div class="sx_logo"><a href="<%configureProvider.format(out,URLVariable.INDEX);%>"><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.QTLOGO))%>" title="<%configureProvider.format(out,SystemVariable.SITE_NAME);%>"></a></div>
        <div class="sx_menu">
        <a href="<%configureProvider.format(out,URLVariable.INDEX);%>" id="nav_1">��ҳ</a>
        <a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>" id="nav_2">��ҪͶ��</a>
        <a href="<%configureProvider.format(out,URLVariable.CREDIT_DKYX);%>" id="nav_3">��Ҫ���</a>
        <a href="/guide.html" id="nav_4">��ƹ���</a>
        <a href="/safe/risk.html" id="nav_5">���տ���</a>
        <a target="_blank" href="http://192.168.3.189/shanlinclub" id="nav_6">������</a>
        </div>
        <div class="clear"></div>
        </div>
        </div>

        <div class="clear"></div>