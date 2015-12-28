$(function(){
	$("#checkAll").click(function(){
		
	if($(this).is(":checked")){
			checkbox_select_all('letterId');
			//$("input:checkbox[name='letterId']").attr("checked",true);
			//$("input:checkbox[name='letterId']").prop("checked",true);	
		}else{
			checkbox_select_all_cancel('letterId');
			//$("input:checkbox[name='letterId']").removeAttr("checked"); 
		}
	
	});
	$("input:checkbox[name='letterId']").click(function(){
		if("checked"!=$(this).attr("checked")){
			$("#checkAll").attr("checked",false);
		}else{
			var c1 = $("input:checkbox[name='letterId']:checked").length;
			var c2 = $("input:checkbox[name='letterId']").length;
			if(c1==c2){
				$("#checkAll").attr("checked",true);
			}
		}
	});
	$("select[name='status']").change(function(){
		window.location.href = url_self+"?status="+$(this).find("option:selected").val();
	});
	$("div.dialog_close").click(function(){
		$("div.dialog").hide();
	});
	$("#cancel").click(function(){
		$("div.dialog").hide();
	});
	$("#ok").click(function(){
		var form = document.forms[0];
		form.action = url_del;
		form.submit();
	});
});
function openLetter(obj, status, id){
	show('_'+id);
	if("WD"==status){
		$.post(url_update,{id:id},function(result){
			result = parseInt(result);
			if(1==result){
				$(obj).attr("onclick","openLetter(this,'YD', '"+id+"')");
				$(obj).find("div.til span").attr("class","zn_ico3");
				var unread = parseInt($("#unread").text());
				if(unread>=1){
					$("#unread").text(unread-1);
				}
				$("a.message span.red").text('('+(unread-1)+')');
			}
		},'json');
	}
}

function delAll(){
	if($("input:checkbox[name='letterId']:checked").length<=0){
		return ;
	}
	$("div.dialog").show();
}


// 全选选中与取消
function checkbox_qx(ck_quanxuan, ck_single) {
	var cu = $("input[name='" + ck_quanxuan + "']")[0];
	checkbox_select_all_cancel(ck_single);
	if (cu.checked) {
		checkbox_select_all(ck_single);
	} else {
		checkbox_select_all_cancel(ck_single);
	}
	$('input[type=checkbox]').trigger("updateState");
}

// 全部选中
function checkbox_select_all(ck_single) {
	$("input[name='" + ck_single + "']").each(function() {
		$(this).get(0).defaultChecked = true;
		$(this).prop("checked", true);
	});
}

// 取消选中
function checkbox_select_all_cancel(ck_single) {
	$("input[name='" + ck_single + "']").each(function() {
		$(this).get(0).defaultChecked = false;
		$(this).prop("checked", false);
	});
}
