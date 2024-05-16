<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="../resources/css/teammate/teammate_info.css">
</head>
<body>
<jsp:include page="../header/header.jsp"/>
<div class="leftCont">
    <div class="teammateinfocont">
        <div class="flexBox">
            <div class="logo">
<%--                 <img class="teammateLogo" src="../resources/img/teamLogo/${teammateDetail.logo}.jpg" alt="teammateLogo">> --%>
                <img class="teammateLogo" src="/logo/${teammateDetail.logo}.png" alt="teammateLogo">>
            </div>
            <div>
                <a class="teammateReportBtn">신고하기</a>
                <h3 class="teamName">${teammateDetail.team_name}</h3>
                <p class="teamLeader"><span>${teammateDetail.id}</span></p>
            </div>
        </div>

        <p class="teamAddress">지역: <span>${teammateDetail.team_address}</span></p>
        <p class="teammateLevel">모집 레벨: <span>${teammateDetail.join_team_level}</span></p>
        <p class="teammateGender">모집 성별: <span>${teammateDetail.join_team_gender}</span></p>
        <p class="teammatePositions">모집 포지션: <span>${teammateDetail.join_team_position}</span></p>
        <p class="tj">
        <a class="teammateJoinBtn">가입 신청하기</a>
        </p>
    </div>
  
    <div class="teamDescriptionBox">
        <p>${teammateDetail.join_to_content}</p>
    </div>
</div>
</body>
<script>
$('.teammateReportBtn').on('click',function(){
	window.location.href = '../mypage/report.go?reportWriteIdx='+${join_team_idx}+'&reportWirteType="팀원모집신고"';
});

var joinTeamIdx = ${join_team_idx};
console.log(joinTeamIdx);
$('.teammateJoinBtn').on('click', function() {
    var cf = confirm("${teammateDetail.team_name} 팀에 가입 하시겠습니까?");
    if (cf) {
        $.ajax({
            type: 'post',
            url: './teammateJoin.ajax',
            data: {
                'joinTeamIdx': joinTeamIdx
            },
            dataType: 'json',
            success: function(data) {
            	console.log(data.result);
            	if(data.result == true){
                alert('팀원 가입 신청이 완료되었습니다.');
                location.href = '../teammate/join_list.go';            		
            	}else{
            		alert('이미 신청된 팀입니다.');
            	}
            },
            error: function(error) {
                console.log(error);
            }
        });
    } 
});

</script>
</html>