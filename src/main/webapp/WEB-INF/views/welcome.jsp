<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <title>网站后台管理模版</title>
    <link rel="stylesheet" type="text/css" href="${PATH}/static/admin/layui/css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="${PATH}/static/admin/css/admin.css"/>
    <link rel="stylesheet" href="${PATH}/static/admin/css/footer.css">
</head>
<body>
<div class="wrap-container welcome-container">
    <div class="row">
        <div class="welcome-left-container col-lg-12">
            <div class="data-show">
                <ul class="clearfix">
                    <li class="col-sm-12 col-md-4 col-xs-12">
                        <a href="javascript:;" class="clearfix">
                            <div class="icon-bg bg-org f-l">
                                <span class="iconfont">&#xe606;</span>
                            </div>
                            <div class="right-text-con">
                                <p class="name">访问人数</p>
                                <p><span class="color-org" id="accessnum"></span>数据<span class="iconfont">&#xe628;</span></p>
                            </div>
                        </a>
                    </li>
                    <li class="col-sm-12 col-md-4 col-xs-12">
                        <a href="javascript:;" class="clearfix">
                            <div class="icon-bg bg-blue f-l">
                                <span class="iconfont">&#xe602;</span>
                            </div>
                            <div class="right-text-con">
                                <p class="name">订场时长</p>
                                <p><span class="color-blue" id="times"></span>数据<span class="iconfont">&#xe628;</span></p>
                            </div>
                        </a>
                    </li>
                    <li class="col-sm-12 col-md-4 col-xs-12">
                        <a href="javascript:;" class="clearfix">
                            <div class="icon-bg bg-green f-l">
                                <span class="iconfont">&#xe605;</span>
                            </div>
                            <div class="right-text-con">
                                <p class="name">收入</p>
                                <p><span class="color-green" id="income"></span>数据<span class="iconfont">&#xe60f;</span></p>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
            <!--图表-->
            <div class="chart-panel panel panel-default">
                <div class="panel-body" id="chart" style="height: 500px;">
                </div>
            </div>
        </div>
    </div>
</div>
<div id="footer"><span>Copyright@copy2020 feng. All rights reserved.</span></div>
<script src="${PATH}/static/admin/layui/layui.js" type="text/javascript" charset="utf-8"></script>
<script src="${PATH}/static/admin/lib/echarts/echarts.js" type="text/javascript"></script>
<script type="text/javascript" src="${PATH}/static/admin/js/jquery.js"></script>
<script type="text/javascript" src="${PATH}/static/admin/js/module/dialog.js"></script>
<script type="text/javascript">
    layui.use(['layer','jquery'], function(){
        var layer 	= layui.layer;
        var $=layui.jquery;
        //图表
        var myChart;
        require.config({
            paths: {
                echarts: '${PATH}/static/admin/lib/echarts'
            }
        });
        require(
            [
                'echarts',
                'echarts/chart/bar',
                'echarts/chart/line',
                'echarts/chart/map'
            ],
            function (ec) {
                //--- 折柱 ---
                myChart = ec.init(document.getElementById('chart'));
                myChart.setOption(
                    {
                        title: {
                            text: "数据统计",
                            textStyle: {
                                color: "rgb(85, 85, 85)",
                                fontSize: 18,
                                fontStyle: "normal",
                                fontWeight: "normal"
                            }
                        },
                        tooltip: {
                            trigger: "axis"
                        },
                        legend: {
                            data: ["访问人数", "订场时长", "收入"],
                            selectedMode: false,
                        },
                        toolbox: {
                            show: true,
                            feature: {
                                dataView: {
                                    show: false,
                                    readOnly: true
                                },
                                magicType: {
                                    show: false,
                                    type: ["line", "bar", "stack", "tiled"]
                                },
                                restore: {
                                    show: true
                                },
                                saveAsImage: {
                                    show: true
                                },
                                mark: {
                                    show: false
                                }
                            }
                        },
                        calculable: false,
                        xAxis: [
                            {
                                type: "category",
                                boundaryGap: false,
                                // data:["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
                                data:datenum
                            }
                        ],
                        yAxis: [
                            {
                                type: "value"
                            }
                        ],
                        grid: {
                            x2: 30,
                            x: 50
                        },
                        series: [
                            {
                                name: "访问人数",
                                type: "line",
                                smooth: true,
                                itemStyle: {
                                    normal: {
                                        areaStyle: {
                                            type: "default"
                                        }
                                    }
                                },
                                data:incomedata
                            },
                            {
                                name: "订场时长",
                                type: "line",
                                smooth: true,
                                itemStyle: {
                                    normal: {
                                        areaStyle: {
                                            type: "default"
                                        }
                                    }
                                },
                                data:timenum
                            },
                            {
                                name: "收入",
                                type: "line",
                                smooth: true,
                                itemStyle: {
                                    normal: {
                                        areaStyle: {
                                            type: "default"
                                        },
                                        color: "rgb(110, 211, 199)"
                                    }
                                },
                                data:moneynum
                            }
                        ]
                    }
                );
            }
        );
        $(window).resize(function(){
            myChart.resize();
        })
    });
    var datenum=[];
    var incomedata=[];
    var timenum=[];
    var moneynum=[];
    $(function () {
        GetToday();
        setInterval(GetToday,3000);
        GetDays();
        setInterval(GetDays,3000);
    })
    function GetToday() {
        $.ajax({
           url:"${PATH}/Income/SearchNowData",
            type:"get",
            success:function (result) {
                $("#accessnum").text(result.extend.in.lgnum);
                $("#times").text(result.extend.in.stime);
                $("#income").text(result.extend.in.money);
            }
        });
    }
    function GetDays() {
        $.ajax({
            url:"${PATH}/Income/SearchNearlyWeekData",
            type:"get",
            success:function (result) {
                datenum=[getMyDate(result.extend.list[0].datess),
                    getMyDate(result.extend.list[1].datess),
                    getMyDate(result.extend.list[2].datess),
                    getMyDate(result.extend.list[3].datess),
                    getMyDate(result.extend.list[4].datess),
                    getMyDate(result.extend.list[5].datess),
                    getMyDate(result.extend.list[6].datess)];
                incomedata=[result.extend.list[0].lgnum,
                    result.extend.list[1].lgnum,
                    result.extend.list[2].lgnum,
                    result.extend.list[3].lgnum,
                    result.extend.list[4].lgnum,
                    result.extend.list[5].lgnum,
                    result.extend.list[6].lgnum];
                timenum=[result.extend.list[0].stime,
                    result.extend.list[1].stime,
                    result.extend.list[2].stime,
                    result.extend.list[3].stime,
                    result.extend.list[4].stime,
                    result.extend.list[5].stime,
                    result.extend.list[6].stime];
                moneynum=[result.extend.list[0].money,
                    result.extend.list[1].money,
                    result.extend.list[2].money,
                    result.extend.list[3].money,
                    result.extend.list[4].money,
                    result.extend.list[5].money,
                    result.extend.list[6].money];
            }
        });
    }
    //时间戳转为日期
    function getMyDate(str){
        var oDate = new Date(str),
            oYear = oDate.getFullYear(),
            oMonth = oDate.getMonth()+1,
            oDay = oDate.getDate(),
            oTime = oYear +'-'+ getzf(oMonth) +'-'+ getzf(oDay);//最后拼接时间
        return oTime;
    };
    //补0操作
    function getzf(num){
        if(parseInt(num) < 10){
            num = '0'+num;
        }
        return num;
    }
</script>
</body>
</html>
