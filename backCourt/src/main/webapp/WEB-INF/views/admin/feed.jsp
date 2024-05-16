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
    .reportFeedTable,.reportFeedTh,.reportFeedTd {
        border: 1px solid black;
        border-collapse: collapse;
    }
    .reportFeedTh,.reportFeedTd {
        padding: 5px 10px;
    }
    .reportFeedTextarea {
        resize: none;
        width: 500px;
        height: 150px;
    }

    #reportSubject{
        width: 60%;
    }
    .reportFeedSubmit{
        background-color: skyblue;

    }
    #buttonDiv{
        text-align: right;
    }
    </style>
</head>
<body>
<div class="adminBody">
	<jsp:include page="../header/header_admin.jsp"/>
	<div class="adminContainer">
		<h1>신고/문의 상세보기</h1>
		<table class="reportFeedTable">
		    <tr>
		        <th class="reportFeedTh">유형</th>
		        <td class="reportFeedTd">글 유형 : <span id="reportCategory">null</span>&nbsp;| 글 번호: <span id="reportCategoryIdx">null</span></td>
		    </tr>
		    <tr>
		        <th class="reportFeedTh">제목</th>
		        <td class="reportFeedTd"><input type="text" id="reportSubject" readonly></td>
		    </tr>
		    <tr>
		        <th class="reportFeedTh">신고자ID</th>
		        <td id="reportId" class="reportFeedTd">null</td>
		    </tr>
		    <tr>
		        <th class="reportFeedTh">신고날짜</th>
		        <td id="reportDate" class="reportFeedTd">null</td>
		    </tr>
		    <tr>
		    	<th class="reportFeedTh">처리 상태</th>
		    	<td class="reportFeedTd">
		    		<select id="reportState">
		    			<option value="처리 전">처리 전</option>
		    			<option value="처리 중">처리 중</option>
		    			<option value="처리 완료">처리 완료</option>
		    		</select>
		    	</td>
		    </tr>
		
		    <tr>
		        <th class="reportFeedTh">내용</th>
		        <td class="reportFeedTd"><textarea class="reportFeedTextarea" id="reportContent" readonly></textarea></td>
		    </tr>
		    <tr>
		        <th class="reportFeedTh">피드백</th>
		        <td class="reportFeedTd"><textarea class="reportFeedTextarea" id="reportFeed" maxlength="300"></textarea></td>
		    </tr>
		    <tr>
		        <td class="reportFeedTd" colspan="2">
		            <div id="buttonDiv">
		                <input class="reportFeedCancel" type="button" value="취소">
		                <input class="reportFeedSubmit" type="button" value="전송">
		            </div>
		        </td>
		    </tr>
		</table>
	</div>
 </div>
</body>
<script>
	var reportIdx = ${reportIdx};
	$('input[value="전송"]').on('click',function(){
		if(!confirm("정말로 전송 하시겠습니까?")){
			return;
		}
		$.ajax({
			type:'post'
			, url:'./reportUpdate.ajax'
			, data:{
				'reportState':$('#reportState').val()
				,'reportFeed':$('#reportFeed').val()
				,'reportIdx':reportIdx
				,'reportId':$('#reportId').text()
			}
			, dataType:'json'
			, success:function(data){
				if(data.result){
					alert("전송에 성공 했습니다.");
					window.location.href = './reportList.go';
				}else{
					alert("전송에 실패 했습니다.");
				}
			}
			, error:function(data){
				
			}
		});
	});

	$('input[value="취소"]').on('click',function(){
		if(!confirm("정말로 취소 하시겠습니까?")){
			return;
		}
		window.location.href = './reportList.go';
	});
	
    $(document).ready(function(){

        $.ajax({
            type:'post'
            , url:'./reportDetail.ajax'
            , data:{
				"reportIdx":reportIdx
            }
            , dataType:'json'
            , success:function(data){
            	console.log(data);
            	$('#reportCategory').html(data.reportInfo.reportCategory);
            	$('#reportCategoryIdx').html(data.reportInfo.reportCategoryIdx);
            	$('#reportId').html(data.reportInfo.reportId);
            	$('#reportDate').html(data.reportInfo.reportDate);
            	$('#reportState').val(data.reportInfo.reportState);
            	$('#reportSubject').val(data.reportInfo.reportSubject);
            	$('#reportContent').html(data.reportInfo.reportContent);
            	$('#reportFeed').html(data.reportInfo.reportFeed);
				
            }
            , error:function(error){
                
            }
        });
    });
</script>
</html>