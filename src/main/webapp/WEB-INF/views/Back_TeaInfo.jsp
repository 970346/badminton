<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>教师信息管理</title>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <link rel="stylesheet" type="text/css" href="${PATH}/static/admin/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="${PATH}/static/admin/css/footer.css">
</head>
<body>
<%--新增教师信息的模态框--%>
<div class="modal fade" id="AddTeaModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">教师添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="teaid" class="col-sm-2 control-label">教职工号：</label>
                        <div class="col-sm-10">
                            <input type="text" name="teaid" class="form-control" id="teaid" placeholder="请输入教职工号">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="teaname" class="col-sm-2 control-label">姓名：</label>
                        <div class="col-sm-10">
                            <input type="text" name="teaname" class="form-control" id="teaname" placeholder="请输入姓名">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="addtea">添加</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<%--搭建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <h1 align="center">教师信息</h1>
        </div>
    </div>
    <%--查询和导入--%>
    <div class="row" style="margin-top: 1%;font-size: 17px">
        <div class="col-md-5">
            教师信息：<input type="text" class="layui-input" name="teainfo" placeholder="请输入职工号或教师名" id="teainfo">
            <button class="btn btn-primary btn-default" onclick="selecttea()">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
            </button>
        </div>
        <div class="col-md-4">
            <form id="tf" method="post" enctype="multipart/form-data" action="${PATH}/Info/GetTea" onsubmit="return check()">
                导入教师信息:<input type="file" name="file" id="file" style="display: inline;width: 200px"/>
                <input type="submit" value="上传" id="btn" >
            </form>
        </div>
        <div class="col-md-3">
            <button class="btn btn-default" id="Tea_modal">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>添加教师
            </button>
            <button class="btn btn-danger" id="tea_delete_all_btn">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除教师
            </button>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <table class="table table-hover" id="tea_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>职工号</th>
                    <th>姓名</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <%--分页--%>
    <div class="row" style="margin-top: 1%">
        <%--分页信息--%>
        <div class="col-md-6" id="page_info_area"></div>
        <%--分页条--%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
<div id="footer"><span>Copyright@copy2020 feng. All rights reserved.</span></div>
<script type="text/javascript" src="${PATH}/static/admin/js/jquery.js"></script>
<script src="${PATH}/static/admin/bootstrap/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
<script>


    function  check(){
        if ($("#file").val() == 0){
            alert("请选择文件！");
            return false;

        } else
            return true;
    }

    //弹出模态框
    $("#Tea_modal").click(function () {
        $("#AddTeaModal").modal({
            backdrop:"static"
        });
    });
    //校验学号
    var flagtea=false;
    $("#teaid").change(function () {
        $("#teaid").parent().removeClass("has-success has-error");
        var id=this.value;
        var str=/(^20[0-9][0-9]\d{6}$)/;
        if (!str.test(id)){
            $("#teaid").next("span").text("");
            $("#teaid").next("span").text("职工号输入不正确！");
            $("#teaid").parent().addClass("has-error");
        }else {
            $.ajax({
                url:"${PATH}/Info/CheckTea",
                data:"teaid="+id,
                type:"post",
                success:function (result) {
                    if (result.code==100){
                        $("#teaid").next("span").text("");
                        $("#teaid").parent().addClass("has-success");
                        flagtea=true;
                    }else {
                        $("#teaid").next("span").text("");
                        $("#teaid").next("span").text("职工号已存在！");
                        $("#teaid").parent().addClass("has-error");
                    }
                }
            });
        }
    })
    $("#addtea").click(function () {
        if ($("#teaid").val()==""||$("#teaname").val()==""){
            alert("请填写完整的信息！")
        } else if(flagtea==true){
            $.ajax({
                url:"${PATH}/Info/AddTea",
                type:"post",
                data:$("#AddTeaModal form").serialize(),
                success:function (result) {
                    alert("添加成功！");
                    $("#AddStuModal").modal('hide');
                    to_page(totalRecord);
                }
            });
        }
    });
    var totalRecord, currentPage,endPage,partendPage;
    $(function () {
        //默认显示第一页的信息
        to_page(1);
    });
    //模糊查询
    function selecttea() {
        var info = $("#teainfo").val();
        $.ajax({
            url: "${PATH}/Info/GetTeaInfo",
            data: "teainfo="+ info,
            type: "post",
            success: function (result) {}
        });
        to_page(1);
    }
    //查询所有
    function to_page(pn) {
        $.ajax({
            url: "${PATH}/Info/ShowTea",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                //解析并显示教师数据
                build_teas_table(result);
                //解析并显示分页信息
                build_page_info(result);
                //解析并显示分页条数据
                build_page_nav(result);
            }
        });
    }

    //创建表格中的内容
    function build_teas_table(result) {
        $("#tea_table tbody").empty();
        var tea = result.extend.pageInfo.list;
        $.each(tea, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>")
            var IdTd = $("<td></td>").append(item.teaid);
            var NameTd = $("<td></td>").append(item.teaname);
            var delbtn = $("<button></button>").addClass("btn btn-danger btn-default delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            delbtn.attr("del-id", item.teaid);
            $("<tr></tr>").append(checkBoxTd)
                .append(IdTd)
                .append(NameTd)
                .append(delbtn)
                .appendTo("#tea_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + "页，总" +
            result.extend.pageInfo.pages + " 页，总" +
            result.extend.pageInfo.total + " 条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
        endPage=result.extend.pageInfo.pages;
    }

    //解析分页条数据
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var fisrtPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            fisrtPageLi.addClass("disabled");
            prePageLi.addClass("disabled")
        } else {
            fisrtPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled")
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        ul.append(fisrtPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area")
    }

    //完成全选/全不选
    $("#check_all").click(function () {
        $(this).prop("checked");
        $(".check_item").prop("checked", $(this).prop("checked"));
    });
    $(document).on("click", ".check_item", function () {
        var flag = $(".check_item:checked").length == $(".check_item").length
        $("#check_all").prop("checked", flag);
    });

    //单个删除
    $(document).on("click", ".delete_btn", function () {
        //弹出确认删除的对话框
        var teaname = $(this).parents("tr").find("td:eq(2)").text();
        var teaid = $(this).attr("del-id")
        if (confirm("确认删除[" + teaname + "]吗？")) {
            $.ajax({
                url: "${PATH}/Info/DelTea/" + teaid,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //点击全部删除，就批量删除
    $("#tea_delete_all_btn").click(function () {
        var teanames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            teanames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        teanames = teanames.substring(0, teanames.length - 1);
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("确认删除【" + teanames + "】吗")) {
            $.ajax({
                url: "${PATH}/Info/DelTea/" + del_idstr,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
