<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="../resources/img/teamLogo/logo.png">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="../resources/css/admin/writing_list.css">
<style>

</style>
</head>
<body>
    <div class="adminBody">
        <jsp:include page="../header/header_admin.jsp"/>
        <div class="adminContainer">
            <div class="officialWrap">
                <div class="writingTabMenu">
                    <ul>
                        <li><a href="./writing_official_list.go">공식 경기</a></li>
                        <li><a href="./writing_team_list.go">팀원 모집</a></li>
                        <li><a href="./writing_guest_list.go">게스트 모집</a></li>
                    </ul>
                </div>
                <div class="filterCont">
                    <!-- 레벨 -->
                    <select id="level" class="filter">
                        <option value="">전체레벨</option>
                        <option value="브론즈">브론즈</option>
                        <option value="실버">실버</option>
                        <option value="골드">골드</option>
                        <option value="플래티넘">플래티넘</option>
                    </select>
                    <!-- 지역 -->
                    <select id="address" class="filter">
                        <option value="">전체 지역</option>
                    </select>
                    <!-- 성별 -->
                    <select id="gender" class="filter">
                        <option value="">전체 성별</option>
                        <option value="남자">남자</option>
                        <option value="여자">여자</option>
                    </select>
                    <!-- 포지션 -->
                    <select id="position" class="filter">
                        <option value="">전체 포지션</option>
                        <option value="가드">가드</option>
                        <option value="센터">센터</option>
                        <option value="포워드">포워드</option>
                    </select>

                </div>
            
                <div class="table">
                    <table>
                        <colgroup>
                            <col width="3%"/> <!-- 번호 -->
                            <col width="5%"/> <!-- 레벨 --> 
                            <col width="5%"/> <!-- 성별 -->
                            <col width="5%"/> <!-- 포지션 -->
                            <col width="10%"/> <!-- 지역 -->
                            <col width="35%"/> <!-- 구장명 -->
                            <col width="10%"/> <!-- 경기 날짜 -->
                            <col width="5%"/> <!-- 남은 모집인원 -->
                            <col width="10%"/> <!-- 로고 -->
                            <col width="10%"/> <!-- 글 상태 -->
                        </colgroup>
                        <thead>
                            <tr>
                                <th></th>
                                <th>레벨</th>
                                <th>성별</th>
                                <th>포지션</th>
                                <th>지역</th>
                                <th>구장명</th>
                                <th>경기 날짜</th>
                                <th>남은 <br> 모집인원</th>
                                <th>로고</th>
                                <th>글 상태</th>
                            </tr>
                        </thead>
                        <tbody id="list">
                            <!-- <tr>
                                <td class="num">1</td>
                                <td class="level">브론즈</td>
                                <td class="gender">남자</td>
                                <td class="gender">가드</td>
                                <td class="courtAddress">Address</td>
                                <td class="courtName"><a href="#">courtName</a></td>
                                <td class="gameDate">2020-10-10</td>
                                <td class="recruitment">5</td>
                                <td class="logo">
                                    <div>
                                        <img src="/logo/team_logo01.jpg" alt="">
                                    </div>
                                </td>
                                <td>공개</td>
                            </tr> -->
                            <!-- <tr>
                                <td class="num">1</td>
                                <td class="level">브론즈</td>
                                <td class="gender">남자</td>
                                <td class="gender">가드</td>
                                <td class="courtAddress">Address</td>
                                <td class="courtName"><a href="#">courtName</a></td>
                                <td class="gameDate">2020-10-10</td>
                                <td class="recruitment">5</td>
                                <td class="logo">
                                    <div>
                                        <img src="/logo/team_logo01.jpg" alt="">
                                    </div>
                                </td>
                                <td>공개</td>
                            </tr> -->
                        </tbody>
                        <tfoot>
                            <tr>
								<td colspan="10">
									<div class="container">
										<nav aria-label="Page navigation" style="text-align: center">
											<ul class="pagination" id="pagination"></ul>
										</nav>
									</div>
								</td>
							</tr>
                        </tfoot>
                    </table>
                </div>
            
                <div class="searchBox">
	                <select id="searchCategory" >
				        <option value="courtName">구장 명</option>
				        <option value="teamName">팀 명</option>
				    </select> 
                    <input type="text" id="searchWord" placeholder="검색단어입력"
						maxlength="20" />
					<!-- 이거 누르면 아작스 하는걸로 -->
					<input type="button" id="searchBtn" value="검색" />
                </div>
            </div>
        </div>
    </div>
</body>
<script>

    // 퍼블 영역
    $('.adminHeader .menu li').eq(3).addClass('on');
    $('.writingTabMenu ul li').eq(2).addClass('on');
    
    var currentPage = 1;
	var filterFlag = false;
	var searchFlag = false;
	
	$(document).ready(function() {
	    // 페이지 로드 시 callList 호출
	    callList(currentPage);
	});
	
	$('#searchBtn').on('click', function(){
	    if($('#searchWord').val() == ''){
	        alert('검색단어를 입력해주세요');
	        return;
	    }
	    currentPage = 1;

	    $('#pagination').twbsPagination('destroy');
	    searchFlag = true;
	    callList(currentPage);
	});	
	
	// 검색 단어 입력 필드에서 Enter 키 눌렀을 때 검색 실행
    $('#searchWord').on('keypress', function(event) {
        if (event.which === 13) { // 13은 Enter 키의 keyCode
            $('#searchBtn').click(); // 검색 버튼 클릭 이벤트 호출
        }
    });


	$('.filter').on('change',function(){
		$('#pagination').twbsPagination('destroy');
		searchFlag = false;
		callList(currentPage);
	});	
	
	function callList(currentPage) {
		$.ajax({
			type:'POST'
			,url:'./writing_guest_list/list.ajax'
			,data:{
				'currentPage':currentPage
				,'address':$('#address').val()
				,'level':$('#level').val()
				,'gender':$('#gender').val()
				,'position':$('#position').val()
				,'searchCategory':$('#searchCategory').val()
				,'searchWord':$('#searchWord').val()
				,'searchFlag':searchFlag
			}
			,dataType:'json'
			,success:function(data){
				console.log(data);
// 				console.log(data.totalPage);
				showList(data.list);
				if(filterFlag == false){
					showFilterList(data.addressList);
					filterFlag = true;
				}
				$('#pagination').twbsPagination({
					startPage:1
					,totalPages:data.totalPage
					,visiblePages:5	
					,onPageClick:function(evt,pg){
						currentPage = pg;
						callList(currentPage);
					}
					
				});
				
			}
			,error:function(error){
				console.log(error);
			}
		});
	}	
	
	function showList(list){
		var content = '';
		var link = '';
		var remainingNum = '';
		for(item of list){
			link = './guestUpdate.go?guestIdx=' + item.guest_idx;
			remainingNum = item.guest_to - item.currentCount
			
			content +=
                '<tr>'
            	+'<td class="num">' + item.guest_idx + '</td>'
            	+'<td class="level">' + item.guest_level + '</td>'
            	+'<td class="gender">' + item.guest_gender + '</td>'
            	+'<td class="position">' + item.guest_position + '</td>'
            	+'<td class="courtAddress">' + item.court_address + '</td>'
            	+'<td class="courtName"><a href="' + link + '">' + item.court_name + '</a></td>'
            	+'<td class="gameDate">' + item.booking_date + '</td>'
            	+'<td class="recruitment">' + remainingNum + '</td>'
            	+'<td class="logo">'
            	+'<div>'
            	+'<img src="/logo/' + item.logo + '.png" alt="">'
            	+'</div>'
            	+'</td>'
            	+'<td>' + item.guest_state + '</td>'
            	+'</tr>';
			
		}
		$('#list').html(content);
	}	
	
	function showFilterList(list) {
		var content = '';
		
		content = '<option value="">전체 지역</option>';
		for(item of list){
			content += '<option value="'+item+'">'+item+'</option>';
		}

		$('#address').html(content);
		
	}	

</script>
</html>

























