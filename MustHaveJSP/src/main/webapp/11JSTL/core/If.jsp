<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JSTL - if</title>
	</head>
	<body>
		<!-- 
			if태그 : 조건을 확인하여 실행여부를 판단한다.
			속성정리
				test : EL을 이용해서 조건식을 삽입한다.
				var : test속성에서 판단한 결과값을 저장한다.
		 -->
		<!-- 변수 선언 -->
		<c:set var="number" value="100" />
		<c:set var="string" value="JSP" />
		
		<h4>JSTL의 if 태그로 짝수/홀수 판단하기</h4>
		<!-- 
	    	if(number%2==0) 과 동일한 조건의 if문으로 해당 조건의 결과가
	    	result에 저장된다. 나머지는 0이므로 true가 저장된다.
	     -->
		<c:if test="${ number mod 2 eq 0 }" var="result">
			${ number }는 짝수입니다.<br/>
		</c:if>
		result : ${ result } <br/>
		
		<!-- 
			Java에서는 비교연산자 ==과 equals()는 다르지만, EL에서는 eq를
			통해 값에 대한 비교와 문자열에 대한 비교 모두를 할 수 있다.
			여기서 사용한 eq는 Java의 compareTo()와 같이 사전순으로 문자열
			을 비교한다.
		 -->
		<h4>문자열 비교와 else 구문 흉내내기</h4>
		<!-- 첫번째 if문은 false의 결과가 나온다. -->
		<c:if test="${ string eq 'Java' }" var="result2">
			문자열은 Java입니다.
		</c:if>
		<!-- result2에 not을 붙여 반대의 조건을 만든다.
    	따라서 Java의 else문과 같은 구문이 된다. -->
		<c:if test="${ not result2 }"><!-- => true 값이므로 아래문장이 출력됨. -->
			'Java'가 아닙니다.
		</c:if>
		
		<h4>조건식 주의사항</h4>
		<!--  EL이 아닌 일반 값이 오면 무조건 false를 반환 -->
		<c:if test="100" var="result3">
			EL이 아닌 정수를 지정하면 false <!-- false이므로 출력이 안된다. -->
		</c:if>
		result3 : ${ result3 } <br/>
		
		<c:if test="tRuE" var="result4">
			대소문자 구분 없이 "tRuE"인 경우 true <br/>
		</c:if>
		result4 : ${ result4 } <br/>
		
		<!-- test에는 (")앞뒤에 하나라도 공백이 들어가면 무조건 false를 
    	반환받게 된다. 따라서 주의해야 한다. -->
		<c:if test=" ${ true } " var="result5">
			EL 양쪽에 빈 공백이 있는 경우 false <br/>
		</c:if>
		result5 : ${ result5 } <br/>
		
		<h4>연습문제 : if 태그</h4>
		<!--  
	    	아이디, 패스워드를 입력후 submit버튼을 누르면 EL식을 통해 파라미터를
	    	받은 후 musthave/1234인 경우에는 'musthave님, 반갑습니다~'이라고 출력한다.
	    	만약 틀렸다면 "아이디/비번을 확인하세요"라고 출력한다.
	    	EL과 JSTL의 if태그만을 이용해서 구현하시오.
	     -->
		<form method="get">
			아이디 : <input type="text" name="user" /> <br/>
			패스워드 : <input type="text" name="pass" /> <br/>
			<input type="submit" value="로그인" />
		</form>
		
		<!-- 최초 실행시에는 파라미터가 없는 상태이므로 아무 내용도
     	출력되지 않는다. -->
     	<c:if test="${ not empty param.user }">
     		전송된 아이디 : ${param.user}<br />
     		전송된 패스워드 : ${param.pass}<br />
     	</c:if>
     	<c:if test="${param.user=='musthave' and param.pass eq '1234' }" var="loginResult">
     		${param.user}님, 반갑습니다~.<br />
     	</c:if>
     	<c:if test="${not loginResult }">
     		아이디/비번을 확인하세요 <br />
     	</c:if>
	</body>
</html>