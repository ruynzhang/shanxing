<%@include file="/WEB-INF/include/jquery-ui.jsp"%>
<style>
	.ui-datepicker-current{display: none}
</style>
<script type="text/javascript">
	$(function() {
		$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
		$.datepicker.setDefaults({
			dateFormat : 'yy-mm-dd',
			showButtonPanel : false,
			onSelect : function(input, inst) {
				this.value = input;
			}
		});
		
		 //用来存放当前正在操作的日期文本框的引用。  
	     var datepicker_CurrentInput;  
	   
	     // 设置DatePicker 的默认设置  
	     $.datepicker.setDefaults({ showButtonPanel: true, closeText: '清空', beforeShow: function (input, inst) { datepicker_CurrentInput = input; } });  
	   
	     // 绑定“Done”按钮的click事件，触发的时候，清空文本框的值  
	     $(".ui-datepicker-close").live("click", function ()  
	     {  
	         datepicker_CurrentInput.value = "";  
	     });
	});
</script>