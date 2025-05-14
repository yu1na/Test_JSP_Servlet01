<%@page import="el.MyELClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="mytag" uri="/WEB-INF/MyTagLib.tld" %>
<%
//정적메서드가 아닌 일반적인 메서드는 객체를 통해 호출해야 하므로
//객체를 생성한 후 EL에서 접근할 수 있도록 영역에 저장한다.
MyELClass myClass = new MyELClass();
pageContext.setAttribute("myClass", myClass);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>표현 언어(EL) - 메서드 호출</title>
	</head>
	<body>
		<h3>영역에 저장 후 메서드 호출하기</h3>
		001225-3000000 => ${ myClass.getGender("001225-3000000") } <br />
	    001225-6000000 => ${ myClass.getGender("001225-6000000") }
	    
	    <h3>클래스명을 통해 정적 메서드 호출하기</h3>
	    ${ MyELClass.showGugudan(7) }
	    
	    <h3>TLD 파일 등록후 정적 메서드 호출하기</h3>
	    <ul>
			<li>mytag:isNumber("100") => ${ mytag:isNumber("100") }</li>
	    	<li>mytag:isNumber("이백") => ${ mytag:isNumber("이백") }</li>
	    </ul>
	</body>
</html>