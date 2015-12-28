$("#checkAll").click(function() {
	var checked = $("#checkAll").attr("checked");
	if (checked == 'checked') {
		$(".checkId").attr("checked", true);
	} else {
		$(".checkId").attr("checked", false);
	}
});

$("#reverseall").click(function() {
	var checked = $(".checkId").attr("checked");
	checked=!checked;
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
		$("#checkAll").attr("checked", true);
	} else {
		$("#checkAll").attr("checked", false);
	}
});
function load(url,title)
{
	if (!window.confirm("是否确认要对“"+title+"”借款执行放款？")) {
		return;
	}
	location.href=url;
}
function batchLoan(url) {
	var ids = "";
	var ckeds = $(".checkId:checked");
	if (ckeds == null || ckeds.length <= 0) {
		alert("请选择放款记录!");
		return;
	}
	if (!window.confirm("是否确认对您所选择的所有借款进行放款？")) {
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
	location.href = url + "?ids=" + ids;
}
function notLoad(id)
{
	$("#id").attr("value", id);
	$("#reasonDiv").show();
}
$(".close").click(function() {
	$("#reasonDiv").hide();
});

function notExcemonyLoad(url,title)
{
	if (!window.confirm("是否确认要对“"+title+"”借款执行不放款操作？")) {
		return;
	}
	location.href=url;
};
