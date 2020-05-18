<%--
  Created by IntelliJ IDEA.
  User: feng
  Date: 2020/2/27
  Time: 22:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文件管理</title>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <script type="text/javascript" src="${PATH}/static/admin/js/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="${PATH}/static/admin/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="${PATH}/static/admin/css/footer.css">
</head>
<body>
<%--搭建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <h1 align="center">文件信息</h1>
        </div>
    </div>
    <%--查询和删除--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-4">
            文件名：<input type="text" class="layui-input">
            <button class="btn btn-primary btn-default">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
            </button>
        </div>
        <div class="col-md-2 col-md-offset-4">
            <button class="btn btn-danger" id="stu_delete_all_btn">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除文件
            </button>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <table class="table table-hover" id="files_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>文件名</th>
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
<script>
    var totalRecord, currentPage, endPage;
    $(function () {
        //默认显示第一页的信息
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${PATH}/Files/ShowFiles",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                //解析并显示文件数据
                build_filess_table(result);
                //解析并显示分页信息
                build_page_info(result);
                //解析并显示分页条数据
                build_page_nav(result);
            }
        });
    }

    //创建表格中的内容
    function build_filess_table(result) {
        $("#files_table tbody").empty();
        var stu = result.extend.pageInfo.list;
        $.each(stu, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>")
            var IdTd = $("<td></td>").append(item.fname);
            var delbtn = $("<button></button>").addClass("btn btn-danger btn-default delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            delbtn.attr("del-id",item.stuid);
            $("<tr></tr>").append(checkBoxTd)
                .append(IdTd)
                .append(delbtn)
                .appendTo("#files_table tbody");
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
        var filename=$(this).parents("tr").find("td:eq(1)").text();
        filename=filename.replace(".xlsx","");
        alert(filename);
        if (confirm("确认删除["+filename+"]吗？")) {
            $.ajax({
                url:"${PATH}/Files/DelFiles/"+filename,
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
        var filesname = "";
        $.each($(".check_item:checked"), function () {
            filesname += $(this).parents("tr").find("td:eq(1)").text().replace(".xlsx","-");
        });
        filesname = filesname.substring(0,filesname.length-1);
        if (confirm("确认删除【"+filesname+"】吗")) {
            $.ajax({
                url:"${PATH}/Files/DelFiles/"+filesname,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
