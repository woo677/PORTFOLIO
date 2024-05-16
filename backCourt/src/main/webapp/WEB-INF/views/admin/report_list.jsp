<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<style>
    .reportListTable{
        border: 2px solid;
        border-collapse: collapse;
    }
    .reportListTh{
        background-color: gainsboro;
    }
    .reportListTh,.reportListTd{
        border: 2px solid;
        padding: 10px 30px;
        text-align: center;
    }
    #adminReportListDiv{
        width: 100%;
    }
    .reportListTr:hover {
		background-color: lightgray;
	}
    
    </style>
</head>
<body>
<div class="adminBody">
        <jsp:include page="../header/header_admin.jsp"/>
        <div class="adminContainer">
		<h1>신고/문의 내역</h1>
		<div id="adminReportListDiv"> 
			처리유형 
			<select id="reportState">
				<option value="">전체</option>
				<option value="처리 전">처리 전</option>
				<option value="처리 중">처리 중</option>
				<option value="처리 완료">처리 완료</option>
			</select>
			<input type="text" id="reportSearch" placeholder="신고/문의자 ID 검색" />
			<table class="reportListTable">
				<thead>
					<tr>
						<th class="reportListTh">no.</th>
						<th class="reportListTh">처리상태</th>
						<th class="reportListTh">제목</th>
						<th class="reportListTh">신고/문의자 ID</th>
						<th class="reportListTh">신고/문의 날짜</th>
						<th class="reportListTh">관리자</th>
					</tr>
				</thead>
				<tbody id="reportList"></tbody>
			</table>
			<div class="container">
				<nav aria-label="Page navigation" style="text-align: center">
					<ul class="pagination" id="pagination"></ul>
				</nav>
			</div>
		</div>
	</div>
 </div>

</body>
<script>
var currentPage = 1;
var searchFlag = false;
	
	$(document).on('click', 'td', function(event) {
		 var reportIdx = $(this).closest('tr').find('td:first').text();
		window.location.href = './reportDetail.go?reportIdx=' + reportIdx;
	});

	$(document).ready(function() {
	    // 페이지 로드 시 callList 호출
	    callList(currentPage);
	});

	$('#reportSearch').on('keydown', function(evt){
		if(evt.keyCode == 13){
			console.log(evt);
		    if($(this).val() == ''){
		        alert('검색단어를 입력해주세요');
		        return;
		    }
		    currentPage = 1;
	
		    $('#pagination').twbsPagination('destroy');
		    searchFlag = true;
		    callList(currentPage);
		}
	});	
	
	$('#reportState').on('change',function(){
		$('#pagination').twbsPagination('destroy');
		searchFlag = false
		callList(currentPage);
		
	});
	
	
	
	function callList(currentPage) {
		$.ajax({
			type:'POST'
			,url:'./reportList.ajax'
			,data:{
				'currentPage':currentPage
				,'reportState':$('#reportState').val()
				,'reportSearch':$('#reportSearch').val()
				,'searchFlag':searchFlag
			}
			,dataType:'JSON'
			,success:function(data){
				console.log(data);
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
			content +=
				'<tr class="reportListTr">'
				+'<td class="reportListTd">'+item.reportIdx+'</td>'
				+'<td class="reportListTd">'+item.reportState+'</td>'
				+'<td class="reportListTd">'+item.reportSubject+'</td>'
				+'<td class="reportListTd">'+item.reportId+'</td>'
				+'<td class="reportListTd">'+item.reportDate+'</td>'
				+'<td class="reportListTd">'+item.reportAdminId+'</td>'
				+'</tr>';
		}
		$('#reportList').html(content);
	}
</script>
</html>