<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 리스트</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/common/common.css" type ="text/css">
<link rel="stylesheet" href="../resources/css/common/reset.css" type ="text/css">
<link rel="stylesheet" href="../resources/css/header/header.css" type ="text/css">
<link rel="stylesheet" href="../resources/css/teammate/teammate_list.css" type ="text/css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
/* 수정 - 강대훈 */
.teammateDIV h2{
	font-size: 25px;
    font-weight: 600;
    margin-bottom: 10px;
}
.teammateTable{
	margin-top: 10px;
}
.searchContainer{
	text-align: center;
}
.searchContainer #searchWord{
	width: 200px;
}
</style>
</head>
<body>
    <jsp:include page="../header/header.jsp"/>
    
    <div class ="teammateDIV">
    <h2>팀원 모집리스트</h2>
    <!-- 지역 -->
    <select id="teamjoinaddr">
        <option value="">전체 지역</option>
    </select>
    <!-- 포지션 -->
    <select id="teamjoinpos">
        <option value="">전체 포지션</option>
        <option value="센터">센터</option>
        <option value="포워드">포워드</option>
        <option value="가드">가드</option>
    </select>
    <!-- 레벨 -->
    <select id="teamjoinlevel">
        <option value="">전체 레벨</option>
        <option value="브론즈">브론즈</option>
        <option value="실버">실버</option>
        <option value="골드">골드</option>
        <option value="플래티넘">플래티넘</option>
    </select>
    
    <div class="teammateTable">
    <table>
        <colgroup>
             <col width="9%"/>
             <col width="9%"/>
             <col width="9%"/>
             <col width="9%"/>
             <col width="50%"/>
             <col width="7%"/>
             <col width="7%"/>
         </colgroup>
         <thead>
           <tr>
           	  <th>no.</th>
              <th>팀로고</th>
              <th>팀명</th>
              <th>팀장아이디</th>
              <th>지역</th>
              <th>포지션</th>
              <th>레벨</th>
           </tr>
           </thead>
           <tbody id="tbody">
           
           </tbody>
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
        </div>
    <br/>
    
    <!-- 수정 - 강대훈 : 상위 div 생성 -->
	<div class="searchContainer">
		<select id="searchCategory">
	        <option value="teamJoinName">팀 명</option>
	        <option value="teamJoinRepresent">팀장명</option>
	        <option value="teamJoinLoc">지역 명</option>
	    </select>
	    
	    <input type="text" id="searchWord" placeholder="내용을 입력해주세요." maxlength="20"/>
	    <input type="button" id="searchBtn" value="검색" />
	</div>
    

    <br/>
   
</body>
<script>

var sessionChk2 = 'on';
sessionChk2 = '${chk}';
console.log(sessionChk2);


// 팀서비스 2depth on
$('.menu').css('display','flex');
$('.menu li').eq(1).children('a').addClass('on');
$('.teamDepth2').addClass('on');
$('.teamDepth2 a').eq(0).addClass('on');
// ------------------------------------------------------


var currentPage = 1;
var filterFlag = false;
var searchFlag = false;


$(document).on('click', 'td', function(event) {
    // 클릭된 요소가 courtJjim 이미지를 포함하는지 확인
    var join_team_idx = $(this).closest('tr').find('.num').html(); // 각 행에서 join_team_idx 값을 가져옴
    console.log(join_team_idx);  // join_team_idx 확인
	if(sessionChk2 == 'on'){
	console.log('a');
    window.location.href = './join_info.go?join_team_idx=' + join_team_idx; // 상세 페이지로 이동
	}else{
	window.location.href = '../login';
	}
});

$(document).ready(function(){ // html 문서가 모두 읽히면 되면(준비되면) 다음 내용을 실행 해라
   callList(currentPage);
});

$('#teamjoinaddr').on('change',function(){
   $('#pagination').twbsPagination('destroy');
   searchFlag =false;
   callList(currentPage);
});
$('#teamjoinpos').on('change',function(){
	$('#pagination').twbsPagination('destroy');
	searchFlag =false;
	callList(currentPage);
});
$('#teamjoinlevel').on('change',function(){
	$('#pagination').twbsPagination('destroy');
	searchFlag =false;
	callList(currentPage);
});
$('#searchBtn').on('click', function(){
    if($('#searchWord').val() == ''){
        alert('검색단어를 입력해주세요');
        return;
    }
    searchFlag = true;
    currentPage = 1;

    $('#pagination').twbsPagination('destroy');
    searchList(currentPage);

});

function callList(currentPage) {
    
    $.ajax({
       type:'POST'
       ,url:'./teammatePage.ajax'
       ,data:{
          'currentPage':currentPage
          ,'address':$('#teamjoinaddr').val()
          ,'position':$('#teamjoinpos').val()
          ,'level':$('#teamjoinlevel').val()
          ,'searchCategory':$('#searchCategory').val()
          ,'searchWord':$('#searchWord').val()
          ,'searchFlag':searchFlag
       }
       ,dataType:'json'
       ,success:function(data){
          console.log(data.list);
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
       ,url:'./teammateSearchList.ajax'
       ,data:{
          'teammateSearchCategory':$('#searchCategory').val()
          ,'teammateSearchWord':$('#searchWord').val()
          ,'address':$('#teamJoinLoc').val()
          ,'id':$('#teamJoinRepresent').val()
          ,'teamName':$('#teamJoinName').val()
          ,'currentPage':currentPage
       }
       ,dataType:'json'
       ,success:function(data){
          console.log(data.list);
          showList(data.list);
          if(filterFlag == false){
             showFilterList(data.allList);
             filterFlag = true;
          }
          var totalPage = data.totalPage;
          showPagination2(totalPage);
       		console.log(showPagination2);
          
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
    	
    	if(item.currentCount == item.join_team_to){
			finishClass = 'end';
			finishClass2 = 'state finish';
			finishTxt = '모집완료';
			link = 'javascript:;';
		}
 		if(sessionChk2 == 'on'){
			console.log('a');
			link = './join_info.go?join_team_idx=' + item.join_team_idx;
		}else{
			link = '../login';
		}
       content +=
          '<tr class="' + finishClass + '">'
       +'<td class="num">' + item.join_team_idx + '</td>'
       +'<td class="logo"><img class="teammateImage" src="/logo/' + item.logo +'.png" alt="teammateLogo"></td>'
       +'<td class="teamName">' + item.team_name +'</td>'
       +'<td class="representID">' + item.id + '</td>'
       +'<td class="address"><a href="' + link + '">서울시 ' + item.team_address.split(' ')[1] + '</a></td>'
       +'<td class="position">' + item.join_team_position + '</td>'
       +'<td class="level">' + item.join_team_level +'</td>'
       +'</tr>';
       
        finishClass = '';
		finishClass2 = 'state';
		finishTxt = '모집중';
    }

    $('#tbody').html(content);
  }

function showFilterList(list) {
   var content = '';
   var allTeammateAddress = [];
   var teammateAddress = [];
   for(item of list){
	   allTeammateAddress.push(item.team_address.split(' ')[1]);         
   }
   teammateAddress = Array.from(new Set(allTeammateAddress));
   teammateAddress.sort();
   content = '<option value="">전체 지역</option>';
   for(item of teammateAddress){
      content += '<option value="'+item+'">'+item+'</option>';
   }

   $('#teamjoinaddr').html(content);
   
}

</script>
</html>

