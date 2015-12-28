$(function(){
	$("#checkAll").click(function(){
		if($(this).attr("checked")){
			$("input:checkbox[name='id']").attr("checked",true);
		}else{
			$("input:checkbox[name='id']").attr("checked",false);
		}
	});
	$("input:checkbox[name='id']").click(function(){
		if(!$(this).attr("checked")){
			$("#checkAll").attr("checked",false);
		}else{
			var c1 = $("input:checkbox[name='id']:checked").length;
			var c2 = $("input:checkbox[name='id']").length;
			if(c1==c2){
				$("#checkAll").attr("checked",true);
			}
		}
	});
	$("#delAll").click(function(){
		if($("input:checkbox[name='id']:checked").length != 0){
			if(confirm("是否确认删除选中的行？")){
				var form = document.forms[0];
				form.action = del_url;
				form.submit();
			}
		}else{
			alert("选择要删除的行");
		}
	});
});