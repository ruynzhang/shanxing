<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="org.apache.http.HttpEntity"%>
<%@ page import="org.apache.http.HttpResponse"%>
<%@ page import="org.apache.http.client.HttpClient"%>
<%@ page import="org.apache.http.client.methods.HttpGet"%>
<%@ page import="org.apache.http.impl.client.DefaultHttpClient"%>
<%@ page import="org.apache.http.protocol.BasicHttpContext"%>
<%@ page import="org.apache.http.protocol.HttpContext"%>
<%@ page import="org.apache.http.util.EntityUtils"%>

<%
  // 除了配置js接口安全域名之外还要认证(目前个人账号不能认证)
		Boolean isReGetTicket = false;// 是否重新获取票据 
		String appId = "wx639cf12332e921f6";// 应用键
		String secret = "f50083d3d6d0504923e6e152104d1aa4";// 应用密钥(善林密钥)
  String wxIntfToken = getSafeString(application.getAttribute("wxIntfToken"));// 微信接口令牌
		String wxIntfTicket = getSafeString(application.getAttribute("wxIntfTicket"));// 微信接口票据
  String tokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appId + "&secret=" + secret;
  String ticketUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=SYMBOLHACK&type=jsapi";// 票据Url
  
  // 若令牌为空->获取令牌
		if(wxIntfToken==null || wxIntfToken.trim().equals("")) {
				wxIntfToken = getAndSetToken(tokenUrl, application);
				isReGetTicket = true;
		}
  // 若令牌非空->检查令牌是否过期
		else {
			// 检查是否时间Token已过期->若已超时需要重新获取Token的值
			String currentTime = getCurrentTime();
			String wxIntfTokenCreateTime = getSafeString(application.getAttribute("wxIntfTokenCreateTime"));
			Long sub = calcSubTime(wxIntfTokenCreateTime, currentTime);
			
			// 官方的Token超时时间是7200秒
			if(sub > 7200L) {
				 isReGetTicket = true;
					wxIntfToken = getAndSetToken(tokenUrl, application);
			}
		}
  
  // 若Token不为空->根据Token获取票据
		if(wxIntfToken!=null && !wxIntfToken.trim().equals("")) {
				ticketUrl = ticketUrl.replace("SYMBOLHACK", wxIntfToken);
				
				if(isReGetTicket) {
					
						// 获取主内容(根据HttpGet)
						wxIntfTicket = getJsonResponse(ticketUrl);
						application.setAttribute("wxIntfTicket", wxIntfTicket);
				}
				
				if(wxIntfTicket!=null && wxIntfTicket.indexOf("ticket")!=-1) {
					 String qzSection = "ticket\":\"";
					 String hzSection = "\",\"expires_in";
					 wxIntfTicket = wxIntfTicket.substring(wxIntfTicket.indexOf(qzSection) + qzSection.length(), wxIntfTicket.indexOf(hzSection));
						System.out.println("wxIntfTicket:" + wxIntfTicket);
				} else {
						System.out.println("wxIntfTicket为空或非法");
				}
		}
%>
<%!
// 获取并设置Token到全局缓存
public String getAndSetToken(String url, ServletContext application) {
	
	// 获取主内容(根据HttpGet)
	String wxIntfToken = getJsonResponse(url);
	
	if(wxIntfToken != null && !wxIntfToken.trim().equals("")) {
			if(wxIntfToken.indexOf("access_token")!=-1) {
				 String qzSection = "access_token\":\"";
				 String hzSection = "\",\"expires_in";
				 wxIntfToken =  wxIntfToken.substring(wxIntfToken.indexOf(qzSection) + qzSection.length(), wxIntfToken.indexOf(hzSection));
					System.out.println("wxIntfToken:" + wxIntfToken);
					application.setAttribute("wxIntfToken", wxIntfToken);
					application.setAttribute("wxIntfTokenCreateTime", getCurrentTime());
					
					return wxIntfToken;
			}
	}
	
	return null;
}
%>
<%!
/**
 * 字符获取:获取安全字符
 * 
 * @param obj
 * @return
 */
public String getSafeString(Object obj) {
	if (obj == null) {
		return "";
	} else {
		return obj.toString();
	}
}
%>
<%!
	// 获取主内容(根据HttpGet)
	public String getJsonResponse(String url) {
		String content = "";
		HttpGet httpGet = null;
		
		HttpContext context = new BasicHttpContext();
		HttpClient httpClient = new DefaultHttpClient();
		try {
			httpGet = new HttpGet(url);

			// 开始执行链接
			HttpResponse response = httpClient.execute(httpGet, context);
			HttpEntity httpEntity = response.getEntity();

			// 若返回有HTTP实体
			if (httpEntity != null) {
				content = EntityUtils.toString(httpEntity, "UTF-8");
			}
		} catch (Exception e) {
			e.printStackTrace();
			httpGet.abort();
		}
		return content;
	}
%>
<%!
 // 获取当前时间yyyy-MM-dd HH:mm:ss
	public String getCurrentTime() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(date);
	}
%>
<%!
		/**
		 * 计算:两个日期的时间差(获取相差的秒数)
		 * 
		 * @param time1
		 * @param time2
		 * @return time2-time1
		 */
		public Long calcSubTime(String time1, String time2) {
			long hoursToSecond = 0L;
			long hoursToMinutes = 0L;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			long t1 = 0L;
			long t2 = 0L;
			try {
				t1 = sdf.parse(time1).getTime();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				t2 = sdf.parse(time2).getTime();
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 因为t1-t2得到的是毫秒级,所以要除3600000得出小时.算天数或秒同理
			int hours = (int) ((t2 - t1) / 3600000);
			int minutes = (int) (((t2 - t1) / 1000 - hours * 3600) / 60);
			int second = (int) ((t2 - t1) / 1000 - hours * 3600 - minutes * 60);
		
			// 若小时不为0,将小时化为秒
			if (hours != 0) {
				hoursToSecond = hours * 3600;
			}
			// 若分不为0,将分化为秒
			if (minutes != 0) {
				hoursToMinutes = minutes * 60;
			}
			return (hoursToSecond + hoursToMinutes + second);
		}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>分享好友</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="">
		<meta http-equiv="description" content="">
		
		<!-- CSS和JS导入区 -->
  <script src="/js/fly/sha.js" type="text/javascript" charset="utf-8"></script>
  <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript" charset="utf-8"></script>
	</head>

	<body>
		<input type="hidden" id="jsapi_appid" value="<%=appId %>" />
		<input type="hidden" id="jsapi_ticket" value="<%=wxIntfTicket %>" />
	</body>
	
<script>
var currentPathUrl = location.href;// 当前网页的Url(注意URL一定要动态获取,不能hardcode)
var appId = document.getElementById("jsapi_appid").value;// 应用键
var jsapi_ticket = getJsApiTicket();// 临时票据(需要通过access_token来获取)(若未获取直接访问的话wx.error会报错的)

var nonceStr = createNonceStr();// 生成签名的随机串
var timestamp = createTimestamp();// 生成签名的时间戳
var signature = startSign(jsapi_ticket, currentPathUrl);// 签名值

// 获取JsApi的临时票据(注意缓存(这个缓存也要是application范围的),若不缓存会造成每次都重新获取,微信做了指定时间段的次数限制)
function getJsApiTicket() {
		var jsapi_ticket = document.getElementById("jsapi_ticket").value;
		if(jsapi_ticket != null) {
				console.log("jsapi_ticket:" + jsapi_ticket);
				return jsapi_ticket;
		}
		else{
				alert("获取Token失败，这会导致微信的所有接口调用失败，返回:" + jsApiTicketJson);
				return;
		}
}

// 配置
wx.config({
    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来,若要查看传入的参数,可以在pc端打开,参数信息会通过log打出,仅在pc端时才会打印
    appId: appId,// 必填,公众号的唯一标识
    timestamp: timestamp,// 必填,生成签名的时间戳
    nonceStr: nonceStr,// 必填,生成签名的随机串
    signature: signature,// 必填,签名,见附录1
    jsApiList: ["onMenuShareAppMessage", "onMenuShareTimeline", "hideMenuItems"]// 必填,需要使用的JS接口列表,所有JS接口列表见附录2
});

// 配置成功后调用
wx.ready(function() {
	// config信息验证后会执行ready方法,所有接口调用都必须在config接口获得结果之后,config是一个客户端的异步操作,所以如果需要在页面加载时就调用相关接口,则须把相关接口放在ready函数中调用来确保正确执行.对于用户触发时才调用的接口,则可以直接调用,不需要放在ready函数中
	wx.hideMenuItems({
      menuList: [
		'menuItem:readMode', // 阅读模式
        'menuItem:share:qq', // 分享到qq
        'menuItem:share:QZone', // 分享到朋友圈
        'menuItem:share:weiboApp', // 分享到腾讯微博
        'menuItem:openWithQQBrowser', // 使用qq浏览器打开
        'menuItem:openWithSafari', // 使用safari浏览器打开
        'menuItem:setFont', // 设置字体
        'menuItem:originPage', // 原网页
        'menuItem:favorite', // 收藏
        'menuItem:share:email', // 发送邮件
        'menuItem:exposeArticle', // 举报
        'menuItem:copyUrl' // 复制链接
      ],
      success: function (res) {
      },
      fail: function (res) {
        //alert(JSON.stringify(res));
      }
    });
	// 注册分享给朋友
	registerShareAppMessage();
});

// 注册分享给朋友
function registerShareAppMessage() {
	
	// 分享给朋友
	wx.onMenuShareAppMessage({
	    title: shareTitle,// 分享标题
	    desc: descContent,// 分享描述
	    link: lineLink,// 分享链接
	    imgUrl: imgUrl,// 分享图标
	    type: "link",// 分享类型,music,video或link,不填默认为link
	    dataUrl: "",// 如果type是music或video,则要提供数据链接,默认为空
	    trigger: function (res) {
	      // alert("点击发送给朋友");// 不要尝试在trigger中使用ajax异步请求修改本次分享的内容,因为客户端分享操作是一个同步操作,这时候使用ajax的回包会还没有返回
	    },
	    success: function (res) {
	      // alert("点击分享");
	    },
	    cancel: function (res) {
	      // alert("点击取消");
	    },
	    fail: function (res) {
	    	 // alert("失败了:" + res);
	    }
	});
	
	wx.onMenuShareTimeline({
	    title: shareTitle, // 分享标题
	    link: lineLink, // 分享链接
	    imgUrl: imgUrl, // 分享图标
	    success: function () { 
	        // 用户确认分享后执行的回调函数
	    },
	    cancel: function () { 
	        // 用户取消分享后执行的回调函数
	    }
	});
	
}
// 配置失败后调用
wx.error(function(res) {
				console.error("error:" + res);
    // config信息验证失败会执行error函数,如签名过期导致验证失败,具体错误信息可以打开config的debug模式查看,也可以在返回的res参数中查看,对于SPA可以在这里更新签名
});
	
// 生成签名的时间戳
function createTimestamp() {
	return parseInt(new Date().getTime() / 1000) + '';
};
	
// 生成签名的随机串
function createNonceStr() {
	return Math.random().toString(36).substr(2, 15);
};

// 开始签名
function startSign(jsapi_ticket, currentPathUrl) {
	if(jsapi_ticket==null||jsapi_ticket==""){
		alert("票据为空");
		return;
	}
	
	var ret = {
		jsapi_ticket : jsapi_ticket,
		nonceStr : nonceStr,
		timestamp : timestamp,
		url : currentPathUrl
	};
	var string = createRawUrl(ret);
	shaObj = new jsSHA(string, "TEXT");
	ret.signature = shaObj.getHash("SHA-1", "HEX");
	return ret.signature;
};

// 生成单行Url
function createRawUrl(args) {
	var keys = Object.keys(args);
	keys = keys.sort()
	var newArgs = {};
	keys.forEach(function(key) {
		newArgs[key.toLowerCase()] = args[key];
	});
	var string = "";
	for (var k in newArgs) {
		string += "&" + k + "=" + newArgs[k];
	}
	string = string.substr(1);
	return string;
};
</script>
</html>