<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <script type="text/javascript" src="${PATH}/static/admin/js/jquery.js"></script>
    <link rel="stylesheet" href="${PATH}/static/admin/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="${PATH}/static/admin/css/footer.css">
    <script type="text/javascript" src="${PATH}/static/admin/js/yzm.js"></script>
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
            <form class="form-horizontal" style="margin-top: 10px;height: 40%;" method="post" action="${PATH}/Login/reg"
                  onsubmit="return check()">
                <div class="form-group">
                    <h2 align="center">用户注册</h2>
                </div>
                <div class="form-group" style="margin-top: 2%;">
                    <label for="uid" class="col-sm-2 control-label">账号:</label>
                    <div class="col-xs-8 col-md-8">
                        <input type="text" name="uid" class="form-control" id="uid" placeholder="请输入手机号">
                        <span class="help-block">&nbsp;</span>
                    </div>
                </div>
                <div class="form-group" style="margin-top: 2%;">
                    <label for="upwd" class="col-sm-2 control-label">请输入密码:</label>
                    <div class="col-xs-8 col-md-8">
                        <input type="password" name="upwd" class="form-control" id="upwd"
                               placeholder="请输入密码(至少8-16个字符，至少包含1个大写字母，1个小写字母和1个数字)">
                        <span class="help-block">&nbsp;</span>
                    </div>
                </div>
                <div class="form-group" style="margin-top: 2%;">
                    <label for="agachuid" class="col-sm-2 control-label">再次输入密码:</label>
                    <div class="col-xs-8 col-md-8">
                        <input type="password" name="agachuid" class="form-control" id="agachuid" placeholder="请再次输入密码">
                        <span class="help-block">&nbsp;</span>
                    </div>
                </div>
                <div class="form-group" style="margin-top: 2%;">
                    <label for="yzcode" class="col-sm-2 control-label">验证码：</label>
                    <div class="col-xs-6 col-md-6">
                        <input type="text" name="yzcode" id="yzcode" placeholder="请输入验证码" style="width: 100px">&nbsp;&nbsp;&nbsp;<canvas
                            id="canvas" width="100" height="30"></canvas>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-4 col-xs-offset-4 col-md-6 col-md-offset-4">
                        <button type="submit" class="btn btn-default">注册</button>
                        <input type="reset" class="btn"/>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<div id="footer"><span>Copyright@copy2020 feng. All rights reserved.</span></div>
</body>
<script>
    var pwdflag = false, codeflag = false, checkid = false;
    var show_num = [];
    $(function () {
        draw(show_num);
        $("#canvas").on('click', function () {
            draw(show_num);
        });
    });
    //用户校验
    $("#uid").blur(function () {
        var intphone = $("#uid").val();
        var phone = /^1[35789]\d{9}$/;
        if (intphone.length == 11 && phone.test(intphone)) {
            $.ajax({
                url: "${PATH}/Login/checkuser",
                type: "post",
                data: "uid=" + $("#uid").val(),
                success: function (result) {
                    if (result.code == 100) {
                        $("#uid").val();
                        $("#uid").attr("placeholder", "账号已存在！");
                        $("#uid").removeClass("success");
                        $("#uid").addClass("error");
                        $("#uid").val("");
                    } else {
                        $("#uid").removeClass("error");
                        $("#uid").addClass("success");
                        checkid = true;
                    }
                }
            });
        } else {
            $("#uid").val("");
            $("#uid").attr("placeholder", "手机号输入有误!");
            $("#uid").removeClass("success");
            $("#uid").addClass("error");
            checkid = false;
        }
    });
    //密码输入校验
    var flag = false;
    $("#upwd").blur(function () {
        var intpwd = $("#upwd").val();
        var pwd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{8,16}$/;
        if (!pwd.test(intpwd)) {
            $("#upwd").val("");
            $("#upwd").attr("placeholder", "密码输入有误(至少8-16个字符，至少包含1个大写字母，1个小写字母和1个数字)");
            $("#upwd").removeClass("success");
            $("#upwd").addClass("error");
            flag = false;
        } else {
            flag = true;
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
            $("#agachuid").val("");
            $("#agachuid").attr("placeholder", "两次密码输入不一致！");
            pwdflag = false;
            $("#agachuid").addClass("error");

        }
    });
    //验证码的校验
    $("#yzcode").blur(function () {
        var num = show_num.join("");
        var inputnum = $("#yzcode").val().toLowerCase();
        if (num == inputnum) {
            codeflag = true;
            $("#yzcode").removeClass("check");
        } else {
            codeflag = false;
            $("#yzcode").val("");
            $("#yzcode").attr("placeholder", "验证码输入有误！");
            $("#yzcode").removeClass("success")
            $("#yzcode").addClass("check");

        }
    });

    function check() {
        console.log(pwdflag);
        console.log(checkid);
        console.log(codeflag);
        if (pwdflag == true && codeflag == true && checkid == true && flag == true) {
            alert("注册成功！");
            return true;
        } else {
            alert("信息输入有误！");
            return false;
        }
    }
</script>
</html>
