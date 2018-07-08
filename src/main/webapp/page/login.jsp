<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工请假系统-登录界面</title>
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
	function submitData() {
		$("#fm")
				.form(
						"submit",
						{
							url : "${pageContext.request.contextPath}/user/login",
							onSubmit : function() {
								return $(this).form("validate");
							},
							success : function(result) {
								var flag=eval('('+result+')');
								if(flag){
									location.href="${pageContext.request.contextPath}/page/main.jsp"
								}else{
									alert("身份信息有误！");
								}
							}
						});
	}
	function resetValue() {
		$("#userName").val("");
		$("#password").val("");
		$("#groupId").combobox("setValue", "");
	}

	
	function changeImg(){
	    $("#imgCode").attr('src','${pageContext.request.contextPath}/base/getImg?time='+new Date().getTime());
	}
</script>
</head>
<body>
	<div
		style="position: absolute; width: 100%; height: 100%; z-index: -1; left: 0; top: 0">
		<img
			src="${pageContext.request.contextPath}/static/images/login_bg.jpg"
			width="100%" height="100%" style="left: 0; top: 0;">
	</div>
	<div class="easyui-window" title="代理商管理系统"
		data-options="modal:true,closable:false,collapsible:false,minimizable:false,maximizable:false"
		style="width: 400px; height: 280px; padding: 10px">
		<form id="fm" action="" method="post">
			<table cellpadding="6px" align="center">
				<tr align="center">
					<th colspan="2" style="padding-bottom: 10px"><big>用户登录</big></th>
				</tr>
				<tr>
					<td>用户名:</td>
					<td><input type="text" id="userName" name="userName" value="cmy"
						class="easyui-validatebox" required="true" style="width: 200px" />
					</td>
				</tr>
				<tr>
					<td>密码:</td>
					<td><input type="password" id="password" name="password" value="456"
						class="easyui-validatebox" required="true" style="width: 200px" />
					</td>
				</tr>
				<tr>
					<td>验证码:</td>
					<td id="imgTd">
					   <img id="imgCode"  src="${pageContext.request.contextPath}/base/getImg" onclick="changeImg()"/>
					    <input type="text" name="vCode" class="easyui-validatebox" required="true" style="width: 200px"/>
						<a href="javascript:void(0)" onclick="changeImg()">看不清，换一张</a></td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td></td>
					<td><a href="javascript:submitData()"
						class="easyui-linkbutton" iconCls="icon-submit">登录</a>&nbsp; <a
						href="javascript:resetValue()" class="easyui-linkbutton"
						iconCls="icon-reset">重置</a></td>
				</tr>

			</table>
		</form>
	</div>
</body>
</html>