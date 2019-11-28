<html>
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
    ${body}

</body>
</html>