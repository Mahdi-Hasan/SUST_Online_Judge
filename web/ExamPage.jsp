<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% response.setHeader("Cache-Control", "no-cache");
    /*HTTP 1.1*/ response.setHeader("Pragma", "no-cache");
    /*HTTP 1.0*/ response.setDateHeader("Expires", 0);
%> 


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width-device-width, initial-scale=1.0">
        <title>SUST Judge</title>
        <link href="<c:url value="/resources/css/topbar.css" />"
              rel="stylesheet" type="text/css" />

        <link href="<c:url value="/resources/css/bootstrap.min.css" />"
              rel="stylesheet" type="text/css" />
        <link href="<c:url value="/resources/css/bootstrap-theme.min.css" />"
              rel="stylesheet" type="text/css" />
        <link href="<c:url value="/resources/css/jquery.dataTables.min.css" />"
              rel="stylesheet" type="text/css" />
        <link href="<c:url value="/resources/css/dataTables.bootstrap.css" />"
              rel="stylesheet" type="text/css" />
        <link href="<c:url value="/resources/css/thesis-list.css"/>"
              rel="stylesheet" type="text/css" />

        <script
            src="<c:url value="/resources/javascript/jquery-1.11.3.min.js" />"
        type="text/javascript"></script>
        <script src="<c:url value="/resources/javascript/bootstrap.min.js" />"
        type="text/javascript"></script>
        <script
            src="<c:url value="/resources/javascript/jquery.dataTables.min.js" />"
        type="text/javascript"></script>
        <script
            src="<c:url value="/resources/javascript/dataTables.bootstrap.js" />"
        type="text/javascript"></script>
        <%-- <script src="<c:url value="/resources/javascript/tasks.js" />" --%>
        <!-- 	type="text/javascript"></script> -->

    </head>
    <body>


    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="row topbar">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div
                class="
                col-sm-4 col-sm-offset-1
                col-xs-12">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">SUST Judge<sup>alpha</sup></a>
            </div>
            <div
                class="
                col-sm-5 col-sm-offset-1
                col-xs-12">
                <ul class="nav navbar-nav navbar-right">
                    <c:choose>
                        <c:when test="${tracker == 'teacher'}">
                            <li><a>${teacher.getFullName()}</a></li>
                                </c:when>
                                <c:when test="${tracker == 'student'}">
                            <li><a>${student.getRegno()}</a></li>
                                </c:when>
                            </c:choose>

                    <li><a href="sign-in.html">Log out</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row searchbar">
            <div class="col-xs-8">
                <p class="table-headertext">
                    Course Title: <span id="course_code">${courseTitle}</span>
                </p>
            </div>
            <c:choose>
                <c:when test="${course.getIsRunning() eq 1}">
                    <div class="col-xs-2">
                        <c:if test="${tracker == 'teacher'}">

                       <button id="button_add_task" data-toggle="modal" data-target="#myModal1" class="btn btn-success col-xs-12" onClick="goToAddTaskPage()">
                            <i class="glyphicon glyphicon-plus-sign"></i> Add New Exam
                        </button>
                                 </c:if>
                    </div>
                    <div class="col-xs-2">
                        <c:if test="${tracker == 'teacher'}">
                            <button id="button_add_task" class="btn btn-success col-xs-12" onClick="goToAddTaskPage()">
                            <i class="glyphicon glyphicon-plus-sign"></i> Add From Previous
                        </button>
                            </c:if>
                    </div>
                </c:when>
            </c:choose>
            </div>       

            <!--	<div class="clearfix"></div> -->
            <!-- TABLE -->
            <div class="panel">

                <table id="taskTable"
                       class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>						
                            <th class="col-md-1 col-sm-1 col-xs-1">Exam. Id</th>						
                            <th class="col-md-3 col-sm-3 col-xs-3">Title</th>
                            <th class="col-md-2 col-sm-2 col-xs-2">Start Time</th>						
                            <th class="col-md-2 col-sm-2 col-xs-2">Duration(Minutes)</th>
                            <th class="col-md-2 col-sm-2 col-xs-2">Score</th>
                            <th class="col-md-2 col-sm-2 col-xs-2">Actions</th>
                            <th class="col-md-2 col-sm-2 col-xs-2">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${exams}" var="exams">


                            <tr>
                                <td><c:out value="${exams.getExamCount()}" /></td>
                                <td>
                                    <c:if test="${tracker=='student'}">
                                        <c:set var="idNo"  value="${exams.getExamId()}"/>
                                        <button style="border: none;cursor: pointer" data-toggle="modal"  class="btn" data-id=${exams.getExamId()}>
                                            <c:out value="${exams.getTitle()}" />
                                                
                                            
                                        </button>
                                    </c:if>
                                    <c:if test="${tracker=='teacher'}">
                                    <a
                                        href="${pageContext.request.contextPath}/QuestionPage?examId=${exams.getExamId()}">
                                        <c:out value="${exams.getTitle()}" />
                                    </a>
                                    </c:if>
                                
                                </td>					
                                <td><c:out value="${exams.getStartTime()}" /></td>
                                <td><c:out value="${exams.getDuration()}" /></td>
                                <td><c:out value="${exams.getScore()}" /></td>
                                <c:choose>
                                    <c:when test="${exams.getStatus() eq 'upcoming'}">
                                        <td><a href="${pageContext.request.contextPath}/EditExamPage?action=0&examId=${exams.getExamId()}" class="btn btn-info btn-sm removebutton" title="Remove"><i
                                                    class="glyphicon glyphicon-remove "></i></a>
                                            <a href="${pageContext.request.contextPath}/EditExamPage?action=1&examId=${exams.getExamId()}" class="btn btn-info btn-sm editbutton" id="editbtn" title="Edit Exam"><i
                                                    class="glyphicon glyphicon-edit "></i></a>
                                        </td>
                                    </c:when>
                                    <c:when test="${exams.getStatus() eq 'ongoing'}">
                                        <td>
                                            <a href="${pageContext.request.contextPath}/EditExamPage?action=1&examId=${exams.getExamId()}" class="btn btn-info btn-sm editbutton" title="Edit Exam"><i
                                                    class="glyphicon glyphicon-edit "></i></a>
                                        </td>
                                    </c:when>    
                                    <c:otherwise>
                                        <td>
                                            Not Allowed
                                        </td>
                                    </c:otherwise>
                                </c:choose>

                                <td><c:out value="${exams.getStatus()}" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
           

            <!-- Modal delete -->
            <a href="${pageContext.request.contextPath}/courseback">Previous Page</a>
        </div>
        <!-- body container -->
        <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Add New Exam</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" action="AddNewExam" method="get">
                  <div class="form-group">
                    <label  class="col-sm-2 control-label">Exam Title</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="title" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" name="password" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label">Start Time</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="startTime" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label">Duration</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="duration" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label">Score</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="score" />
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-default">Add</button>
                    </div>
                  </div>
                </form>
                </div>
            </div>
        </div>
    </div>
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Edit Exam</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" action="AddNewExam" method="get">
                  <div class="form-group">
                    <label  class="col-sm-2 control-label">Exam Title</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="title" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" name="password" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label">Start Time</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="startTime" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label">Duration</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="duration" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label">Score</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="score" />
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <input type="hidden" id="exId"></input>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-default">Add</button>
                    </div>
                  </div>
                </form>
                </div>
            </div>
        </div>
    </div>
    </body>

    <script>
        //alert("alert");
        var id="";
        $(document).ready(function () {
            $('#taskTable').DataTable();
            $(".btn").click(function(){
                var id=$(this).data('id');
                document.getElementById('hid').value=id;
               $('#myModal').modal('show'); 
            });
        });
        
       
    </script>
</html>