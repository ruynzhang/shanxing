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
<div class="alert_bg"></div>
<div class="banner" >

    <!----banner------->
    <ul id="lunboUl" class="bxslider">
        <li><a href="http://www.myshanxing.com/mobile/anniversary.html" target="_blank"><img src="/images/mbanner6.jpg" /></a></li>
    </ul>
    <!---end----->
    <div class="xuanfu">
        <a href="/index.html"><span class="logo"></span></a><button class="denglu" onclick="login();" style="cursor: pointer;">登录</button>
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
<div class="main-1" id="regiid">
    <div class="input phone" style="display: none">
        <span>用 户 名</span>
        <!-- value="请输入您的用户名" -->
        <input type="text" id="uname" name="accountName" placeholder="请输入您的用户名" value=""  maxlength="18" regobj="iptReg" reg="m" class="tit_input">
        <div class="tip" style="color:red" id="unameErr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    </div>
    <div class="input phone">
        <span>手 机 号</span>
        <!-- value="请输入您的手机号码" --> 
        <input type="text" id="mb_phone" name="mobilephone" placeholder="请输入您的手机号码" value="<%StringHelper.filterQuoter(out, request.getParameter("mobilephone"));%>" onblur="mobilephoneCheck()"  maxlength="11"  regobj="iptReg" reg="m" class="tit_input">
        <div class="tip" style="color:red" id="phoneErr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    </div>
    <div class="input password" id="pwd">
        <span>注册密码</span>
        <input id="pwd" type="password" name="password" onblur="passwordCheck()" placeholder="请输入您的注册密码" maxlength="20" value="<%StringHelper.filterQuoter(out, request.getParameter("password"));%>"  class="tit_input">
        <div class="tip" style="color:red" id="upwdErr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    </div>
    <div class="code">
        <div class="input">
            <span>验 证 码</span>
           <input id="valCode" type="text" name="verifyCode" onblur="verifyCodeCheck()" placeholder="请输入验证码" maxlength="6"  class="tit_input">
           <div class="tip" style="color:red" id="codeErr">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        </div>
        <button id="get_verify" style="cursor: pointer;"><img src="<%=controller.getURI(request, RegisterVerify.class)%>" onclick='this.src="<%=controller.getURI(request, RegisterVerify.class)%>?"+Math.random()' style="cursor: pointer;" id="verify-img" /></button>
        <input type="hidden"  name="code"  value="<%StringHelper.filterQuoter(out, request.getParameter("code"));%>"  maxlength="11">
        <input type="hidden" name="partId" value="<%StringHelper.filterQuoter(out, request.getParameter("partId")==null?partId:request.getParameter("partId"));%>"/>
    </div>
    <div class="sx_agree">
    <input name="xieyi" type="checkbox" value="" id="xieyi" checked="checked" />
    <label for="xieyi">我同意<a class="showText sx_blueColor"> 《善行创投平台协议》</a></label>
    </div>
    <button class="ljzc" style="cursor:pointer;" id="regaction" onclick="doReg()">注册领取50元红包</button>
    <p class="down">下载客户端享受指尖投资的乐趣</p>
    <div class="download">
        <a href="http://a.app.qq.com/o/simple.jsp?pkgname=com.myshanxing.app"><button class="apk">安卓下载</button></a>
        <a href="https://itunes.apple.com/cn/app/shan-xing-chuang-tou/id979122379"><button class="app">苹果下载</button></a>
    </div>
</div>


<!---善行创投介绍--->
<div class="main-2">
    <img src="/images/ad_hb.png" alt="" class="ad_hb">
    <div class="add_group"><a href="http://shang.qq.com/wpa/qunwpa?idkey=c647db3a06f80172936918518a1e7237a3f341e949d73b9cd9fca3fb3bb67817"></a></div>
    <p class="credit-title">关于善行创投</p>
    <ul class="credit">
        <li></span> 三亿注册资本 </li>
        <li></span> 资金第三方托管 </li>
        <li></span>  三大实力股东高通盛融、善林金融、深圳善林资产 </li>

    </ul>
    <p class="feeter copyright-1"> 广东德纳律师事务所为本站提供全程法律顾问服务</p>
    <p class="feeter copyright-1"> ©2014 善行创投 All rights reserved 粤ICP备14042804号-2</p>
    <p class="feeter">深圳市罗湖区深南东路5016号京基100大厦41楼</p>

</div>

    <div class="sx_m_showbox">
    <span class="sx_m_close">X</span>
    <p>善行创投“网站（www.myshanxing.com，以下简称“本网站”）由深圳市前海善林资产管理有限公司(以下简称“本公司”)负责运营。本服务协议双方为本网站用户与本公司，适用于用户注册使用本网站服务的全部活动。<br /><br />

    在注册成为本网站用户前，请您务必认真、仔细阅读并充分理解本服务协议全部内容。您在注册本网站取得用户身份时勾选同意本服务协议并成功注册为本网站用户，视为您已经充分理解和同意本服务协议全部内容，并签署了本服务协议，本服务协议立即在您与本公司之间产生合同法律效力，您注册使用本网站服务的全部活动将受到本服务协议的约束并承担相应的责任和义务。如您不同意本服务协议内容，请不要注册使用本网站服务。<br /><br />

    本服务协议包括以下所有条款，同时也包括本网站已经发布的或者将来可能发布的各类规则。所有规则均为本服务协议不可分割的一部分，与本服务协议具有同等法律效力。<br /><br />

    用户在此确认知悉并同意本公司有权根据需要不时修改、增加或删减本服务协议。本公司将采用在本网站公示的方式通知用户该等修改、增加或删减，用户有义务注意该等公示。一经本网站公示，视为已经通知到用户。若用户在本服务协议及各类规则变更后继续使用本网站服务的，视为用户已仔细认真阅读、充分理解并同意接受修改后的本服务协议及各类规则，且用户承诺遵守修改后的本服务协议及各类规则内容，并承担相应的义务和责任。若用户不同意修改后的本服务协议及各类规则内容，应立即停止使用本网站服务，本公司保留中止、终止或限制用户继续使用本网站服务的权利，但该等终止、中止或限制行为并不豁免用户在本网站已经进行的交易下所应承担的责任和义务。本公司不承担任何因此导致的法律责任。<br /><br />

    一. 本网站服务<br />
    本网站为用户提供【信用咨询、评估、管理，促成用户与本网站其他用户达成交易的居间服务，还款管理等服务】，用户通过本网站居间服务与其他用户达成的所有交易项下资金的存放和移转均通过银行或第三方支付平台机构实现，本网站并不存放交易资金。<br /><br />

    <b>二. 服务费用</b><br />
    用户注册使用本网站服务，本公司有权向用户收取服务费用，具体服务费用以本网站公告或其他协议为准。用户承诺按照本服务协议约定向本网站支付服务费用，并同意本网站有权自其有关账户中直接扣划服务费用。用户通过本网站与其他方签订协议的，用户按照签署的协议约定向其他方支付费用。<br /><br />

    <b>三. 使用限制</b><br />
    注册成为本网站用户必须满足如下主体资格条件：具有中华人民共和国（以下简称“中国”）国籍（不包括中国香港、澳门及台湾地区）、年龄在18周岁以上、具有完全民事行为能力的自然人。若不具备前述主体资格条件，请立即终止注册使用本网站服务.若违反前述规定注册使用本网站服务，本公司保留终止用户资格、追究用户或用户的监护人相关法律责任的权利。<br />
    用户在注册使用本网站服务时应当根据本网站的要求提供自己的真实信息（包括但不限于真实姓名、联系电话、地址、电子邮箱等信息），并保证向本网站提供的各种信息和资料是真实、准确、完整、有效和合法的，复印件与原件一致。如用户向本网站提供的各项信息和资料发生变更，用户应当及时向本网站更新用户的信息和资料，如因用户未及时更新信息和资料导致本网站无法向用户提供服务或发生错误，由此产生的法律责任和后果由用户自己承担。如使用他人信息和文件注册使用本网站服务或向本网站提供的信息和资料不符合上述规定，由此引起的一切责任和后果均由用户本人全部承担，本公司及本网站不因此承担任何法律责任，如因此而给本公司及本网站造成损失，用户应当承担赔偿本公司及本网站损失的责任。<br />
    成功注册为本网站用户后，用户应当妥善保管自己的用户名和密码，不得将用户名转让、赠与或授权给第三方使用。用户在此确认，使用其用户的用户名和密码登录本网站及由用户在本网站的用户账户下发出的一切指令均视为用户本人的行为和意思，该等指令不可逆转，由此产生的一切责任和后果由用户本人承担，本公司及本网站不承担任何责任。<br />
    用户不得利用本网站从事任何违法违规活动，用户在此承诺合法使用本网站提供的服务，遵守中国现行法律、法规、规章、规范性文件以及本服务协议的约定。若用户违反上述规定，所产生的一切法律责任和后果与本公司和本网站无关，由用户自行承担，如因此给本公司和本网站造成损失的，由用户赔偿本公司和本网站的损失。本公司保留将用户违法违规行为及有关信息资料进行公示、计入用户信用档案、按照法律法规的规定提供的有关政府部门或按照有关协议约定提供给第三方的权利。<br />
    如用户在本网站的某些行为或言论不合法、违反有关协议约定、侵犯本公司的利益等，本公司有权基于独立判断直接删除用户在本网站上作出的上述行为或言论，有权中止、终止、限制用户使用本网站服务，而无需通知用户，亦无需承担任何责任。如因此而给本公司及本网站造成损失的，应当赔偿本公司及本网站的损失。<br /><br />

    <b>四. 不保证条款</b><br />
    本网站提供的服务中不含有任何明示、暗示的，对任何用户、任何交易的真实性、准确性、可靠性、有效性、完整性等的任何保证和承诺，用户需根据自身风险承受能力，衡量本网站披露的交易内容及交易对方的真实性、可靠性、有效性、完整性，用户因其选择使用本网站提供的服务、参与的交易等而产生的直接或间接损失均由用户自己承担，包括但不限于资金损失、利润损失、营业中断等。本公司及其股东、创始人、全体员工、代理人、关联公司、子公司、分公司均不对以上损失承担任何责任。<br /><br />

    <b>五. 责任限制</b><br />
    基于互联网的特殊性，本公司无法保证本网站的服务不会中断，对于包括但不限于本公司、本网站及相关第三方的设备、系统存在缺陷，计算机发生故障、遭到病毒、黑客攻击或者发生地震、海啸等不可抗力而造成服务中断或因此给用户造成的损失，本公司不承担任何责任，有关损失由用户自己承担。<br />
    本公司无义务监测本网站内容。用户对于本网站披露的信息、选择使用本网站提供的服务，选择参与交易等，应当自行判断真实性和承担风险，由此而产生的法律责任和后果由用户自己承担，本公司不承担任何责任。
    与本公司合作的第三方机构向用户提供的服务由第三方机构自行负责，本公司不对此等服务承担任何责任。<br />
    本网站的内容可能涉及第三方所有的信息或第三方网站，该等信息或第三方网站的真实性、可靠性、有效性等由相关第三方负责，用户对该等信息或第三方网站自行判断并承担风险，与本网站和本公司无关。
    无论如何，本公司对用户承担的违约赔偿（如有）总额不超过向用户收取的服务费用总额。<br /><br />

    <b>六. 用户资料的使用与披露</b><br />
    用户在此同意，对于用户提供的和本公司为提供本网站服务所需而自行收集的用户个人信息和资料，本公司有权按照本服务协议的约定进行使用或者披露。<br />
    用户授权本公司基于履行有关协议、解决争议、调停纠纷、保障本网站用户交易安全的目的等使用用户的个人资料（包括但不限于用户自行提供的以及本公司信审行为所获取的其他资料）。本公司有权调查多个用户以识别问题或解决争议， 特别是本公司可审查用户的资料以区分使用多个用户名或别名的用户。<br /><br />

    为避免用户通过本网站从事欺诈、非法或其他刑事犯罪活动，保护本网站及其正常用户合法权益，用户授权本公司可通过人工或自动程序对用户的个人资料进行评价和衡量。<br /><br />

    用户同意本公司可以使用用户的个人资料以改进本网站的推广和促销工作、分析网站的使用率、改善本网站的内容和产品推广形式，并使本网站内容、设计和服务更能符合用户的要求。这些使用能改善本网站的网页，以调整本网站网页使其更能符合用户的需求，从而使用户在使用本网站服务时得到更为顺利、有效、安全及度身订造的交易体验。<br /><br />

    用户在此同意允许本公司通过在本网站的某些网页上使用诸如“Cookies”的设置收集用户信息并进行分析研究，以为用户提供更好的量身服务。<br /><br />

    本公司有义务根据有关法律、法规、规章及其他政府规范性文件的要求向司法机关和政府部门提供用户的个人资料及交易信息。<br /><br />

    在用户未能按照与本公司签订的包括但不限于本服务协议或者与本网站其他用户签订的借款协议等其他法律文本的约定履行自己应尽的义务时，本公司有权将用户提供的及本公司自行收集的用户的个人信息、违约事实等通过网络、报刊、电视等方式对任何第三方披露，且本公司有权将用户提交或本公司自行收集的用户的个人资料和信息与任何第三方进行数据共享，以便对用户的其他申请进行审核等使用。由此而造成用户损失的，本公司不承担法律责任。<br /><br />

    本公司采用行业标准惯例以保护用户的个人信息和资料，鉴于技术限制，本公司不能确保用户的全部私人通讯及其他个人资料不会通过本条款中未列明的途径泄露出去。<br /><br />

    <b>七. 知识产权保护条款</b><br />
    本网站中的所有内容均属于本公司所有,包括但不限于文本、数据、文章、设计、源代码、软件、图片、照片、音频、视频及其他全部信息。本网站内容受中国知识产权法律法规及各国际版权公约的保护。
    未经本公司事先书面同意,用户承诺不以任何形式复制、模仿、传播、出版、公布、展示本网站内容,包括但不限于电子的、机械的、复印的、录音录像的方式和形式等。用户承认本网站内容是属于本公司的财产。

    <b>八. 违约责任</b><br />
    如一方发生违约行为，守约方可以书面通知方式要求违约方在指定的时限内停止违约行为，并就违约行为造成的损失要求违约方进行赔偿。<br /><br />

    <b>九. 法律适用及争议解决</b><br />
    本服务协议的签订、效力、履行、终止、解释和争端解决受中国法律法规的管辖。<br />
    因本服务协议发生任何争议或与本服务协议有关的争议，首先应由双方友好协商解决，协商不成的，任何一方有权将纠纷提交至本公司所在地有管辖权的人民法院诉讼解决。<br />

    <b>十. 其他条款</b><br />
    本服务协议自您同意勾选并成功注册为本网站用户之日起生效，除非本网站终止本服务协议或者用户丧失本网站用户资格，否则本服务协议始终有效。本服务协议终止并不免除用户根据本服务协议或其他有关协议、规则所应承担的义务和责任。
    本公司对于用户的违约行为放弃行使本服务协议规定的权利的，不得视为其对用户的其他违约行为放弃主张本服务协议项下的权利。<br />
    本服务协议部分条款被认定为无效时，不影响本服务协议其他条款的效力。<br />
    本服务协议不涉及用户与本网站其他用户之间因网上交易而产生的法律关系及法律纠纷，但用户在此同意将全面接受和履行与本网站其他用户通过本网站签订的任何电子法律文本，并承诺按该法律文本享有和/或放弃相应的权利、承担和/或豁免相应的义务。<br /><br />
    本公司对本服务协议享有最终的解释权。</p>
    <input type="button" class="sj_m_close" value="确定">
    </div>
<script>
var wait = 180;
    $(function(){
        $(window).bind('resize load', function(){

            $("body").css("display" , "block");
        });
        $(window).scroll(function(){
            var h=$(window).height();
            var h1=$(document).scrollTop();
            if(h1>h||h1==h){
                $('.yindao').fadeOut(500);
            }else{
                $('.yindao').fadeIn(500);
            }
        })
    });
   	function login(){
   		location.href = "/user/mobile/login.html";
   	}
</script>
    <!--轮播切换-->

    <script>
    /*协议*/
    $(function(){
     $(".showText").click(function(){
        $("body").addClass("add_body_class");
       $(".alert_bg").css("display","block");
       $(".sx_m_showbox").css("display","block");

      });
        $(".sx_m_close,.sj_m_close").click(function(){
            $("body").removeClass("add_body_class");
            $(".alert_bg").css("display","none");
            $(".sx_m_showbox").css("display","none");
        });
    })
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