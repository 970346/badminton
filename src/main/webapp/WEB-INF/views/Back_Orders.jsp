<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>武汉工商学院羽毛球馆</title>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <link rel="stylesheet" type="text/css" href="${PATH}/static/admin/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="${PATH}/static/admin/css/footer.css">
    <style>
        .liclick{
            color: #00b5f9;
        }
    </style>
</head>
<body>
<%--搭建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <h1 align="center">历史账单</h1>
        </div>
    </div>
    <div class="row" style="margin-top: 1%;font-size: 18px">
        <div class="col-md-6">
            订单信息：<input type="text" class="layui-input" name="ordersinfo" placeholder="请输入订单号/用户账号" id="ordersinfo">
            <button class="btn btn-primary btn-default" onclick="selectorders()">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
            </button>
        </div>
        <div class="col-md-4 col-md-offset-2">
            <span>导出订单：</span>
            <select id="sel">
                <option value="1">一月</option>
                <option value="2">二月</option>
                <option value="3">三月</option>
                <option value="4">四月</option>
                <option value="5">五月</option>
                <option value="6">六月</option>
                <option value="7">七月</option>
                <option value="8">八月</option>
                <option value="9">九月</option>
                <option value="10">十月</option>
                <option value="11">十一月</option>
                <option value="12">十二月</option>
            </select>
            <button class="btn btn-info" id="torder_output_all_btn" onclick="output()">
                <span class="glyphicon glyphicon-circle-arrow-down" aria-hidden="true"></span>导出
            </button>
        </div>
    </div>
    <div class="row" style="margin-top: 1%">
        <ul class="pagination col-md-12" id="Umonth">
            <li class="col-md-1" style="cursor: pointer">一月</li>
            <li class="col-md-1" style="cursor: pointer">二月</li>
            <li class="col-md-1" style="cursor: pointer">三月</li>
            <li class="col-md-1" style="cursor: pointer">四月</li>
            <li class="col-md-1" style="cursor: pointer">五月</li>
            <li class="col-md-1" style="cursor: pointer">六月</li>
            <li class="col-md-1" style="cursor: pointer">七月</li>
            <li class="col-md-1" style="cursor: pointer">八月</li>
            <li class="col-md-1" style="cursor: pointer">九月</li>
            <li class="col-md-1" style="cursor: pointer">十月</li>
            <li class="col-md-1" style="cursor: pointer">十一月</li>
            <li class="col-md-1" style="cursor: pointer">十二月</li>
        </ul>
    </div>
    <%--表格数据--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <table class="table table-hover" id="files_table">
                <thead>
                <tr>
                    <th>订单</th>
                    <th>用户账号</th>
                    <th>场地号</th>
                    <th>订场时长</th>
                    <th>订场时区</th>
                    <th>场地费</th>
                    <th>商品消费</th>
                    <th>总金额</th>
                    <th>日期</th>
                    <th>状态</th>
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
<script type="text/javascript" src="${PATH}/static/admin/js/jquerysession.js"></script>
<script>
    function output() {
        let mon = $("#sel option:selected").val();
        $.ajax({
            url:"${PATH}/Orders/GetMonth",
            data:"month="+mon,
            type:"post",
            success:function () {
                
            }
        });
        window.location.href="${PATH}/Orders/monthsave"
    }
    $("#Umonth li").click(function () {
        var index = $(this).index();
        $("#Umonth li").removeClass("liclick");
        $("#Umonth").find("li").eq(index).addClass("liclick");
        to_page(1,(index+1));
    });

    var totalRecord, currentPage, endPage,month,likeflage=false;
    $(function () {
        //默认显示当前月份的账单
        var myDate = new Date;
        month = myDate.getMonth()+1;
        $("#Umonth li").removeClass("liclick");
        $("#Umonth").find("li").eq(month-1).addClass("liclick");
        to_page(1,month);
    });

    function selectorders() {
        var monthorder = $("#ordersinfo").val();
        if (monthorder == ""){
            likeflage = false;
            var myDate = new Date;
            month = myDate.getMonth()+1;
            $("#Umonth li").removeClass("liclick");
            $("#Umonth").find("li").eq(month-1).addClass("liclick");
            to_page(1,month);
        } else {
            likeflage = true;
            to_page(1,"");
        }
    }
    function to_page(pn,month) {
        var monthorder;
        if (likeflage==null){
            var monthorder = "";
        } else{
            var monthorder = $("#ordersinfo").val();
        }
        $.ajax({
            url: "${PATH}/Orders/ShowFiles",
            data: {"pn":pn,"month":month,"info":monthorder},
            type: "get",
            success: function (result) {
                //解析并显示账单数据
                build_orders_table(result);
                //解析并显示分页信息
                build_page_info(result);
                //解析并显示分页条数据
                build_page_nav(result);
            }
        });
    }

    //创建表格中的内容
    function build_orders_table(result) {
        $("#files_table tbody").empty();
        var order = result.extend.pageInfo.list;
        $.each(order, function (index, item) {
            var OridTd = $("<td></td>").append(item.orid);
            var UiddTd = $("<td></td>").append(item.uid);
            var SidTd = $("<td></td>").append(item.sid);
            var StimeTd = $("<td></td>").append(item.stime);
            var TimentervalTd = $("<td></td>").append(item.timenterval);
            var StpriceTd = $("<td></td>").append(item.stprice);
            var GdpriceTd = $("<td></td>").append(item.gdprice);
            var TlpriceTd = $("<td></td>").append(item.tlprice);
            var OdataTd = $("<td></td>").append(item.odata);
            var OstateTd = $("<td></td>").append(item.ostate=='t'?"已生效":"已退款");
            $("<tr></tr>")
                .append(OridTd)
                .append(UiddTd)
                .append(SidTd)
                .append(StimeTd)
                .append(TimentervalTd)
                .append(StpriceTd)
                .append(GdpriceTd)
                .append(TlpriceTd)
                .append(OdataTd)
                .append(OstateTd)
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
                to_page(1,month);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1,month);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled")
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1,month);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages,month);
            });
        }
        ul.append(fisrtPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item,month);
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
