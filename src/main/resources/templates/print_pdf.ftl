<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <#--<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>-->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"></link>
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
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
<#assign wcount = 0>
<#assign rowcount = 0>
<#assign rowsPerPage = 12>

<#list pywords as w>
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
        <p class="pinyin_span" style="display: none">${w.pinyin}</p>
        <table class="tabTian"><tr>
                <#list 1..w.word?length as t>
                    <td class="td_lt"></td><td class="td_rt"></td>
                </#list></tr><tr>
                <#list 1..w.word?length as t>
                    <td class="td_lb"></td><td class="td_rb"></td>
                </#list></tr></table>
        <#--<input type="text" class="word_input" readonly="readonly">${w.word}</input>-->
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
</body>

<script type="text/javascript">
    $(function () {
        $(".pinyin_span").each(function(i){
            var txt = $(this).html();
            txt = txt.replace('ā','<font class="pinyin_span_a">ā</font>');
            txt = txt.replace('á','<font class="pinyin_span_a">á</font>');
            txt = txt.replace('ǎ','<font class="pinyin_span_a">ǎ</font>');
            txt = txt.replace('à','<font class="pinyin_span_a">à</font>');
            $(this).html(txt);
        });
    });

</script>
</html>