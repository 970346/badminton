<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生信息管理</title>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <link rel="stylesheet" type="text/css" href="${PATH}/static/admin/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="${PATH}/static/admin/css/footer.css">
</head>
<body>
<%--新增学生信息的模态框--%>
<div class="modal fade" id="AddStuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">学生添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="stuid" class="col-sm-2 control-label">学号：</label>
                        <div class="col-sm-10">
                            <input type="text" name="stuid" class="form-control" id="stuid" placeholder="请输入学号">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="stuname" class="col-sm-2 control-label">姓名：</label>
                        <div class="col-sm-10">
                            <input type="text" name="stuname" class="form-control" id="stuname" placeholder="请输入姓名">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="addstu">添加</button>
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
            <h1 align="center">学生信息</h1>
        </div>
    </div>
    <%--查询和导入--%>
    <div class="row" style="margin-top: 1%;font-size: 17px">
        <div class="col-md-5">
            学生信息：<input type="text" class="layui-input" name="stuinfo" placeholder="请输入学号或姓名" id="stuinfo">
            <button class="btn btn-primary btn-default" onclick="selectstu()">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
            </button>
        </div>
        <div class="col-md-4">
            <form id="tf" method="post" enctype="multipart/form-data" action="${PATH}/Info/GetStu" onsubmit="return check()">
                导入学生信息:<input type="file" name="file" id="file" style="display: inline;width: 200px"/>
                <input type="submit" value="上传" id="btn">
            </form>
        </div>
        <div class="col-md-3">
            <button class="btn btn-default" id="Stu_modal">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>添加学生
            </button>
            <button class="btn btn-danger" id="stu_delete_all_btn">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除学生
            </button>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <table class="table table-hover" id="stu_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>学号</th>
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
</body>
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
    $("#Stu_modal").click(function () {
        $("#AddStuModal").modal({
           backdrop:"static"
        });
    });
    //校验学号
    var flagstu=false;
    $("#stuid").change(function () {
        $("#stuid").parent().removeClass("has-success has-error");
        var id=this.value;
        var str=/(^1[6789]\d{8}$)/;
        if (!str.test(id)){
            $("#stuid").next("span").text("");
            $("#stuid").next("span").text("学号输入不正确！");
            $("#stuid").parent().addClass("has-error");
        }else {
            $.ajax({
                url:"${PATH}/Info/CheckStu",
                data:"stuid="+id,
                type:"post",
                success:function (result) {
                    if (result.code==100){
                        $("#stuid").next("span").text("");
                        $("#stuid").parent().addClass("has-success");
                        flagstu=true;
                    }else {
                        $("#stuid").next("span").text("");
                        $("#stuid").next("span").text("学号已存在！");
                        $("#stuid").parent().addClass("has-error");
                    }
                }
            });
        }
    })
    $("#addstu").click(function () {
        if ($("#stuid").val()==""||$("#stuname").val()==""){
            alert("请填写完整的信息！")
        } else if(flagstu==true){
            $.ajax({
                url:"${PATH}/Info/AddStu",
                type:"post",
                data:$("#AddStuModal form").serialize(),
                success:function (result) {
                    alert("添加成功！");
                    $("#AddTeaModal").modal('hide');
                    to_page(totalRecord);
                }
            });
        }
    });

    var totalRecord, currentPage, endPage,partendPage;
    $(function () {
        //默认显示第一页的信息
        to_page(1);
    });
    //模糊查询
    function selectstu() {
        var info = $("#stuinfo").val();
        $.ajax({
            url: "${PATH}/Info/GetStuInfo",
            data: "stuinfo="+ info,
            type: "post",
            success: function (result) {}
        });
        to_page(1);
    }
    //查询所有
    function to_page(pn) {
        $.ajax({
            url: "${PATH}/Info/ShowStu",
            data: "pn="+ pn,
            type: "get",
            success: function (result) {
                //解析并显示学生数据
                build_stus_table(result);
                //解析并显示分页信息
                build_page_info(result);
                //解析并显示分页条数据
                build_page_nav(result);
            }
        });
    }
    //创建表格中的内容
    function build_stus_table(result) {
        $("#stu_table tbody").empty();
        var stu = result.extend.pageInfo.list;
        $.each(stu, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>")
            var IdTd = $("<td></td>").append(item.stuid);
            var NameTd = $("<td></td>").append(item.stuname);
            var delbtn = $("<button></button>").addClass("btn btn-danger btn-default delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            delbtn.attr("del-id",item.stuid);
            $("<tr></tr>").append(checkBoxTd)
                .append(IdTd)
                .append(NameTd)
                .append(delbtn)
                .appendTo("#stu_table tbody");
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
        endPage = result.extend.pageInfo.pages;
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
    $(document).on("click",".delete_btn",function () {
        //弹出确认删除的对话框
        var stuname=$(this).parents("tr").find("td:eq(2)").text();
        var stuid=$(this).attr("del-id");
        // alert(stuid+stuname)
        if (confirm("确认删除["+stuname+"]吗？")) {
            $.ajax({
                url:"${PATH}/Info/BackMagaDelStu/"+stuid,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //点击全部删除，就批量删除
    $("#stu_delete_all_btn").click(function () {
        var stunames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            stunames += $(this).parents("tr").find("td:eq(2)").text()+ ",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        stunames = stunames.substring(0,stunames.length-1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if (confirm("确认删除【"+stunames+"】吗")) {
            $.ajax({
                url:"${PATH}/Info/BackMagaDelStu/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });
</script>

</html>
