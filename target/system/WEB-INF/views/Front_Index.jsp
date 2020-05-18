<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>预订场地页面</title>
    <% pageContext.setAttribute("PATH", request.getContextPath());%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="${PATH}/static/admin/bootstrap/css/bootstrap.css" />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <style>
        * {
            padding: 0px;
            margin: 0px;
        }

        img {
            width: 100%;
            height: 400px;
            overflow: auto;
        }

        #footer {
            height: 40px;
            line-height: 40px;
            position: fixed;
            bottom: 0;
            width: 100%;
            text-align: center;
            font-family: Arial;
            font-size: 12px;
            letter-spacing: 1px;
        }

        .boder {
            height: 200px;
            border: 1px dashed black;
        }

        #topNavWrapper {
            text-align: left;
            height: 70px;
            _position: relative;
            _top: 0px;
        }

        #topNav {
            width: 80%;
            margin-left: 10%;
            float: left;
            display: block;
            z-index: 100;
            overflow: visible;
            position: fixed;
            top: 0px;
            _position: absolute;
            background-repeat: no-repeat;
            background-position: right;
            height: auto;
            line-height: 70px;
            background-color: #F8F8FF;
            color: #000;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row" id="topNavWrapper">
        <div id="topNav">
            <h1 style="font-size: 70px;font-weight: bolder">武汉工商学院羽毛球馆</h1>
            <span id="uid" style="font-size: 20px;font-weight: bolder">账号：${ sessionScope.uid}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="${PATH}/Pages/ToBackchange" style="font-size: 20px">修改密码</a>
        </div>
    </div>
    <div class="row" style="margin-top: 40px;height: 500px;">
        <%--轮播图--%>
        <div id="carouselExampleControls" class="carousel col-md-8 col-sm-offset-2 slide m-auto w-100" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="${PATH}/static/admin/images/index/01.jpg" class="d-block w-100" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="${PATH}/static/admin/images/index/02.png" class="d-block w-100" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="${PATH}/static/admin/images/index/03.png" class="d-block w-100" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="${PATH}/static/admin/images/index/04.png" class="d-block w-100" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="${PATH}/static/admin/images/index/05.JPG" class="d-block w-100" alt="...">
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
    <div class="row" style="margin-top: 10px;">
        <div class=" col-xs-4 col-xs-offset-1 col-lg-2" style="padding: 60px 60px 60px 60px">
            <a href="${PATH}/Pages/ToReserve"><img src="${PATH}/static/admin/images/index/0001.png" style="height: 200px;"></a>
        </div>
        <div class=" col-xs-4 col-xs-offset-2 col-lg-2" style="padding: 60px 60px 60px 60px">
            <a href="${PATH}/Pages/ToPersonBills"><img src="${PATH}/static/admin/images/index/0002.png" style="height: 200px;"></a>
        </div>
        <div class=" col-xs-4 col-xs-offset-1 col-lg-2" style="padding: 60px 60px 60px 60px">
            <a href="${PATH}/Pages/ToCpns"><img src="${PATH}/static/admin/images/index/0004.png" style="height: 200px;"></a>
        </div>
        <div class=" col-xs-4 col-xs-offset-2 col-lg-2" style="padding: 60px 60px 60px 60px">
            <a href="https://bwfbadminton.com/"><img src="${PATH}/static/admin/images/index/0005.png" style="height: 200px;"></a>
        </div>
    </div>
</div>
<div  id="footer">
    <span>Copyright@copy2020 feng. All rights reserved.</span>
</div>
</body>
</html>
