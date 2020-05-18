<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>预定场地</title>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <link rel="stylesheet" type="text/css" href="${PATH}/static/admin/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="${PATH}/static/admin/css/footer.css">
    <style>
        .closecolor{
            color: gray;
        }

    </style>
</head>
<body>
<%--信息模态框--%>
<div class="modal fade" id="RulesTextModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="z-index: 1060;margin-top: 200px">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div>
                <h1 align="center">武汉工商学院订场地准则</h1>
            </div>
            <div style="font-size: 18px;padding: 2px 2px 2px 2px;">
                <p>（一）、欢迎您能够来到武汉工商学院羽毛球馆打球，“爱运动，爱生活！”是我们球馆的主旨，希望您能玩的愉快！</p>
                <p>（二）、一个账号一次只能预订一片场地，最少预订一小时，最多预订时间同该场地的开放时间。</p>
                <p>（三）、一片场地最多只能租两把球拍，一把球拍5元一次，直到预订的场地时间结束。时间截止需将球拍返回给管理员。如有损坏则<span style="color: red">原价赔偿！</span></p>
                <p>（四）、一片场地最多只能购买五个羽毛球，羽毛球6元一个。</p>
                <p>（五）、请您在球场上挥洒汗水之前，<span style="color: red">妥善保护好个人的随身财物，谨防小偷，如有丢失，如有丢失概不负责！</span></p>
                <p>（六）、请您在运动完后随身带走自己的垃圾，维护场馆卫生人人有责！</p>
                <p>（七）、友谊第一，比赛第二，希望您能够维护球场秩序，健康运动！衷心祝愿您运动愉快！！！</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<%--确认订单模态框--%>
<div class="modal fade" id="OrderStateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"  style="z-index: 1060;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">确认订单</h4>
                </div>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">场地号：</label>
                        <div class="col-sm-7">
                            <p class="form-control-static" id="Order_Site_name"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">预定时间：</label>
                        <div class="col-sm-7">
                            <p class="form-control-static" id="Order_Site_time"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">羽毛球拍：</label>
                        <div class="col-sm-7">
                            <p class="form-control-static" id="Order_Racket"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">购买羽毛球：</label>
                        <div class="col-sm-7">
                            <p class="form-control-static" id="Order_Ball"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">实付总金额：</label>
                        <div class="col-sm-7">
                            <p class="form-control-static" id="Order_Money"></p>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="Order_save_btn">确认预定</button>
            </div>
        </div>
    </div>
</div>
<%--预订场地的模态框--%>
<div class="modal fade" id="SitesStateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">预订场地</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">场地：</label>
                        <div class="col-sm-7">
                            <p class="form-control-static" id="Site_name"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">开放时长：</label>
                        <div class="col-sm-7">
                            <p class="form-control-static" id="Site_tame"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">预订时间：</label>
                        <div class="col-sm-7">
                            <select class="form-control" name="time" id="Site_rime">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">租羽毛球拍：</label>
                        <div class="col-sm-7">
                            <%--羽毛球拍的个数--%>
                            <select class="form-control" name="time" id="Site_racket">
                                <option>0</option>
                                <option>1</option>
                                <option>2</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">购买羽毛球：</label>
                        <div class="col-sm-7">
                            <%--羽毛球的个数--%>
                            <select class="form-control" name="time" id="Site_ball">
                                <option>0</option>
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </div>
                    </div>
                </form>
                <div><input type="checkbox" id="read" /><span>阅读<span style="text-decoration:underline" id="Rules">《武汉工商学院订场地准则》</span></span> </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="state_save_btn">预订</button>
            </div>
        </div>
    </div>
</div>
<%--构建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <h1 align="center">预定场地</h1>
        </div>
    </div>
    <div class="row" style="margin-top: 1%">
        <div class="col-md-12">
            <table class="table table-hover" id="sites_table">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>场地</th>
                    <th>可预订时长</th>
                    <th>营业时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>
<div id="footer"><span>Copyright@copy2020 feng. All rights reserved.</span></div>
</body>
<script type="text/javascript" src="${PATH}/static/admin/js/jquery.js"></script>
<script src="${PATH}/static/admin/bootstrap/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
<script>
    //准侧模态框
    $("#Rules").click(function () {
        $("#RulesTextModal").modal({
            backdrop: "static"
        });
    });

    /*显示页面*/
    $(function () {
        var myDate = new Date;
        var h = myDate.getHours();//获取当前小时数(0-23)
        if (h>=17||h<=9){
            alert("现在无法预订场地！");
            window.location.href="${PATH}/Pages/ToHome";
        } else{
            refresh();
        }
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
            var RestimeTd = $("<td></td>").append(item.toption.interval);
            var editbtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("预定");
            editbtn.attr("edit-id", item.sid);
            var btnTd = $("<td></td>").append(editbtn)
            $("<tr></tr>").append(NumTd)
                .append(NameTd)
                .append(TimeTd)
                .append(RestimeTd)
                .append(btnTd)
                .appendTo("#sites_table tbody");
        });
        for (var i = 0; i < 9; i++) {
            if ($("#sites_table tbody").find("tr").eq(i).find("td").eq("2").text() == 0) {
                $("#sites_table tbody").find("tr").eq(i).addClass("closecolor");
                $("#sites_table tbody").find("tr").eq(i).find("td").eq("4").find("button").eq(0).removeClass("btn-primary");
            }
            else{
                $("#sites_table tbody").find("tr").eq(i).find("td").eq("4").find("button").eq(0).addClass("btn-primary");
                $("#sites_table tbody").find("tr").eq(i).removeClass("closecolor");
            }
        }
    }
    /*预订的模态框*/
    $(document).on("click", ".edit_btn", function () {
        if ($(this).hasClass("btn-primary")){
            getSitesinfo($(this).attr("edit-id"));
            $("#state_save_btn").attr("edit-id", $(this).attr("edit-id"));
            $("#SitesStateModal").modal({
                backdrop: "static"
            });
        }else{
            alert("无法预订！")
        }

    });
    /*获取场地号,能够预订的时区*/
    function getSitesinfo(sid) {
        $.ajax({
            url:"${PATH}/Sites/Getsname/"+sid,
            type:"GET",
            success:function (result) {
                $("#Site_name").text(result.extend.name);
                $("#Site_tame").text(result.extend.time);
                var tlist=result.extend.list;
                $("#Site_rime").empty();
                for(var i=0;i<tlist.length;i++){
                    $("#Site_rime").append("<option value="+tlist[i]+">"+tlist[i]+"</option>");
                }
            }
        });
    }
    /*预订操作*/
    $("#state_save_btn").click(function () {
        if($("#read").is(':checked')){
            var FrontSiteId = $(this).attr("edit-id");
            var FrontSitetime = $("#Site_rime option:selected").val();
            var FrontSiterackets = $("#Site_racket option:selected").val();
            var FrontSiteball = $("#Site_ball option:selected").val();
            $.ajax({
                url:"${PATH}/Sites/GetFrontSitesInfo/"+FrontSiteId,
                type:"post",
                data:{"FrontSitetime":FrontSitetime,"FrontSiterackets":FrontSiterackets,"FrontSiteball":FrontSiteball},
                success:function (result) {
                    $("#Order_Site_name").text(result.extend.sid);
                    $("#Order_Site_time").text(result.extend.data);
                    $("#Order_Racket").text(result.extend.rackets);
                    $("#Order_Ball").text(result.extend.balls);
                    $("#Order_Money").text(result.extend.money);
                    $("#OrderStateModal").modal({
                        backdrop: "static"
                    })
                }
            });
            $("#SitesStateModal").modal('hide');
        }else
        {
            alert("请仔细阅读并勾选《武汉工商学院订场地准则》");
        }
    });
    /*确认预定*/
    $("#Order_save_btn").click(function () {
        var sid=$("#Order_Site_name").text();
        var time=$("#Order_Site_time").text();
        var racket=$("#Order_Racket").text();
        var ball=$("#Order_Ball").text();
        var money=$("#Order_Money").text();
        $.ajax({
            url:"${PATH}/Sites/UpdateSitesInfo",
            type:"get",
            data:{"sid":sid,"time":time,"racket":racket,"ball":ball,"money":money},
            success:function (result) {
                if (result.code==100){
                    alert("预定成功 !")
                    $("#OrderStateModal").modal('hide');
                    refresh();
                }else{
                    alert("账号过期！")
                    $("#OrderStateModal").modal('hide');
                    refresh();
                }
            }
        });
    });
</script>
</html>
