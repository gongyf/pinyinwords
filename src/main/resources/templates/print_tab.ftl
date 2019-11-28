<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
    <title>Title</title>
    <style type="text/css">
        .bigTR { }
        .bigTD {
            padding-top:15px;
        }
        .pinyin_span {
            font-size: 17px;
        }
        hr {
            margin-top: 0px;
            padding: 0px;
        }
        .title_span {
            font-size: 12px;
            margin: 0px;
            padding: 0px;
        }
        .tabTian {
            border-collapse:collapse;
        }
        .tabTian tbody tr td {
            /*border: 1px dotted #aaaaaa;*/
            border-width: 1px;
            height:6mm;
            width:6mm;
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
<#assign wcount = 0>
<#assign rowcount = 0>
<#assign rowsPerPage = 11>
<button id="readyPrint">准备打印</button>
<#list words as w>
    <#if wcount == 0>
        <#if rowcount == 0>
            <#if title??>
                <span class="title_span">${title}</span>
                <hr/>
            </#if>
            <table>
        </#if>
        <tr class="bigTR">
    <#elseif wcount + w.word?length gt 12>
        </tr>
        <#assign rowcount = rowcount + 1>
        <#assign wcount = 0>
        <#if rowcount gte rowsPerPage>
            </table>
            <div style="page-break-after: always;"></div>
            <#assign rowcount = 0>
            <#if title??>
                <span class="title_span">${title}</span>
                <hr/>
            </#if>
            <table>
        </#if>
        <tr class="bigTR">
    </#if>

    <#if w.word?length gte 4 && w.word?length lte 5>
    <td colspan="2" class="bigTD">
    <#elseif w.word?length gte 6>
    <td colspan="3" class="bigTD">
    <#else >
    <td class="bigTD">
    </#if>
            <input value="${w.pinyin}" type="text" class="pinyin_input">
            <span class="pinyin_span" style="display: none">${w.pinyin}</span>
            <br/>

            <table class="tabTian"><tr>
            <#list 1..w.word?length as t>
                <td class="td_lt"></td><td class="td_rt"></td>
            </#list></tr><tr>
            <#list 1..w.word?length as t>
                <td class="td_lb"></td><td class="td_rb"></td>
            </#list></tr></table>
            <span class="hanzi">${w.word}</span>
        </td>
    <#assign wcount = wcount + w.word?length>
    <#if wcount gte 12>
        </tr>
        <#assign rowcount = rowcount + 1>
        <#assign wcount = 0>
        <#if rowcount gte rowsPerPage>
            </table>
            <div style="page-break-after: always;"></div>
            <#assign rowcount = 0>
        </#if>
    </#if>
</#list>
</body>
<script type="text/javascript">
    $(function () {
        $(".pinyin_span").hide();
        $(".tabTian").hide();
        $(".pinyin_input").change(function () {
            $(this).next(".pinyin_span").text($(this).val());
        });
        $("#readyPrint").click(function () {
            $(".hanzi").hide();
            $(".tabTian").show();
            $(".pinyin_input").hide();
            $(".pinyin_span").show();
            $("#readyPrint").hide();
        });
    });

    function preview()
    {
        bdhtml=window.document.body.innerHTML;//获取当前页的html代码
        sprnstr="<!--startprint-->";//设置打印开始区域
        eprnstr="<!--endprint-->";//设置打印结束区域
        prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html
        prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html
        window.document.body.innerHTML=prnhtml;
        window.print();
        window.document.body.innerHTML=bdhtml;
    }

</script>
</html>