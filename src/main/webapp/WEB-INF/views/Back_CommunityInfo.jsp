<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>社团信息管理</title>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <script type="text/javascript" src="${PATH}/static/admin/js/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="${PATH}/static/admin/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="${PATH}/static/admin/css/footer.css">
</head>
<body>
<%--新增社团学生信息的模态框--%>
<div class="modal fade" id="AddComStuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">社团学生添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="comname" class="col-sm-2 control-label">社团名：</label>
                        <div class="col-sm-10">
                            <input type="text" name="stuid" class="form-control" id="comname" placeholder="请输入社团名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="stuid" class="col-sm-2 control-label">学号：</label>
                        <div class="col-sm-10">
                            <input type="text" name="stuname" class="form-control" id="stuid" placeholder="请输入学号">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="addcomstu">添加</button>
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
            <h1 align="center">社团信息管理</h1>
        </div>
    </div>
    <%--查询和导入--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-4">
            社团学生信息：<input type="text" class="layui-input" name="cominfo" placeholder="请输入社团名\学号\社团编号" id="cominfo">
            <button class="btn btn-primary btn-default" onclick="selectcom()">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
            </button>
        </div>
        <div class="col-md-5">
            <form id="tf" method="post" enctype="multipart/form-data" action="${PATH}/Info/GetCom" onsubmit="return check()">
                导入社团学生信息:<input type="file" name="file" id="file" style="display: inline;width: 200px"/>
                <input type="submit" value="上传" id="btn">
            </form>
        </div>
        <div class="col-md-3">
            <button class="btn btn-default" id="add_comstu">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>添加社团学生
            </button>
            <button class="btn btn-danger" id="comstu_delete_all_btn">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除社团学生
            </button>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <table class="table table-hover" id="com_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>社团名</th>
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
<div id="footer"><span>Copyright@copy2020 feng. All rights reserved.</span></div>
</body>
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

    var totalRecord, currentPage, endPage, partendPage;
    $(function () {
        //默认显示第一页的信息
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${PATH}/Info/ShowCom",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                //解析并显示社团数据
                build_coms_table(result);
                //解析并显示分页信息
                build_page_info(result);
                //解析并显示分页条数据
                build_page_nav(result);
            }
        });
    }

    //创建表格中的内容
    function build_coms_table(result) {
        $("#com_table tbody").empty();
        var com = result.extend.pageInfo.list;
        $.each(com, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>")
            var ComIdTd = $("<td></td>").append(item.comname);
            var StuIdTd = $("<td></td>").append(item.student.stuid);
            var StuNameTd = $("<td></td>").append(item.student.stuname);
            var delbtn = $("<button></button>").addClass("btn btn-danger btn-default delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            delbtn.attr("del-id", item.student.stuid);
            $("<tr></tr>").append(checkBoxTd)
                .append(ComIdTd)
                .append(StuIdTd)
                .append(StuNameTd)
                .append(delbtn)
                .appendTo("#com_table tbody");
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

    //添加社团学生
    $("#add_comstu").click(function () {
        $("#AddComStuModal").modal({
            backdrop:"static"
        });
    });
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
                        $("#stuid").next("span").text("学号不存在！");
                        $("#stuid").parent().addClass("has-error");
                    }else{
                        $("#stuid").next("span").text("");
                        $("#stuid").parent().addClass("has-success");
                        flagstu=true;
                    }
                }
            });
        }
    })
    $("#addcomstu").click(function () {
        if ($("#comname").val()==""||$("#stuid").val()==""){
            alert("请填写完整信息！");
        }else if(flagstu==true){
            $.ajax({
                url:"${PATH}/Info/AddComStu",
                type:"post",
                data:{"comname":$("#comname").val(),
                      "stuid":$("#stuid").val()},
                success:function (result) {
                    if (result.code==100){
                        alert("添加成功！");
                        $("#AddComStuModal").modal('hide');
                        to_page(totalRecord);
                    }else{
                        alert($("#comname").val()+"社团已存在该学生信息！")
                        $("#AddComStuModal").modal('hide');
                    }
                }
            });
        }
    })

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
        var stuname = $(this).parents("tr").find("td:eq(3)").text();
        var comname = $(this).parents("tr").find("td:eq(1)").text();
        var comid = $(this).attr("del-id")+","+comname;
        if (confirm("确认删除[" + stuname + "]吗？")) {
            $.ajax({
                url: "${PATH}/Info/DelCom/" + comid,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    if(endPage==partendPage){
                        alert(currentPage);
                        to_page(1);
                    }else{
                        to_partpage(1,cominfo);
                    }
                }
            });
        }
    });

    //点击全部删除，就批量删除
    $("#comstu_delete_all_btn").click(function () {
        var stuname = "";
        var del_idstr = "";
        var comname="";
        $.each($(".check_item:checked"), function () {
            $(this).parents("tr").find("td:eq(2)").text();
            stuname += $(this).parents("tr").find("td:eq(3)").text() + ",";
            del_idstr += $(this).parents("tr").find("td:eq(2)").text() + "-";
            comname += $(this).parents("tr").find("td:eq(1)").text() +"=";
        });
        console.log("del_idstr:---->"+del_idstr);
        console.log("comname:---->"+comname);
        del_idstr = del_idstr.substring(0, del_idstr.length - 1)+","+comname.substring(0, comname.length - 1);
        console.log("del_idstr:--->"+del_idstr)
        if (confirm("确认删除[" + stuname + "]吗？")) {
            $.ajax({
                url: "${PATH}/Info/DelCom/" + del_idstr,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    if(endPage==partendPage){
                        to_page(1);
                    }else{
                        to_partpage(1,cominfo);
                    }
                }
            });
        }
    });

    //模糊查询
    var cominfo="";
    function selectcom(){
        cominfo=$("#cominfo").val();
        if (cominfo!=""){
            to_partpage(1,cominfo)
        }else{
            alert("请输入社团或学生的相关信息！");
        }
    }
    function to_partpage(pn,cominfo) {
        $.ajax({
            url:"${PATH}/Info/ShowPartCom/"+pn,
            data:"cominfo="+cominfo,
            type:"get",
            success:function (result) {
                //解析并显示学生数据
                build_coms_table(result);
                //解析并显示分页信息
                build_partpage_info(result);
                //解析并显示分页条数据
                build_partpage_nav(result);
            }
        });
    }
    function build_partpage_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + "页，总" +
            result.extend.pageInfo.pages + " 页，总" +
            result.extend.pageInfo.total + " 条记录");
        currentPage = result.extend.pageInfo.pageNum;
        partendPage = result.extend.pageInfo.total;
    }
    function build_partpage_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var fisrtPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            fisrtPageLi.addClass("disabled");
            prePageLi.addClass("disabled")
        } else {
            fisrtPageLi.click(function () {
                to_partpage(1,cominfo);
            });
            prePageLi.click(function () {
                to_partpage(result.extend.pageInfo.pageNum - 1,cominfo);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled")
        } else {
            nextPageLi.click(function () {
                to_partpage(result.extend.pageInfo.pageNum + 1,cominfo);
            });
            lastPageLi.click(function () {
                to_partpage(result.extend.pageInfo.pages,cominfo);
            });
        }
        ul.append(fisrtPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_partpage(item,cominfo);
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area")
    }
</script>

</html>

