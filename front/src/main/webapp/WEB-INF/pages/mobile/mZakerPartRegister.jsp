    <%@page import="com.dimeng.p2p.front.servlets.CheckPhoneExists"%>
        <%@page import="com.dimeng.p2p.front.servlets.GetPhoneVerifyCode"%>
        <%@page import="com.dimeng.p2p.front.servlets.RegisterVerify"%>
        <%@page import="com.dimeng.p2p.front.servlets.CheckNameExists"%>

        <!DOCTYPE html>
        <html lang="en">
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta content="yes" name="apple-mobile-web-app-capable" />
        <meta content="black" name="apple-mobile-web-app-status-bar-style" />
        <title>善行创投</title>
        <link rel="stylesheet" type="text/css" href="/css/mpart_style.css" />
        <script src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js" type="text/javascript" ></script>
        <script src="<%=controller.getStaticPath(request)%>/js/mpartregister.js" type="text/javascript" ></script>
            <%
     String partId = request.getParameter("partId");
     %>

        </head>
        <body style="display: block;">
        <div class="banner" >

        <!----banner------->
        <ul id="lunboUl" class="bxslider">
        <li><a href="http://www.myshanxing.com:8888/app/home/wzgg.action?id=66" target="_blank"><img src="/images/mbanner2.jpg" /></a></li>
        <li><a href="javascript:;" target="_blank"><img src="/images/mbanner3.jpg" /></a></li>
        <li><a href="javascript:;"><img src="/images/banner.jpg" /></a></li>
        <li><a href="javascript:;"><img src="/images/mbanner5.png" /></a></li>
    	</ul>

        <!--
        <img src="/images/banner.jpg" alt="" >
        -->
        <!---end----->
        <div class="xuanfu">
        <a href="/index.html"><span class="logo"></span></a>
        </div>
        </div>
        <style>
        .sx_grey {background:#949494 !important; color:#e2e2e2 !important; border:#949494 !important;}
        </style>
        <img src="/images/jiantou.gif" alt="" class="yindao" style="display: none;">
        <script type="text/javascript">
        var _nURL='<%=controller.getURI(request, CheckNameExists.class)%>';
        var getVerifyCodeURL='<%=controller.getURI(request, GetPhoneVerifyCode.class)%>';
        var checkPhoneExistsURL='<%=controller.getURI(request, CheckPhoneExists.class)%>';
        </script>
        <!--form-->
        <div class="sx_body">
        <div class="sx_body_info">
        <div class="sx_box">
        <div class="sx_code"><img src="/images/sx_app_code.png" alt="" /></div>
        <div class="download">
		<p> <a id="android" href="https://www.myshanxing.com/android/myshanxing.apk"><button class="apk">安卓下载</button></a></p>
        <p> <a id="apple" href="https://itunes.apple.com/cn/app/shan-xing-chuang-tou/id979122379"><button class="app">苹果下载</button></a></p>
        </div>
        </div>
        <div class="sx_box sx_site">
             <img src="/images/sx_invest.png" class="sx_invest">
             <a href="http://www.myshanxing.com/index.html"><img src="/images/site_btn.png"></a>
        </div>
        <div class="sx_box sx_site">
        <img src="/images/paper.png" class="sx_paper">
        </div>

        <div class="sx_box sx_app_note">
            <div><h1>1、三亿注册资本</h1><p>善行创投是善林互联网金融服务有限公司推出的一款P2P投资理财平台，善林互联网金融服务有限公司注册资金为3亿元人民币，注册地为深圳市前海深港合作区。</p></div>
            <div><h1>2、资金安全托管</h1><p>平台创建之初，即与第三方支付平台——汇潮支付合作，做到投资人、借款人、渠道平台独立在第三方支付平台设立资金账户，所有资金的进出流向都由第三方支付平台控制。</p></div>
            <div><h1>3、千万风险保障金</h1><p>善行创投创建伊始，即在中信银行盐田支行预存了1000万风险保障金，用于保障平台投资人所投项目的本金及收益。</p></div>
            <div><h1>4、股东实力雄厚</h1><p>善行创投股东包括高通盛融（北京）投资基金管理有限公司、善林(上海)金融信息服务有限公司、深圳市前海善林资产管理有限公司等多家实力雄厚的公司。</p></div>

        </div>

        <div class="main-2 sx_footer">
        <p class="feeter copyright-1"> 广东德纳律师事务所为本站提供全程法律顾问服务</p>
        <p class="feeter copyright-1"> ©2014 善行创投 All rights reserved 粤ICP备14042804号-2</p>
        <p class="feeter">深圳市罗湖区深南东路5016号京基100大厦41楼</p>
        </div>
      </div>
     </div>
        <!--轮播切换-->
        <script src="<%=controller.getStaticPath(request)%>/mobile/js/jquery.bxslider.js" type="text/javascript" ></script>
        <script>
        $(document).ready(function(){
        $('.bxslider').bxSlider();
        var partId = '<%=partId%>';
        if(partId == 'zaker_1'){
        	$('#android').attr('href','https://www.myshanxing.com/android/myshanxing_zaker_1.apk');
        	$('#apple').attr('href','http://um0.cn/2N00Oy');
        }else if(partId == 'zaker_2'){
        	$('#android').attr('href','https://www.myshanxing.com/android/myshanxing_zaker_2.apk');
        	$('#apple').attr('href','http://um0.cn/3tJRjE');
        }else if(partId == 'zaker_3'){
        	$('#android').attr('href','https://www.myshanxing.com/android/myshanxing_zaker_3.apk');
        	$('#apple').attr('href','http://um0.cn/3P4IaS');
        }
        });
        </script>
        </body>
        <script>
        var _hmt = _hmt || [];
        (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?6325fde2cae7259da1162ba645d09079";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
        })();
        </script>
        </html>