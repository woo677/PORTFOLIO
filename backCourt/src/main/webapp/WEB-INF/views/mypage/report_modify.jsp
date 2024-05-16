<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>
    <head>
    <meta charset="UTF-8">
    <title>신고글 수정 페이지</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="../resources/css/common/reset.css" type ="text/css">
    <link rel="stylesheet" href="../resources/css/header/header.css" type ="text/css">
    <link rel="stylesheet" href="../resources/css/report_modify/report_modify.css" type ="text/css">
    </head>
    <body>
        <div class="top">
            <h1>
                <a href="#" >
                    <img src="../resources/img/icon/report.png" class="img"/>
                    신고/문의 수정
                </a>
            </h1>
            <br/><br/>
            <form id="report_modify" action="report_modify.do" method="post">
            	<input type="hidden" name="report_idx" value="${report.report_idx}" />
                <label class="title">제목</label>
                <br/>
                <input type="text" id="name" name="report_tit"  class="zz" placeholder=" 제목을 입력해 주세요.(글자수 제한: 30자)" maxlength="30"  value="${report.report_tit}" />
                <br/><br/>
                <label class="title">내용</label>
                <textarea id="message" name="report_content" class="text" placeholder="내용을 입력해 주세요.(글자수 제한: 1000자)" maxlength="1000">${report.report_content}</textarea>
                <br/>
                <div class="but">
                    <input type="button" value="취소" id="cancel" class="submit"/>
            	<c:if test="${report.report_feed!=null}">
					<input type="hidden" value="수정" id="Modify" class="submit" />
				</c:if>
				<c:if test="${report.report_feed==null}">
					<input type="button" value="수정" id="Modify" class="submit" />
				</c:if>
                </div>
            </form>
        </div>
        <div class="bottom">
            <br/>
            <div class="admin">
                <h3 class="admin_title">관리자</h3>
            </div>
            <input type="text" class="admin_text" readonly value="${report.report_feed}"/>
        </div>
    </body>
    <script>
        
    //버튼을 클릭 했을때
    $('input[type="button"]').on('click',function(){
        var Choice = $(this).val();
        var name = $('#name').val();
        var text = $('#message').val();
        if(Choice == "수정"){
            if(name=='' || text==''){
                alert('제목 또는 내용을 입력하세요');
            }else{
                var Modify = confirm('수정 하시겠습니까?');
                if(Modify){
                    $('form').submit();
                }
                // $('form').submit();
                console.log(name);
                console.log(text);
            }
        }
        if(Choice == '취소'){
            console.log(Choice);
            location.href="./report_list.go";
        }
    });
    
    
    </script>
    </html>