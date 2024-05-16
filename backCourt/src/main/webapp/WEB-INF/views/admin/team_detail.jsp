<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>제목 입력</title>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet"
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="../resources/js/jquery.twbsPagination.js"
	type="text/javascript"></script>
<link rel="stylesheet" href="../resources/css/header/header.css">

<style>
.imgBox {
	width: 50%; /* 원하는 크기로 조절합니다. */
	max-width: 300px; /* 최대 너비를 설정합니다. */
	margin: 10px auto; /* 가운데 정렬을 위해 margin을 조절합니다. */
}

/* 이미지에 대한 스타일 */
.teamLogo {
	width: 100%; /* 부모 요소의 너비에 맞게 이미지의 크기를 조절합니다. */
	height: auto; /* 가로 세로 비율을 유지하면서 이미지의 크기를 조절합니다. */
}

.leftCont {
	background: lightgray;
	display: flex;
	flex-direction: column;
	align-items: flex-start; /* 왼쪽 정렬 */
}

.teamInfoContainer {
	margin-left: 50%; /* 로고 오른쪽으로 이동 */
	font-size: 15px;
	font-weight: bold;
	margin-top: 10px
}

.buttonContainer {
	margin-top: 10px; /* 버튼과 팀 이름 사이 간격 조절 */
	margin-left: 10px;
}

.leftCont2 {
	background: lightgray;
	flex-direction: column;
	margin-top: 10px;
}

.cont2 {
	margin-left: 10px;
	margin-top: 10px;
}

.leftCont3 {
	background: lightgray;
	flex-direction: column;
	margin-top: 10px;
}

.cont3, .info {
	margin-top: 10px;
	margin-left: 10px;
}

.info {
	resize: none;
	width: 70%;
	height: auto;
}

.rightCont {
	width: 500px;
	border: 2px solid;
	border-collapse: collapse;
	align-items: flex-end; /* 오른쪽 정렬 */
}

.rightContth {
	background-color: gainsboro;
}

.rightContth, .teammateListTd {
	border: 2px solid;
	padding: 10px 30px;
	text-align: center;
}

.teammateListTr:hover {
	background-color: lightgray;
}

.button1{
	padding: 15px 30px;
	border-radius: 20px;
	float: center; /* 수정된 부분: 버튼을 오른쪽으로 이동시킵니다. */
	margin-left: 10px; /* 수정된 부분: 버튼 사이의 간격을 조절합니다. */
	background: gray;
	color: white;
	font-weight: bold;
	font-size:12px;
	
}

.button2{
	padding: 15px 30px;
	border-radius: 20px;
	float: center; /* 수정된 부분: 버튼을 오른쪽으로 이동시킵니다. */
	margin-left: 10px; /* 수정된 부분: 버튼 사이의 간격을 조절합니다. */
	background: blue;
	color: white;
	font-size:12px;
	font-weight: bold;
}

.flexBox{
	display: flex;
    margin-top: 30px;
}

.flexBox .left{
	width: 500px;
}

.flexBox .right{
	margin-left: 50px;
}

.right .container{
	width: 400px !important;
}

.flexBox .right .btnWrap{
	text-align: center;
}


</style>
</head>	
<body>
	<div class="adminBody">
		<jsp:include page="../header/header_admin.jsp" />
		<div class="adminContainer">
			<div class="flexBox">
				<div class="left">
					<div class="leftCont">
						<div class="imgContainer">
							<div class="imgBox" id="imgBox">
								<img class="teamLogo" src="/logo/${teamInfo.logo}.jpg" alt="" />
							</div>
						</div>
						<div class="teamInfoContainer">
							<input type="text" class="teamName" id="teamName" value="${teamInfo.team_name}">
						</div>
						<div class="buttonContainer">
							<button type="button" class="siteLogo">기본 로고로 변경</button>
						</div>
					</div>
					<div class="leftCont2">
						<div class="cont2" id="teamLevel">
							팀 레벨: 
							<select class="select" name="team_level" id="level">
								<option value="브론즈">브론즈</option>
								<option value="실버">실버</option>
								<option value="골드">골드</option>
								<option value="플래티넘">플래티넘</option>
							</select>
						</div>
						<div class="cont2">
							지역: 
							<input type="text" class="address" id="teamAddress" value=""/>
						</div>
					</div>
					<div class="leftCont3">
						<div class=cont3>팀 소개:</div>
						<textarea name="teamInfo" class="info" id="team_info" maxlength="300">${teamInfo.team_info}</textarea>
					</div>
				</div>
				<div class="right">
					<table class="rightCont">
						<thead>
							<tr>
								<th class="rightContth">팀원</th>
								<th class="rightContth">팀장 체크</th>
							</tr>
						</thead>
						<tbody id="teamDetailList"></tbody>
					</table>
					<div class="container">
						<nav aria-label="Page navigation" style="text-align: center">
							<ul class="pagination" id="pagination"></ul>
						</nav>
					</div>
					<div class="btnWrap">
						<input type="button" class="button1" id="cancle" value="취소"/>
						<input type="button" class="button2" id="submit" value="수정"/>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</body>
<script>
		var teammateIdx = '${teamInfo.team_idx}';
		var currentPage = 1;
// 		console.log('${teamInfo.team_idx}');
		console.log('${list[0].teamjang}');
		console.log('${list[0].id}');
		console.log('${totalPage}');
		var teamList1 = []; // JSON 형식으로 데이터를 받아옴
		var totalPage = '${totalPage}';
		var logoFlag = false;	
		$('#teamAddress').val('${teamInfo.team_address}');
		$('#level').val('${teamInfo.team_level}');
		$(document).ready(function() {
	        // 로고 선택 버튼 클릭 시
	        $('.siteLogo').on('click', function() {
	            // 기본 이미지 URL로 변경합니다.
	            logoFlag = true;
	            $('#imgBox').html('<img class="teamLogo" src="/logo/defaultLogo.jpg	" alt="" />');
	        });
	    });
		
		
		<c:forEach var="teamList" items="${list}">
		    var item = {}; // 객체로 초기화합니다.
		    item.id = '${teamList.id}'; // id 속성에 값을 할당합니다.
		    item.teamjang = '${teamList.teamjang}'; // teamjang 속성에 값을 할당합니다.
		    console.log('${teamList.id}');
		    teamList1.push(item); // 배열에 객체를 추가합니다.
		</c:forEach>

	    
		showList(teamList1);
		paging();
// 		document.getElementById("team_info").value = '${teamInfo.team_info}';
		
		$('#cancle').on('click', function(){
			if(confirm('취소하시겠습니까?') == false){
				return;
			}
			window.location.href='./team_list.go';
		});
		
		$('#submit').on('click', function(){
			var teamAddress = $('#teamAddress').val();
			var teamInfo = $('#team_info').val();
			if(confirm('수정하시겠습니까?') == false){
				return;
			}
			console.log($('#level').val());
			console.log(teamAddress);
			console.log(logoFlag);
			console.log(teamInfo);
			$.ajax({
				url:'./teamUpdate.ajax'
				,type:'post'
				,dataType:'json'
				,data:{
					"teamName":$('#teamName').val()
					,"teamLevel":$('#level').val()
					,"teamAddress":$('#teamAddress').val()
					,"teamInfo":teamInfo
					,"logoFlag":logoFlag
					,"teamIdx":teammateIdx
				}
				,success:function(data){
					console.log(data);
					
// 					if(data.result == false){
// 						alert('수정 실패했습니다.');
// 						return ;
// 					}else{
// 						alert('수정 성공');
// // 						window.location.href='./team_list.go';
// 					}
					
				}
				,error:function(error){
					console.log(error);
				}
			});
		});
		
		function callteammateList(currentPage) {
			$.ajax({
				url:'./teammateList.ajax'
				,type:'POST'
				,dataType:'json'
				,data:{
					"currentPage":currentPage
					,"teamIdx":teammateIdx
				}
				,success:function(data){
					console.log(data);
					showList(data.list);
// 					paging();
				}
				,error: function(xhr, status, error) {
					console.error("AJAX request failed:", status, error);
				}
			})

		}

		function paging(){
			$('#pagination').twbsPagination({
				startPage:1
				,totalPages:totalPage
				,visiblePages:5	
				,onPageClick:function(evt,pg){
					currentPage = pg;
					callteammateList(currentPage);
				}
				
			});
		}
		
		function showList(list){
// 			console.log(list);
			var content = '';
			for(item of list){
				console.log(item);
				content +=
					'<tr class="teammateListTr">'
					+'<td class="teammateListTd">'+item.id+'</td>'
					+'<td class="teammateListTd">'+item.teamjang+'</td>'
					+'</tr>';
			}
			$('#teamDetailList').html(content);
			
		}
		
		$('#teammateRegisterCancel').on('click',function(){
			if(confirm('정말 취소 하시겠습니까?')){
				alert('취소되었습니다.');
				window.location.href = "./teammateList.go";
			}
		});
			
		

		
	</script>

</html>
