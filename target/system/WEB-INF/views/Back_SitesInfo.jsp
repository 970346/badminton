<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <title>场馆管理</title>
    <link rel="stylesheet" type="text/css" href="${PATH}/static/admin/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="${PATH}/static/admin/css/footer.css">
    <style>
        .closecolor {
            color: gray;
        }

        .opencolor {
            color: black;
        }
    </style>
</head>
<body>
<%--修改场地信息模态框--%>
<div class="modal fade" id="SitesStateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">场地信息修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">场地：</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="Site_name"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">状态</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="state" id="gender1_add_input" value="t" checked="checked"> 开放
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="state" id="gender2_add_input" value="f"> 关闭
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">营业时间</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="time" id="time">
                                <option>6-7</option>
                                <option>6-8</option>
                                <option>6-9</option>
                                <option>7-8</option>
                                <option>7-9</option>
                                <option>6-7,8-9</option>
                                <option>8-9</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="state_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--搭建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <h1 align="center">场馆信息</h1>
        </div>
    </div>
    <%--开闭馆--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-3">
            <span>是否开馆：</span>
            <label class="radio-inline">
                <input type="radio" name="gender" value="t" id="open" checked="checked">开馆
            </label>
            <label class="radio-inline">
                <input type="radio" name="gender" value="f" id="close">闭馆
            </label>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <table class="table table-hover" id="sites_table">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>场地</th>
                    <th>开放时长</th>
                    <th>营业时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>
<div id="footer"><span>Copyright@copy2020 feng. All rights reserved.</span></div>
<script type="text/javascript" src="${PATH}/static/admin/js/jquery.js"></script>
<script src="${PATH}/static/admin/bootstrap/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
<script>
    /*显示页面*/
    $(function () {
        refresh()
    });

    function refresh() {
        $.ajax({
            url: "${PATH}/Sites/GetSites",
            type: "get",
            success: function (result) {
                //解析并显示场馆信息
                build_sites_table(result);
            }
        });
    }

    function build_sites_table(result) {
        $("#sites_table tbody").empty();
        var sites = result.extend.pageInfo;
        $.each(sites, function (index, item) {
            var NumTd = $("<td></td>").append(item.sid);
            var NameTd = $("<td></td>").append(item.sname);
            var TimeTd = $("<td></td>").append(item.time);
            var InTimeTd = $("<td></td>").append(item.toption.interval);
            var StateTd = $("<td></td>").append(item.state == 't' ? "开放" : "不开放");
            var editbtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("修改");
            editbtn.attr("edit-id", item.sid);
            var btnTd = $("<td></td>").append(editbtn)
            $("<tr></tr>").append(NumTd)
                .append(NameTd)
                .append(TimeTd)
                .append(InTimeTd)
                .append(StateTd)
                .append(btnTd)
                .appendTo("#sites_table tbody");
        });
        var count = 0;
        for (var i = 0; i < 9; i++) {
            if ($("#sites_table tbody").find("tr").eq(i).find("td").eq("4").text() == "不开放") {
                $("#sites_table tbody").find("tr").eq(i).addClass("closecolor");
                count++;
            } else {
                $("#sites_table tbody").find("tr").eq(i).removeClass("closecolor");
                $("#sites_table tbody").find("tr").eq(i).addClass("opencolor");
            }
        }
        if (count == 9) {
            $("#close").prop("checked", true);
        } else {
            $("#close").prop("checked", false);
            $("#open").prop("checked", true);
        }
    }

    /*闭馆操作*/
    $("#close").click(function () {
        if (confirm("今日是否闭馆")) {
            $.ajax({
                url: "${PATH}/Sites/CloseSites",
                success: function () {
                    alert("今日闭馆！");
                    $("#sites_table").addClass("closecolor");
                    refresh();
                }
            });
        } else {
            $("#close").prop("checked", false);
            $("#open").prop("checked", true);
        }
    })
    /*开馆操作*/
    $("#open").click(function () {
        if (confirm("今日是否开馆")) {
            $.ajax({
                url: "${PATH}/Sites/OpenSites",
                success: function () {
                    alert("今日开馆！");
                    $("#sites_table").removeClass("closecolor");
                    refresh();
                }
            });
        } else {
            $("#open").prop("checked", false);
            $("#close").prop("checked", true);
        }
    })
    /*修改状态的模态框*/
    $(document).on("click", ".edit_btn", function () {
        getSitesinfo($(this).attr("edit-id"));
        $("#state_save_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#SitesStateModal").modal({
            backdrop: "static"
        });
    });

    /*获取场地号*/
    function getSitesinfo(backSiteid) {
        $.ajax({
            url: "${PATH}/Sites/Getsname/" + backSiteid,
            type: "GET",
            success: function (result) {
                $("#Site_name").text(result.extend.name);
            }
        });
    }

    /*保存请求*/
    $("#state_save_btn").click(function () {
        var state = $('input:radio[name="state"]:checked').val();
        var time = $("#time option:selected").val();
        $.ajax({
            url: "${PATH}/Sites/UpdateSites/" + $(this).attr("edit-id"),
            type: "put",
            data: {"state": state, "time": time},
            success: function () {
                $("#SitesStateModal").modal('hide');
                refresh()
            }
        });
    });
</script>
</body>
</html>