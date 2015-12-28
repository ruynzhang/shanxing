$(function() {
	keyWord();
});
$("#keyWord").focusin(function() {
	var keyWord = $("#keyWord").val();
	if (keyWord == '用户名、姓名、银行卡账号') {
		$("#keyWord").attr("value", "");
		$("#keyWord").css("color", "");
	}
});
$("#keyWord").blur(function() {
	keyWord();
});
function keyWord() {
	var keyWord = $("#keyWord").val();
	if (keyWord == "") {
		$("#keyWord").attr("value", "用户名、姓名、银行卡账号");
		$("#keyWord").css("color", "gray");
	} else if (keyWord == '用户名、姓名、银行卡账号') {
		$("#keyWord").css("color", "gray");
	}
}
$("#importData").click(function() {
	$("#importDiv").show();
});
$(".close").click(function() {
	$("#importDiv").hide();
});
$(".checkAll").click(function() {
	var checked = $(".checkAll").attr("checked");
	if (checked == 'checked') {
		$(".checkId").attr("checked", true);
	} else {
		$(".checkId").attr("checked", false);
	}
});

$(".checkId").click(function() {
	var checkBoxs = $(".checkId");
	var isCheckedAll = true;
	for ( var i = 0; i <= checkBoxs.length - 1; i++) {
		if ($(checkBoxs[i]).attr("checked") != "checked") {
			isCheckedAll = false;
		}
	}
	if (isCheckedAll) {
		$(".checkAll").attr("checked", true);
	} else {
		$(".checkAll").attr("checked", false);
	}
});
function checkAll(status,url) {
	$("#reasonDiv").hide();
	var ids = "";
	var ckeds = $(".checkId:checked");
	if (ckeds == null || ckeds.length <= 0) {
		alert("请选择提现记录!");
		return;
	}
	if (status == 'SHTG' && !window.confirm("是否执行'批量审核通过'")) {
		return;
	} else if (status == 'SHSB' && !window.confirm("是否执行'批量审核不通过'")) {
		return;
	}
	for ( var i = 0; i < ckeds.length; i++) {
		var val = $(ckeds[i]).val();
		if (i == 0) {
			ids += val;
		} else {
			ids += "," + val;
		}
	}
	if (status == 'SHTG') {
		location.href = url + "?status="+ status + "&ids=" + ids;
	} else {
		$("#ids").attr("value", ids);
		$("#reasonDiv").show();
	}
}

$(".close").click(function() {
	$("#reasonDiv").hide();
});