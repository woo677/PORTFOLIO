<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="./resources/img/icon/logo.png">
<link rel="stylesheet" href="./resources/css/login/login.css" type="text/css">
<!-- <link rel="stylesheet" href="resources/css/common/common.css" type ="text/css"> -->	
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	 <div>
        	<a href="official/match_list.go" class="link">
            <img src="resources/img/icon/logo.png" alt="메인로고 이미지" width="50px" height="50px"/>
            <h1>백코드</h1>
       		</a>
    <form action="login.do" method="post">
        <table>
            <tr>
                <th>
                    <input type="text" name="id" placeholder="아이디" />
                </th>
            </tr>
            <tr>
                <td>
                    <input type="password" name="pw" placeholder="비밀번호"/>  
                </td>
            </tr>
            <tr>
                <th>
                    <input type="submit" class="sub" value="로그인"/>

                </th>
            </tr>
        </table>
        <input type="button" value="회원가입" onclick="location.href='/Join'" class=" button">
    </form>
    </div>
</body>
<script>
	var msg = '${msg}';
	if (msg !='') {
		alert(msg);
	}
	$('.button').on('click',function(){
	    // console.log("클릭");
	    location.href="Join.go";
	});
</script>
</html>