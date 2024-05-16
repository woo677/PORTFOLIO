<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="../resources/img/teamLogo/logo.png">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="../resources/css/admin/team_member_update.css">
<style>

</style>
</head>
<body>
    <div class="adminBody">
        <jsp:include page="../header/header_admin.jsp"/>
        <div class="adminContainer">
            <div class="teamUpdate">
                <h1>팀원 모집 게시글 수정</h1>
                <div class="flexBox">
                    <div class="leftBox">
                        <div class="teamLogo">
                            <span class="logoImg"><img src="../resources/img/teamLogo/team_logo01.jpg" alt=""></span>
                            <span class="teamName">${info.team_name}</span>
                        </div>
                        <div class="address">
                            <span class="tit">활동지역</span>
                            <span class="txt">${info.team_address}</span>
                        </div>
                        <div class="requbox">
                            <span>모집내용</span>
                            <textarea name="requInfo" id="requInfo">${info.join_team_content}</textarea>
                        </div>
                        <!-- 레벨 -->
                        <div class="teamLevel">
                            <span class="tit">모집 레벨</span>
                            <select id="level">
                                <%-- <option value="${info.join_team_level}">${info.join_team_level}</option>
                                <option value="브론즈">브론즈</option>
                                <option value="실버">실버</option>
                                <option value="골드">골드</option>
                                <option value="플래티넘">플래티넘</option> --%>
                            </select>
                        </div>
                    </div>
                    <div class="rightBox">
                        <div class="teaminfo">
                            <p class="tit">팀 설명</p>
                            <p class="txt">${info.team_info}</p>
                        </div>
                    </div>
                </div>
                <div class="stateWrap">
                	<c:if test="${info.join_team_state == 'false'}">
                    	<input type="checkbox" name="" id="teamIsDisabled" checked="checked">
                	</c:if>
                	<c:if test="${info.join_team_state == 'true'}">
                    	<input type="checkbox" name="" id="teamIsDisabled"> 
                	</c:if>
                
        			<label for="teamIsDisabled">팀원모집 비활성</label>
                </div>
                <div class="btnWrap">
                    <button id="btnCancle" onclick="callUpdate(1)">취소</button>
                    <button id="btnModify" onclick="callUpdate(2)">수정</button>
                </div>
            </div>
        </div>
    </div>
</body>
<script>

    // 퍼블 영역
    $('.adminHeader menu li').eq(3).addClass('on');

    
    // 개발 영역
    $(document).ready(function(){
    	teamJoinLevel()
    	
    	console.log('${info.join_team_state}');
    });
    
    var join_team_idx = '${info.join_team_idx}';
    var teamIsDisabled = '';
    
    if($('#teamIsDisabled').is(':checked')){
    	teamIsDisabled = 'false';
    }else{
    	teamIsDisabled = 'true';
    }
    
    // level selectBox 그리기
    function teamJoinLevel(){
    	var levelArr = ['브론즈', '실버', '골드', '플래티넘'];
    	var content = '';
    	
    	content += '<option value="' + '${info.join_team_level}' + '">' + '${info.join_team_level}' + '</option>'
    	
    	for(item of levelArr){
			
    		if('${info.join_team_level}' == item){
        		continue;
        	}
    		
    		content += 
    			'<option value="' + item + '">' + item + '</option>'
    		
		}
    	$('#level').html(content);
    }
    
	function callUpdate(num) {
		var chk = '';
		if(num == 1){
			chk = confirm('수정을 취소하시겠습니까?');
			location.href = '../admin/writing_team_list.go';
			
		}else{
			chk = confirm('수정을 완료하시겠습니까?');
			if(chk){
				$.ajax({
					type:'POST'
					,url:'./team_member_update/update.ajax'
					,data:{
						'requInfo':$('#requInfo').val()
						,'level':$('#level').val()
						,'teamIsDisabled':teamIsDisabled
						,'join_team_idx':join_team_idx
					}
					,dataType:'json'
					,success:function(data){
						console.log(data);
						location.href = '../admin/writing_team_list.go';
					}
					,error:function(error){
						console.log(error);
					}
				});
			}
		}
		
		
	}
    
</script>
</html>





























