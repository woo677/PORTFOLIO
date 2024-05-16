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
    .courtListTable{
        border: 2px solid;
        border-collapse: collapse;
        
    }
    .courtListTh{
        background-color: gainsboro;
    }
    .courtListTh,.courtListTd{
        border: 2px solid;
    padding: 10px 30px;
    text-align: center;
    }
    .courtImage{
    	height: 50px;
    	width: auto;
    }
   .courtJjim{
    	height: 50px;
		width: auto;
    }
	.courtListTr:hover {
		background-color: lightgray;
	}
	/* 수정 - 강대훈 */
	.courtListContainer{
		width: 1280px;
    	margin: 15px auto 0;
	}
	.courtListContainer .courtListTable{
		width: 100%;
	}
	.searchContainer{
		text-align: center;
	}

</style>
</head>
<body>
	<jsp:include page="../header/header.jsp"/>
	<!-- 수정 - 강대훈 : 상위 div 생성 -->
	<div class="courtListContainer">
	    <select id="address">
	    	<option value="">전체 지역</option>
	        <!-- 원래는 반복문 돌리는게 나을꺼 같은데 -->
	    </select>
	    <br/>
	    <br/>
	    <table class="courtListTable">
			<thead>
				<tr>
					<th class="courtListTh">구장 사진</th>
					<th class="courtListTh">구장 이름</th>
					<th class="courtListTh">지역</th>
					<th class="courtListTh">가격</th>
					<th class="courtListTh">찜</th>
				</tr>
			</thead>
			<tbody id="list">
				
			</tbody>
	
	    </table>
		<div class="container">                           
			 <nav aria-label="Page navigation" style="text-align:center">
			  	<ul class="pagination" id="pagination"></ul>
			 </nav>               
		 </div>
	    <br/>
	
		<!-- 수정 - 강대훈 : 상위 div 생성 -->
		<div class="searchContainer">
		    <select id="searchCategory" >
		        <option value="courtName">코트 명</option>
		        <option value="courtAddress">지역 명</option>
		    </select>
		    
		    <input type="text" id="searchWord" placeholder="검색단어입력" maxlength="20"/>
		    <!-- 이거 누르면 아작스 하는걸로 -->
			<input type="button" id="searchBtn" value="검색" />
			
			<div></div>
		</div>

	</div>

</body>
<script>
	// 구장 대여
	$('.menu li').eq(2).children('a').addClass('on');
	// ---------------------------------------------------

	var currentPage = 1;
	var filterFlag = false;
	var searchFlag = false;
	
	$(document).on('click', 'td', function(event) {
	    // 클릭된 요소가 courtJjim 이미지를 포함하는지 확인
	    if (!$(event.target).hasClass('courtJjim')) {
	        var courtIdx = $(this).closest('tr').find('.courtJjim').data('courtidx');
	        console.log(courtIdx);  // courtIdx 확인
	        window.location.href = './detail.go?court_idx=' + courtIdx; // 상세 페이지로 이동
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

	    $('#pagination').twbsPagination('destroy');
	    searchFlag = true;
	    callList(currentPage);

	});	
	
	$('#address').on('change',function(){
		$('#pagination').twbsPagination('destroy');
		searchFlag = false;
		callList(currentPage);
		
	});
	
	/*찜 아이콘 눌렀을때 처리 */
	$('#list').on('click', '.courtJjim', function() {
	    var currentJjimImg = $(this).attr('src');
		var imgThis = $(this);
// 	    console.log($(this));
// 	    console.log($(this).data('courtidx'));
	    
	    if (currentJjimImg.indexOf('/jjim.png') != -1) {
	        $.ajax({
	        	type:'POST'
	        	,url:'./noJjim.ajax'
	        	,data:{
	        		"courtIdx":$(this).data('courtidx')
	        	}
	   			,dataType:'json'
	   			,success:function(data){
// 	   				console.log(data.result);
// 	   				console.log($(this));
	   				if(data.result){
	   					imgThis.attr('src', '../resources/img/court/no_jjim.png');
	   				}
	   			}
	   			,error:function(error){
	   				
	   			}
	        });
	    } else {
	    	
	        $.ajax({
	        	type:'POST'
	        	,url:'./jjim.ajax'
	        	,data:{
	        		"courtIdx":$(this).data('courtidx')
	        	}
	   			,dataType:'json'
	   			,success:function(data){
// 	   				console.log(data.result);

// 	   				console.log($(this));
	   				if(data.result){
	   					imgThis.attr('src', '../resources/img/court/jjim.png');
	   				}
	   		    }
	   			,error:function(error){
	   				
	   			}
	        });
	    }
	});
	
	function callList(currentPage) {
		$.ajax({
			type:'POST'
			,url:'./list.ajax'
			,data:{
				'currentPage':currentPage
				,'address':$('#address').val()
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
			console.log(item.firstImageName);
			var img = item.firstImageName != null ? item.firstImageName+'.png':'no_image.png';
			var jjim = item.jjim > 0 ? 'jjim.png':'no_jjim.png';
			content +=
				'<tr class="courtListTr">'
				+'<td class="courtListTd"><img class="courtImage"  src="/court/'+img+'" alt="courtImage"></td>'
				+'<td class="courtListTd">'+item.courtName+'</td>'
				+'<td class="courtListTd">'+item.courtAddress.split(' ')[1]+'</td>'
				+'<td class="courtListTd">'+item.courtPrice+'</td>'
				+'<td class="courtListTd"><img class="courtJjim" data-courtIdx="'+item.courtIdx+'" src="../resources/img/court/'+jjim+'" alt="ImageCheck"></td>'
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