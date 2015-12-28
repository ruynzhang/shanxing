var bestScore = 0;// 最佳分
var sareUrlQzPath = "http://www.myshanxing.com";// 分享前置路径
var lqLinkQzPath = "http://www.myshanxing.com";// 领取体验金的前置路径(http://192.168.3.123:8080)
var lineLink = sareUrlQzPath + "/fly/index.html";// 分享链接
var imgUrl = sareUrlQzPath + "/images/fly_p_007.png";// 分享图片地址
var descContent = "";// 分享描述(过后设置)
var shareTitle = "钱太少，不满足？赶紧搬救兵吧！?";// 分享标题
var HOME_PATH = sareUrlQzPath + "/fly/index.html", HORIZONTAL = HORIZONTAL || false, COVER_SHOW_TIME = COVER_SHOW_TIME || 2e3;

(function() {
	function n() {
		window.scroll(0, 0);
		var e;
		if (window.orientation == 0 || window.orientation == 180) {
			e = false
		} else if (window.orientation == -90 || window.orientation == 90) {
			e = true
		}
		if (e == HORIZONTAL) {
			t.style.display = "none"
		} else {
			setTimeout(function() {
				r();
				t.style.width = window.innerWidth + "px";
				t.style.display = "block"
			}, isIOS() ? 0 : 600)
		}
		if (HORIZONTAL == true && isWeixin() && !isIOS()) {
			WeixinJSBridge.call("hideToolbar");
		}
	}
	function r() {
		e.style.height = window.innerHeight + "px";
		e.style.width = window.innerWidth + "px";
		t.style.height = window.innerHeight + "px"
	}
	if (typeof playInit == "function") {
		playInit();
	}
	if (!isMobile()) {
		return;
	}
	var e = document.createElement("div");
	e.style.cssText = "position:absolute;z-index:1000000;left:0;top:0;background-size: 50%;width:" + window.innerWidth + "px;height:" + Math.max(window.innerHeight, window.document.documentElement.offsetHeight) + "px";
	e.className = "common_cover";
	document.body.appendChild(e);
	setTimeout(function() {
		e.parentNode.removeChild(e);
	}, COVER_SHOW_TIME);
	document.addEventListener("touchmove", function(e) {
		e.preventDefault();
	}, false);
	var t = document.createElement("div");
	t.className = "common_notice";
	t.style.cssText = "position:absolute;z-index:999999;left:0;top:0;background-size: 50%;";
	document.body.appendChild(t);
	window.addEventListener("orientationchange", n);
	window.addEventListener("load", n);
	window.addEventListener("scroll", r);
})();

addShareWX();// 分享到朋友圈(弹框)

// 显示分享
function showShare() {
	var score = 0;
	
	// 若为点击首页的领取体验金
	if (pressType == 0) {
		score = getCookie("dc987d0296234d428e54a04a5ee5c5c0");
		if (score == null) {
			score = 0;
		}
	}
	// 若为点击游戏结束的领取体验金
	else if (pressType == 2) {
		score = bestScore;
	}

	var pid = document.getElementById("pid").value;
	var url = lqLinkQzPath + "/m_register.html";
	//alert(url);// 测试

	// 兼容IE6的Location.href(若为a标签,在a的href属性中设置为###也可兼容)
	startLocationHref(url);
}

// 关闭分享
function closeshare() {
	document.getElementById("share-wx").style.display = "none";
}

// 初始化play
function playInit() {
	var score = getCookie("dc987d0296234d428e54a04a5ee5c5c0");
	if (score != null) {
		updateScore(score);// 更新分享记录
	} else {
		updateScore(0);// 更新分享记录
	}
}

// 更新分享记录
function updateScore(scr_m) {
	if (scr_m > 0) {
		var score = getCookie("dc987d0296234d428e54a04a5ee5c5c0");
		if (score != null) {
			if (score > scr_m) {
				scr_m = score;
			}
		}
		
		bestScore = scr_m;
		setCookie("dc987d0296234d428e54a04a5ee5c5c0", bestScore);
		descContent = "哇塞！我在善行创投抢到了" + bestScore + "的横财，快给我助力赢更多，你也赶紧来测试自己的横财运！";
	} else {
		descContent = "哇塞！我在善行创投抢到了好多横财，快给我助力赢更多，你也赶紧来测试自己的横财运！";
	}
	lineLink = lineLink + "?PID=" + document.getElementById("userId").value;
	
	// 注册分享给朋友(重新注册,用于更新参数值)
	registerShareAppMessage();
}

// 是否为微信
function isWeixin() {
	var e = navigator.userAgent.toLowerCase();
	if (e.match(/MicroMessenger/i) == "micromessenger") {
		return true;
	} else {
		return false;
	}
}

// 是否为手机
function isMobile() {
	return navigator.userAgent.match(/android|iphone|ipod|blackberry|meego|symbianos|windowsphone|ucbrowser/i)
}

// 是否为IOS系统
function isIOS() {
	return navigator.userAgent.match(/iphone|ipod|ios/i)
}

// 分享到朋友圈(弹框)
function addShareWX() {
	var e = document.createElement("div");
	e.id = "share-wx";
	e.onclick = closeshare;
	document.body.appendChild(e);
	var t = document.createElement("p");
	t.style.cssText = "text-align:right;padding-left:10px;";
	e.appendChild(t);
	var n = document.createElement("img");
	n.src = "/images/fly_p_001.png";
	n.id = "share-wx-img";
	n.style.cssText = "max-width:280px;padding-right:25px;";
	t.appendChild(n);
}

// 获取Cookie值
function getCookie(name) {
	var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
	if (arr = document.cookie.match(reg))
		return unescape(arr[2]);
	else
		return null;
}

// 设置Cookie值
function setCookie(name, value) {
	var Days = 0.25;
	var exp = new Date();
	exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
	document.cookie = name + "=" + escape(value) + ";expires" + exp.toGMTString();
}

// 兼容IE6的Location.href(若为a标签,在a的href属性中设置为###也可兼容)
function startLocationHref(url) {
	location.href = url;// 将当前页面改变
	return false;
}