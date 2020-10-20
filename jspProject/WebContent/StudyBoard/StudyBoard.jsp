<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.net.URLEncoder"%>
<%@ page import="Moble.*" %>
<%@ page import="java.util.List" %>   

<%
   DAO dao = new DAOImpl();
   String Study_Choice = request.getParameter("Study_Choice");
   String Study_Search = request.getParameter("Study_Search");
   
   System.out.println(Study_Choice);
   System.out.println(Study_Search);
   
   List<StudyBoardVO> list = dao.getListStudyBoard(Study_Choice, Study_Search);
   System.out.println(list.toString());
   Long userid = (Long)(application.getAttribute("userid"));
%>

<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>모블 학습 게시판</title>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <link href="../CSS/StudyBoard.css" rel="stylesheet" type="text/css"/>
      <link href="../CSS/right-menu.css" rel="stylesheet" type="text/css"/>
   </head>

    <body>
        <!-- ****** 네비게이션 바 메뉴 ****** -->
        <div class="wrap">
            <header class="app-header"> <!-- div태그를 써서 작성하여도 되지만 헤더를 이용하여 좀더 세세히 나눔 -->
                <h1 class="brand">
                <a href="../Main/First-web.jsp" target="_self"> 
                    <span class="logo-name">모블</span>
                        <!-- <SPAN>태그 인태그를 사용해서 위드나 헤이드 태그를 사용 DIV와의 차이 /
                        CSS로 모블 글씨의 변화를 주고자 함-->
                </a>
                </h1>
                <ul class="nav">
                    <li class="nav-item">
                        <a class="nav-link" href="../StudyBoard/StudyBoard.jsp" target="_self"> 학습 게시판</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="../FreeBoard/FreeBoard.jsp" target="_self"> 자유 게시판</a> </li>
                    <li class="nav-item">
                        <a class="nav-link nav-right" href="#" id="sowon-link" target="_self"> 소원 수리함</a> </li>
                    <li class="nav-item">
                      <a class="nav-link nav-right" href="../Chat/User_chat.jsp" target="_self"> 채          팅</a> </li>
                </ul>
                <button type="button" class="button is-open rightBtn">
                    <img src="../images/navigation-button.gif" alt="메뉴 열기">
                </button>
             
                
            </header>
            
      <!-- ************ 게시판 내용  ************ -->
      <main class="board-main">
         <!-- ******   타이틀 부분  ****** -->
           <div class="boardtitle">
              <p class="boardfont">모블 학습 게시판</p>
         </div>
         
         <div class="container_board">
            <!-- ****** 게시판 검색 ****** -->
            <form method="post" action="FindFreeBoard.jsp" >
               <div class="inp_text">
                  <!-- 옵션 선택 -->
                  <select class="select_search" name="free_Choice">
                       <option value="free_Title">제 목</option>
                       <option value="User_Name">작성자</option>
                       <option value="free_Date">날 짜(일)</option>
                  </select>
                  
                      <label for="loginId" class="screen_out"></label>
                      <!-- 검색 텍스트 입력-->
                      <input type="text" id="search" name="free_Search" placeholder="Search" >
                      
                      <!-- 검색 버튼 선택 -->
                  <input type="submit" value="검색" id="BtnSearch"/>
               </div>
            </form>
            
            
            <!-- ****** 게시판 컬럼 ****** -->
            <form method="post" name="moveChoice" >
               <table class="table_board"> 
                  <thead>
                     <tr>
                        <th class="tableCulrom1" style="border:1px solid #dddddd">No</th>
                        <th class="tableCulrom2" style="border:1px solid #dddddd">제 목</th>
                        <th class="tableCulrom4" style="border:1px solid #dddddd">내 용</th>
                        <th class="tableCulrom5" style="border:1px solid #dddddd">파일명</th>
                        <th class="tableCulrom1" style="border:1px solid #dddddd">날 짜</th>
                     </tr>
                  </thead>
                  
                  <tbody>
                     <% 
                        int i= 0;
                        for(StudyBoardVO vo : list) {
                     %>
                     
                     
                     <tr>
                              
                        <td class="tableContent1"><%=++i%></td>
                        <td class="tableContent2"><%=vo.getStudyTitle()%></td>
                        <td class="tableContent4"><%=vo.getStudyContent()%></td>
                        <td class="tableContent5">
                           <%=vo.getFile() %>
                           <a href="DownloadStudyBoard.jsp?filename=<%=URLEncoder.encode(vo.getFile(),"utf-8") %>">
                           <img src="../images/file.png" width="30px" height="30px" id = "<%=vo.getFile()%>" name ="filename"></a>
                           </td>
                           <!--  <a href="#" onclick="ViewConet(this, <%=vo.getFile()%>)" class="file-image"></a></td>-->
                        <td class="tableContent5"><%=vo.getReg_date()%></td>
                        
                              <input type="hidden" name="send_file" id="send_file">
                              
                     </tr>   
                     
                           <script>
                              function ViewConet(id, id_value){
                                 document.getElementById('send_file').value = id_value;
                                 document.moveChoice.action="DownloadStudyBoard.jsp";
                                 document.moveChoice.submit();
         
                              }
                           </script>
                     
                                       
                     <%
                        }
                     %>
                  </tbody>
               </table>
               
               <!-- ****** 글 작성 버튼 ****** -->
               <div class="post_button">
                  <input type="button" onClick="MoveSubmit(1)" class="btn-delete" value="글  쓰기" />
               </div>
               
               <!-- ****** 원하는 submit 페이지로 이동 ****** -->
               <script>
                  // 글작성 페이지 이동
                  function MoveSubmit(index){
                     if(index == 1){
                        document.moveChoice.action='WriteStudyBoard.jsp';
                     }
                     document.moveChoice.submit();
                  }
               </script>            
            </form>   
   
            
            <!-- ****** 글 리스트 갯수  ****** -->
            <div class="Num_board">
                  <ul class="ul_board"> 
                   <li class="li_board"><a href="#">[ 1 ]</a></li>
                     <li class="li_board"><a href="#">[ 2 ]</a></li>
                     <li class="li_board"><a href="#">[ 3 ]</a></li>
                  </ul>
            </div>
         </div>
      </main>   
      
      <!-- ****** 하단 부 디자인 ****** -->
      <div class="boxColor">
         <p>""</p>
      
      </div>      
      
      <!-- ****** 우측 메뉴 디자인 ****** -->
      <div class="right-menubar">
      <ul class="logout-list">
        
           <li class="logout-item"><a href="../Login/LoginForm.jsp" class="logout-link">로그아웃</a></li>
        </ul>
        </div>
        <div class="hidden"></div>
        
        <script>
        
        var right_menuBtn = document.querySelector(".rightBtn");
        var right_menuBar = document.querySelector(".right-menubar");
        var i = 1;
        
        right_menuBtn.addEventListener('click', function() {
           
           if(i==0)
            {
               right_menuBar.style.right = "-11rem";
               i=1;
            }
            else{
               right_menuBar.style.right = "0rem";
               i=0;
            }
            console.log(right_menuBar.style.right);


        // if(right_menuBar.style.display!="none"){
        //   right_menuBar.style.display = "none";
        // }
        // else {
        //   right_menuBar.style.display = "block";
        // }
      });
    </script>
    
    
         <script type="text/javascript">
   //999999 = 관리자 / 나머지 = 학생
   //관리자,일반학생 아이디 구분하여 링크걸기
   var user_ID=<%=userid%>;
   var sowon_link = document.querySelector('#sowon-link');

   sowon_link.addEventListener('click', function() {
      if(user_ID==999999){
           sowon_link.setAttribute('href',"../WishBoard/WishBoard.jsp");
           console.log(sowon_link.href);
           
        }
        else{
           sowon_link.setAttribute('href',"../WishBoard/WriteWishBoard.jsp");
        
        }
   });

  </script>
    </body>
</html>