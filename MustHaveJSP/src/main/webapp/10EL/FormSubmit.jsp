<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>표현 언어(EL) - 폼값 처리</title>
	</head>
	<body>
		<h2>폼값 전송하기</h2>
		<form name="frm" method="post" action="FormResult.jsp">
			이름 : <input type="text" name="name" /><br/>
			성별 : <input type="radio" name="gender" value="Man" />남자
					<input type="radio" name="gender" value="Woman" />여자<br/>
			학력 :
				<select name="grade">
					<option value="ele">초딩</option>
					<option value="mid">중딩</option>
					<option value="high">고딩</option>
					<option value="uni">대딩</option>
				</select>
			<!-- 
	       		위쪽 부분은 단일값만 전송된다.
	       		아래 부분은 2개 이상의 값이 전송된다.
	       	 -->
			관심사항 :
				<input type="checkbox" name="inter" value="pol" />정치
				<input type="checkbox" name="inter" value="eco" />경제
				<input type="checkbox" name="inter" value="ent" />연예
				<input type="checkbox" name="inter" value="spo" />운동<br/>
			<input type="submit" value="전송하기" />
		</form>
	</body>
</html>