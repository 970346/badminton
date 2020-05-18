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
            <h1 align="center">个人订单</h1>
        </div>
    </div>
        <div class="row" style="margin-top: 1%">
            <div class="col-md-12">
                <table class="table table-hover" id="orders_table">
                    <thead>
                    <tr>
                        <th>订单号</th>
                        <th>场地号</th>
                        <th>订场时长</th>
                        <th>订场时区</th>
                        <th>场地费</th>
                        <th>商品消费</th>
                        <th>总金额</th>
                        <th>日期</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
        <div class="row" style="margin-top: 1%">
            <div class="col-md-6 col-md-offset-3" id="page_nav_area"></div>
        </div>
    </div>
<div id="footer"><span>Copyright@copy2020 feng. All rights reserved.</span></div>
<script>
    $(function () {
        //默认显示第一页的信息
        to_page(1);
    });
    function to_page(pn) {
        $.ajax({
            url: "${PATH}/Orders/PersonalOrders",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                build_orders_table(result);
                build_page_nav(result);
            }
        });
    }
    var flag=false;
    //创建表格中的内容
    function build_orders_table(result) {
        $("#orders_table tbody").empty();
        var stu = result.extend.pagepersonalInfo.list;
        $.each(stu, function (index, item) {
            var OridTd = $("<td></td>").append(item.orid);
            var SidTd = $("<td></td>").append(item.sid);
            var StimeTd = $("<td></td>").append(item.stime);
            var TimentervalTd = $("<td></td>").append(item.timenterval);
            var StpriceTd = $("<td></td>").append(item.stprice);
            var GdpriceTd = $("<td></td>").append(item.gdprice);
            var TlpriceTd = $("<td></td>").append(item.tlprice);
            var DateTd = $("<td></td>").append(item.odata);
            var RefundTd = $("<td></td>").append(item.ostate=="f"?"已退款":"取消订单").addClass("Edit_orders")
            RefundTd.attr("orders-id", item.orid);
            $("<tr></tr>")
                .append(OridTd)
                .append(SidTd)
                .append(StimeTd)
                .append(TimentervalTd)
                .append(StpriceTd)
                .append(GdpriceTd)
                .append(TlpriceTd)
                .append(DateTd)
                .append(RefundTd)
                .appendTo("#orders_table tbody");
        });
        //获取当前时间
        var myDate = new Date();
        var year=myDate.getFullYear();        //获取当前年
        var month=myDate.getMonth()+1;   //获取当前月
        var date=myDate.getDate();            //获取当前日
        var h=myDate.getHours();              //获取当前小时数(0-23)
        var now=year+'-'+month+"-"+date;
        var splitnow = now.split(" ");
        var strings = splitnow[0].split("-");
        if (strings[1]<=9){
            strings[1]=0+strings[1];
        }
        if (strings[2]<=9){
            strings[2]=0+strings[2];
        }
        var nowdate=strings[0]+strings[1]+strings[2];   //获取日期
        for (var i=0;i< result.extend.pagepersonalInfo.size;i++){
            if ($("#orders_table tbody").find("tr").eq(i).find("td").eq("8").text()=="取消订单"){
                var orderstime = $("#orders_table tbody").find("tr").eq(i).find("td").eq("7").text();
                var splitorderstime = orderstime.split(" ");
                var strings1 = splitorderstime[0].split("-");
                var otime=strings1[0]+strings1[1]+strings1[2];  //获取日期
                var strings2 = splitorderstime[1].split(":");
                var ohtime=strings2[0];                         //获取小时
                if (otime!=nowdate){
                    $("#orders_table tbody").find("tr").eq(i).find("td").eq("8").text("已完成");
                }
                if (otime==nowdate&&ohtime<17) {
                    flag=true;
                }else{
                    $("#orders_table tbody").find("tr").eq(i).find("td").eq("8").text("已生效");
                }
            }
        }
    }
    //取消订单操作
    $(document).on("click", ".Edit_orders", function () {
        var id = $(this).attr("orders-id");
        if ($(this).text()=="取消订单"){
            var flag=false;
            var state="f";
            var time=$(this).prev().text();
            var split = time.split(" ");
            var otimes = split[1].split(":");
            if (otimes[0]>=16&&otimes[0]<17){
                if (confirm("取消订单需要交场地费5%的违约金！是否取消订单？")) {
                    flag=true;
                    state="t";
                }
            }else{
               if (confirm("是否取消订单？")){
                   flag=true;
               }
            }
            if (flag){
                $.ajax({
                    url:"${PATH}/Orders/PersonalOrders",
                    data:{"id":id,"state":state},
                    type:"put",
                    success:function (result) {
                        alert("取消成功！");
                        to_page(1);
                    }
                });
            }
        }else {
            alert("无法退款！");
        }
    });
    //解析分页条数据
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var fisrtPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pagepersonalInfo.hasPreviousPage == false) {
            fisrtPageLi.addClass("disabled");
            prePageLi.addClass("disabled")
        } else {
            fisrtPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pagepersonalInfo.pageNum - 1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pagepersonalInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled")
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pagepersonalInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pagepersonalInfo.pages);
            });
        }
        ul.append(fisrtPageLi).append(prePageLi);
        $.each(result.extend.pagepersonalInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pagepersonalInfo.pageNum == item) {
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
