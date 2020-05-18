<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>武汉工商学院羽毛球馆</title>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <link rel="stylesheet" type="text/css" href="${PATH}/static/admin/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="${PATH}/static/admin/css/footer.css">
    <link rel="stylesheet" href="${PATH}/static/admin/css/footer.css">
</head>
<body>
<div class="container">
    <%--标题--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <h1 align="center">赛事信息</h1>
        </div>
    </div>
    <%--查询和导入--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-4">
            <form id="tf" method="post" enctype="multipart/form-data">
                导入赛事信息:<input type="file" name="file" id="file" style="display: inline;width: 200px"/>
                <input type="submit" value="上传" id="btn" onclick="uploadtxt()">
            </form>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <table class="table table-hover" id="cpn_table">
                <thead>
                <tr>
                    <th>起始时间</th>
                    <th>结束时间</th>
                    <th>赛事名称</th>
                    <th>赛事级别</th>
                    <th>举办地点</th>
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

    //文件上传
    function uploadtxt() {
        if ($("#file").val() != 0) {
            var form = new FormData(document.getElementById("tf"));
            $.ajax({
                url: "${PATH}/Cpn/InputCpn",
                type: "post",
                data:form,
                processData:false,
                contentType:false,
                success: function (result) {
                    alert(result.msg);
                    to_page(endPage);
                }
            });
        } else {
            alert("请选择文件！");
        }
    }


    var totalRecord, currentPage,endPage;
    $(function () {
        //默认显示第一页的信息
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${PATH}/Cpn/GetCpn",
            data: "Cpnspagepn=" + pn,
            type: "get",
            success: function (result) {
                //解析并显示赛事数据
                build_cpns_table(result);
                //解析并显示分页信息
                build_page_info(result);
                //解析并显示分页条数据
                build_page_nav(result);
            }
        });
    }
    //创建表格中的内容
    function build_cpns_table(result) {
        var i=0;
        $("#cpn_table tbody").empty();
        var Cpn = result.extend.pageInfo.list;
        $.each(Cpn, function (index, item) {
            var StartimeTd = $("<td></td>").text(timestampToTime(item.startime));
            var EndTimeTd = $("<td></td>").text(timestampToTime(item.endtime));
            var NameTd = $("<td></td>").append(item.cpnname);
            var GradeTd = $("<td></td>").append(item.cpngrade);
            var AddressTd = $("<td></td>").append(item.cpnaddress);
            $("<tr></tr>").append(StartimeTd)
                .append(EndTimeTd)
                .append(NameTd)
                .append(GradeTd)
                .append(AddressTd)
                .appendTo("#cpn_table tbody");
        });
    }
    function timestampToTime(timestamp) {
        var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        Y = date.getFullYear() + '-';
        M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        D = date.getDate() + ' ';
        return Y+M+D
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
</script>
</body>
</html>