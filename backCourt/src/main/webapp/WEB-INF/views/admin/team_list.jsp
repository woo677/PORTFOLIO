<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="../resources/js/jquery.twbsPagination.js"
	type="text/javascript"></script>
<style>
.adminteamListTable {
	border: 2px solid;
	border-collapse: collapse;
}

.adminteamListTh {
	background-color: gainsboro;
}

.adminteamListTh, .adminteamListTd {
	border: 2px solid;
	padding: 10px 30px;
	text-align: center;
}

.adminteamListTr:hover {
	background-color: lightgray;
}

.teamIdx { 
	display: none;
}
</style>
</head>
<body>
	<div class="adminBody">
		<jsp:include page="../header/header_admin.jsp" />
		<div class="adminContainer">
			<table class="adminteamListTable">
				<thead>
					<tr>
						<th class="adminteamListTh">팀로고</th>
						<th class="adminteamListTh">팀이름</th>
						<th class="adminteamListTh">지역</th>
						<th class="adminteamListTh">팀장명</th>
					</tr>
				</thead>
				<tbody id="adminteamList"></tbody>
			</table>
			<div class="container">
				<nav aria-label="Page navigation" style="text-align: center">
					<ul class="pagination" id="pagination"></ul>
				</nav>
			</div>
			<select id="searchCategory">
				<option value="teamName">팀이름</option>
				<option value="teamAddress">지역</option>
			</select> <input type="text" id="searchWord" placeholder="검색단어입력"
				maxlength="20" />
			<!-- 이거 누르면 아작스 하는걸로 -->
			<input type="button" id="searchBtn" value="검색" />

		</div>
	</div>
</body>
<script>
	var currentPage = 1;
	var searchFlag = false;
	$('#teamRegist').on('click', function(){
		window.location.href = './teamWrite.go';
	});
	
	$(document).on('click', 'td', function(event) {
		var teamIdx = $(this).closest('tr').find('.teamIdx').html();
		console.log(teamIdx);
		window.location.href = './team_detail.go?teamIdx=' + teamIdx;
	});

	$('#searchWord').on('keydown', function(evt){
		if(evt.keyCode == 13){
			if($(this).val() == ''){
		        alert('검색단어를 입력해주세요');
		        return;
		    }
		    currentPage = 1;
		    searchFlag = true;
		    $('#pagination').twbsPagination('destroy');
		    callList(currentPage);
			console.log($(this).val());
		}
	});
	
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
	    searchFlag = true;
	    $('#pagination').twbsPagination('destroy');
	    callList(currentPage);

	});	
	
	
	
	function callList(currentPage) {
		
		$.ajax({
			type:'POST'
			,url:'./teamList.ajax'
			,data:{
				'currentPage':currentPage
				,'searchCategory':$('#searchCategory').val()
				,'searchWord':$('#searchWord').val()
				, 'searchFlag':searchFlag
			}
			,dataType:'json'
			,success:function(data){
				console.log(data);
// 				console.log(data.totalPage);
				showList(data.list);
		
				showPagination(data.totalPage);
				
			}
			,error:function(error){
				console.log(error);
			}
		});
	}
	function showPagination(totalPage) {
		$('#pagination').twbsPagination({
				startPage:1
				,totalPages:totalPage
				,visiblePages:5	
				,onPageClick:function(evt,pg){
// 					console.log(pg);
					
					currentPage = pg;
					callList(currentPage);
				}
				
		});
	}
	function showList(list){
		var content = '';
		for(item of list){
			console.log(item.team_idx);
			content +=
				'<tr class="adminteamListTr">'
				+'<td class="adminteamListTd"><img class="logo" src="/logo/'+ item.logo +'.jpg" alt="" /><span class="teamIdx">'+ item.team_idx+'</span></td>'
				+'<td class="adminteamListTd">'+item.team_name+'</td>'
				+'<td class="adminteamListTd">'+item.team_address+'</td>'
				+'<td class="adminteamListTd">'+item.id+'</td>'
				+'</tr>';
		}
		$('#adminteamList').html(content);
	}

</script>
</html>