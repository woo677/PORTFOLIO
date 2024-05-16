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
<link rel="stylesheet" href="../resources/css/official/official.css">
<style>

</style>
</head>
<body>
	<jsp:include page="../header/header.jsp"/>
	<div class="official content">
        <div class="filterCont">
            <!-- 지역 -->
            <select id="address">
                <option value="">전체 지역</option>
            </select>
    
            <!-- 레벨 -->
            <select id="level">
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
                    <col width="5%"/>
                    <col width="10%"/>
                    <col width="50%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                </colgroup>
                <thead>
                	<tr>
	                    <th></th>
	                    <th>경기 날짜</th>
	                    <th>지역</th>
	                    <th>레벨</th>
	                    <th>모집인원</th>
	                    <th>상태</th>
	                </tr>
                </thead>
                <tbody id="tbody">
                	
                </tbody>
                <!-- <tr>
                    <td class="num">1</td>
                    <td class="gameDate">5월5일</td>
                    <td class="address"><a href="#">서울시 금천구</a></td>
                    <td class="level">골드</td>
                    <td>
                        <span class="present">5</span> / 
                        <span class="Recruitment">10</span>
                    </td>
                    <td class="state">모집중</td>
                </tr>
                <tr>
                    <td class="num">1</td>
                    <td class="gameDate">5월5일</td>
                    <td class="address"><a href="#">서울시 금천구</a></td>
                    <td class="level">골드</td>
                    <td>
                        <span class="present">5</span> / 
                        <span class="Recruitment">10</span>
                    </td>
                    <td class="state finish">모집중</td>
                </tr> -->
                <tr>
					<td colspan="7">
						<div class="container">                           
						  <nav aria-label="Page navigation" style="text-align:center">
							  <ul class="pagination" id="pagination"></ul>
						  </nav>               
						 </div>
					</td>
				</tr>
            </table>
        </div>
        
    
        <div class="searchBox">
            <input type="text" name="searchInput" placeholder="지역명을 입력해주세요." maxlength="20"/>
            <button onclick="searchList(1)">검색</button>
        </div>
    
    </div>
</body>
<script>
    // 퍼블 영역
    $(function(){
        // 공식 경기
        $('.menu li').eq(0).children('a').addClass('on');
    })
    
    // 개발 영역
    var sessionChk2 = 'on';
    sessionChk2 = '${chk}';
    console.log(sessionChk2);
    
    var currentPage = 1;
	var filterFlag = false;
    
    $(document).ready(function(){
    	callList(currentPage);
    });
    
    $('#level').on('change',function(){
		$('#pagination').twbsPagination('destroy');
		callList(currentPage);
	});
    
	$('#address').on('change',function(){
		$('#pagination').twbsPagination('destroy');
		callList(currentPage);
	});
	
	$('.searchBox button').on('click',function(){
		$('#pagination').twbsPagination('destroy');
		searchList(currentPage);
	});
    
    // list
	function callList(currentPage) {
		
		$.ajax({
			type:'POST'
			,url:'./match_list.ajax'
			,data:{
				'courtSearchWord':$('select[name="searchInput"]').val()
				,'currentPage':currentPage
				,'address':$('#address').val()
				,'level':$('#level').val()
			}
			,dataType:'json'
			,success:function(data){
				/* console.log(data.list); */
				/* console.log(data.totalPage); */
				showList(data.list);
				if(filterFlag == false){
					showFilterList(data.allList);
					filterFlag = true;
				}
				var totalPage = data.totalPage;
				showPagination(totalPage);
				
			}
			,error:function(error){
				console.log(error);
			}
		});
	}
	function searchList(currentPage) {
		$.ajax({
			type:'POST'
			,url:'./searchList.ajax'
			,data:{
				'courtSearchWord':$('input[name="searchInput"]').val()
				,'currentPage':currentPage
			}
			,dataType:'json'
			,success:function(data){
				/* console.log(data.list); */
				console.log(data.totalPage);
				showList(data.list);
				if(filterFlag == false){
					showFilterList(data.allList);
					filterFlag = true;
				}
				var totalPage = data.totalPage;
				showPagination2(totalPage);
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
					console.log(pg);
					currentPage = pg;
					callList(currentPage);
					
				}
				
		});
	}
	function showPagination2(totalPage) {
		$('#pagination').twbsPagination({
				startPage:1
				,totalPages:totalPage
				,visiblePages:5
				,onPageClick:function(evt,pg){
					console.log(pg);
					currentPage = pg;
					searchList(currentPage);
				}
				
		});
	}
	function showList(list){
		var content = '';
		var finishClass = '';
		var finishClass2 = 'state';
		var finishTxt = '모집중';
		var link = '';
		for(item of list){
			
			if(item.currentCount >= item.official_match_to){
				finishClass = 'end';
				finishClass2 = 'state finish';
				finishTxt = '모집완료';
				link = 'javascript:;';
			}else{
				link = './match_info.go?official_match_idx=' + item.official_match_idx;
			}
			if(sessionChk2 == 'on'){
				console.log('a');
			}else{
				link = '../login';
			}
			content +=
				'<tr class="' + finishClass + '">'
				+'<td class="num">' + item.official_match_idx + '</td>'
                +'<td class="gameDate">' + item.official_match_date + '</td>'
                +'<td class="address"><a href="' + link + '">서울시 ' + item.court_address.split(' ')[1] + '</a></td>'
                +'<td class="level">' + item.official_match_level + '</td>'
                +'<td>'
                +'<span class="present">' + item.currentCount + '</span> / '
                +'<span class="Recruitment">' + item.official_match_to + '</span>'
                +'</td>'
                +'<td class="' + finishClass2 +'">' + finishTxt + '</td>'
                +'</tr>';
            
           	finishClass = '';
			finishClass2 = 'state';
			finishTxt = '모집중';
		}
		$('#tbody').html(content);
	}
	function showFilterList(list) {
		var content = '';
		var allAddress = [];
		var address = [];
		for(item of list){
			allAddress.push(item.court_address.split(' ')[1]);			
		}
		address = Array.from(new Set(allAddress));
		address.sort();
		content = '<option value="">전체 지역</option>';
		for(item of address){
			content += '<option value="'+item+'">'+item+'</option>';
		}

		$('#address').html(content);
		
	}
    
	/* function searchList() {
		currentPage = 1;
		callList(currentPage);
	} */

</script>
</html>

