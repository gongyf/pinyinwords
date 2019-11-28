<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>看拼音写词语</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</head>
<body>
<#assign ctx=request.getContextPath()>
<form method="post" action="${ctx}/make">

    <div class="container">

        <div class="form-group row">
            <label for="title" class="col-sm-2 col-form-label">标题：</label>
            <div class="col-sm-10">
                <input name="title" type="text" class="form-control" id="title" placeholder="例： xx年级xx单元 姓名" value="看拼音写词语">
            </div>
        </div>
        <div class="form-group row">
            <label for="tool" class="col-sm-2 col-form-label">选择转换工具：</label>
            <div class="col-sm-10">
                <select class="custom-select" id="tool" name="tool">
                    <option value="pinyin4j" selected>pinyin4j</option>
                    <option value="bopomofo4j">bopomofo4j</option>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label for="rowsPerPage" class="col-sm-2 col-form-label">每页几行？</label>
            <div class="col-sm-10">
                <select class="custom-select" id="rowsPerPage" name="rowsPerPage">
                    <option value="8" selected>8行</option>
                    <option value="9">9行</option>
                    <option value="10">10行</option>
                    <option value="11" selected="selected">11行</option>
                    <option value="12">12行</option>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label for="words" class="col-sm-2 col-form-label">空格分割的词语：</label>
            <div class="col-sm-10">
                <textarea id="words" name="words" class="form-control" rows="5" aria-label="With textarea"></textarea>
            </div>
        </div>

<#--
        <div class="row">
            <div class="col-2"><span>标题：</span></div>
            <div class="col-7"><input type="text" name="title"></div>
        </div>



        <div class="row">
            <div class="col-2"><span>：</span></div>
            <div class="col-7">
                <select name="tool" style="width:200px">
                    <option value="pinyin4j"></option>
                    <option value="bopomofo4j"></option>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-2"><span>空格分割的词语：</span></div>
            <div class="col-7"><textarea name="words" style="width: 550px;height: 250px"></textarea></div>
        </div>
-->
        <button type="submit" class="btn btn-primary">提交</button>
    </div>

    <div class="container" style="margin-top: 20px">
        <div class="row">
            <div class="col-12">
                <p>推荐使用Chrome（谷歌浏览器）</p>
                <p>打印配置：</p>
                <img src="${ctx}/img/print.png" />
            </div>
        </div>
    </div>

</form>
</body>
</html>