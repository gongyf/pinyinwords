<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"/>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>


    <title>${title}</title>
    <style type="text/css">
        /*@media print {
            .no-print {
                display: none !important;
                height: 0;
            }
        }*/
        .mytool{
            background: rgba(240,240,240,0.5);
        }
        .bigRow {
            padding-top:22px;
        }
        .pinyin_span {
            font-size: 18px;
        }
        .pinyin_span_a {
            font-size: 19px;
            font-family: 宋体;
        }
        hr {
            margin-top: 0px;
            padding: 0px;
        }
        .title_span {
            color:black;
            font-size: 18px;
            margin: 0px;
            padding: 0px;
        }
        .tabTian {
            border-collapse:collapse;
        }
        .tabTian tbody tr td {
            /*border: 1px dotted #aaaaaa;*/
            border-width: 1px;
            height:32px;
            width:32px;
        }
         #yunmutab tbody tr td {
             width:15px;
             font-size: 18px;
         }
        .td_lt {
            border-style:solid dotted dotted solid;
            border-color: dimgray darkgray darkgray dimgray;
        }
        .td_rt {
            border-style:solid solid dotted dotted;
            border-color:dimgray dimgray darkgray darkgray;
        }
        .td_rb {
            border-style:dotted solid solid dotted;
            border-color:darkgray dimgray dimgray darkgray;
        }
        .td_lb {
            border-style:dotted dotted solid solid;
            border-color:darkgray darkgray dimgray dimgray;
        }
    </style>
</head>
<body>
<#assign ctx=request.getContextPath()>
<#assign wcount = 0>
<#assign rowcount = 0>
<#--<form action="${ctx}/pdf" method="post">-->
    <#if title??>
        <input type="hidden" name="title" value="${title}">
    </#if>
<div class="mytool sticky-top d-print-none">
<button type="button" class="btn btn-outline-danger d-print-none" id="gotoModify" >返回修改</button>
<button type="button" class="btn btn-outline-primary d-print-none" id="readyPrint">准备打印</button>
<#--<button type="submit" class="btn btn-outline-primary d-print-none" id="downloadPDF">下载PDF</button>-->
    <span>如要打印：右键本网页，选择“打印”（如果想保存为文件，在目标打印机种选择PDF——需您当前访问设备的支持）</span>
    <table id="yunmutab" class="float-right d-print-none">
        <tr>
            <td>ā</td><td>á</td><td>ǎ</td><td>à</td><td> </td>
            <td>ō</td><td>ó</td><td>ǒ</td><td>ò</td><td> </td>
            <td>ē</td><td>é</td><td>ě</td><td>è</td><td> </td>
            <td>ī</td><td>í</td><td>ǐ</td><td>ì</td><td> </td>
            <td>ū</td><td>ú</td><td>ǔ</td><td>ù</td><td> </td>
            <td>ǖ</td><td>ǘ</td><td>ǚ</td><td>ǜ</td><td> </td>
            <td>ü</td><td>ɑ</td>
        </tr>
    </table>
</div>
<#list words as w>
    <#if wcount == 0>
        <#if rowcount == 0>
            <#if title??>
                <span class="title_span">${title}</span>
                <hr/>
            </#if>
            <div class="container-fluid">
        </#if>
        <div class="row bigRow">
    <#elseif wcount + w.word?length gt 12>
        </div>
        <#assign rowcount = rowcount + 1>
        <#assign wcount = 0>
        <#if rowcount gte rowsPerPage>
            </div>
            <div style="page-break-after: always;"></div>
            <#assign rowcount = 0>
            <#if title??>
                <span class="title_span">${title}</span>
                <hr/>
            </#if>
<div class="container-fluid">
        </#if>
        <div class="row bigRow">
    </#if>

    <#assign wlength = w.word?length>
    <#if wlength gt 12>
        <#assign wlength = 12>
    </#if>
    <div class="col-${wlength} pyword">

        <input value="${w.pinyin}" type="text" class="pinyin_input" name="pywords[${w_index}].pinyin"></input>
        <p class="pinyin_span" style="display: none">${w.pinyin}</p>

        <table class="tabTian"><tr>
                <#list 1..w.word?length as t>
                    <td class="td_lt"></td><td class="td_rt"></td>
                </#list></tr><tr>
                <#list 1..w.word?length as t>
                    <td class="td_lb"></td><td class="td_rb"></td>
                </#list></tr></table>
        <input type="text" class="word_input" readonly="readonly" value="${w.word}" name="pywords[${w_index}].word"></input>

    </div>

    <#assign wcount = wcount + wlength>
    <#if wcount gte 12>
        </div>
        <#assign rowcount = rowcount + 1>
        <#assign wcount = 0>
        <#if rowcount gte rowsPerPage>
            </div>
            <div style="page-break-after: always;"></div>
            <#assign rowcount = 0>
        </#if>
    </#if>
</#list>
</div></div>
<#--</form>-->
</body>
<script type="text/javascript">
    jQuery.fn.outerHTML = function() {
        return jQuery('<pre></pre>').append(this.clone()).html();
    };
    $(function () {
        $(".title_span").hide();
        $("hr").hide();
        $("#gotoModify").hide();
        $(".pinyin_span").hide();
        $(".tabTian").hide();

        $(".pinyin_input").each(function(i){
            var txt = $(this).val();
            txt = txt.replace('ā','<font class="pinyin_span_a">ā</font>');
            txt = txt.replace('á','<font class="pinyin_span_a">á</font>');
            txt = txt.replace('ǎ','<font class="pinyin_span_a">ǎ</font>');
            txt = txt.replace('à','<font class="pinyin_span_a">à</font>');
            $(this).next(".pinyin_span").html(txt);
        });

        $(".pinyin_input").change(function () {
            var txt = $(this).val();
            txt = txt.replace('ā','<font class="pinyin_span_a">ā</font>');
            txt = txt.replace('á','<font class="pinyin_span_a">á</font>');
            txt = txt.replace('ǎ','<font class="pinyin_span_a">ǎ</font>');
            txt = txt.replace('à','<font class="pinyin_span_a">à</font>');
            $(this).next(".pinyin_span").html(txt);
        });
        $("#readyPrint").click(function () {
            $("#gotoModify").show();
            $(".tabTian").show();
            $(".pinyin_span").show();
            $(".title_span").show();
            $("hr").show();
            $("#yunmutab").hide();
            $("#readyPrint").hide();
            $(".word_input").hide();
            $(".pinyin_input").hide();
        });
        $("#gotoModify").click(function () {
            $("#readyPrint").show();
            $("#yunmutab").show();
            $(".word_input").show();
            $(".pinyin_input").show();

            $(".title_span").hide();
            $("hr").hide();
            $("#gotoModify").hide();
            $(".tabTian").hide();
            $(".pinyin_span").hide();

        });

        $("#downloadPDF").click(function(){
            var pywords = new Array();
            pywords.push({"word":"${title}","pinyin":""});
            $(".pyword").each(function(i){
                pywords.push({
                    "word":$(this).find(".word_input").val(),
                    "pinyin":$(this).find(".pinyin_span").val()
                });
            });

/*
            $.ajax({
                type: "POST",
                url: "${ctx}/pdf",
                async:false,
                //timeout: 30000,
                data: JSON.stringify(pywords),
                contentType: "application/json",
                dataType: "application/pdf"
                /!*traditional: true,
                complete: function(data) {
                    var w = window.open("data:application/pdf, " + escape(data.responseText));
                    w.document.write(data.responseText);
                    w.document.close();
                }*!/
            });
*/

        });


    });

</script>
</html>