<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
<script>
	function goBack(){
		alert("페이지를 찾을 수 없습니다! \n  이전페이지로 돌아갑니다.");
		window.history.back();
	}
</script>
</head>
<body onload="goBack()">
</body>
</html>