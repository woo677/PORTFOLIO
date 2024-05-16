<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="../resources/css/common/reset.css"  type="text/css">
    <link rel="stylesheet" href="../resources/css/point/point.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/header/header.css">
      <script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
      <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
      <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
    <title>포인트 리스트</title>
<style>
	/* 수정 - 강대훈 */
	.pointContainer .container{
		width: 970px;
	}
</style>
</head>
<body>
	<!-- jsp 붙이는 법 -->
    <jsp:include page="../header/header.jsp"/>
    <div id="style">
        <button id="mon">문의 하기</button>
        <h2 id="title">내 포인트 내역</h2>
        <!-- 수정 - 강대훈 : 상위 div 생성 -->
        <div class="pointContainer">
			<div id="he">
	            <h3 class="poin">포인트 내역</h3>
	            <h3 class="point" ></h3>
	            <button class="state">충전</button>
	            <button class="state">환급</button>
	        </div>
	        <table>
	        	<colgroup>
	                    <col width="25%"/>
	                    <col width="25%"/>
	                    <col width="25%"/>
	                    <col width="25%"/>
	            </colgroup>
	            <thead>
	                <tr class="thead_tr">
	                    <th class="thead_th">ON.</th>
	                    <th class="thead_th">날짜</th>
	                    <th class="thead_th">금액</th>
	                    <th class="thead_th">구분</th>
	                </tr>
	            </thead>
	           	<c:if test="${pont_list.size()<1 }">
	            	<tr><th colspan="4" class="point_if" >포인트 사용 내역이 없습니다.</th></tr>
	            </c:if>
	            <tbody id="list">
	                
	            </tbody>
	            <tr>
	          <!-- 플러그인 사용법 --> 
	             <td colspan="4">
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
</body>
<script>
/* 아작스로 리스트 가져오기 */
var showPage = 1;
var pagePerNum = 5;

/* 리스트 호출 */
listCall(showPage);
allPoint();

/* 아작스로 리스트 만들기 */
	function listCall(page) {
	    $.ajax({
	        type:'post', //method 방식
	        url:'./point.ajax', //컨트롤러에 리퀘스트 주소
	        data:{
	        	'page':page,//몇번부터
	        	cnt : pagePerNum //몇개 보여죠
	        }, //보낼 파라미터 값이 있을때
	        dataType:'JSON', //아작스 타입
	        success:function(data){//리턴된 값을 받는 곳
	           drawList(data.list,data.start); //drawList 라는 이름으로 data에 있는 값을 넣어서 넣어준다.
	           allPoint(data.point);
	            console.log("총페이지수",data); 
	           
	           //플러그인 추가
	            $('#pagination').twbsPagination({
	         	  startPage:1, // 시작 페이지 [1] (너 몇 페이지야)
	         	  totalPages:data.totalPages, // 총 페이지 갯수 (내가 개산 해야함) 
	         	  visiblePages:5, //보여줄 페이지 수 [1][2][3][4][5]
	         	  onPageClick:function(evt,pg){ //페이지 클릭시 실행 함수
	         		  console.log(evt); //이벤트 객체
	         		  console.log(pg); //클릭한 페이지 번호
	         		 showPage = pg;
	        		  listCall(pg);

	         	  }
	            });
	        },
	        error:function(error){ //에허러가 났을 떄
	            console.log(error);
	        }
	    });
	    
	}
	
//내 지갑 사정	
function allPoint(){
	$.ajax({
        type:'post',
        url:'./my_allpoint.ajax',
        data:{},
        dataType:'JSON',
        success:function(data){
        	Point(data.point);
        },
        error:function(error){
            console.log(error);
        }
    });
}
	

//리스트를 출력
function drawList(list,count){
    var con = '';
    var count = count;
    for (lists of list) {
    	count = count+1;
        //console.log(lists);
        con += '<tr>';
        con += '<td>'+count+'</td>';
        var date = new Date(lists.point_date);
        var dateStr = date.toLocaleDateString("ko-KR");
        con += '<td>'+dateStr+'</td>';
        con += '<td>'+lists.point_change+'</td>';
        con += '<td>'+lists.point_state+'</td>';
        con += '<tr>';
    }
    $('#list').html(con);
}


//내 지갑 포인트
function Point(point){
	var point = point;
	var content = '';
	console.log(point);
	if (point == null) {
		content = '<h3 class="poin">0 원</h3>';	
	}else {
		content = '<h3 class="poin">'+point+' 원</h3>';		
	}
	$('.point').html(content);
}





var msg = '${msg}';
if (msg !='') {
	alert(msg);
}

$('button').on('click',function(){
    var butt = $(this).text();
    console.log(butt);
    if(butt=='충전'){
        location.href="point_add.go";
    }
    if(butt=='환급'){
        location.href="point_minus.go";
    }
    if(butt=='문의 하기'){
        location.href="report.go?reportWriteIdx=0&reportWirteType='포인트문의'";
    }
});
</script>
</html>