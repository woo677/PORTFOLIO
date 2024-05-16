<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common/reset.css" type="text/css">
    <link rel="stylesheet" href="resources/css/Join/Join.css" type="text/css">
    <link rel="icon" href="resources/img/icon/logo.png" >
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	/* 수정 - 강대훈 */
	body{
		position: static;
	}
	h1{
		position: static;
		vertical-align: 12px;
	}
	.joinContainer{
		position: absolute;
    	top: calc(50% - 150px);
    	left: calc(50% - 160px);
	}
</style>
</head>
<body>
	<!-- 수정 - 강대훈 - 상위 div 추가 -->
	<div class="joinContainer">
		<img src="resources/img/icon/logo.png" alt="로고">
	    <h1>백코트 회원가입</h1>
	    <form action="Join.do" method="post">
	        <table>
	            <tr>
	                <th>
	                    아이디
	                </th>
	                <td>
	                    <input type="text" name="id"  maxlength="15"/>
	                    <input type="button" value="중복 체크" onclick="overlay()"/>
	                </td>
	            </tr>
	            <tr>
	                <th>
	                    비밀번호
	                </th>
	                <td>
	                    <input type="password" name="pw" maxlength="25" />
	                </td>
	            </tr>
	            <tr>
	                <th>
	                    이름 
	                </th>
	                <td>
	                    <input type="text" name="name"/>
	                </td>
	            </tr>
	            <tr>
	                <th>
	                    지역
	                </th>
	                <td>
	                    <select name="address" id="address">
	                        <option value="강남구">강남구</option>
	                        <option value="강동구">강동구</option>
	                        <option value="강북구">강북구</option>
	                        <option value="강서구">강서구</option>
	                        <option value="관악구">관악구</option>
	                        <option value="광진구">광진구</option>
	                        <option value="구로구">구로구</option>
	                        <option value="금천구">금천구</option>
	                        <option value="노원구">노원구</option>
	                        <option value="도봉구">도봉구</option>
	                        <option value="동대문구">동대문구</option>
	                        <option value="동작구">동작구</option>
	                        <option value="마포구">마포구</option>
	                        <option value="서대문구">서대문구</option>
	                        <option value="서초구">서초구</option>
	                        <option value="성동구">성동구</option>
	                        <option value="성북구">성북구</option>
	                        <option value="송파구">송파구</option>
	                        <option value="양천구">양천구</option>
	                        <option value="영등포구">영등포구</option>
	                        <option value="용산구">용산구</option>
	                        <option value="은평구">은평구</option>
	                        <option value="종로구">종로구</option>
	                        <option value="중구">중구</option>
	                        <option value="중랑구">중랑구</option>
	                    </select>
	                </td>
	            </tr>
	            <tr>
	                <th>성별</th>
	                <td>
	                    <input type="radio" name="gender" value="남자"/>남자
	                    <input type="radio" name="gender" value="여자"/>여자
	                </td>
	            </tr>
	            <tr>
	                <th>
	                    포지션
	                </th>
	                <td>
	                    <select name="position" id="position">
	                        <option value="가드">가드</option>
	                        <option value="포워드">포워드</option>
	                        <option value="센터">센터</option>
	                    </select>
	                </td>
	            </tr>
	            <tr>
	                <th>
	                    레벨
	                </th>
	                <td>
	                    <select name="level" id="level">
	                        <option value="브론즈">브론즈</option>
	                        <option value="실버">실버</option>
	                        <option value="골드">골드</option>
	                        <option value="플래티넘">플래티넘</option>
	                    </select>
	                </td>
	            </tr>
	        </table>
	        <input class="in" type="button" onclick="back()" value="돌아가기"/>
	        <input id="inp" type="button" onclick="join()" value="회원 가입"/>
	    </form> 
	</div>
	
    
</body>
<script>
	function back(){
	    var con = confirm('회원가입을 취소 하시겠습니가?');
	    if(con){
	        location.href="./login";
	    }
	}
	
	
	var overChk = false;
	function join(){
	    var $id = $('input[name="id"]').val();
		var $pw = $('input[name="pw"]').val();
		var $name = $('input[name="name"]').val();
		var $gender = $('input[name="gender"]:checked').val();
	
	   
	    if($id==''){
	        alert('아이디를 입력해 주세요');
			$id.focus();
	    }else if ($id.length<5) {
   		 	alert('아이디를 최소 5글자를 입력해 주세요');
			$id.focus();
		}else if(overChk==false){ //중복 체크를 안 했다면 false 중복 체크를 해다면 overChk가 true로 변환 되서 다음줄 실행
			 	alert('아이디 중복 확인');
			 	$id.focus();
		}else if($pw==''){
	        alert('비밀번호를 입력해 주세요');
			$pw.focus();
	    }else if ($pw.length<8) {
   		 	alert('비밀번호 최소 8글자를 입력해 주세요');
   		 	$pw.focus();
		}else if($name==''){
	        alert('이름을 입력해 주세요');
			$name.focus();
	    }else if($gender==null){
	        alert('성별을 선택해 주세요');
			$gender.focus();
	    }else{
	        var con = confirm('가입 하시겠습니까?');
	        if(con){
	            $('form').submit();
	        }
	    }
	}

	//아이디 중복 확인 하는 아작스
	function overlay(){
	    // console.log('로로롤');
	    // 버튼을 클랙 했을때 필요한 값 가져오기
	    var id = $('input[name="id"]').val();
	    console.log(id);
	    $.ajax({
	        type:'post',//method 방식
	        url:'overlay.ajax', //요청한 주소
	        data:{'id':id}, //파라메터로 보낼 값
	        success:function(data){  //통신 성공 했을 떄
	        //ajax에서 XmlhttpRequest 객체를 통해 대신 받아와서
			//여기에 뿌려준다
			console.log(data);
	            if(data.use>0){
	                alert('이미 사용중인 아이디 입니다.');
	                $('input[name="id"]').val('');
	            }else{
	                alert('사용 가능한 아이디 입니다');
	                overChk = true;
	            }
	        },
	        error:function(error){ // 통신 실패를 했을때
	            console.log(error);
	        }
	    });
	}
</script>
</html>