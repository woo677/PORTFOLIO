<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 페이징 처리 -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<!--  -->
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="../resources/css/team/team.css">
<style>

</style>
</head>
<body>
	<jsp:include page="../header/header.jsp"/>
    <div class="teamInfoContainer">
        <div class="leftCont">
            <ul class="teamInformation">
                <li class="logoImg"><img src="/logo/${info.logo}.png" alt=""></li>
                <li>${info.team_name}</li>
                <li>팀장 : ${info.id}</li>
                <li>${info.team_address}</li>
                <li>${info.team_level}</li>
                <li>팀 인원 : ${info.teamCount}</li>
                <li>${info.team_info}</li>
                <!-- 팀장 입장 -->
                <c:if test="${id == info.id}">
                	<li><button class="dropTeamBtn"  onclick="destroyTeam()">팀 해체</button></li>
                </c:if>
                 <!-- 팀원 입장 -->
                <c:if test="${id != info.id}">
                	<li><button class="createTeamBtn" onclick="location.href='./create.go'">내 팀 만들기</button></li>
                </c:if>
            </ul>
        </div>
        <div class="rightCont">
            <h1>팀 명단</h1>
            <!-- 팀장일 경우 생성 -->
            <div class="teamTabMenu on">
                <ul class="cont">
                    <li class="on"><a href="javascript:;" onclick="">팀원</a></li>
                    <li><a href="javascript:;" onclick="">팀원 신청 내역</a></li>
                    <li><a href="javascript:;" onclick="">게스트 신청 내역</a></li>
                    <li><a href="javascript:;" onclick="" id="myWrite">내가 쓴글</a></li>
                    <li><a href="javascript:;" onclick="">탈퇴 회원</a></li>
                </ul>
            </div>
            
            <!-- 내가 쓴글 탭일 경우 생성 -->
            <div class="writeCont" id="writeCont">
                <div class="cont">
	               	<!-- <button onclick="location.href='../teammate/join_write'">팀원 모집 글 작성</button>
	                <button onclick="noWrite()">팀원 모집 글 작성</button> -->
                    <!-- <button onclick="location.href='../guest/join_write'">게스트 모집 글 작성</button> -->
                </div>
            </div>
            <div class="tableList" id="tableList">
	            <table class="teamMember">
	                <thead id="thead">
	                    <!-- <tr>
	                        <th>No.</th>
	                        <th>아이디</th>
	                        <th>직책</th>
	                        <th>가입날짜</th>
	                        <th></th>
	                    </tr> -->
	                </thead>
	                <tbody id="tbody">
<!-- 	                    <tr>
	                        <td class="no">1</td>
	                        <td class="user"><a href="javascript:;" class="userDetail">admin1</a></td>
	                        <td class="rank">팀장</td>
	                        <td class="date">2020.10.10</td>
	                        <td></td>
	                    </tr>
	                    <tr>
	                        <td class="no">2</td>
	                        <td class="user"><a href="javascript:;" class="userDetail">admin2</a></td>
	                        <td class="rank">팀원</td>
	                        <td class="date">2020.10.10</td>
	                        <td class="drop"><button class="dropBtn">추방</button></td>
	                    </tr> -->
	                </tbody>
	                <tfoot>
						<tr>
							<td colspan="7">
								<div class="container">                           
								  <nav aria-label="Page navigation" style="text-align:center">
									  <ul class="pagination" id="pagination"></ul>
								  </nav>               
								 </div>
							</td>
						</tr>
	                </tfoot>
	            </table>
            </div>
        </div>
    </div>

    <!-- 유저 상세 팝업 -->
    <div class="userPop">
        <a href="#" class="close"><img src="../resources/img/icon/close.png" alt=""></a>
        <div class="popWrap">
            <div class="listCont" id="listCont2">
                <!-- <ul>
                    <li>
                        <p class="tit">아이디</p>
                        <p class="txt">admin1</p>
                    </li>
                    <li>
                        <p class="tit">레벨</p>
                        <p class="txt">플래티넘</p>
                    </li>
                    <li>
                        <p class="tit">포지션</p>
                        <p class="txt">가드</p>
                    </li>
                    <li>
                        <p class="tit">성별</p>
                        <p class="txt">남자</p>
                    </li>
                    <li>
                        <p class="tit">지역</p>
                        <p class="txt">서울시 금천구</p>
                    </li>
                </ul> -->
            </div>
        </div>
    </div>
</body>
<script>
    // 퍼블 영역
    $(function(){
        
        $('.menu').css('display','none');

        // 유저 상세 팝업
        /* $('.userDetail').on('click',function(){
            $('.userPop').addClass('on');
            $('.curtain').addClass('on');
            $('html').addClass('on');
        }); */
        $('.close').on('click',function(){
            $('.userPop').removeClass('on');
            $('.curtain').removeClass('on');
            $('html').removeClass('on');
        });

        // tab menu
        $('.teamTabMenu li').on('click',function(){
            $(this).addClass('on').siblings().removeClass('on');
        });
        
       /*  $('#myWrite').on('click',function(){
        	$('.writeCont').addClass('on');
        }); */
    })
    
    // 개발 영역
    
    // ---------------------------------------------------------------------------------------------------------
    
    var currentPage = 1;
    var tabNum = 0;
    var team_idx = '${info.team_idx}';
    var writeTeam = 0;
    
    $('.teamTabMenu li').on('click',function(){
    	tabNum = $(this).index();
    	console.log(tabNum);
    	$('#pagination').twbsPagination('destroy');
    	callTeam(currentPage);
    });
    
    if(${id == info.id}){
    	$('.teamTabMenu').addClass('on');
    	$('.writeCont').addClass('on');
    }else{
    	$('.teamTabMenu').removeClass('on');
    	$('.writeCont').removeClass('on');
    }
    
	$(document).ready(function(){
    	callTeam(currentPage);
    });
	
	function noWrite(){
		alert('팀원 모집글은 하나만 작성이 가능합니다.');
	}
	
	// ---------------------------------------------------------------------------------------------------------
	
	// 팀 명단 list.ajax
	function callTeam(currentPage) {
		
		$.ajax({
			type:'POST'
			,url:'./info_list.ajax'
			,data:{
				'currentPage':currentPage
				,'team_idx':team_idx
			}
			,dataType:'json'
			,success:function(data){
				console.log(data.listAppli);
				console.log(data.totalPageAppli);
				var totalPage;
				
				$('.writeCont').removeClass('on');
				
				if(tabNum == 0){
					console.log('팀명단 출력');
					showTeamList(data.listTeam);
					totalPage = data.totalPageTeam;
				}else if(tabNum == 1){
					console.log('팀원 신청내역 출력');
					showAppliList(data.listAppli);
					totalPage = data.totalPageAppli;
					console.log(data.totalPageAppli);
				}else if(tabNum == 2){  // 게스트 신청 내역
					console.log('게스트 신청내역 출력');
					showAppliListGuest(data.listAppliGuest);
					totalPage = data.totalPageAppliGuest;
					console.log(data.totalPageAppliGuest);
				}else if(tabNum == 3){
					// 팀 모집글이 이미 있는지 확인하기 위해 사전 진행
					if(data.listWriteTeam != ''){
						writeTeam = 1;
						console.log('팀원 모집글 갯수',writeTeam);
					}else{
						writeTeam = 0;
						console.log('팀원 모집글 갯수',writeTeam);
					}
					$('.writeCont').addClass('on');
					console.log('내가쓴글 출력');
					showWriteList(data.listWriteTeam, data.listWriteGuest);
					totalPage = data.totalPageWrite;
					
				}else if(tabNum == 4){
					console.log('탈퇴회원 출력');
					showDropList(data.listDrop);
					totalPage = data.totalPageDrop;
				}
				
				showPagination(totalPage);
				
			}
			,error:function(error){
				console.log(error);
			}
		});
	}
	// 페이징
	function showPagination(totalPage) {
		$('#pagination').twbsPagination({
				startPage:1
				,totalPages:totalPage
				,visiblePages:5
				,onPageClick:function(evt,pg){
					console.log(pg);
					currentPage = pg;
					callTeam(currentPage);
					
				}
				
		});
	}
	// 팀 명단 list 그리기
	function showTeamList(list){
		$('#tableList table').addClass('teamMember').siblings().removeClass('application writeList dropList');
		
		var content = '';
		var content2 = '';
		var cnt = 0;
		var rank = '';
		var drop = '';
		content +=
            '<tr>'
            +'<th>No.</th>'
            +'<th>아이디</th>'
            +'<th>직책</th>'
            +'<th>가입날짜</th>'
            +'<th></th>'
            +'</tr>';
		
		for(item of list){
			cnt++;
			
			if(item.id == '${info.id}'){
				rank = '팀장';
				drop = '';
			}else{
				rank = '팀원';
				drop = '<button class="dropBtn" onclick="dropMember(\'' +  item.id + '\')">추방</button>';
			}
			var date = new Date(item.team_date);
		    var dateStr = date.toLocaleDateString("ko-KR");
			
			content2 += '<tr>';
			content2 += '<td class="no">' + cnt + '</td>';
			content2 += '<td class="user"><a href="javascript:;" class="userDetail" onclick="userPop(\'' +  item.id + '\')">' + item.id + '</a></td>';
			content2 += '<td class="rank">' + rank + '</td>';
			content2 += '<td class="date">' + dateStr + '</td>';
			if(${id == info.id}){
				content2 += '<td class="">' + drop + '</td>';
			}
			content2 += '</tr>';

		}
		cnt = 0;
		$('#thead').html(content);
		$('#tbody').html(content2);
	}
	// 팀원 신청 내역 list 그리기
	function showAppliList(list){
		$('#tableList table').addClass('application').siblings().removeClass('teamMember writeList dropList');
		
		var content = '';
		var content2 = '';
		var cnt = 0;
		
		content +=
            '<tr>'
            +'<th>No.</th>'
            +'<th>아이디</th>'
            +'<th>레벨</th>'
            +'<th>포지션</th>'
            +'<th></th>'
            +'</tr>';
		
		for(item of list){
			cnt++;
			
			content2 +=
                '<tr>'
            	+'<td class="no">' + cnt + '</td>'
            	+'<td class="user"><a href="javascript:;" class="userDetail" onclick="userPop(\'' +  item.id + '\')">' + item.id + '</a></td>'
            	+'<td class="userLevel">' + item.level + '</td>'
            	+'<td class="position">' + item.position + '</td>'
            	+'<td class="request">'
            	+'<button class="requestBtnY" onclick="confirmMember(\'' +  item.id + '\',\'' + item.applicant_idx + '\',\'' + 1 +'\')">수락</button>'
            	+'<button class="requestBtnN" onclick="confirmMember(\'' +  item.id + '\',\'' + item.applicant_idx + '\',\'' + 2 +'\')">거부</button>'
            	+'</td>'
            	+'</tr>';

		}
		cnt = 0;
		$('#thead').html(content);
		$('#tbody').html(content2);
	}
	// 게스트 신청 내역 list 그리기
	function showAppliListGuest(list){
		$('#tableList table').addClass('application').siblings().removeClass('teamMember writeList dropList');
		
		var content = '';
		var content2 = '';
		var cnt = 0;
		
		content +=
            '<tr>'
            +'<th>No.</th>'
            +'<th>아이디</th>'
            +'<th>레벨</th>'
            +'<th>포지션</th>'
            +'<th></th>'
            +'</tr>';
		
		for(item of list){
			cnt++;
			
			content2 +=
                '<tr>'
            	+'<td class="no">' + cnt + '</td>'
            	+'<td class="user"><a href="javascript:;" class="userDetail" onclick="userPop(\'' +  item.id + '\')">' + item.id + '</a></td>'
            	+'<td class="userLevel">' + item.level + '</td>'
            	+'<td class="position">' + item.position + '</td>'
            	+'<td class="request">'
            	+'<button class="requestBtnY">수락</button>'
            	+'<button class="requestBtnN">거부</button>'
            	+'</td>'
            	+'</tr>';

		}
		cnt = 0;
		$('#thead').html(content);
		$('#tbody').html(content2);
	}
	// 내가 쓴글 list 그리기
	function showWriteList(listTeam, listGuest){
		$('#tableList table').addClass('writeList').siblings().removeClass('teamMember application dropList');
		
		var content = '';
		var content2 = '';
		var content3 = '';
		var cnt = 0;
		
		content +=
            '<tr>'
            +'<th>No.</th>'
            +'<th>구분</th>'
            +'<th>성별</th>'
            +'<th>레벨</th>'
            +'<th>포지션</th>'
            +'<th></th>'
            +'</tr>';
            
		for(item of listTeam){
			cnt++;
			
			content2 +=
                '<tr>'
            	+'<td class="no">' + cnt + '</td>'
            	+'<td class="gubun">팀원모집</td>'
            	+'<td class="gender">' + item.join_team_gender + '</td>'
            	+'<td class="userLevel">' + item.join_team_level + '</td>'
            	+'<td class="position">' + item.join_team_position + '</td>'
            	+'<td class="modifications">'
            	+'<button class="modifyBtn" onclick="location.href=\'../teammate/join_modify?idx=' + item.join_team_idx + '\'">수정</button>'
            	+'<button class="refusalBtn" onclick="deleteWrite(\'' +  item.join_team_idx + '\',\'' + 1 +'\')">삭제</button>'
            	+'</td>'
            	+'</tr>';

		}
		
		for(item of listGuest){
			cnt++;
			
			content2 +=
                '<tr>'
            	+'<td class="no">' + cnt + '</td>'
            	+'<td class="gubun">게스트모집</td>'
            	+'<td class="gender">' + item.guest_gender + '</td>'
            	+'<td class="userLevel">' + item.guest_level + '</td>'
            	+'<td class="position">' + item.guest_position + '</td>'
            	+'<td class="modifications">'
            	+'<button class="modifyBtn" onclick="location.href=\'../guest_join/modify.go?idx=' + item.guest_idx + '\'">수정</button>'
            	+'<button class="refusalBtn" onclick="deleteWrite(\'' +  item.guest_idx + '\',\'' + 2 +'\')">삭제</button>'
            	+'</td>'
            	+'</tr>';

		}
		console.log('???',writeTeam);
		if(writeTeam == 0){
			content3 +=
				'<button onclick="location.href=\'../teammate/join_write.go?team_idx=' + team_idx + '\'">팀원 모집 글 작성</button>'
				+'<button onclick="location.href=\'../guest_join/write.go\'">게스트 모집 글 작성</button>';
		}else{
			content3 +=
				'<button onclick="noWrite()">팀원 모집 글 작성</button>'
				+'<button onclick="location.href=\'../guest_join/write.go\'">게스트 모집 글 작성</button>';
		}
		console.log(content3);
		cnt = 0;
		$('#thead').html(content);
		$('#tbody').html(content2);
		$('#writeCont').children('.cont').html(content3);
	}
	// 탈퇴회원 list 그리기
	function showDropList(list){
		$('#tableList table').addClass('dropList').siblings().removeClass('teamMember writeList application');
		
		var content = '';
		var content2 = '';
		var cnt = 0;
		
		content +=
            '<tr>'
            +'<th>No.</th>'
            +'<th>아이디</th>'
            +'<th>추방여부</th>'
            +'</tr>';
		
		for(item of list){
			cnt++;
			
			content2 +=
                '<tr>'
            	+'<td class="no">' + cnt + '</td>'
            	+'<td class="user"><a href="javascript:;" class="userDetail" onclick="userPop(\'' +  item.id + '\')">' + item.id + '</a></td>'
            	+'<td>' + item.team_ban + '</td>'
            	+'</tr>';

		}
		cnt = 0;
		$('#thead').html(content);
		$('#tbody').html(content2);
	}
	// 유저 상세보기 팝업
	function userPop(userId){
        $('.userPop').addClass('on');
        $('.curtain').addClass('on');
        $('html').addClass('on');
        
        popAjax(userId);
	}
	function popAjax(userId){
		$.ajax({
			type:'POST'
			,url:'./user_pop.ajax'
			,data:{
				'userId':userId
			}
			,dataType:'json'
			,success:function(data){
				console.log(data.list);
				showUserPop(data.list);
				
			}
			,error:function(error){
				console.log(error);
			}
		});
	}
	// 유저 상세보기 팝업 그리기
	function showUserPop(list){
		
		var content2 = '';
		console.log(list.id);
		console.log(list.level);
		console.log(list.position);
		content2 +=
           	'<ul>'
           	+'<li>'
           	+'<p class="tit">아이디</p>'
           	+'<p class="txt">' + list.id + '</p>'
           	+'</li>'
           	+'<li>'
           	+'<p class="tit">레벨</p>'
           	+'<p class="txt">' + list.level + '</p>'
           	+'</li>'
           	+'<li>'
           	+'<p class="tit">포지션</p>'
           	+'<p class="txt">' + list.position + '</p>'
           	+'</li>'
           	+'<li>'
           	+'<p class="tit">성별</p>'
           	+'<p class="txt">' + list.gender + '</p>'
           	+'</li>'
           	+'<li>'
           	+'<p class="tit">지역</p>'
           	+'<p class="txt">' + list.address + '</p>'
           	+'</li>'
           	+'</ul>';
		console.log(list.address);
		console.log(content2);
		$('#listCont2').html(content2);
	}
	
	// ---------------------------------------------------------------------------------------------------------
	
	// 멤버 추방
	function dropMember(userId) {
		var cf = '';
		cf = confirm(userId + '님을 추방하시겠습니까?');
		if(cf){
			$.ajax({
				type:'POST'
				,url:'./drop_member.ajax'
				,data:{
					'team_idx':team_idx
					,'userId':userId
				}
				,dataType:'json'
				,success:function(data){
					/* console.log(data.listAppli);
					console.log(data.totalPageAppli); */
					
					$('#pagination').twbsPagination('destroy');
			    	callTeam(currentPage);
					
				}
				,error:function(error){
					console.log(error);
				}
			});
		}
	}
	// 멤버 신청 수락, 거부
	function confirmMember(userId, idx, num) {
		var cf = '';
		if(num == 1){
			cf = confirm(userId + '님을 수락하시겠습니까?');
		}else{
			cf = confirm(userId + '님을 거부하시겠습니까?');
		}
		if(cf){
			$.ajax({
				type:'POST'
				,url:'./appli_member.ajax'
				,data:{
					'team_idx':team_idx
					,'userId':userId
					,'idx':idx
					,'num':num
				}
				,dataType:'json'
				,success:function(data){
					/* console.log(data.listAppli);
					console.log(data.totalPageAppli); */
					
					$('#pagination').twbsPagination('destroy');
			    	callTeam(currentPage);
					
				}
				,error:function(error){
					console.log(error);
				}
			});
		}
	}
	
	// 글 삭제
	function deleteWrite(idx, num){
		var cf = '';
		if(num == 1){
			cf = confirm('팀원 모집글을 삭제하시겠습니까?');
		}else{
			cf = confirm('게스트 모집글을 삭제하시겠습니까?');
		}
		if(cf){
			$.ajax({
				type:'POST'
				,url:'./delete_write.ajax'
				,data:{
					'idx':idx
					,'num':num
				}
				,dataType:'json'
				,success:function(data){
					alert('삭제 완료했습니다.');
					
					$('#pagination').twbsPagination('destroy');
			    	callTeam(currentPage);
					
				}
				,error:function(error){
					console.log(error);
				}
			});
		}
	}
	
	// 팀 해체
	function destroyTeam(){
		var cf = '';
		cf = confirm('팀을 삭제하시겠습니까?');
		if(cf){
			$.ajax({
				type:'POST'
				,url:'./destroy_team.ajax'
				,data:{
					'team_idx':team_idx
				}
				,dataType:'json'
				,success:function(data){
					alert('삭제 완료했습니다.');
					
					location.href='../official';
					
				}
				,error:function(error){
					console.log(error);
				}
			});
		}
	}
    
</script>
</html>




























