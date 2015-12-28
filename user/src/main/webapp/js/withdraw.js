$(function() {
	$("input[name='amount']").focusout(function() {
		var amount = $(this).val() * 1;
		amount = amount.toFixed(2) * 1;
		$(this).val(amount);
		if (!checkAmount(amount)) {
			return;
		}
		amount = amount * 1;
		/*if (!checkRange(amount)) {
			return;
		}*/
		$("span.error_tip").text("");
		var p = poundage2(amount);
		$("#poundage").text(p);
		var total = checkTotal(amount, p*1);
		$("#paySum").text(total);
		//$("#paySum").text(amount + p*1);
		//overFlow(amount + p);
	});
	$("div.dialog_close").click(function() {
		$("#dialog").hide();
	});
	$("a.tx_an1").mouseover(function(){
		$(this).parent().parent().find("div.pop-con").show();
	});
	$("a.tx_an1").mouseout(function(){
		$(this).parent().parent().find("div.pop-con").hide();
	});
	var a = $("input[name='amount']").val();
	if(a != null && "" != a && a.length != 0){
		var aa = a*1;
		var pp = poundage(aa);
		$("#poundage").text(pp);
		$("#paySum").text(aa + pp);
	}
});
function poundage1(amount){
	if (1 <= amount && amount < 5000) {
		return p1;
	} else if(amount >= 5000 ){
		return p2;
	} else {
		return 0;
	}
}
function poundage2(amount){
	return amount * proRate < proMin?proMin:(amount * proRate).toFixed(2);
}
function checkTotal(amount, p){
	if((p+amount) > balance){
		return amount;
	}
	return p+amount;
}
function checkCard(obj, id) {
	$("li.cards a").removeClass();
	$(obj).addClass("curr");
	$("input[name='cardId']").val(id);
}
function checkAmount(amount) {
	if (isNaN(amount)) {
		$("input[name='amount']").val("");
		$("#con_error").html("对不起，您输入的金额不为数字");
		$("#dialog").show();
		return false;
	}
	if (amount > balance) {
		$("input[name='amount']").val("");
		$("#con_error").html("对不起，您的余额不足");
		$("#dialog").show();
		return false;
	}
	return true;
}
function checkRange(amount) {
	if (amount >= min && amount <= max) {
		return true;
	}
	$("#poundage").text(0);
	$("#paySum").text(0);
	$("#con_error").html(
			"提现金额不能低于<span class='red'>" + min
					+ "</span>元，且不能高于<span class='red'>" + max / 10000
					+ "</span>万元");
	$("#dialog").show();
	return false;
}
function onSubmit() {
	var a = $("input[name='amount']").val();
	if(a == '' || a == null || a.length == 0){
		$("#con_error").html("请输入提现金额");
		$("#dialog").show();
		return false;
	}
	var a = $("input[name='amount']").val();
	if(!getCard() || !checkAmount(a)){
		return false;
	}
	var amount = $("input[name='amount']").val() * 1;
	var p = poundage2(amount);
	if(!checkRange(amount) || !withdrawPsd()){
		return false;
	}
	return true;;
}
function withdrawPsd() {
	var psd = $("input[name='withdrawPsd']").val();
	if (psd == null || "" == psd || psd.length == 0) {
		$("#con_error").html("提现密码不能为空");
		$("#dialog").show();
		return false;
	}
	return true;
}
function getCard(){
	if(len <= 0){
		$("#con_error").html("您还没有银行卡，请先添加银行卡");
		$("#dialog").show();
		return false;
	}
	return true;
}