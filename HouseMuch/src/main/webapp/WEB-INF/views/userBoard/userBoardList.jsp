<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../mainInc/mainTop.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/userBoard/css/boardPaging.css">

<style type="text/css">
.tbStyle{
	background-color: #7db2490d;
}

</style>
<script type="text/javascript">
	$(function(){
		tbStyle();
		
		$('#chkAll').click(function(){
			//만약에 최상단 체크박스가 체크되면
			if($(this).prop("checked")){
				$('input[type="checkbox"]').prop("checked",true); //전체 선택
			}else{ //아니면
				$('input[type="checkbox"]').prop("checked",false); //전체 해제
			}
		});
		
		/* $('#btDel').click(function(){
			var len=$('.suggFrm').find('input[type=checkbox]:checked').length;
			
			if(len==0){
				alert('삭제할 글을 선택하세요.');
				return false;
			}else{
				if(confirm('선택한 글(들)을 삭제하시겠습니까?')){
					$('.suggFrm').prop('action','<c:url value="/userBoard/deleteUserBoardMulti.do?boardFilename=${boardFilename}"/>');
					$('.suggFrm').submit();
				}
			}
		}); */
		
	});

	function btWrite(){
		location.href="<c:url value='/userBoard/userBoardWrite.do'/>";
	}
	
	function pageFunc(curPage){
		$('input[name=currentPage]').val(curPage);
		$('form[name=frmPage]').submit();
	}
	
	function tbStyle(){
		$('.tbBoard tbody tr').mouseover(function(){
			$(this).addClass('tbStyle');
		}).mouseout(function(){
			$(this).removeClass('tbStyle');
		});
	}
</script>

<link
	href="${pageContext.request.contextPath}/resources/userBoard/css/boardStyle.css"
	rel="stylesheet">

<section id="userBoard" class="userBoard">

	<div class="container">
		<br> <br> <br> <br>

		<form action="<c:url value='/userBoard/userBoardList.do'/>"
			name="frmPage" method="post">
			<input type="hidden" name="currentPage"> <input type="hidden"
				name="searchCondition" value="${param.searchCondition }"> <input
				type="hidden" name="searchKeyword" value="${param.searchKeyword }">
		</form>

		<div class="section-title">
			<h2>입주민게시판</h2>
			<p>입주민들 간의 생활 속 이야기를 공유해보세요.</p>
		</div>
		<div class="row">
			<div class="col-12">
				<c:if test="${!empty param.searchKeyword }">
					<p>검색어 : ${param.searchKeyword }, ${pagingInfo.totalRecord }건
						검색되었습니다.</p>
				</c:if>
			</div>
			<!-- <div class="col-2">
				<button type="button" id="btDel" style="float: right;">삭제</button>
			</div> -->
		</div>
		<form class="suggFrm">
			<input type="hidden" name="${boardFilename }" id="boardFilename">
			<table class="tbBoard"
				summary="기본 게시판에 관한 표로써, 번호, 제목, 작성자, 작성일, 조회수에 대한 정보를 제공합니다.">
				<!-- 일반 회원일 경우 -->
				<c:if test="${authMap['AUTH_LEVEL']==1 }">
					<colgroup>
						<col style="width: 10%;" />
						<col style="width: 10%;" />
						<col style="width: 40%;" />
						<col style="width: 15%;" />
						<col style="width: 15%;" />
						<col style="width: 10%;" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">분류</th>
							<th scope="col">제목</th>
							<th scope="col">글쓴이</th>
							<th scope="col">작성일</th>
							<th scope="col">조회</th>
						</tr>
					</thead>
				</c:if>
				<!-- 관리자일 경우 -->
				<c:if test="${authMap['AUTH_LEVEL']!=1 }">
					<colgroup>
						<!-- <col style="width: 5%;" /> -->
						<col style="width: 10%;" />
						<col style="width: 10%;" />
						<col style="width: 40%;" />
						<col style="width: 15%;" />
						<col style="width: 15%;" />
						<col style="width: 10%;" />
					</colgroup>
					<thead>
						<tr>
							<!-- <th scope="col"><input type="checkbox" id="chkAll" /></th> -->
							<th scope="col">번호</th>
							<th scope="col">분류</th>
							<th scope="col">제목</th>
							<th scope="col">글쓴이</th>
							<th scope="col">작성일</th>
							<th scope="col">조회</th>
						</tr>
					</thead>
				</c:if>
				<tbody>
					<!-- DB 없을 때 -->
					<c:if test="${empty userList }">
						<tr>
							<td colspan="6">데이터가 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<!-- DB 있을 때 -->
					<c:if test="${!empty userList }">
						<c:set var="boardFilename" value="0" />
						<!--게시판 내용 반복문 시작  -->
						<c:forEach var="map" items="${userList }">
							<c:set var="boardNo" value="${map['BOARD_NO'] }" />
							<c:set var="boardFilename" value="${map['BOARD_FILENAME'] }" />
							<tr>
								<!-- 관리자일 경우 -->
								<%-- <c:if test="${authMap['AUTH_LEVEL']!=1 }">
									<td><input type="checkbox" name="boardNoArray[]" id="chk" 
										value="${map['BOARD_NO'] }" /></td>
								</c:if> --%>
								<td>${map['BOARD_NO'] }</td>
								<td>${map['BOARD_CTG_NAME'] }</td>
								<td>
									<c:if test="${!empty map['BOARD_FILENAME'] }">
										<img alt="파일이미지" src="<c:url value='/resources/aptUser_images/file.gif'/>">
									</c:if>
									<a href="<c:url value='/userBoard/userBoardDetail.do?boardNo=${boardNo }'/>"
										style="color: black;">
										<!-- 제목이 긴 경우 일부만 보여주기 -->
										<c:if test="${fn:length(map['BOARD_TITLE'])>=25}">
											${fn:substring(map['BOARD_TITLE'],0,25) } ... <span style="color: #7DB249;">[${map['COMM_COUNT'] }]</span>
										</c:if>
										<c:if test="${fn:length(map['BOARD_TITLE'])<25}">
											${map['BOARD_TITLE'] } <span style="color: #7DB249;">[${map['COMM_COUNT'] }]</span>
										</c:if></a>
									</td>
								<td>${map['MEMBER_NAME'] }</td>
								<td><fmt:formatDate value="${map['BOARD_REGDATE'] }"
										pattern="yyyy-MM-dd" /></td>
								<td>${map['BOARD_READCOUNT'] }</td>
							</tr>
						</c:forEach>
						<!--게시판 내용 반복처리 끝  -->
					</c:if>
				</tbody>
			</table>
		</form>
	</div>
	<div class="divPage">
		<!-- 페이지 번호 추가 -->
		<!-- 이전 블럭으로 이동 -->
		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center mt-2">
				<c:if test="${pagingInfo.firstPage>1 }">
					<li class="page-item prev"><a class="page-link" href="#"
						onclick="pageFunc(${pagingInfo.firstPage-1})"></a></li>
				</c:if>

				<!-- [1][2][3][4][5][6][7][8][9][10] -->

				<c:forEach var="i" begin="${pagingInfo.firstPage }"
					end="${pagingInfo.lastPage }">
					<c:if test="${i==pagingInfo.currentPage }">
						<li class="page-item active"><a class="page-link"
							href="javascript:void(0);"> ${i}</a></li>
					</c:if>
					<c:if test="${i!=pagingInfo.currentPage }">
						<li class="page-item"><a href="#" class="page-link"
							onclick="pageFunc(${i})">${i }</a>
					</c:if>
				</c:forEach>
				<!-- 다음 블럭으로 이동 -->
				<c:if test="${pagingInfo.lastPage<pagingInfo.totalPage }">
					<li class="page-item next"><a class="page-link" href="#"
						onclick="pageFunc(${pagingInfo.lastPage+1})"></a></li>
				</c:if>
			</ul>
		</nav>
		<!--  페이지 번호 끝 -->
	</div>
	<div class="formSearch">
		<form class="frmUserBoard" method="post" name="frmUserBoard"
			action='<c:url value="/userBoard/userBoardList.do"/>'>
			<select name="searchCondition">
				<option value="BOARD_TITLE"
					<c:if test="${param.searchCondition=='BOARD_TITLE' }">
            		selected="selected"
            	</c:if>>글제목</option>
				<option value="BOARD_CONTENT"
					<c:if test="${param.searchCondition=='BOARD_CONTENT' }">
            		selected="selected"
            	</c:if>>글내용</option>
				<option value="BOARD_CTG_NAME"
					<c:if test="${param.searchCondition=='BOARD_CTG_NAME' }">
            		selected="selected"
            	</c:if>>분류</option>
				<option value="MEMBER_NAME"
					<c:if test="${param.searchCondition=='MEMBER_NAME' }">
            		selected="selected"
            	</c:if>>글쓴이
				</option>
				<option value="BOARD_FILENAME"
					<c:if test="${param.searchCondition=='BOARD_FILENAME' }">
            		selected="selected"
            	</c:if>>첨부파일명
				</option>
			</select> 
			<input type="text" name="searchKeyword" title="검색어 입력"
				value="${param.searchKeyword }"> 
			<input type="submit" name="btCancel" value="검색">
			<button type="button" onclick="btWrite()">글쓰기</button>
		</form>
	
	</div>
</section>

<div class="clearfix"></div>
<%@ include file="../mainInc/mainBottom.jsp"%>