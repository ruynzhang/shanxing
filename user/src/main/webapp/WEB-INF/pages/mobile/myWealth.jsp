<!DOCTYPE html>
<%@page import="java.util.Map"%>
<html lang="en">
<head>
    <title>善行创投</title>
    <%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/javascript.jsp" %>
    <link rel="stylesheet" type="text/css" href="/mobile/css/bidDetail.css" />
</head>
<body>
<div class="alert_bg"> </div>
<%CURRENT_CATEGORY="WEALTH";%>
<!---top--->
<%@include file="/WEB-INF/pages/mobile/header.jsp"%>

<%
Map<String, Object> map=(Map<String, Object>)request.getAttribute("resultMap");
UserManage userManage = serviceSession.getService(UserManage.class);
String usrCustId = userManage.getUsrCustId();
String phone=map.get("phone")!=null?(String)map.get("phone"):"";
if(StringHelper.isEmpty(phone)){
	controller.sendRedirect(request, response, "/user/mobile/setPhone.html");
	return;
}
%>

<!----container-->

<div class="sj_wealth sj_wealth_if">
    <div class="sj_wealth_info"><a href="/user/mobile/user.htm" ><p class="face_heads"><img src="/mobile/images/heads.png"></p><p><%=map.get("userName")%></p><p><%=phone%></p><img src="/mobile/images/rr_arrow.png" class="rr_arrow"></a></div>
    <div class="sj_wealth_bl"><p><b>净资产</b><b>可用余额</b></p><p><span class="sj_wealth_zc">￥<%=map.get("jzc")%></span><span class="sj_wealth_ye">￥<%=map.get("balance")%></span></p><img src="/mobile/images/u_arrow.png" class="u_arrow"></div>

    <!---资金情况---->
    <div class="sj_wealth_st">
    <p><span>冻结资金</span><span>￥<%=map.get("djzj")%></span></p>
    <p><span>待收本金</span><span>￥<%=map.get("dszj")%></span></p>
    <p><span>待收收益</span><span>￥<%=map.get("dssy")%></span></p>
    <p><span>累计投资</span><span>￥<%=map.get("ljtz")%></span></p>
    <p><span>累计收益</span><span>￥<%=map.get("ljsy")%></span></p>
    </div>
</div>
<div class="sj_wealth">

    <div class="sj_wealth_nav"><a href="/user/mobile/funds_detail.html"><span>资金明细</span><img src="/mobile/images/r_arrow.png"></a></div>
    <div class="sj_wealth_nav invest"><a href="/user/mobile/invest.html"><span>我的投资</span><img src="/mobile/images/r_arrow.png"></a></div>
    <div class="sj_wealth_nav cl_detail"><a href="/user/mobile/cl_detail.html"><span>收款明细</span><img src="/mobile/images/r_arrow.png"></a></div>
    <div class="sj_wealth_nav paper"><a href="/user/mobile/redPaper.html"><span>我的红包</span><img src="/mobile/images/r_arrow.png"></a></div>
    <div class="sj_wealth_nav invite"><a href="/user/mobile/myExtendCode.html"><span>好友邀请</span><img src="/mobile/images/r_arrow.png"></a></div>

</div>
    <div id="info"></div>
<!---footer-->
<%@include file="/WEB-INF/pages/mobile/footer.jsp"%>
<!--end footer--> 
<script>
    $(function(){
    	<%if(StringHelper.isEmpty(usrCustId)){ %>
    		warmTip();
    	<%}%>
        $(".sj_wealth_bl").click(function(){
            if($(this).find('img').attr('src')=="/mobile/images/u_arrow.png"){
                $(this).find('img').attr('src','/mobile/images/t_arrow.png');
            }else{$(this).find('img').attr('src','/mobile/images/u_arrow.png');}
            $('.sj_wealth_st').toggle();

        })
    })

    function warmTip(){
    $('.alert_bg').css('display','block');
    $("body").css("overflow-y","hidden");
    $(".wx_top").css("position","absolute");
    $("#info").html(showDialogInfo("温馨提示"));
    $("div.popup_bg").show();
    }
    //封装信息消息文本.
    function showDialogInfo(msg,type){
    return   '<body class="add_body_class">'+'<div class="alert_bg" style="display:block">'+'</div>'+'<div class="dialog w510 thickpos" >'+
    '<div class="dialog_close fr" onclick="closeInfo()"><a></a></div>'+
    '<div class="con clearfix">'+
    '<div class="d_'+type+' fl"></div>'+
    '<div class="info fr">'+
    '<p class="f20 gray33">'+'温馨提示：亲爱的善粉，为了您账户的资金安全，请移步电脑端官网：www.myshanxing.com,进行“认证-充值-提现”那里有最先进的SSL加密技术为您保驾护航，如有不便，敬请谅解！'+'</p>'+
    '</div>'+
    '<div class="clear2"></div>'+
    '<div class="dialog_btn dl_close_btn"><a onclick="closeInfo()" class="btn btn01">关闭</a></div>'+
    '</div>'+
    '</div>'+'</body>';
    }
    function closeInfo(){
    $("#info").html("");
    $("div.popup_bg").hide();
    $(".alert_bg").css('display','none');
    $("body").removeClass("add_body_class").css("overflow-y","scroll");
    $(".wx_top").css("position","fixed");
    }

    </script>
</body>
</html>