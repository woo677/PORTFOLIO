<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원 포인트 관리 페이지</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/common/reset.css" type ="text/css">
<link rel="stylesheet" href="../resources/css/header/header.css" type ="text/css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>   
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="../resources/css/admin/member_point.css" type ="text/css">
<style>
</style>
</head>
<body>
    <div class="adminBody">
    	<jsp:include page="../header/header_admin.jsp"/>
     	<div>
     		<h2>포인트 내역</h2>
    
			<div class="pointDiv">
				<table class="pointListTable">
			    	<colgroup>
				        <col width="5%"/>
				        <col width="30%"/>
				        <col width="20%"/>
				        <col width="20%"/>
				        <col width="15%"/>
				        <col width="10%"/>
			    	</colgroup>
				    <thead>
				        <tr>
				            <th class="pointListTh">번호</th>
				            <th class="pointListTh">날짜</th>
				            <th class="pointListTh">포인트</th>
				            <th class="pointListTh">경기</th>
				            <th class="pointListTh">상태</th>
				        </tr>
				    </thead>
			    	<tbody id="pointTbody">
			        
			    	</tbody>
			    	<tfoot>
				        <tr>
				            <td colspan="5">
				                <div class="container">                     
				                    <nav aria-label="Page navigation" style="text-align:center">
				                        <ul class="pagination" id="pagination"></ul>
				                    </nav>               
				                </div>
				            </td>
				        </tr>
				    </tfoot>
				</table>
	
	        </div>
     	</div>
    
		
	</div>
    <br/>
    <!-- 회원 포인트 변경 상태 -->
    <select id="pointState">
        <option value="충전">충전</option>
        <option value="차감">차감</option>
    </select>
    
   	<div class="content">변경 포인트 : </div> 
   	<textarea name="point" class="textarea" id="pointVal" maxlength="7"></textarea>
    <input type="button" id="changeBtn" value="변경" />
    <input type="button" id="back" value="뒤로가기" />
    <br/>
   
</body>
<script>
var currentPage = 1;
var point_list = [];

<c:forEach var="p" items="${p}">
var item = {}; // 객체로 초기화합니다.
item.point_idx = '${p.point_idx}'; // point_idx 속성에 값을 할당합니다.
item.point_date = '${p.point_date}'; // point_date 속성에 값을 할당합니다.
item.point_change = '${p.point_change}'; // point_change 속성에 값을 할당합니다.
item.write_type = '${p.write_type}'; // write_type 속성에 값을 할당합니다.
item.point_state = '${p.point_state}'; // point_state 속성에 값을 할당합니다.
console.log('${p.point_idx}');
console.log('${p.point_date}');
console.log('${p.point_change}');
console.log('${p.write_type}');
console.log('${p.point_state}');
point_list.push(item); // 배열에 객체를 추가합니다.
</c:forEach>

console.log(point_list);
showList(point_list);

//페이지가 준비되면 호출되는 함수
$(document).ready(function() {
    callList(currentPage); // 페이지가 준비되면 첫 번째 페이지의 데이터를 가져옵니다.
});

$('#pagination').twbsPagination('destroy');

//테이블에 데이터를 표시하는 함수
function showList(list){
//		console.log(list);
	var content = '';
	for(item of list){
		console.log(item);
		content +=
			'<tr class="pointListTr">'
            +'<td class="pointListTd">'+item.point_idx+'</td>'
            +'<td class="pointListTd">'+item.point_date+'</td>'
            +'<td class="pointListTd">'+item.point_change+'</td>'
            +'<td class="pointListTd">'+item.write_type+'</td>'
            +'<td class="pointListTd">'+item.point_state+'</td>'
       		+'</tr>';
	}
	$('#pointTbody').html(content);
	
}

var id = '${id}';


function callList(currentPage) {
    $.ajax({
        type: 'POST',
        url: './adminPoint.ajax',
        data: {
            'currentPage': currentPage
        },
        dataType: 'json',
        success: function(data) {
            console.log(data.pointList);
            showList(data.pointList);
            var totalPage = data.totalPage;
            showPagination(totalPage);
        },
        error: function(error) {
            console.log(error);
        }
    });
}

//페이징
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
 
// 포인트 수정 완료 클릭 시
$('#changeBtn').on('click', function() {
    var confirmed = confirm('포인트를 변경 하시겠습니까?');
    if (!confirmed) {
        return; // 취소된 경우 아무런 처리도 하지 않음
    }
 	$.ajax({
 		type: 'POST'
 		, url: './pointUpdate.ajax'
 		, dataType: 'json'
 		, data:{
 			'id':id
 			,'pointVal':$('#pointVal').val()
 			,'pointState':$('#pointState').val()
 		}
 		, success:function(data){
 				alert("포인트 수정이 완료되었습니다.");
 				window.location.href = './memberDetail.go?memberId=' + id;
 		}
 		, error:function(){
 			alert("수정 실패");
 		}
 	});
 	
 });


 // 포인트 수정 취소 시 컨펌창
 $(document).ready(function() {
     $('#back').click(function(event) {
         // 취소 여부 확인
         var confirmed = confirm("포인트 수정을 취소하시겠습니까?");
         if (confirmed) {
             window.history.back();
         } else {
             event.preventDefault();
         }
     });
 });
</script>
</html>