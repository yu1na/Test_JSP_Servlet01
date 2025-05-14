<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JSTL - forEach2(향상된 for문)</title>
	</head>
	<body>
		<!-- 
			foreach 태그의 향상된 for문 형태 : 주로 배열이나 컬렉션에서 값을
			순차적으로 접근하고 싶을때 사용한다.
			속성]
				items : 사용할 배열이나 컬랙션을 지정한다.
				var : 해당 loop에서 반환해준 객체를 저장할 변수명을 지정한다.
		 -->
		<h4>향상된 for문 형태의 forEach 태그</h4>
		<%
		// 루프에서 순회할 String 배열을 선언 
		String[] rgba = {"Red", "Green", "Blue", "Black"}; 
		%>
		<!-- 원소의 갯수만큼 반복하여 span태그가 4번 출력된다. -->
	    <!-- Java의 향상된 for ( int var : items) { ... }  -->
		<c:forEach items="<%= rgba %>" var="c">
			<span style="color:${ c };">${ c }</span>
		</c:forEach>
		
		<h4>varStatus 속성 살펴보기</h4>
		<!-- 
	    	개선된 for문에서의 varStatus 속성 
	    		index : 현재 루프에서의 인덱스를 표현한다. 0부터 시작한다.
	    		current : 현재 루프의 실제원소를 반환한다.
	    		count : 실제 반복 횟수를 반환한다. 1부터 시작한다.
	    		first, last: 처음과 마지막에 true를 반환한다. 
	     -->
		<table border="1">
		<c:forEach items="<%= rgba %>" var="c" varStatus="loop">
			<tr>
				<td>count : ${ loop.count }</td>
				<td>index : ${ loop.index }</td>
				<td>current : ${ loop.current }</td>
				<td>first : ${ loop.first }</td>
				<td>last : ${ loop.last }</td>
			</tr>
		</c:forEach>
		</table>
	</body>
</html>