<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/zTreeStyle.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.ztree.core-3.5.min.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript">
	var array = []; //原有权限的数组
	$(function() {

		$("#cc").combobox({
			onSelect : function(data) {
				//清空数组
				array.splice(0, array.length);
				initTree();
				roleChange(data.id);
			}
		})
	});

	function initTree() {
		$.ajax({
			url : '${pageContext.request.contextPath}/role/getAllPri',
			method : 'post',
			dataType : 'json',
			success : function(data) {
				var setting = {
					check : {
						enable : true
					},
					chkStyle : "checkbox",
				};
				$.fn.zTree.init($('#xzqtree'), setting, data);

			}
		});
	}

	function roleChange(data) {
		$.ajax({
			url : '${pageContext.request.contextPath}/role/getPriByRole',
			method : 'post',
			data : {
				roleid : data
			},
			success : function(data) {
				// 获取zTree对象
				var treeObj = $.fn.zTree.getZTreeObj("xzqtree");
				var nodes = treeObj.getNodes(); //获取树状图上的根节点
				treeObj.setChkDisabled(nodes[0], true);
				var node = treeObj.transformToArray(nodes); //通过根节点 获取所有节点数组
				for (var a = 0; a < node.length; a++) {
					$.each(eval("(" + data + ")"), function(i, item) {
						array[i] = item.p_Id;
						if (item.p_Id == node[a].id) {
							treeObj.expandNode(node[a], true); //展开选中的  
							treeObj.checkNode(node[a], true);
						}
					});
				}
			}
		})
	}
	function savePrivilege() {

		var datas = $('#cc').combobox('getValue');
		if (datas == "")
			$.messager.alert("系统提示", "请选择角色！");

		var treeObj = $.fn.zTree.getZTreeObj("xzqtree");
		var nodes = treeObj.getChangeCheckedNodes();//更新后的新数组

		var nodeId = []; //角色的新权限数组

		for (var i = 0; i < nodes.length; i++) {
			nodeId[i]=nodes[i].id;
		}
		//移除-1

		/*
		     系统管理员: 1  2  3
		                     新: 1  2  4
		 */
		//两个数组中的数据 A(原有角色拥有的数据) B(角色新分配的数据)
		//1:重复的数据无需任何增删操作
		//2:不重复的数据(原数组中的数据) 需要被移除  新数组中的数据需要追加
		//获取两个数组的重复部分 交集(返回值数组)
		var arrayInter = arrayIntersection(nodeId.sort(), array.sort());

		//获取原有权限和重复部分的差集 要被移除的部分！
		var remove = sub(array.sort(), arrayInter.sort());

		var remove1 = remove.join(",");
		//获取现有权限和重复部分的差集 要被增加的部分！
		var add = sub(nodeId.sort(), arrayInter.sort());

		var add1 = add.join(",")

		$.post("${pageContext.request.contextPath}/role/changePrivilege", {
			addStr : add1,
			removeStr : remove1,
			roleid : datas
		}, function(json) {
			var flag = eval("(" + json + ")");
			if (flag) {
				$("ul").empty();
				initTree();
				roleChange(datas);

			}
		});
	}
	function arrayIntersection(a, b) {
		var ai = 0, bi = 0;
		var result = new Array();
		while (ai < a.length && bi < b.length) {
			if (a[ai] < b[bi]) {
				ai++;
			} else if (a[ai] > b[bi]) {
				bi++;
			} else /* they're equal */
			{
				result.push(a[ai]);
				ai++;
				bi++;
			}
		}
		return result;
	}
	function sub(a, b) {
		var arr3 = new Array();
		for (var i = 0; i < a.length; i++) {
			var flag = true;
			for (var j = 0; j < b.length; j++) {
				if (a[i] == b[j])
					flag = false;
			}
			if (flag)
				arr3.push(a[i]);
		}
		return arr3
	}
</script>
</head>
<!-- 对对应的角色赋权 -->
<body style="">
	<!-- 下拉框:加载所有角色 -->
	&nbsp;&nbsp;&nbsp;
	<select id="cc" style="width: 130px" class="easyui-combobox"
		url="${pageContext.request.contextPath}/role/getall"
		textField="roleName" valueField="id" editable="false">
	</select>
	<!-- 树状图 -->
	<ul class="ztree" id="xzqtree"
		style="width: 180px; height: 350px; margin: 10px; border: 1px solid blue; overflow: auto;"></ul>
	&nbsp;&nbsp;&nbsp;
	<a href="javascript:savePrivilege()" class="easyui-linkbutton"
		iconCls="icon-ok">保存</a>
	<a href="javascript:closePasswordModifyDialog()"
		class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</body>
</html>