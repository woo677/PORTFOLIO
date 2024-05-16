<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
    .adminCourtListTable{
        border: 2px solid;
        border-collapse: collapse;
    }
    .adminCourtListTh{
        background-color: gainsboro;
    }
    .adminCourtListTh,.adminCourtListTd{
        border: 2px solid;
        padding: 10px 30px;
        text-align: center;
    }
	.adminCourtListTr:hover {
		background-color: lightgray;
	}
    
    </style>
</head>
<body>
<div class="adminBody">
	<jsp:include page="../header/header_admin.jsp"/>
	<div class="adminContainer">
		<select id="address">
			<option value="">전체지역</option>
		</select>
		<div>
			<input type="button" id="courtRegist" value="구장 등록"/>
		</div>
		<table class="adminCourtListTable">
			<thead>
				<tr>
					<th class="adminCourtListTh">구장번호</th>
					<th class="adminCourtListTh">구장이름</th>
					<th class="adminCourtListTh">지역</th>
					<th class="adminCourtListTh">활성여부</th>
				</tr>
			</thead>
			<tbody id="admincourtList"></tbody>
		</table>
		<div class="container">                           
			<nav aria-label="Page navigation" style="text-align:center">
				<ul class="pagination" id="pagination"></ul>
			</nav>               
		</div>
		<select id="searchCategory" >
			<option value="courtName">코트 명</option>
			<option value="courtAddress">지역 명</option>
		</select>
		      
		<input type="text" id="searchWord" placeholder="검색단어입력" maxlength="20"/>
		<input type="button" id="searchBtn" value="검색" />
	</div>
</div>
	
</body>
<script>
	var currentPage = 1;
	var filterFlag = false;
	var searchFlag = false;
	var isFirstCall = true;
    callList(currentPage);


	$('#courtRegist').on('click', function(){
		window.location.href = './courtWrite.go';
	});
	
	$(document).on('click', 'td', function(event) {
		var courtIdx = $(this).closest('tr').find('td:first').text();
		window.location.href = './courtDetail.go?courtIdx=' + courtIdx;
	});

	$('#searchWord').on('keydown',function(evt){
		if(evt.keyCode == 13){
			if($(this).val() == ''){
				alert('검색단어를 입력해주세요');
				return;
			}
			currentPage = 1;
			isFirstCall = true;
			$('#pagination').twbsPagination('destroy');
			searchFlag = true;
			callList(currentPage);
		}
	});

	$('#searchBtn').on('click', function(){
	    if($(this).val() == ''){
	        alert('검색단어를 입력해주세요');
	        return;
	    }
	    currentPage = 1;
	    isFirstCall = true;
	    $('#pagination').twbsPagination('destroy');
	    searchFlag = true;
	    callList(currentPage);

	});	
	
	$('#address').on('change',function(){
		isFirstCall = true;
		$('#pagination').twbsPagination('destroy');
		searchFlag = false
		callList(currentPage);
		
	});
	
	
	
	function callList(currentPage) {
		$.ajax({
			type:'POST'
			,url:'./courtList.ajax'
			,data:{
				'currentPage':currentPage
				,'address':$('#address').val()
				,'searchCategory':$('#searchCategory').val()
				,'searchWord':$('#searchWord').val()
				,'searchFlag':searchFlag
			}
			,dataType:'json'
			,success:function(data){
				console.log(data.totalPage);
				console.log(data.addressList);
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
						if(isFirstCall == false){
							callList(currentPage);							
						}
						isFirstCall = false;
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
				'<tr class="adminCourtListTr">'
				+'<td class="adminCourtListTd">'+item.courtIdx+'</td>'
				+'<td class="adminCourtListTd">'+item.courtName+'</td>'
				+'<td class="adminCourtListTd">'+item.courtAddress.split(' ')[1]+'</td>'
				+'<td class="adminCourtListTd">'+item.courtState+'</td>'
				+'</tr>';
		}
		$('#admincourtList').html(content);
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