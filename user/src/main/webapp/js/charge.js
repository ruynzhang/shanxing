$(function() {
	$("input[name='amount']").focusout(function() {
		var amount = $(this).val() * 1;
		amount = amount.toFixed(2) * 1;
		$(this).val(amount);
		/*
		 * if(!checkAmount(amount)){ return ; }
		 */
		amount = amount * 1;
		/*
		 * if(!checkRange(amount)){ return ; }
		 */
		var poundage = amount * p;
		if (poundage > pMax) {
			$("#poundage").text(pMax);
			$("#paySum").text(amount - pMax);
		} else {
			$("#poundage").text(toDecimal(poundage));
			$("#paySum").text((amount - poundage).toFixed(2));
		}
	});
	$("#dialog div.dialog_close").click(function() {
		$("#dialog").hide();
	});
	function toDecimal(x) {
		var f = parseFloat(x);
		if (isNaN(f)) {
			return;
		}
		f = Math.round(x * 100) / 100;
		return f;
	}
	$("#otherPay").click(function() {
		$("#problem").hide();
	});
	$("#problem div.dialog_close").click(function() {
		$("#problem").hide();
	});
	$("#problem a.btn06").click(function() {
		$("#problem").hide();
	});
	$("a.tx_an1").mouseover(function() {
		$(this).parent().parent().find("div.pop-con").show();
	});
	$("a.tx_an1").mouseout(function() {
		$(this).parent().parent().find("div.pop-con").hide();
	});
});
function checkAmount(amount) {
	if (isNaN(amount)) {
		$("input[name='amount']").val("");
		$("#con_error").html("对不起，您输入的金额不为数字");
		$("#dialog").show();
		return false;
	}
	return true;
}
function checkRange(amount) {
	if (amount >= min && amount <= max) {
		return true;
	}
	$("#con_error").html(
			"充值金额不能低于<span class='red'>" + min
					+ "</span>元，且不能高于<span class='red'>" + max / 10000
					+ "</span>万元");
	$("#dialog").show();
	return false;
}
function checkAuth() {
	if (auth) {
		return true;
	}
	$("#con_error").html(authText);
	$("#dialog").show();
	return false;
}
function onSubmit() {
	var amount = $("input[name='amount']").val() * 1;
	if (checkAuth() && checkAmount(amount) && checkRange(amount)) {
		$("#problem").show();
		return true;
	}
	return false;
}