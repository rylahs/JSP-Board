<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>

<title>JSP</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collpase-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">미니 교보문고</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collpase-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">공지사항</a></li>
			</ul>
			<%
				if(userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
					
				</li>
			</ul>
			<%
				} else {
			%>
						<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="userUpdate.jsp">회원정보 수정</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
					
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>미니 교보문고</h1>
				<p>이 웹 사이트는 교보문고의 일부 도서를 검색해볼 수 있는 사이트입니다. 최소한의 공지사항과 책 검색 기능을 제공합니다. 디자인 템플릿으로는 부트스트랩을 이용했습니다.</p>
				<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
			</div>
		</div>
	</div>
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
				<li data-target="#myCarousel" data-slide-to="4"></li>
			</ol>
			<div class="carousel-inner" role="listbox" >
		        <div class="item active" style="text-align: center">
		          <img src="images/newbook1.png" alt="First slide" >
		        </div>
		        <div class="item">
		        	<img src="images/newbook2.png" alt="Second slide">
		        </div>
		        <div class="item" >
		        	<img src="images/newbook3.png" alt="Third slide">
		        </div>
		        <div class="item">
		        	<img src="images/newbook4.png" alt="Fourth slide">
		        </div>
		    	<div class="item">
		        	<img src="images/newbook5.png" alt="Fivth slide">
		        </div>
	      	</div>
			
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
<script type="text/javascript">
(function($){
	// 닫기태그 오류 대안
	if( $('#wrap #footer').size() ){
		document.write('</div></div>');
		$('#wrap #footer').remove();
	}
	// 웹접근성: LNB 있는 페이지 본문바로가기
	if( $('#neo_conbody>.content01>.bookList01').size() ) { // eBook
		$('#neo_conbody>.content01>.bookList01').attr('id','main_content');
		$('#skip_to_content a').eq(0).attr('href','#main_content');
	} else if( $('#neo_conbody>.content-guide>.guide').size() ) { // eBook 이용안내
		$('#neo_conbody>.content-guide>.guide').attr('id','main_content');
		$('#skip_to_content a').eq(0).attr('href','#main_content');
	}
	if( $('#body>#container').size() ) // 음반/DVD 메인
		$('#skip_to_content a').eq(0).attr('href','#container');
	if( $('#body>#container>#music').size() ) // 음반 목록
		$('#skip_to_content a').eq(0).attr('href','#music');
	if( $('#body>#container>#dvd').size() ) // DVD 목록
		$('#skip_to_content a').eq(0).attr('href','#dvd');
	if( $('body.bookcast #container').size() ) // 북캐스트
		$('#skip_to_content a').eq(0).attr('href','#container');
})(jQuery);

</script>

<style type="text/css">
html{background:none !important;}
#footer{margin-top:70px;background:#f5f5f5 url('http://image.kyobobook.co.kr/ink/images/common/bg_footer3.gif') 0 0 repeat-x;*position:relative;}
#footer .footer_con{width:950px;margin:0 auto;padding:0 30px 30px;background:url('http://image.kyobobook.co.kr/ink/images/common/bg_footer3.gif') 0 0
repeat-x;color:#666;*zoom:1;}
#footer .footer_con:after{content:'';display:block;clear:both;}

#footer .footer_con .logo_area{clear:both;padding-top:21px;}
#footer .footer_con .shortcut_list {float:right;width:150px;height:44px;}
#footer .footer_con .shortcut_list .btn_open {padding-top:15px;padding-bottom:13px;border:1px solid #6d6d6d;background:#6d6d6d url('http://image.kyobobook.co.kr/ink/images/common/arr_shortcut2.png') no-repeat right 0;color:#fff;font-weight:bold;padding-right:27px;text-align:center;text-transform:uppercase;}
#footer .footer_con .shortcut_list ul {bottom:43px;}
#footer .footer_con .shortcut_open .btn_open {background-position:right -44px;}
#footer .footer_con .member_area{list-style:none;}
#footer .footer_con .member_area{float:left;height:44px;width:800px;background-color:#8b8b8b;line-height:15px;}
#footer .footer_con .member_area li{float:left;padding:16px 14px 0 15px;height:28px;text-align:center;background:url('http://image.kyobobook.co.kr/ink/images/common/line_footer.gif') no-repeat left center;}
#footer .footer_con .member_area li:first-child {background-image:none;padding-left:14px;}
#footer .footer_con .member_area a {text-decoration:none;color:#f1f0f0;}
#footer .footer_con .member_area a:hover {text-decoration:underline;color:#fff;}
#footer .footer_con .member_area strong {color:#fff;text-decoration:underline;}
#footer .footer_con .click_footer{float:left;width:460px;margin:18px 0 0 0;}
#footer .footer_con .click_footer address{font-size:11px;line-height:18px;}
#footer .footer_con .click_footer address a{text-decoration:underline;color:#666;}
#footer .footer_con .click_footer address a:hover {text-decoration:underline;color:#3c5fe1;}
#footer .footer_con .click_footer address .copy {margin-top:10px;}
#footer .footer_con .lg_area{float:right;width:460px;font-size:11px;line-height:18px;margin:18px 0 0 20px;}
#footer .footer_con .lg_area p {font-size:11px;line-height:18px;color:#666;}
#footer .footer_con .lg_area a:link {text-decoration:underline;color:#666;}
#footer .footer_con .lg_area a:hover {text-decoration:underline;color:#3c5fe1;}
#footer .footer_con .mark_isms{float:right;width:460px;margin-top:10px;position:relative;}/* 2020-09-01 */
#footer .footer_con .mark_isms a{display:inline-block;padding:10px 0 0 52px;height:38px;font-size:11px;line-height:15px; /* 2020-12-04 삭제 background:url('http://image.kyobobook.co.kr/ink/images/common/mark_isms.png') no-repeat 0 0;*/}
#footer .footer_con .mark_isms p {position:absolute;left:168px;top:10px;font-size:11px;color:#666666;line-height:1.5;} /* 2020-09-01 */
#footer .footer_con .mark_isms a {background:url('http://image.kyobobook.co.kr/ink/images/common/mark_isms_02.png') no-repeat 0 0;}
#footer .footer_con .click_footer address {float:none;padding-left:0;}
#footer {height:auto;}
</style>
<div id="footer">
	<div class="footer_con">
		<ul class="member_area">
				<li><a href="http://www.kyobobook.co.kr/company/intro.laf?orderClick=rXa&orderClick=1da" onClick="GA_Event('ebook_공통_PC', 'CNT', '회사소개');">회사소개</a></li>
				<li><a href="http://www.kyobobook.co.kr/contents/provision.laf?orderClick=rXc&orderClick=1db" onClick="GA_Event('ebook_공통_PC', 'CNT', '이용약관');">이용약관</a></li>
				<li><a href="http://www.kyobobook.co.kr/contents/privacyPolicy.laf?orderClick=rXd&orderClick=1dc" onClick="GA_Event('ebook_공통_PC', 'CNT', '개인정보처리방침');"><strong>개인정보처리방침</strong></a></li>
				<li><a href="http://www.kyobobook.co.kr/guidePublisher/chargePerson.laf?orderClick=rXf&orderClick=1de" onClick="GA_Event('ebook_공통_PC', 'CNT', '협력사여러분');">협력사여러분</a></li>
				<li><a href="http://www.kyobobook.co.kr/guidePublisher/suggest.laf?orderClick=rXi&orderClick=1dg" onClick="GA_Event('ebook_공통_PC', 'CNT', '제휴&middot;제안');">제휴&middot;제안</a></li>
				<li><a href="http://adcenter.kyobobook.co.kr/?orderClick=rXg&orderClick=1dh" onClick="GA_Event('ebook_공통_PC', 'CNT', '광고센터');">광고센터</a></li>
				<li><a href="https://ehr.kyobobook.co.kr/recr/recruit_system_1.jsp?orderClick=rXb&orderClick=1di" target="_blank" onClick="GA_Event('ebook_공통_PC', 'CNT', '채용정보');">채용정보</a></li>
				<li><a href="http://www.kyobobook.co.kr/contents/sitemap.jsp?orderClick=rXm&orderClick=1dj" onClick="GA_Event('ebook_공통_PC', 'CNT', '서비스 전체보기');">서비스 전체보기</a></li>

		</ul>
	<div class="logo_area">
			<img src="http://image.kyobobook.co.kr/ink/images/common/logo_footer.png" alt="KYOBO 교보문고"/>
		</div>
		<div class="click_footer">
			<address>
				㈜ 교보문고 &nbsp; 서울시 종로구 종로 1 &nbsp; 대표이사 : 안병현<br />
				사업자등록번호 : 102-81-11670<br />
				대표전화 : 1544-1900 (발신자 부담전화)  &nbsp;  팩스 : 0502-987-5711 (지역번호공통)<br />
				서울특별시 통신판매업신고번호 : 제 653호  ▶<a href="https://www.ftc.go.kr/bizCommPop.do?wrkr_no=1028111670&apv_perm_no=&orderClick=1dk" target="_blank" title="새 창 열림">사업자정보확인</a><br />

				<div class="copy">COPYRIGHT(C) <strong>KYOBO BOOK CENTRE</strong> ALL RIGHTS RESERVED.</div>
			</address>
		</div>

	</div>
</div>
</body>
</html>