$("#checkAll").click(function() {
	var checked = $("#checkAll").attr("checked");
	if (checked == 'checked') {
		$(".checkId").attr("checked", true);
	} else {
		$(".checkId").attr("checked", false);
	}
});

$("#reverseall").click(function() {
	var inputs = $(".checkId");
	for (var i = 0; i <= inputs.length - 1; i++) {
		var input = inputs[i];
		input.checked=!input.checked;
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
		$("#checkAll").attr("checked", true);
	} else {
		$("#checkAll").attr("checked", false);
	}
});
function batchDispose(url,state) {
	var ids = "";
	var ckeds = $(".checkId:checked");
	if (ckeds == null || ckeds.length <= 0) {
		alert("请选择记录!");
		return;
	}
	if(state=='S')
	{
		if (!window.confirm("是否确认对您所选择的所有借款标进行发布？")) {
			return;
		}
	}else if(state=='F')
	{
		if (!window.confirm("是否确认对您所选择的所有借款标进行下架？")) {
			return;
		}
	}
	for ( var i = 0; i < ckeds.length; i++) {
		var val = $(ckeds[i]).val();
		if (i == 0) {
			ids += val;
		} else {
			ids += "," + val;
		}
	}
	location.href = url + "?ids=" + ids+"&state="+state;
}
function notLoad(id)
{
	$("#id").attr("value", id);
	$("#reasonDiv").show();
}
$(".close").click(function() {
	$("#reasonDiv").hide();
});
