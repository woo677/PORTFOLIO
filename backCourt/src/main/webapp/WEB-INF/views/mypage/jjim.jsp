<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="../resources/css/common/reset.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
	/* 수정 - 강대훈 */
	.jjimContainer{
		width: 1280px;
    	margin: 0 auto;
	}
	
	.jjimContainer h2{
		font-size: 30px;
    	font-weight: 600;
    	margin: 20px 0;
	}
	
	.jjimContainer .deleteBtn{
		margin-bottom: 20px;
    	font-size: 20px;
	}

    .jjimTable{
    	width:100%;
         border: 2px solid;
        border-collapse: collapse;
    }
    .jjimTh{
    	background-color: gainsboro;
    }
    .jjimTh,.jjimTd{
        border: 2px solid;
        padding: 10px 50px;
        text-align: center;
    }



    </style>
</head>
<body>
    
	<jsp:include page="../header/header.jsp"/>
	<!-- 수정 - 강대훈 - 상위 div 생성 -->
	<div class="jjimContainer">
		<h2>찜 내역</h2>
	    <input type="button" value="선택 삭제" class="deleteBtn">
	    <table class="jjimTable">
	        <thead>
	            <tr>
	                <th class="jjimTh"><input type="checkbox" id="allCheck"/></th>
	                <th class="jjimTh">No.</th>
	                <th class="jjimTh">이름</th>
	                <th class="jjimTh">위치</th>
	                <th class="jjimTh">가격</th>
	            </tr>
	        </thead>
	        <tbody class="jjimList">
	
	        </tbody>
	        <tr>
				<td colspan="5">
					<div class="container">                           
					  <nav aria-label="Page navigation" style="text-align:center">
						  <ul class="pagination" id="pagination"></ul>
					  </nav>               
					 </div>
				</td>
			</tr>
	    </table>
	</div>
	
</body>
<script>
    var currentPage = 1;
    var jjimListFirstCallFlag = true;
    $('input[value="선택 삭제"]').on('click',function(){
        if ($('.rowCheck:checked').length == 0) {
            alert('선택된 항목이 없습니다.');
            return;
        }
        if(!confirm('선택한 구장을 찜목록에서 삭제하시겠습니까?')){
            return;
        }

        // 체크된 체크박스의 data-jjimIdx 값을 저장할 배열
        var selectedIdx = [];
        // .rowCheck 체크박스 중 체크된 것들을 반복하여 처리
        $('.rowCheck:checked').each(function() {
            // 체크된 체크박스의 data-jjimIdx 값을 배열에 추가
            selectedIdx.push($(this).data('jjimidx'));
        });
        var selectedCount = selectedIdx.length;
        // 선택된 체크박스의 data-jjimIdx 값들을 콘솔에 출력
        console.log(selectedIdx);
        
        $.ajax({
        	type:'POST'
        	, url:'./jjimDel.ajax'
        	, data:{
        		'selectedIdxList':selectedIdx
        	}
        	, dataType:'json'
        	, success:function(data){
        		currentPage = 1;
        		$('#pagination').twbsPagination('destroy');
        		callList(currentPage);
        		jjimNumber = 1;
        		alert(selectedCount+'개 가 삭제 되었습니다.');
        	}
        	, error:function(error){
        		
        	}
        });
    	$('#allCheck').prop('checked', false);
    	
    });
    
	$(document).ready(function() {
	    callList(currentPage);
	});
	
	$('#allCheck').on('click',function(){
		var state = $(this).prop('checked');
		$('.rowCheck').prop('checked', state);
	});
	
    function callList(currentPage){
        $.ajax({
            type:'POST'
            , url:'./jjimList.ajax'
            , data:{
                'currentPage':currentPage
            }
            , dataType:'json'
            , success:function(data){
            	console.log(data);
                showList(data.list,currentPage);
                $('#pagination').twbsPagination({
                    startPage:1
                    , totalPages:data.totalPage
                    , visiblePages:5
                    , onPageClick:function(evt, pg){
                    	currentPage = pg;
                        if(jjimListFirstCallFlag == false){
	                        callList(currentPage);                        	
                        }
                        jjimListFirstCallFlag = false;
                    }
                });
            }
            , error:function(){

            }
        });
        console.log(currentPage);
    }
    function showList(list,currentPage){
        var content = '';
        var count = 1 + (currentPage-1)*10;
        console.log(count);
        for (item of list) {
            content +=
                '<tr>'
                + '<td class="jjimTd"><input class="rowCheck" type="checkbox" data-jjimIdx="'+item.jjimIdx+'"/></td>'
                + '<td class="jjimTd">'+count+'</td>'
                + '<td class="jjimTd">'+item.courtName+'</td>'
                + '<td class="jjimTd">'+item.courtAddress.split(' ')[1]+'</td>'
                + '<td class="jjimTd">'+item.courtPrice+'</td>'
                + '</tr>';
			count++;
        }
        $('.jjimList').html(content);
    }
</script>
</html>