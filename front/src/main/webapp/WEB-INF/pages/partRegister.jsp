<!DOCTYPE html>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdlb"%>
<%@page import="com.dimeng.p2p.front.servlets.GetPhoneVerifyCode"%>
<%@page import="com.dimeng.p2p.front.servlets.CheckPhoneExists"%>
<%@page import="com.dimeng.p2p.front.servlets.CheckNameExists"%>
<%@page import="com.dimeng.p2p.front.servlets.RegisterVerify"%>
<%@page import="org.joda.time.DateTime"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.query.QyBidQueryAccount"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq"%>

<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="black" name="apple-mobile-web-app-status-bar-style" />
    <title>善行创投</title>

    <link rel="stylesheet" type="text/css" href="/css/part_style.css" />
    <script src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js" type="text/javascript" ></script>
    <script src="<%=controller.getStaticPath(request)%>/js/partregister.js" type="text/javascript" ></script>
    <style type="text/css">
    /* 顶部栏 */
.bgBlock1 {
	background:#f5f5f5;
	position:relative;
	z-index:100; width:100%;
	border-bottom:1px solid #e6e6e6;
}
#sx_topbox {width:1200px; margin:0 auto; height:40px; position:relative; z-index:100;}
#sx_topbox span.sx_phone {float:left; padding-top:10px; color:#666;}
#sx_topbox .sx_phone i {display:inline-block; width:28px; height:24px; background:url(../images/icon.png) no-repeat -211px -50px;vertical-align:middle;}
#sx_topbox .sx_regbox {float:right; padding-top:10px; color:#b5c4ce;}
#sx_topbox .sx_regbox b {padding-left:10px; font-weight:normal;}
#sx_topbox .sx_regbox a {margin-left:10px; color:#666;}
#sx_topbox .sx_regbox a:hover {color:#ff525a;}
#sx_topbox .sx_regbox a.orangeLink {color:#fb4700;}
.g_warp .ad_block{padding: 40px 0 20px 0;}
    .rightAD{position: fixed;right: 20px; top: 150px; z-index: 1000;}
    .rightAD-box{position: relative;width: 150px;height: 150px; }
    .rightAD a{position: absolute;bottom:0px;}
    .rightAD .xy{position: absolute;top: 106px;left: 59px;width: 30px;}
    .rightAD .close{font-size: 28px;z-index: 2;position: absolute;color: #999;right: -20px;top: 10px;cursor: pointer;font-style: normal;text-decoration: none;}
    * html .rightAD{position: absolute;right: auto;left: expression(eval(document.documentElement.scrollLeft+document.documentElement.clientWidth-this.offsetWidth)-(parseInt(this.currentStyle.marginLeft,10)||0)-(parseInt(this.currentStyle.marginRight,10)||0));}
    </style>
    <%@include file="/WEB-INF/include/style.jsp"%>
    <% 
    final String RATE_KEY="r"; 
    final String partId = request.getParameter("partId");
     final String PROGRESS_KEY="p";
    BidManage bidManage = serviceSession.getService(BidManage.class);
    final HttpServletRequestWrapper requestWrapper = new HttpServletRequestWrapper(request);
    
    PagingResult<Bdlb> result = bidManage.searchOneBid(new QyBidQueryAccount() {
			public int getRate() {
				int rate = IntegerParser.parse(requestWrapper.getParameter(RATE_KEY));
				return rate;
			}

			public int getJd() {
				int progress = IntegerParser.parse(requestWrapper.getParameter(PROGRESS_KEY));
				return progress;
			}

			public T6230_F20 getStatus() {
				return null;
			}

			public int getOrder() {
				return 0;
			}

			public String getWay() {
				return "";
			}
		}, null, new Paging() {
			public int getCurrentPage() {
				return 1;
			}
			public int getSize() {
				return 1;
			}
		});
    
     %>
</head>
<body>

<div class="bgBlock1" style="width: 1920px;">
    <div id="sx_topbox">
       <span class="sx_phone"><i></i>客服电话:&nbsp;4000-166-277</span>
       <div class="sx_regbox">
	   		<a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">登录</a>
       		<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>">注册</a>
       </div>
       <div class="clear"></div>
    </div>
</div>
<div id="top">

</div>
    <div class="top_logo">
        <div class="g_warp g-cf">
        <a href="<%configureProvider.format(out,URLVariable.INDEX);%>" class="logo g-f-l">
        <img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.QTLOGO))%>" alt="善行创投">
        </a>
        </div>
    </div>
<!---banner-->
<div id="banner">
    <div class="bannerBg">
        <div class="g_warp g-p-r">
            <div class="regBox">
                <div class="highLight J-highLight"></div>
                <p class="banner_title">注册即送50元投资红包</p>
                <div class="regBoxWarp">

                    <!-- 注册模块 -->
                       <script type="text/javascript">
	                      var _nURL='<%=controller.getURI(request, CheckNameExists.class)%>';
	                      var getVerifyCodeURL='<%=controller.getURI(request, GetPhoneVerifyCode.class)%>';
	                      var checkPhoneExistsURL='<%=controller.getURI(request, CheckPhoneExists.class)%>';
	                      var userIndex ='<%configureProvider.format(out,URLVariable.USER_INDEX);%>';
                     </script>
                     <input type="hidden" id="bkMobilePhone" name="bkMobilePhone" value="" />
                        <table cellspacing="0" cellpadding="0" width="100%" id="regiid">
                            <tbody>
                            <tr style="display: none">
                                <td align="right" valign="middle" >
                                    <span class="g-d-ib g-v-m lable"><i>*</i>用户名：</span>
                                </td>
                                <td align="left" valign="middle" id="uname_div">
                                    <input type="text" id="uname" name="accountName" placeholder="请输入用户名" value="" maxlength="18" regobj="iptReg" reg="m" class="tit_input">
                                    <div class="tip" style="color:red" id="unameErr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                </td>
                            </tr>
                            <tr class="phone">
                                <td align="right" valign="middle">
                                    <span class="g-d-ib g-v-m lable"><i>*</i>手机号码：</span>
                                </td>
                                <td align="left" valign="middle">
                                    <input type="text" id="mb_phone" name="mobilephone" placeholder="请输入手机号码" value="<%StringHelper.filterQuoter(out, request.getParameter("mobilephone"));%>" onblur="mobilephoneCheck()"  maxlength="11"  regobj="iptReg" reg="m" class="tit_input">
                                    <div class="tip" style="color:red" id="phoneErr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                </td>
                            </tr>
                            <tr class="pwd">
                                <td align="right" valign="middle">
                                    <span class="g-d-ib g-v-m lable"><i>*</i>设置密码：</span>
                                </td>
                                <td align="left" valign="middle">
                                    <input id="pwd" type="password" name="password" onblur="passwordCheck()"  placeholder="6~20个字符，区分大小写" maxlength="20" value="<%StringHelper.filterQuoter(out, request.getParameter("password"));%>"  class="tit_input">
                                    <div class="tip" style="color:red" id="upwdErr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                </td>
                            </tr>
                            <tr class="remCode">
                                <td align="right" valign="middle">
                                    <span class="g-d-ib g-v-m lable">邀请码：</span>
                                </td>
                                <td align="left" valign="middle">
                                    <input id="remCode" type="text"  name="code"  placeholder="如有邀请码请填写" value="<%StringHelper.filterQuoter(out, request.getParameter("code"));%>"  maxlength="11" onblur="codeCheck()" style="color:#ccc;" class="tit_input">
                                    <input type="hidden" name="partId" value="<%StringHelper.filterQuoter(out, request.getParameter("partId")==null?partId:request.getParameter("partId"));%>"/>
                                    <div class="tip" style="color:red" id="remCodeErr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                </td>
                            </tr>
                             <tr class="valCode">
                                <td align="right" valign="middle">
                                    <span class="g-d-ib g-v-m lable"><i>*</i>验证码：</span>
                                </td>
                                <td align="left" valign="middle">
                                    <input id="valCode" type="text" name="verifyCode" onblur="verifyCodeCheck()" maxlength="6"  class="tit_input" style="width:110px;">
                                    <img src="<%=controller.getURI(request, RegisterVerify.class)%>" onclick='this.src="<%=controller.getURI(request, RegisterVerify.class)%>?"+Math.random()' style="cursor: pointer;width:100px;" id="verify-img" />   
                                    <div class="tip" style="color:red" id="codeErr">验证码不能为空</div>
                                </td>
                            </tr>
                            
                            </tbody>
                        </table>

                        <p class="g-fz-14 agreeTxt">
                            <input class="g-d-ib g-v-m" type="checkbox" value="1"  checked="checked">
                            <span class="g-d-ib g-v-m">我已阅读并同意<a href="/term/ZCXY.html" target="_blank">《善行创投平台协议》</a></span>
                        </p>
                        <p class="regBtnBox">
                            <a class="regBtn g-d-ib" id="J-regBtn" href="javascript:doReg();">马上注册</a>
                        </p>
                        <p class="g-ta-c g-mt-10 g-fz-14"><span class="g-d-ib g-v-t">已注册<a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">立即登录</a></span></p>

                </div>
            </div>
        </div>
    </div>
</div>
<!---end banner------>
<!------奖励标专区----------------->
<%
          boolean tag = true;
           Bdlb bdlb = null;
           String statusButtonTemp = null;
           Bdlb[] bdlbs = result.getItems();
           if (bdlbs != null && bdlbs.length > 0) {
            bdlb = bdlbs[0];
           }

           T6230_F20 status = null;
           if (bdlb != null) {
            status = bdlb.F11;
            if (status == T6230_F20.TBZ || status == T6230_F20.DFK) {
             if (new DateTime(bdlb.F13).plusDays(bdlb.F09).getMillis() - System.currentTimeMillis() <= 0) {
              statusButtonTemp = "已完结";
             } else if (status == T6230_F20.DFK) {
              statusButtonTemp = status.getChineseName();
             } else {
              statusButtonTemp = "立即投资";
             }
            } else {
             statusButtonTemp = status.getChineseName();
            }
           }
         %>
         
<%if(bdlb!=null){ %>
<div id="share" style="">

         
    <a href="" class="header"></a>

    <h1>善行创投——您的家庭理财设计师</h1>
    <div class="content">

        <div class="top">
            <strong>活动专享标</strong>
            <a class="color1"><span id="bid_name"><a href="<%=controller.getPagingItemURI(request, Bdxq.class,bdlb.F02)%>"><%StringHelper.filterHTML(out, StringHelper.truncation(bdlb.F04, 12));%></a></span></a>
            <span class="new"></span>
            <span style="font-size: 12px;float: right;margin-top: -15px;">测算收益和年化收益不等于实际收益</span>
        </div>
        <div class="clearfix bottom">
            <p class="fl"><strong id="rate" class="strong"><span><%=Formater.formatRate(bdlb.F07.subtract(bdlb.bonus.divide(new BigDecimal("100"))),false)%>% <%if(bdlb.bonus.compareTo(BigDecimal.ZERO)==1){out.print("+ "+bdlb.bonus+"%");}%></span></strong><br><span class="color1 span2">预期年化收益</span></p>
            <a class="fl gantan" style="display:"><span class="f12 color1">专享补贴收益</span></a>
            <p class="fl p2"><strong id="date" class="color1 strong2"><span><%if(T6231_F21.S == bdlb.F19){out.print(bdlb.F20 + "天");}else{out.print(bdlb.F10 + "个月");} %></span></strong><br><span class="color1 span4">借款期限</span></p>
            <p class="fl p3"><strong id="total_money" class="color1 strong3"><span><%=Formater.formatAmount(bdlb.F06)%></span></strong><br><span class="color1 span5">借款金额</span></p>
            <span id="progress" class="fl f12 span6">
                <div class="index_progress">
                    <div class="index_progress_bar">
                        <strong id="bar" style=" width:<%=(int)(bdlb.proess*100)%>%; "></strong>
                    </div>
                    <div  class="index_progress_per">
                    <span><%=(int)(bdlb.proess*100)%>%</span>
                    </div>
                </div>
            </span>
            <span id="btn"><a class="btn cursor" href="<%=controller.getPagingItemURI(request, Bdxq.class,bdlb.F02)%>">我要投资</a></span>
        </div>
    </div>
    
</div>
    <%} %>


<!---icon------->
<div id="con1">
    <div class="g_warp">
        <table cellspcing="0" cellpadding="0" width="100%" height="335px">
            <tbody><tr>

                <td width="33.33%" valign="middle" align="center">
                    <p>
                        <span class="icon12"></span>
                    </p>
                    <p class="txt">
                        资金第三方托管
                    </p>
                </td>
                <td width="33.33%" valign="middle" align="center">
                    <p>
                        <span class="icon13"></span>
                    </p>
                    <p class="txt">
                        100元即可投资理财
                    </p>
                </td>
                <td width="33.33%" valign="middle" align="center">
                    <p>
                        <span class="icon14"></span>
                    </p>
                    <p class="txt">
                        全流程6道风控
                    </p>
                </td>
            </tr>
            </tbody></table>
    </div>
</div>
<div id="ad1">
    <div class="g_warp g-ta-c">
        <img src="images/ad1Img.png" width="952px" height="79px">
    </div>
</div>

<!----icon2-------->
<div id="con2">
    <div class="g_warp">
        <table cellspcing="0" cellpadding="0" width="100%" height="367px">
            <tbody>
            <tr>
                <td >
                    <h3 class="til">三亿注册资本</h3>
                    <div class="txt">
                        善行创投是善林互联网金融服务有限公司推出的一款P2P投资理财平台，善林互联网金融服务有限公司注册资金为<span class="fz28">3亿</span>元人民币，注册地为深圳市前海深港合作区。
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <h3 class="til">股东实力雄厚</h3>
                    <div class="txt">
                        善行创投股东包括高通盛融（北京）投资基金管理有限公司、善林(上海)金融信息服务有限公司、深圳市前海善林资产管理有限公司等多家实力雄厚的公司。
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <h3 class="til">资金第三方托管</h3>
                    <div class="txt">
                        平台创建之初，即与第三方支付平台——汇潮支付合作，做到投资人、借款人、渠道平台独立在第三方支付平台设立资金账户，所有资金的进出流向都由第三方支付平台控制。
                    </div>
                </td>
            </tr>
            </tbody></table>
          <div class="index_flow"></div>
    </div>
</div>
<!--ad---->
<div id="ad3">
    <div class="g_warp">
        <img src="images/ad3Img.png" width="1000px" height="110px">
    </div>

</div>

<!-----icon4---->
<div id="con4">
    <div class="g_warp">
        <!--周年庆--->
        <div class="ad_block"><img src="images/ad_chris.png" alt="" width="100%"></div>
        <div class="con4_step">
        <img src="images/step.png" >
        </div>
     </div>

    </div>
</div>

<!-----马上注册---->
    <div class="g_warp register">
        <div class="g-ta-c">
            <a href="">马上注册拿红包</a>
        </div>

    </div>

    <div class="rightAD" id="rightAD">
    <div class="rightAD-box">
    <i onclick="$(this).parent().hide()" class="close">×</i> <a href="/zxdt/wzgg/72.html" target="_blank">
    <img src="/images/sx_pos.png" alt="">
    </a>
    </div>
    </div>

<!-----footer-------->
    <script type="text/javascript">
    $(function(){
    var tophtml="<div id=\"izl_rmenu\" class=\"izl-rmenu\"><a target=\"_blank\" href=\"http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzkzODAzMDYwOV8yOTI2MDFfNDAwMDE2NjI3N18yXw\" class=\"btn btn-qq\"></a><div class=\"btn btn-phone_app\"><img class=\"app_pic\" src=\"/images/phone_shanxing.png\" ></div><div class=\"btn btn-wx\"><img class=\"pic\" src=\"/images/wechat_shanxing.png\" onclick=\"window.location.href=\'\'\"/></div><div class=\"btn btn-phone\"><div class=\"phone\">4000-166-277</div></div><div class=\"btn btn-top\"></div></div>";
    $("#top").html(tophtml);
    $("#izl_rmenu").each(function(){
    $(this).find(".btn-phone_app").mouseenter(function(){
    $(this).find(".app_pic").fadeIn("fast");
    });
    $(this).find(".btn-phone_app").mouseleave(function(){
    $(this).find(".app_pic").fadeOut("fast");
    });
    $(this).find(".btn-wx").mouseenter(function(){
    $(this).find(".pic").fadeIn("fast");
    });
    $(this).find(".btn-wx").mouseleave(function(){
    $(this).find(".pic").fadeOut("fast");
    });
    $(this).find(".btn-phone").mouseenter(function(){
    $(this).find(".phone").fadeIn("fast");
    });
    $(this).find(".btn-phone").mouseleave(function(){
    $(this).find(".phone").fadeOut("fast");
    });
    $(this).find(".btn-top").click(function(){
    $("html, body").animate({
    "scroll-top":0
    },"fast");
    });
    });
    var lastRmenuStatus=false;
    $(window).scroll(function(){//bug
    var _top=$(window).scrollTop();
    if(_top>200){
    $("#izl_rmenu").data("expanded",true);
    }else{
    $("#izl_rmenu").data("expanded",false);
    }
    if($("#izl_rmenu").data("expanded")!=lastRmenuStatus){
    lastRmenuStatus=$("#izl_rmenu").data("expanded");
    if(lastRmenuStatus){
    $("#izl_rmenu .btn-top").slideDown();
    }else{
    $("#izl_rmenu .btn-top").slideUp();
    }
    }
    });
    });
    $(document).ready(function(){
    function onLoad(){
    var nav_1=$("#nav_1");
    var nav_2=$("#nav_2");
    var nav_3=$("#nav_3");
    var nav_4=$("#nav_4");
    var nav_5=$("#nav_5");

    var windows_href=window.location.href;
    for(var i=1;i<8;i++){
    if(windows_href.indexOf("sbtz")!=-1){
    nav_2.addClass("hover");
    return false;
    }else if(windows_href.indexOf("dkyx")!=-1){
    nav_3.addClass("hover");
    return false;
    }else if(windows_href.indexOf("guide")!=-1){
    nav_4.addClass("hover");
    return false;
    }else if(windows_href.indexOf("safe")!=-1){
    nav_5.addClass("hover");
    return false;
    }else if(windows_href.indexOf("gywm")!=-1 || windows_href.indexOf("active")!=-1 || windows_href.indexOf("xszy")!=-1){
    return false;
    }else{
    nav_1.addClass("hover");
    return false;
    }
    }
    }
    onLoad();
    })
    </script>
<!-----end footer-------->
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?6325fde2cae7259da1162ba645d09079";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>

</body>
</html>