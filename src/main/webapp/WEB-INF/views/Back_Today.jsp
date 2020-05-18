<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>武汉工商学院羽毛球馆</title>
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
            <h1 align="center">今日订场信息</h1>
        </div>
    </div>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-2 col-md-offset-10">
            <button class="btn btn-info" id="torder_output_all_btn" onclick="output()">
                <span class="glyphicon glyphicon-circle-arrow-down" aria-hidden="true"></span>导出订单
            </button>
        </div>
    </div>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <table class="table table-hover" id="torder_table">
                <thead>
                <tr>
                    <th>订单号</th>
                    <th>用户账号</th>
                    <th>场地号</th>
                    <th>订场时长</th>
                    <th>订场时区</th>
                    <th>羽毛球拍</th>
                    <th>羽毛球</th>
                    <th>状态</th>
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
    function output() {
        window.location.href="${PATH}/Orders/save";
    }
    var totalRecord, currentPage, endPage;
    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${PATH}/Orders/SelectToday",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                //解析并显示场地数据
                build_TodaySites_table(result);
                //解析并显示分页信息
                build_page_info(result);
                //解析并显示分页条数据
                build_page_nav(result);
            }
        });
    }

    //创建表格中的内容
    function build_TodaySites_table(result) {
        $("#torder_table tbody").empty();
        var today = result.extend.ABNDOrders.list;
        $.each(today, function (index, item) {
            var OridTd = $("<td></td>").append(item.orid);
            var UiddTd = $("<td></td>").append(item.uid);
            var SidTd = $("<td></td>").append(item.sid);
            var StimeTd = $("<td></td>").append(item.stime);
            var TimentervalTd = $("<td></td>").append(item.timenterval);
            var RacketsTd = $("<td></td>").append(item.rackets);
            var BallsTd = $("<td></td>").append(item.balls);
            var OstateTd = $("<td></td>").append(item.ostate == 't' ? "已生效" : "已退款");
            var delbtn = $("<button></button>").addClass("btn btn-danger btn-default delete_btn tos")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("退款");
            delbtn.attr("del-id", item.orid);
            $("<tr></tr>")
                .append(OridTd)
                .append(UiddTd)
                .append(SidTd)
                .append(StimeTd)
                .append(TimentervalTd)
                .append(RacketsTd)
                .append(BallsTd)
                .append(OstateTd)
                .append(delbtn)
                .appendTo("#torder_table tbody");
        });
        for (var i = 0; i < result.extend.ABNDOrders.size; i++) {
            if ($("#torder_table tbody").find("tr").eq(i).find("td").eq("7").text() == "已退款") {
                // console.log("1")
                $("#torder_table tbody").find("tr").eq(i).find("button").prop("disabled", "false").removeClass("btn-danger");
            }
        }
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.ABNDOrders.pageNum + "页，总" +
            result.extend.ABNDOrders.pages + " 页，总" +
            result.extend.ABNDOrders.total + " 条记录");
        totalRecord = result.extend.ABNDOrders.total;
        currentPage = result.extend.ABNDOrders.pageNum;
        endPage = result.extend.ABNDOrders.pages;
    }

    //解析分页条数据
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var fisrtPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.ABNDOrders.hasPreviousPage == false) {
            fisrtPageLi.addClass("disabled");
            prePageLi.addClass("disabled")
        } else {
            fisrtPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.ABNDOrders.pageNum - 1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.ABNDOrders.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled")
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.ABNDOrders.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.ABNDOrders.pages);
            });
        }
        ul.append(fisrtPageLi).append(prePageLi);
        $.each(result.extend.ABNDOrders.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.ABNDOrders.pageNum == item) {
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

    //退款
    $(document).on("click",".delete_btn",function () {
        //弹出确认退款的对话框
        var orid=$(this).attr("del-id");
        if (confirm("确定需要退款的订单的订单号为："+orid+"吗？")) {
            $.ajax({
                url:"${PATH}/Orders/refund/",
                data:"orid="+orid,
                type:"put",
                success:function (result) {
                    alert(result.msg);
                    to_page(1);
                }
            });
        }
    });
</script>
</body>
</html>
