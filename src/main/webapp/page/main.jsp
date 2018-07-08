<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工请假流程系统-主页面</title>
<%
	// 权限验证
	if (session.getAttribute("user") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	var url;
	function openTab(text, url, iconCls) {
		if ($("#tabs").tabs("exists", text)) {
			$("#tabs").tabs("select", text);
		} else {
			var content = "<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/page/"
					+ url + "'></iframe>";
			$("#tabs").tabs("add", {
				title : text,
				iconCls : iconCls,
				closable : true,
				content : content
			});
		}
	}

	
	function openPasswordModifyDialog() {
		$("#dlg").dialog("open").dialog("setTitle", "修改密码");
	}
	
	function modifyPassword() {
		$("#fm")
				.form(
						"submit",
						{
							url : "${pageContext.request.contextPath}/user/motifyPassword",
							onSubmit : function() {
								var oldPassword = $("#oldPassword").val();
								var newPassword = $("#newPassword").val();
								var newPassword2 = $("#newPassword2").val();
								if (!$(this).form("validate")) {
									return false;
								}
								if (oldPassword != '${user.userPassword}') {
									$.messager.alert("系统系统", "用户原密码输入错误！");
									return false;
								}
								if (newPassword != newPassword2) {
									$.messager.alert("系统系统", "确认密码输入错误！");
									return false;
								}
								return true;
							},
							success : function(result) {
								var result = eval('(' + result + ')');
								if (result) {
									$.messager.alert("系统系统", "密码修改成功，下一次登录生效！");

									location.href = "${pageContext.request.contextPath}/page/login.jsp";
								} else {
									$.messager.alert("系统系统", "密码修改失败，请联系管理员！");
									return;
								}
							}
						});
	}

	function resetValue() {
		$("#oldPassword").val("");
		$("#newPassword").val("");
		$("#newPassword2").val("");
	}

	function closePasswordModifyDialog() {
		resetValue();
		$("#dlg").dialog("close");
	}
	function logout() {
		$.messager
				.confirm(
						"系统提示",
						"您确定要退出系统吗?",
						function(r) {
							if (r) {
								window.location.href = '${pageContext.request.contextPath}/user/logOut';
							}
						});
	}
	function changeFrameHeight() {
		/* var ifm= document.getElementById("iframepage"); 
		ifm.height=document.documentElement.clientHeight; */
	}
	window.onresize = function() {
		changeFrameHeight();

	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" style="height: 178px; background-color: #E0ECFF">
		<table style="padding: 5px;" width="100%">
			<tr>
				<td width="50%">
					<!-- 一个页面嵌入另一个页面  --> <iframe src="../static/html/clock.html"
						width="690px" id="myiframe" scrolling="no"
						onload="changeFrameHeight()" frameborder="0" height="130px"></iframe>
				</td>
				<td valign="bottom" align="right" width="50%"><font size="3">&nbsp;&nbsp;<strong>欢迎:${user.userName}登录！</strong></font>
				</td>
			</tr>
		</table>
	</div>
	<div region="center">
		<div class="easyui-tabs" fit="true" border="false" id="tabs">
			<div title="首页" data-options="iconCls:'icon-home'">
				<div align="center" style="padding-top: 100px;">
					<font color="red" size="10">欢迎使用</font>
				</div>
			</div>
		</div>
	</div>
	<div region="west" style="width: 200px;" title="导航菜单" split="true">
		<div class="easyui-accordion" data-options="fit:true,border:false">
			<div title="系统管理" data-options="selected:true,iconCls:'icon-item'"
				style="padding: 10px">
				<pri:privilege privilege="ROLE_MANAGE">
				  <a href="javascript:openTab('角色管理','roleManage.jsp','icon-user')"
					  class="easyui-linkbutton"
					  data-options="plain:true,iconCls:'icon-user'" style="width: 150px">角色管理</a>
				</pri:privilege>
				
				<a href="javascript:openTab('用户管理','groupManage.jsp','icon-role')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-role'" style="width: 150px">用户管理</a>
				<a href="javascript:openTab('角色权限配置','privilegeManage.jsp','icon-power')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-power'" style="width: 150px">角色权限配置</a>
				<a href="javascript:openTab('系统配置','authManage.jsp','icon-power')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-power'" style="width: 150px">系统配置</a>
				<a href="javascript:openPasswordModifyDialog()"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-modifyPassword'"
					style="width: 150px;">修改密码</a> <a href="javascript:logout()"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
			</div>

		</div>
	</div>
	<div region="south" style="height: 26px; padding: 5px" align="center">
		Copyright @ 2012-2016 张欢 版权所有</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 400px; height: 250px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">

		<form id="fm" method="post">
			<table cellpadding="8px">
				<tr>
					<td>用户名:</td>
					<td><input type="text" id="userId" name="userCode"
						readonly="readonly" value="${user.userCode }" style="width: 200px" />
					</td>
				</tr>
				<tr>
					<td>原密码:</td>
					<td><input type="password" id="oldPassword" name="oldPassword"
						class="easyui-validatebox" required="true" style="width: 200px" />
					</td>
				</tr>
				<tr>
					<td>新密码:</td>
					<td><input type="password" id="newPassword" name="newPassword"
						class="easyui-validatebox" required="true" style="width: 200px" />
					</td>
				</tr>
				<tr>
					<td>确认密码:</td>
					<td><input type="password" id="newPassword2"
						name="newPassword2" class="easyui-validatebox" required="true"
						style="width: 200px" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:modifyPassword()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a
			href="javascript:closePasswordModifyDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>

</body>
</html>