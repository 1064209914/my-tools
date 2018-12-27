+function ($){
	//1.使用严格模式ES5支持
	"use strict";
	//2.表单插件类及原型方法的定义
	var FormComponents = function (element,options){
		
	};
	//下拉菜单生成
	FormComponents.prototype.select = function(obj){
		var $this = $(obj);
		//防止重复生成选项
		if($this.has('option').length > 0){
			return;
		}
		var value = $this.data("selectValue");
		var emptyOption = $this.data("emptyoption"); 
		var labelValue;
		if($this.data("selectList") && $this.data("selectList") != ""){
			labelValue = $this.data("selectList").replace('[','').replace(']','').trim().split(',');
		}else{
			return;
		}
		if(emptyOption){
			$this.append("<option value='' selected>请选择</option>");
		}
		$(labelValue).each(function(index){
			var labelValueAttr = labelValue[index].split(':');
			$this.append("<option value="+labelValueAttr[0]+">"+labelValueAttr[1]+"</option>");
		});
		if(value || value=="0"){
			$this.val(value);
		}
	};
	//单选按钮生成
	FormComponents.prototype.radio = function(obj){
		var $this = $(obj);
		//防止重复生成选项
		if($this.has('label').length > 0){
			return;
		}
		var value = $this.data("radioValue");
		var name = $this.attr("name");
		var labelValue;
		if($this.data("radioList") && $this.data("radioList") != ""){
			labelValue = $this.data("radioList").replace('[','').replace(']','').trim().split(',');
		}else{
			return;
		}
		$(labelValue).each(function(index){
			if(index>0 && index%4 ==0){
				$this.append("<br>");
			}
			var labelValueAttr = labelValue[index].split(':');
			
			$this.append("<label>" +
							"<input name="+name+" id=\"form-field-"+$this.attr("id")+"\" type=\"radio\" class=\"ace\" value="+labelValueAttr[0]+">" +
							"<span class=\"lbl\">"+labelValueAttr[1]+"</span>" +
						"</label> &nbsp;&nbsp;");
			if((value.toString()).indexOf(parseInt(labelValueAttr[0])) >= 0){
				$this.find("input[value="+value+"]").attr("checked","checked");
			}
		});
	};
	//多选按钮生成
	FormComponents.prototype.check = function(obj){
		var $this = $(obj);
		//防止重复生成选项
		if($this.has('label').length > 0){
			return;
		}
		var value = $this.data("checkValue");
		var name = $this.attr("name");
		var labelValue;
		var checkedHtml = "";
		var labelValueAttr = "";
		if($this.data("checkList") && $this.data("checkList") != ""){
			labelValue = $this.data("checkList").replace('[','').replace(']','').trim().split(',');
		}else{
			return;
		}
		checkedHtml += "<table width='50%'>";
		$(labelValue).each(function(index){
			labelValueAttr = labelValue[index].split(':');
			if( index%2 == 1 ){
				checkedHtml += "<td class='left' width='25%'><label> "+
						"<input name="+name+" id=\"form-field-checkbox\" type=\"checkbox\" class=\"ace ace-checkbox-2\" value="+labelValueAttr[0]+">"+
						"<span class=\"lbl\">"+labelValueAttr[1]+"</span>"+
				"</label></td></tr>";
			}else{
				checkedHtml += "<tr><td class='left' width='25%'><label> "+
						"<input name="+name+" id=\"form-field-checkbox\" type=\"checkbox\" class=\"ace ace-checkbox-2\" value="+labelValueAttr[0]+">"+
						"<span class=\"lbl\">"+labelValueAttr[1]+"</span>"+
				"</label></td>";
			}
			if(value){
				if((value.toString()).indexOf(parseInt(labelValueAttr[0])) >= 0){
					$this.find("input[value="+labelValueAttr[0]+"]").attr("checked","checked");
				}
			}
		});
		checkedHtml += "</table>";
		$this.append(checkedHtml);
	};
	//3.在jQuery上定义FormComponents插件，并重设插件构造器
	$.fn.formComponents = function(element){
		//alert("jQuery调用FormComponents方法");
		if(element === "select"){
			FormComponents.prototype.select(this);
		}else if(element === "radio"){
			FormComponents.prototype.radio(this);
		}else if(element === "check"){
			FormComponents.prototype.check(this);
		}
	};
	$.fn.formComponents.Constructor = FormComponents;
	//4.防冲突处理
	$.fn.formComponents.noConflict = function(){
		//恢复以前的旧代码
		$.fn.select = old;
		return this;
	};
	//5.绑定触发事件
	$(document).on("load","[data-select='select']",FormComponents.prototype.select);
}(window.jQuery);