<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="../resources/img/teamLogo/logo.png">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="../resources/css/common/reset.css">
<link rel="stylesheet" href="../resources/css/header/header.css">
<link rel="stylesheet" href="../resources/css/admin/writing_list.css">
<style>

</style>
</head>
<body>
    <div class="adminBody">
        <jsp:include page="../header/header_admin.jsp"/>
        <div class="adminContainer">
            <div class="officialWrap">
                <div class="writingTabMenu">
                    <ul>
                        <li><a href="./writing_official_list.go">공식 경기</a></li>
                        <li><a href="./writing_team_list.go">팀원 모집</a></li>
                        <li><a href="./writing_guest_list.go">게스트 모집</a></li>
                    </ul>
                </div>
                <div class="filterCont">
                    <!-- 지역 -->
                    <select id="address" class="filter">
                        <option value="">전체 지역</option>
                    </select>

                </div>
            
                <div class="table">
                    <table>
                        <colgroup>
                            <col width="10%"/>
                            <col width="20%"/>
                            <col width="50%"/>
                            <col width="10%"/>
                            <col width="10%"/>
                        </colgroup>
                        <thead>
                            <tr>
                                <th></th>
                                <th>로고</th>
                                <th>팀명</th>
                                <th>팀 대표자명</th>
                                <th>글 상태</th>
                            </tr>
                        </thead>
                        <tbody id="list">
                            <!-- <tr>
                                <td class="num">1</td>
                                <td class="logo">
                                    <div>
                                        <img src="../resources/img/teamLogo/team_logo01.jpg" alt="">
                                    </div>
                                </td>
                                <td class="teamNikName">
                                    <a href="#">팀1</a>
                                </td>
                                <td class="reader">admin</td>
                                <td>공개</td>
                            </tr> -->
                            <!-- <tr>
                                <td class="num">1</td>
                                <td class="logo">
                                    <div>
                                        <img src="../resources/img/teamLogo/team_logo01.jpg" alt="">
                                    </div>
                                </td>
                                <td class="teamNikName"><a href="#">팀1</a></td>
                                <td class="reader">admin</td>
                                <td>공개</td>
                            </tr> -->
                        </tbody>
                        <tfoot>
							<tr>
								<td colspan="7">
									<div class="container">
										<nav aria-label="Page navigation" style="text-align: center">
											<ul class="pagination" id="pagination"></ul>
										</nav>
									</div>
								</td>
							</tr>
                        </tfoot>
                    </table>
                </div>
                
			                  
            
                <div class="searchBox">
	                <select id="searchCategory" >
				        <option value="teamName">팀 명</option>
				        <option value="teamLeaderName">팀 대표 명</option>
				    </select> 
                    <input type="text" id="searchWord" placeholder="검색단어입력"
						maxlength="20" />
					<!-- 이거 누르면 아작스 하는걸로 -->
					<input type="button" id="searchBtn" value="검색" />
                </div>
            </div>
        </div>
    </div>
</body>
<script>

    // 퍼블 영역
    $('.adminHeader .menu li').eq(3).addClass('on');
    $('.writingTabMenu ul li').eq(1).addClass('on');
    
    var currentPage = 1;
	var filterFlag = false;
	var searchFlag = false;
	
	$(document).ready(function() {
	    // 페이지 로드 시 callList 호출
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
	
	// 검색 단어 입력 필드에서 Enter 키 눌렀을 때 검색 실행
    $('#searchWord').on('keypress', function(event) {
        if (event.which === 13) { // 13은 Enter 키의 keyCode
            $('#searchBtn').click(); // 검색 버튼 클릭 이벤트 호출
        }
    });


	$('.filter').on('change',function(){
		$('#pagination').twbsPagination('destroy');
		searchFlag = false;
		callList(currentPage);
	});	
	
	function callList(currentPage) {
		$.ajax({
			type:'POST'
			,url:'./writing_team_list/list.ajax'
			,data:{
				'currentPage':currentPage
				,'address':$('#address').val()
				,'searchCategory':$('#searchCategory').val()
				,'searchWord':$('#searchWord').val()
				,'searchFlag':searchFlag
			}
			,dataType:'json'
			,success:function(data){
				console.log(data);
// 				console.log(data.totalPage);
				showList(data.list);
				if(filterFlag == false){
					showFilterList(data.addressList);
					filterFlag = true;
				}
				$('#pagination').twbsPagination({
					startPage:1
					,totalPages:data.totalPage
					,visiblePages:5	
					,onPageClick:function(evt,pg){
						currentPage = pg;
						callList(currentPage);
					}
					
				});
				
			}
			,error:function(error){
				console.log(error);
			}
		});
	}	
	
	function showList(list){
		var content = '';
		var link = '';
		for(item of list){
			link = './team_member_update.go?join_team_idx=' + item.join_team_idx;
			
			content +=
				'<tr>'
            	+'<td class="num">' + item.join_team_idx + '</td>'
            	+'<td class="logo">'
            	+'<div>'
            	+'<img src="/logo/' + item.logo + '.png" alt="">'
            	+'</div>'
            	+'</td>'
            	+'<td class="teamNikName">'
            	+'<a href="' + link + '">' + item.team_name + '</a>'
            	+'</td>'
            	+'<td class="reader">' + item.id + '</td>'
            	+'<td>' + item.join_team_state + '</td>'
            	+'</tr>';
			
		}
		$('#list').html(content);
	}	
	
	function showFilterList(list) {
		var content = '';
		
		content = '<option value="">전체 지역</option>';
		for(item of list){
			content += '<option value="'+item+'">'+item+'</option>';
		}

		$('#address').html(content);
		
	}	

</script>
</html>

























