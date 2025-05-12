<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>표현 언어 - 폼값 처리</title>
	</head>
	<body>
		<h3>EL로 폼값 받기</h3>
		<ul>
			<li>이름 : ${ param.name }</li>
			<li>성별 :  ${ param.gender }</li>
			<li>학력 :  ${ param.grade }</li>
			<li>관심사항 :  ${ paramValues.inter[0] }
				${ paramValues.inter[1] }
				${ paramValues.inter[2] }
				${ paramValues.inter[3] }
			</li>
		</ul>
		
		<h3>JSP 내장객체를 통해 폼값 받기</h3>
		<%-- <%
			String name = request.getParameter("name");
			String[] interArr = request.getParameterValues("inter");
			
			out.println("이름:" + name + "<br />");
			out.println("관심사항1:" + interArr[0]);
			out.println("관심사항2:" + interArr[1]);
		%> --%>
	</body>
</html>