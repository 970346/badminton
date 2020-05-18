<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录界面</title>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <link rel="stylesheet" href="${PATH}/static/admin/bootstrap/css/bootstrap.css"/>
    <style>
        #footer {
            height: 40px;
            line-height: 40px;
            position: fixed;
            bottom: 0;
            width: 100%;
            text-align: center;
            font-family: Arial;
            font-size: 12px;
            letter-spacing: 1px;
        }
    </style>
</head>
<body>
<%--信息模态框--%>
<div class="modal fade" id="RulesTextModal" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" style="z-index: 1060;margin-top: 200px">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div>
                <h1 align="center">武汉工商学院订场地准则</h1>
            </div>
            <div style="font-size: 18px;padding: 2px 2px 2px 2px;">
                <p>欢迎登录武汉工商学院羽毛球馆预订系统！</p>
                <p>在校师生首次登录的账号为：学号/职工号，密码为：123456。登录成功后请修改您的密码！</p>
                <p>校外人员可通过点击注册跳转至注册页面，注册登录账号！</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<div class="container" style="margin-top: 2%;">
    <div class="row" style="margin-top: 2%;">
        <div class="col-xs-12 col-md-10 col-md-offset-1">
            <h1 align="center" style="font-weight: bolder;">武汉工商学院羽毛球馆</h1>
        </div>
    </div>
    <div class="row"  >
        <div class="col-xs-11 col-xs-offset-1 col-md-8 col-md-offset-2" style="margin-top: 50px;  border:1px solid gainsboro ; border-radius: 30px; box-shadow:5px 5px 5px 5px  gray;">
            <form id="stuinfo" action="${PATH}/Login/SystemAdminPagelogin" class="form-horizontal" method="post" style="margin-top: 10px;height: 40%;">
                <div class="form-group">
                    <h2 align="center">登录界面</h2>
                </div>
                <div class="form-group" style="margin-top: 2%;">
                    <label for="uid" class="col-sm-2 control-label">账号:</label>
                    <div class="col-xs-8 col-md-8">
                        <input type="text" name="uid" class="form-control" id="uid" placeholder="请输入学号">
                        <span class="help-block">&nbsp;${error}</span>
                    </div>
                </div>
                <div class="form-group" style="margin-top: 2%;">
                    <label for="upwd" class="col-sm-2 control-label">密码:</label>
                    <div class="col-xs-8 col-md-8">
                        <input type="password" name="upwd" class="form-control" id="upwd" placeholder="请输入密码">
                        <span class="help-block">&nbsp;${errors}</span>
                    </div>
                </div>
                <div class="form-group" style="margin-top: 2%;">
                    <div class="col-xs-4 col-xs-offset-4 col-md-6 col-md-offset-4">
                        <button type="submit" class="btn btn-default" id="lg">登 录</button>
                        <a href="${PATH}/Pages/ToReg" class="btn btn-default" role="button" style="margin-left: 60px;">注册</a>
                    </div>
                </div>
                <div class="form-group" style="margin-top: 3%;">
                    <div class="col-xs-3 col-xs-offset-4 col-md-4 col-md-offset-4">
                        <a id="readlogin">登录须知</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="${PATH}/Pages/ToChange">忘记密码</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<div id="footer"><span>Copyright@copy2020 feng. All rights reserved.</span></div>
<script type="text/javascript" src="${PATH}/static/admin/js/jquery.js"></script>
<script src="${PATH}/static/admin/bootstrap/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
<script>
    $("#readlogin").click(function () {
        $("#RulesTextModal").modal({
            backdrop: "static"
        });
    });
</script>
</body>
</html>