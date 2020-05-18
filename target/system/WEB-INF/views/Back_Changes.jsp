<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <link rel="stylesheet" href="${PATH}/static/admin/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="${PATH}/static/admin/css/footer.css">
    <script type="text/javascript" src="${PATH}/static/admin/js/jquery.js"></script>
</head>
<body>
<div class="container" style="margin-top: 2%;">
    <div class="row" style="margin-top: 2%;">
        <div class="col-xs-12 col-md-10 col-md-offset-1">
            <h1 align="center" style="font-weight: bolder;">武汉工商学院羽毛球馆</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-11 col-xs-offset-1 col-md-8 col-md-offset-2"
             style="margin-top: 50px;  border:1px solid gainsboro ; border-radius: 30px; box-shadow:5px 5px 5px 5px  gray;">
            <form action="${PATH}/Login/fchanges" onsubmit="return check()" class="form-horizontal" method="post" style="margin-top: 10px;text-align: center">
                <div class="form-group">
                    <h2 align="center">修改密码</h2>
                </div>
                <div class="form-group" style="margin-top: 2%;">
                    <label for="uid" class="col-sm-2 control-label">账号:</label>
                    <div class="col-xs-8 col-md-8">
                        <span id="uid" style="margin-left: 0px">${ sessionScope.uid}</span>
                    </div>
                </div>
                <div class="form-group" style="margin-top: 2%;">
                    <label for="upwd" class="col-sm-2 control-label">请输入密码:</label>
                    <div class="col-xs-8 col-md-8">
                        <input type="password" name="upwd" class="form-control" id="upwd"
                               placeholder="请输入密码(至少8-16个字符，至少1个大写字母，1个小写字母和1个数字)"/>
                    </div>
                </div>
                <div class="form-group" style="margin-top: 2%;">
                    <label for="agachuid" class="col-sm-2 control-label">再次输入密码:</label>
                    <div class="col-xs-8 col-md-8">
                        <input type="password" name="upwds" class="form-control" id="agachuid" placeholder="请再次输入密码"/>
                    </div>
                </div>
                <div class="form-group" style="margin-top: 2%;">
                    <div>
                        <button type="submit" class="btn btn-default" id="Changes">修改</button>
                        <button type="reset" class="btn btn-default">重置</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<div id="footer"><span>Copyright@copy2020 feng. All rights reserved.</span></div>
<script>
    //密码输入校验
    var flag=false,pwdflag=false;
    $("#upwd").blur(function () {
        var intpwd = $("#upwd").val();
        var pwd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{8,16}$/;
        if (!pwd.test(intpwd)){
            $("#upwd").val("");
            $("#upwd").attr("placeholder","密码输入有误！(至少8-16个字符，至少1个大写字母，1个小写字母和1个数字)");
            $("#upwd").removeClass("success");
            $("#upwd").addClass("error");
            flag=false;
        } else {
            flag=true;
            $("#upwd").removeClass("check");
            $("#upwd").addClass("success");
        }
    });
    //两次密码输入的校验
    var code = "", rcode = "";
    $("#agachuid").blur(function () {
        code = "", rcode = "";
        code = $("#upwd").val();
        rcode = $("#agachuid").val();
        if (code == rcode) {
            $("#agachuid").removeClass("error");
            $("#agachuid").addClass("success");
            pwdflag = true;
        } else {
            pwdflag = false;
            $("#agachuid").val("");
            $("#agachuid").attr("placeholder","两次输入的密码不一致");
            $("#agachuid").removeClass("success");
            $("#agachuid").addClass("error");
        }
    });
    function check() {
        if (flag==false||pwdflag==false){
            alert("信息输入有误！");
            return false;
        }else
            return true;
    }

</script>
</body>
</html>
