$(function(){
	$("input").keypress(function(){
		if(event.keyCode==13) {return false;}
	  });
	
	$('#tips0').hover(function(){
        $("#tips0Msg").show();
       },function(){
    	$("#tips0Msg").hide();
    });
	
	$('#tips0Msg').hover(function(){
        $("#tips0Msg").show();
       },function(){
    	$("#tips0Msg").hide();
    });
	$('#tips1').hover(function(){
        $("#tips1Msg").show();
       },function(){
    	$("#tips1Msg").hide();
    });
	
	$('#tips1Msg').hover(function(){
        $("#tips1Msg").show();
       },function(){
    	$("#tips1Msg").hide();
    });
	
	$("#tbButton").click(function(){
		checkBid();
	});
	
	$("#ok").click(function(){
		var value=$(":input[name='hb_id']").val();
		$("#hbId").val(value);
		var form = document.forms[0];
		form.submit();
	});
	
	 
});

function checkBid(){
	
	
	
	var amount=$("#amount").val();
	if(amount == 0 || amount.length==0){
		$("#info").html(showDialogInfo("请输入购买金额","perfect"));	
		$("div.popup_bg").show();
		return;
	}
	
	var kyMoney=$("#kyMoney").val();
	if(parseInt(kyMoney) < parseInt(amount)){
		var url=$("#charge").val();
		$("#info").html(showForwardInfo('您的账户余额不足进行本次投标 ，请充值，点击"确定"，跳到充值页面，点击"取消"返回当前页面',"perfect",url));	
		$("div.popup_bg").show();
		return;
	}
	var syje= $("#syje").val();
	if(parseInt(syje) < parseInt(amount)){
		$("#info").html(showDialogInfo("您的投标金额大于标的剩余金额","perfect"));	
		$("div.popup_bg").show();
		return;
	}
	
	var minBid = $("#minBid").val();
	if(parseInt(amount) < parseInt(minBid)){
		$("#info").html(showDialogInfo("您的投标金额小于投标最低金额","perfect"));	
		$("div.popup_bg").show();
		return;
	}
	
	if(parseInt(syje) - parseInt(amount) <  parseInt(minBid) &&  parseInt(syje) - parseInt(amount) >  0){
		$("#info").html(showDialogInfo("剩余可投金额不能小于"+parseInt(minBid),"perfect"));	
		$("div.popup_bg").show();
		return;
	}
	
	
	var isYuqi= $("#isYuqi").val();
	
	if(isYuqi == "Y"){
		$("#info").html(showDialogInfo("您有逾期未还的贷款，还完才能进行投标操作","perfect"));	
		$("div.popup_bg").show();
		return;
	}
	$("#zxMoney").text(amount);
	if($("#isActivity").val()=='F'){
		$.ajax({
			   type: "POST",
			   url: "/financing/sbtz/hbList.htm",
			   data: "amount="+amount,
			   success: function(msg){
				   $("#hb_div").empty();
				   $("#div_confirm").after(msg);
			   }
		});
	}
	 $("div.popup_bg").show();
	 $("div.dialog").show();
}

function openImageDiv(id) {

	//显示灰色 jQuery 遮罩层 
	var bh = $("body").height();
	var bw = $("body").width();
	$("#fullbg"+id).css({
		height : bh,
		width : bw,
		display : "block"
	});
	$("#dialog"+id).show();
}
//关闭灰色 jQuery 遮罩 
function closeBg(id) {
	$("#fullbg"+id).hide();
	$("#dialog"+id).hide();
}

function AutoResizeImage(maxWidth,maxHeight,objImg,imgId){
	nivWidth = window.screen.width;
	nivHeight = window.screen.height;
	if(nivWidth == 1366 && nivHeight == 768){
		maxWidth = 750;
		maxHeight = 750;
	}else if(nivWidth == 1360 && nivHeight == 768){
		maxWidth = 745;
		maxHeight = 745;
	}else if(nivWidth == 1280 && nivHeight == 1024){
		$("#dialog"+imgId).css("left","30%");
		if($.browser.msie){
		maxWidth = 945;
		maxHeight = 945;
		$("#dialog"+imgId).css("top","25%");	
		}else{
			maxWidth = 950;
			maxHeight = 950;
		}
	}else if(nivWidth == 1280 && nivHeight == 960){
		$("#dialog"+imgId).css("left","30%");
		if($.browser.msie){
		maxWidth = 935;
		maxHeight = 935;
		$("#dialog"+imgId).css("top","20%");	
		}else{
			maxWidth = 950;
			maxHeight = 950;
			$("#dialog"+imgId).css("top","25%");
		}
	}else if(nivWidth == 1280 && nivHeight == 800){
		$("#dialog"+imgId).css("left","30%");
		if($.browser.msie){
		maxWidth = 935;
		maxHeight = 935;
		$("#dialog"+imgId).css("top","20%");	
		}else{
			maxWidth = 950;
			maxHeight = 950;
			$("#dialog"+imgId).css("top","25%");
		}
	}else if(nivWidth == 1024 && nivHeight == 768){
		$("#dialog"+imgId).css("left","33%");
		if($.browser.msie){
		maxWidth = 680;
		maxHeight = 680;
		$("#dialog"+imgId).css("top","27%");	
		}else{
			maxWidth = 750;
			maxHeight = 750;
			$("#dialog"+imgId).css("top","25%");
		}
	}
	
	var img = new Image();
	img.src = objImg.src;
	var hRatio;
	var wRatio;
	var Ratio = 1;
	var w = img.width;
	var h = img.height;
	wRatio = maxWidth / w;
	hRatio = maxHeight / h;
	if (maxWidth ==0 && maxHeight==0){
	Ratio = 1;
	}else if (maxWidth==0){//
	if (hRatio<1) Ratio = hRatio;
	}else if (maxHeight==0){
	if (wRatio<1) Ratio = wRatio;
	}else if (wRatio<1 || hRatio<1){
	Ratio = (wRatio<=hRatio?wRatio:hRatio);
	}
	if (Ratio<1){
	w = w * Ratio;
	h = h * Ratio;
	}
	objImg.height = h;
	objImg.width = w;
	}