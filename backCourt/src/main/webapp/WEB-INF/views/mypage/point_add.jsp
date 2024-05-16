<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="../resources/css/common/reset.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/poin_add/point_add.css" type="text/css">
    <title>충전</title>
</head>
<body>
	<h1>포인트 충전</h1>
        <form action="point_add.do" method="post">
        <table>
            <tr>
                <th>현재 금액</th>
                <td id="point"></td>
            </tr>
            <tr>
                <th>충전할 금액</th>
                    <td class="td"><input type="text" name="Charging"></td>
                </tr>
            </table>
            <input type="button" name="button" value="충전">
        </form>
        <button>취소</button>
</body>
<script>
$('input[type="button"]').on('click',function(){
    var ch = $('input[name="Charging"]').val();
    var tex = $(this).text();
    var Normalization = /^\d+$/;
    console.log(Normalization.test(ch));
    if(ch!=''){
    	if (Normalization.test(ch)) {
        alert('충전이 완료되었습니다');
            $('form').submit();			
		}else{
			alert('숫자만 입력해 주세요');
		}
        }else{
            alert('충전이 실패 되었습니다.');
        }
});
$('button').on('click',function(){
    //지금 내가 클릭한 버튼의 텍스트를 가져온다
    var tex = $(this).text();
    //input에 있는 값을 가져온다
    console.log(tex);
    if(tex=='취소'){
        location.href="point.go";
    }
});
allPoint();

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

//내 지갑 포인트
function Point(point){
	var point = point;
	var content = '';
	console.log(point);
	if (point == 0) {
		content = '<td id="point">0 원</td>';
	}else {
		content = '<td id="point">'+point+' 원</td>';
	}
	$('#point').html(content);
}

</script>
</html>