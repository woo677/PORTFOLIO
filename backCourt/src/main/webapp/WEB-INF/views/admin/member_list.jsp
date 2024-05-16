<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리 리스트</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/common/reset.css" type ="text/css">
<link rel="stylesheet" href="../resources/css/header/header.css" type ="text/css">
<link rel="stylesheet" href="../resources/css/admin/member_list.css" type ="text/css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>   
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>

</head>
<body>
    <div class="adminBody">
    <jsp:include page="../header/header_admin.jsp"/>
    <div>
    <h2>회원 관리 리스트</h2>
    <!-- 멤버 계정 상태 -->
    <select id="memberState">
        <option value="">전체</option>
        <option value="일반">일반</option>
        <option value="경고">경고</option>
        <option value="정지">정지</option>
    </select>
    
    <div class="memberDiv">
    <table class="adminMemberListTable">
        <colgroup>
             <col width="5%"/>
             <col width="30%"/>
             <col width="30%"/>
             <col width="20%"/>
             <col width="15%"/>
         </colgroup>
         <thead>
           <tr>
           	  <th class="adminMemberListTh">no.</th>
              <th class="adminMemberListTh">회원 아이디</th>
              <th class="adminMemberListTh">이름</th>
              <th class="adminMemberListTh">포인트</th>
              <th class="adminMemberListTh">제재상태</th>
           </tr>
           </thead>
           <tbody id="memberTbody">
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
        </div>
    <br/>
    
    <input type="text" id="searchWord" placeholder="회원 ID 검색" maxlength="20"/>
    <input type="button" id="searchBtn" value="검색" />

    <br/>
   
</body>
<script>
var currentPage = 1;
var filterFlag = false;
var searchFlag = false;


$(document).on('click', 'td', function(event) {
	var memberId = $(this).closest('tr').find('.memberId').html();
	window.location.href = './memberDetail.go?memberId=' + memberId;
	console.log(item.id);
});

$(document).ready(function(){ // html 문서가 모두 읽히면 되면(준비되면) 다음 내용을 실행 해라
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

$('#memberState').on('change',function(){
   $('#pagination').twbsPagination('destroy');
   searchFlag =false;
   callList(currentPage);
});
// 필터 리스트
function callList(currentPage) {
    
    $.ajax({
       type:'POST'
       ,url:'./adminMember.ajax'
       ,data:{
          'currentPage':currentPage
          ,'state':$('#memberState').val()
          ,'searchWord':$('#searchWord').val()
          ,'searchFlag':searchFlag
       }
       ,dataType:'json'
       ,success:function(data){
          console.log(data.list);
          showList(data.list);
          var totalPage = data.totalPage;
          showPagination(totalPage);
          
       }
       ,error:function(error){
          console.log(error);
       }
    });
 }
 

//페이징 아작
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
 
// 테이블
 function showList(list){
		var content = '';
		for(item of list){
			content +=
				'<tr class="adminMemberListTr">'
				+'<td class="adminMemberListTd"></td>'
				+'<td class="adminMemberListTd">'+'<span class = "memberId">'+item.id+'</span></td>'
				+'<td class="adminMemberListTd">'+item.name+'</td>'
				+'<td class="adminMemberListTd">'+item.point+'</td>'
				+'<td class="adminMemberListTd">'+item.state+'</td>'
				+'</tr>';
		}
	$('#memberTbody').html(content);
}

</script>
</html>