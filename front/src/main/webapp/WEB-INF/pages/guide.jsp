<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>善行创投</title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<link href="<%=controller.getStaticPath(request)%>/css/style_sx.css" rel="stylesheet" type="text/css">
<link type="text/css" rel="stylesheet" href="<%=controller.getStaticPath(request)%>/css/layer.css" id="skinlayercss">
    <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/zzsc1016.js"></script>
    <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/layer.min.js"></script>
    <script src="<%=controller.getStaticPath(request)%>/js/public.min.js" type="text/javascript" ></script>


</head>
<body>
<!--------顶部栏-------->
<%@include file="/WEB-INF/include/header.jsp"%>

<div class="wrapper">
<link href="<%=controller.getStaticPath(request)%>/css/owl.carousel.css" rel="stylesheet" type="text/css">
<link href="<%=controller.getStaticPath(request)%>/css/owl.theme.css" rel="stylesheet" type="text/css">
  <script type="text/javascript">
	//sdfsdf2015年06月25日 09时07分

	function amm(obj) {
		var pp;
		var pp2;
		$('.yst').children('span').removeClass("lisl");
		$(".maog").hide();
		document.getElementById("shah_" + obj).style.display = "block";
			try{
			 $("#channlViews img.lazy").trigger("sporty");
			}catch(e){}
	}
	function amm2(obj) {
		var pp;
		var pp2;
		$('.yst').children('span').removeClass("lisl");
		$(".maog").hide();
		document.getElementById("shah_x_" + obj).style.display = "block";
	try{
			 $("#channlViews img.lazy").trigger("sporty");
			}catch(e){}
	}
</script> 

<!--漂浮广告-->
<!--  <script>
$().ready(function(){
				var lay=$.layer({
					type: 1,
					title: false,
					area : ['800px','587px'],
					fix: false,
					shadeClose: true,
					//closeBtn: true,
					//offset: [($(window).height() - 700)/2+'px', ''], //上下垂直居中
					border : true,
					shade : [0.2, '#000'],
					page: {
						dom : '#lsightlei' 
					}
				});
				
				setTimeout(function(){ layer.close(lay); }, 5000);
				
      });          
               
				
</script> 
<div class="lsightlei" id="lsightlei" style="display:none;"><a class="lsight" href="page/picit"> </a></div>-->
<!--漂浮广告end-->  
  
  
  <!--图片延时加载--> 
  <script>
    /***
$().ready(function(){
	$("#focusa img.lazy").lazyload({effect : "fadeIn",event : "sporty"});
	$("#channlViews img.lazy").lazyload({effect : "fadeIn",event : "sporty"});
		try{
			 $("#channlViews img.lazy").trigger("sporty");
			}catch(e){}
	
});
    **/
</script> 

  <!--图片延时加载end--> 
    <style>
    #owl-demo .item img{
        display: block;
        width: 100%;
        height: auto;
    }
    </style>

    <script>
    $(document).ready(function() {
      $("#owl-demo").owlCarousel({

      navigation : false,
      slideSpeed : 300,
      paginationSpeed : 400,
	  lazyLoad : true,
	  autoPlay : true,
      singleItem : true

      // "singleItem:true" is a shortcut for:
      // items : 1, 
      // itemsDesktop : false,
      // itemsDesktopSmall : false,
      // itemsTablet: false,
      // itemsMobile : false

      });
    });
    </script>  
  <!--banenr-->
  <div class="lunhuan">
        		<div id="lunhuanback">
            			<p style="background-image:url(<%=controller.getStaticPath(request)%>/images/zhsh6.jpg);opacity: 1; filter:alpha(opacity=100);"></p> 
                </div>	
        </div>
        <div class="brooding">
        	<div class="brooy">
            	<div class="esma">
                	<p><b>善行创投</b>（ www.myshanxing.com ) 是由深圳市前海善林资产管理有限公司倾力打造的互联网投资理财平台，注册资金3亿元人民币。平台致力于为国内外投资人与融资方提供高效、安全的综合金融信息服务，由专业的理财顾问为客户私人定制最佳资本解决方案。<br /><br />
公司总部位于深圳市地标性金融中心——京基100大厦，并在此设立了大型的平台管理中心。 善行创投管理团队集合银行、担保、
信息服务、电子商务、第三方支付等领域知名企业高级管理人才和专业信息技术人员，配合完善的产品体系、成熟的业务流程，全力打造了这个高效
便捷、安全稳定、诚信可靠的互联网投资理财平台，为个人和中小企业提供了丰富多元的网络投资理财渠道，让所有人都成为自己财富的主人。</p>
            		<div class="fkee1"><img src="<%=controller.getStaticPath(request)%>/images/fkee1.png"></div>
            	</div>
            </div>
        </div>
        <div class="brooding">
        	<div class="brooy ">
            	<h1></h1>
                <div class="guodo find_minfk1"><img src="<%=controller.getStaticPath(request)%>/images/fkee2.png"></div>
                <div class="guodo2 find_minfk2">
                   <div class="yao_bao">为什么选择善行创投</div>
                   <br>
                   <div class="yao_bao2">最安全</div>
                   <br>
                   <p>第三方合作金融机构提供本息全额担保</p>
                   <br>
                   <div class="yao_bao2">好收益</div>
                   <br>
                   <p>年化收益最高15%投资当日立即生息</p>
                   <br>
                   <div class="yao_bao2">可转让</div>
                   <br>
                   <p>支持自主定价转让保证资金流动性</p>
                   <br>
                   <div class="yao_bao2">更方便</div>
                   <br>
                   <p>移动客户端，投资更方便</p>
                </div>
                <div class="clear"></div>
            </div>
        </div>
        <div class="brooding">
        	<div class="brooy kang_noying">
                <div class="wu_bui">简单五步，轻松理财！</div>
				<div><img src="<%=controller.getStaticPath(request)%>/images/fkee3.png"></div>
            </div>
        </div>
  

<%@include file="/WEB-INF/include/footer.jsp"%>

<!-----
<script type="text/javascript">
$(".fullSlide").hover(function() {
    jQuery(this).find(".prev,.next").stop(true, true).fadeTo("show", 0.3)
},
function() {
    $(this).find(".prev,.next").fadeOut()
});
$(".fullSlide").slide({
    titCell: ".hd ul",
    mainCell: ".bd ul",
    effect: "fold",
    autoPlay: true,
    autoPage: true,
    trigger: "click",
    startFun: function(i) {
        var curLi = $(".fullSlide .bd li").eq(i);
        if ( !! curLi.attr("_src")) {
            curLi.css("background-image", curLi.attr("_src")).removeAttr("_src")
        }
    }
});
$(function(){
	$('.sx_3box').Tabs({
		event:'click'
	});
	
});	
</script>
-->
</body>
</html>