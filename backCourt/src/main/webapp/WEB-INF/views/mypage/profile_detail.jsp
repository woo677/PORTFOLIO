<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="../resources/css/common/reset.css"  type="text/css">
    <link rel="stylesheet" href="../resources/css/profile_detail/profile_detail.css">
    <link rel="stylesheet" href="../resources/css/header/header.css">
</head>
<body>
	<jsp:include page="../header/header.jsp"/>
	<div id="profile_detail_div">
        <h2>내 프로필 수정</h2>
        <form action="profile_detail.do" method="post">
            <table>
                <tr class="profile_detail_tr">
                    <th class="profile_detail_th">id</th>
                    <td class="profile_detail_td">
                    	<span>${dto.id}</span>
                    	<input type="hidden" name="id" value="${dto.id}">
                    </td>
                </tr>
                <tr class="profile_detail_tr">
                    <th class="profile_detail_th">이름</th>
                    <td class="profile_detail_td_input">
                        <input type="text" name="Name" id="Name" class="profile_detail_input" value=""/>
                    </td>
                </tr>
                <tr class="profile_detail_tr">
                    <th class="profile_detail_th">포인트</th>
                    <td class="profile_detail_td"><span>${dto.point}</span></td>
                </tr>
                <tr class="profile_detail_tr">
                    <th class="profile_detail_th">지역</th>
                    <td class="profile_detail_td_select">
                        <select name="Area" class="select" id="Area">
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
                <tr class="profile_detail_tr">
                    <th class="profile_detail_th">포지션</th>
                    <td class="profile_detail_td_select">
                        <select name="Position" class="select" id="Position">
                            <option value="Guard">가드</option>
                            <option value="Forward">포워드</option>
                            <option value="Center">센터</option>
                        </select>
                    </td>
                </tr>
                <tr class="profile_detail_tr">
                    <th class="profile_detail_th">성별</th>
                    <td class="profile_detail_td">
                        <select name="gender" class="select" id="gender">
                            <option value="남">남자</option>
                            <option value="여">여자</option>
                        </select>
                    </td>
                </tr>
                <tr class="profile_detail_tr">
                    <th class="profile_detail_th">레벨</th>
                    <td class="profile_detail_td_select">
                        <select name="Level" class="select" id="Level">
                            <option value="Bronze">브론즈</option>
                            <option value="Silver">실버</option>
                            <option value="Gold">골드</option>
                            <option value="Platinum" >플래티넘</option>
                        </select>
                    </td>
                </tr>
                <tr class="profile_detail_tr">
                    <th class="profile_detail_th">제제 상태</th>
                    <td class="profile_detail_td"><span>${dto.state}</span></td>
                </tr>
            </table>
            <input type="button" value="취소" class="NO" />
            <input type="button" value="저장" class="OK" />
        </form>
    </div>
</body>
<script>

$(document).ready(function(){
	$.ajax({
        type:'post',
        url:'./profile_detail.ajax',
        data:{},
        dataType:'JSON',
        success:function(data){
        	console.log(data.profile_detail);
        	$('#Name').val(data.profile_detail.name);
        	$('#gender').val(data.profile_detail.gender);
        	$('#Position').val(data.profile_detail.position);
        	$('#Area').val(data.profile_detail.address);
        	$('#Level').val(data.profile_detail.level);
        },
        error:function(error){
            console.log(error);
        }
    });
});

    $('input[type="button"]').on('click',function(){
        var click = $(this).val();
        if (click=='저장') {
        	console.log("저장한다");
        	alert('수정이 완료되었습니다');
        	$('form').submit();
		}else if (click=='취소') {
			location.href="../official/match_list.go";
		}

    

        
        
    });
</script>
</html>