<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>게스트 모집 게시판</title>
<link rel="icon" href="/logo/logo.png">
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="../resources/js/jquery.twbsPagination.js"
	type="text/javascript"></script>

<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="../resources/css/guest_join/list.css">
<style>
.table tr{
	cursor: pointer;
}
.table tr th {
	background: lightgray;
}
/* 수정 - 강대훈 */
.guest_join.content{
	width: 1280px;
    margin: 0 auto;
}
.searchContainer{
	text-align: center;
}
</style>
</head>
<body>

	<jsp:include page="../header/header.jsp" />
	<div class="guest_join content">
		<div class="filterCont">
			<!-- 지역 -->
			<select id="address" class="filter">
				<option value="">전체 지역</option>
			</select>

			<!-- 성별 -->
			<select id="gender" class="filter">
				<option value="">성별 선택</option>
				<option value="남자">남자</option>
				<option value="여자">여자</option>
			</select>

			<!-- 포지션 -->
			<select id="position" class="filter">
				<option value="">포지션 선택</option>
				<option value="센터">센터</option>
				<option value="포워드">포워드</option>
				<option value="가드">가드</option>
			</select>

			<!-- 레벨 -->
			<select id="level" class="filter">
				<option value="">전체 레벨</option>
				<option value="브론즈">브론즈</option>
				<option value="실버">실버</option>
				<option value="골드">골드</option>
				<option value="플래티넘">플래티넘</option>
			</select>
		</div>

		<div class="table">
			<table>
				<colgroup>
					<col width="20%" />
					<col width="20%" />
					<col width="10%" />
					<col width="5%" />
					<col width="5%" />
					<col width="5%" />
					<col width="5%" />
				</colgroup>
				<thead>
					<tr>
						<th>구장명</th>
						<th>지역</th>
						<th>팀명</th>
						<th>포지션</th>
						<th>레벨</th>
						<th>성별</th>
						<th>모집인원</th>
					</tr>
				</thead>
				<tbody id="list">

				</tbody>
				<tr>
					<td colspan="7">
						<div class="container">
							<nav aria-label="Page navigation" style="text-align: center">
								<ul class="pagination" id="pagination"></ul>
							</nav>
						</div>
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 수정 - 강대훈 : 상위 div 생성 -->
		<div class="searchContainer">
			<select id="searchCategory">
				<option value="courtName">코트 명</option>
				<option value="Address">지역 명</option>
				<option value="teamName">팀 명</option>
			</select> <input type="text" id="searchWord" placeholder="검색단어입력"
				maxlength="20" />
			<!-- 이거 누르면 아작스 하는걸로 -->
			<input type="button" id="searchBtn" value="검색" />
		</div>	

	</div>
</body>
<script>
 
	$('.menu li').eq(1).children('a').addClass('on');
	$('.teamDepth2').addClass('on');
	$('.teamDepth2 a').eq(1).addClass('on');
    
    var currentPage = 1;
	var filterFlag = false;
	var searchFlag = false;
    
	// $(document).on('click', 'td', function(event) {
	// 	var guest_join_idx = $(this).closest('tr').find('.num')
	//         var courtIdx = $(this).closest('tr').find('.courtJjim').data('courtidx');
	//         console.log(courtIdx);  // courtIdx 확인
	//         window.location.href = './detail.go?court_idx=' + courtIdx; // 상세 페이지로 이동
	    
	// });

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
	
	$(document).on('click', 'td', function(event){
		var guestJoinIdx = $(this).closet('tr').find('.')
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
			,url:'./list.ajax'
			,data:{
				'currentPage':currentPage
				,'address':$('#address').val()
				,'position':$('#position').val()
				,'gender':$('#gender').val()
				,'level':$('#level').val()
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
		for(item of list){

			content +=
				'<tr onclick="goGuestDetail(' + item.guest_idx +')">'
				+'<td>'+ item.court_name +'</td>'
				+'<td>'+ item.court_address +'</td>'
				+'<td>'+ item.team_name +'</td>'
				+'<td>'+ item.guest_position +'</td>'
				+'<td>'+ item.guest_level +'</td>'
				+'<td>'+ item.guest_gender +'</td>'
				+'<td>'+ item.guest_to +'</td>'
				+'</tr>';
		}
		$('#list').html(content);
	}

	function goGuestDetail(guest_idx) {
	    window.location.href = './info.go?guest_idx=' + guest_idx; // 공지사항 상세 페이지로 이동
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

