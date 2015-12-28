$(function(){
	
	$("input").keypress(function(){
		if(event.keyCode==13) {return false;}
	  });
	
	$("#amount").keyup(function(){
		var fs=$("#amount").val();
		var zrjg=$("#zrjg").val();
		var zxMoney=zrjg*fs;
		$("#tbMoney").text(zxMoney);
	});
	
	$("#tbButton").click(function(){
		checkBid();
	});
	
	$("#ok").click(function(){
		var form = document.forms[0];
		form.submit();
	});
	
	
});

function checkBid(){
	
	var fs=$("#amount").val();
	if(fs == 0 || fs.length==0){
		$("#info").html(showDialogInfo("请输入购买份数","perfect"));	
		$("div.popup_bg").show();
		return;
	}
	var syfs= $("#syfs").val();
	if(parseInt(syfs) < parseInt(fs)){
		$("#info").html(showDialogInfo("你的购买的份数大余剩余债权份数","perfect"));	
		$("div.popup_bg").show();
		return;
	}
	var kyMoney=$("#kyMoney").val();
	var zrjg=$("#zrjg").val();
	var zxMoney=zrjg*fs;
	if(kyMoney < zxMoney){
		var url=$("#charge").val();
		$("#info").html(showForwardInfo('你的账户余额不足进行本次投标 ，请充值，点击"确定"，跳到充值页面，点击"取消"返回当前页面',"perfect",url));	
		$("div.popup_bg").show();
		return;
	}
	var isYuqi= $("#isYuqi").val();
	
	if(isYuqi == "Y"){
		$("#info").html(showDialogInfo("您有逾期未还的贷款，还完才能进行投标操作","perfect"));	
		$("div.popup_bg").show();
		return;
	}
	
	
	
	
	$("#fs").text(fs);
	$("#zxMoney").text(zxMoney);
	$("div.popup_bg").show();
	$("div.dialog").show();
}

function buy(zrjg,zqjz,zqsqId){
	$("#zqzrId").val(zqsqId);
	$("#zqjz").html(zqjz);
	$("#zrjg").html(zrjg);
	$("div.popup_bg").show();
	$("div.dialog").show();
}

 
