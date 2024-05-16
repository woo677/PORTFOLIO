<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>제목 입력</title>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">

<style>
.courtWriteTable, .courtWriteTh, .courtWriteTd {
	border: 1px solid black;
	border-collapse: collapse;
}

.courtWriteTh, .courtWriteTd {
	padding: 5px 10px;
}

#courtWriteInfo {
	resize: none;
	width: 500px;
	height: 150px;
}
</style>
</head>
<body>
<div class="adminBody">
	<jsp:include page="../header/header_admin.jsp"/>
	<div class="adminContainer">
		<h1>구장 등록</h1>
		<table class="courtWriteTable">
			<tr>
				<th class="courtWriteTh">구장 이름</th>
				<td class="courtWriteTd">
					<input type="text" id="courtWriteName" />
				</td>
			</tr>
			<tr>
				<th class="courtWriteTh">구장 사진</th>
				<td class="courtWriteTd">
					<input type="file" id="courtImageUpload" multiple>
				</td>
			</tr>
			<tr>
				<th class="courtWriteTh">구장 정보</th>
				<td class="courtWriteTd">
					<textarea id="courtWriteInfo" maxlength="300"></textarea>
				</td>
			</tr>
			<tr>
				<th class="courtWriteTh">구장 가격</th>
				<td class="courtWriteTd">
					<input type="number" id="courtWritePrice" />
				</td>
			</tr>
			<tr>
				<th class="courtWriteTh">구장 위치</th>
				<td class="courtWriteTd">
					<input type="text" id="courtWriteAddress" maxlength="300" />
				</td>
			</tr>
		</table>
		<br/>
		<input type="checkbox" id="courtIsOfficial" />
			<label for="courtIsOfficial">공식 경기 구장</label>
		<input type="checkbox" name="" id="courtIsDisabled">
			<label for="courtIsDisabled">구장 비활성</label>
		<br/>
		<input id="courtRegisterCancel" type="button" value="취소 하기" />
		<input id="courtRegisterSubmit" type="button" value="등록 하기" />
	</div>
</div>
<script>
	$('#courtRegisterSubmit').on('click',function(){
		var formData = new FormData();
		var files = $('#courtImageUpload')[0].files;

        // 파일이 선택되었는지 확인 후 FormData에 추가
        if (files.length > 0) {
            for (var i = 0; i < files.length; i++) {
                formData.append('file', files[i]);
            }
        } else {
            // 파일이 선택되지 않았을 때의 처리
            alert('파일이 선택되지 않았습니다.');
            return;
        }

    	var courtWriteName = $('#courtWriteName').val();
    	var courtWriteInfo = $('#courtWriteInfo').val();
    	var courtWritePrice = $('#courtWritePrice').val();
    	var courtWriteAddress = $('#courtWriteAddress').val();
    	var courtIsOfficial = $('#courtIsOfficial').is(':checked');
    	var courtIsDisabled = !$('#courtIsDisabled').is(':checked');
    	
//     	console.log(courtWriteName);
//     	console.log(courtWriteInfo);
//     	console.log(courtWritePrice);
//     	console.log(courtWriteAddress);
//     	console.log(courtIsOfficial);
//     	console.log(courtIsDisabled);

    	formData.append('courtWriteName', courtWriteName);
        formData.append('courtWriteInfo', courtWriteInfo);
        formData.append('courtWritePrice', courtWritePrice);
        formData.append('courtWriteAddress', courtWriteAddress);
        formData.append('courtIsOfficial', courtIsOfficial);
        formData.append('courtIsDisabled', courtIsDisabled);

        //키 벨류 formdata 에서는 entries써야됨
        for (pair of formData.entries()) {
            console.log(pair[0] + ': ', pair[1]);
        }

    	
    	if(courtWriteName == ''
    		|| courtWriteInfo == ''
        	|| courtWritePrice == ''
        	|| courtWriteAddress == ''
    	){
	        alert('모든 정보를 입력해 주세요');
	        return;
    	}
    	if(confirm('정말 등록 하시겠습니까?')){
        	$.ajax({
        		url:'./courtWrite.ajax'
        		,type:'post'
        		,data:formData
                ,contentType:false
                ,processData:false
                ,success:function(data){
                	if(data.result == true){
						window.location.href = './courtList.go';                		
                	}
                }
                ,error:function(error){

                }
        	});
    	}
    });

    $('#courtRegisterCancel').on('click',function(){
        if(confirm('정말 취소 하시겠습니까?')){
        	alert('취소되었습니다.');
        	window.location.href = "./courtList.go";
        }
    });
    
	$('#courtImageUpload').on('change',function(){
		var files = $(this)[0].files;
		
		if(files.length > 0){
			for(file of files){
// 				console.log(file);
				var fileName = file.name;
				var fileSize = file.size;
				if(fileName.endsWith('.png') == false){
					alert('png 확장자만 업로드 가능합니다.');
					$('#courtImageUpload').val('');
					return;
				}
				if(fileSize > 5242880){// 5mb제한
					alert('5mb가 넘습니다.');
					$('#courtImageUpload').val('');
					return;
				}
				
			}
		}
		
	});    
    
</script>
</body>
</html>
