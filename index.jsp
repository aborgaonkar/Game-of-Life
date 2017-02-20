<!DOCTYPE html>
<html>
    <head>
        <style>
            div.container {
                width: 100%;
                border: 1px solid gray;
            }

            header, footer {
                padding: 1em;
                color: white;
                background-color: #3f51b5;
                clear: left;
                text-align: center;
            }

            nav {
                float: left;
                max-width: 300px;
                margin: 0;
                padding: 1em;
            }

            nav ul {
                list-style-type: none;
                padding: 0;
            }

            article {
                margin-left: 170px;
                border-left: 1px solid gray;
                padding: 1em;
                overflow: hidden;
            }
            .button {
                background-color: #3f51b5; /* Green */
                border: none;
                color: white;
                padding: 15px 32px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 12px;
                width: 75%;
            }
            table {
                border-collapse: collapse;
                width: 100%;
            }

            th, td {
                text-align: left;
                padding: 8px;
                cursor: pointer;
                text-align: center;

            }

            tr:nth-child(even){background-color: #f2f2f2}

            th {
                background-color: #3f51b5;
                color: white;
            }
            input[type=text] {
                width: 75%;
                padding: 12px 20px;
                margin: 8px 0;
                display: inline-block;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                text-align: center;
            }
            input[type=button]:disabled {
                background: #dddddd;
            }

        </style>
    </head>
    <body>

        <div class="container">

            <header>
                <h1>Game of Life</h1>
            </header>

            <nav>
                <ul>
                    <li>                
                        <input type = "text" name="rows" id="rows" placeholder="Rows">
                    </li>
                    <li>                
                        <input type = "text" name="columns" id="columns" placeholder="Columns">
                    </li>
                    <li>
                        <input type = "button" class="button" name="generate" id="generate" value="Generate" onclick="createTable()">
                    </li>
                    <br/>
                    <li>
                        <input type = "button" class="button"disabled="" name="reset" id="reset" value="Reset" onclick="resetTable()">    
                    </li>
                    <br/>
                    <li>
                        <input type = "button" class="button" disabled="" name="confirm" id="confirm" value="Confirm" onclick="reload()">
                    </li>
                    <br/>
                    <li>
                        <input type = "button" class="button" disabled="" name="start" id="start" value="Start" onclick="startGame()">
                    </li>
                    <br/>
                    <li>
                        <input type = "button" class="button" disabled="" name="stop" id="stop" value="Stop">
                    </li>
                </ul>
            </nav>

            <article>
                <table><th>Matrix</th></table>
                <table border = "1" id="myTable" align = "center">
                    <tr id="myRow">
                    </tr>                
                </table>

            </article>

            <footer>@AashayBorgaonkar</footer>

        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script type="text/javascript">
                            var globalRows = 0;
                            var globalCols = 0;
                            function createTable()
                            {
                                var rows = document.getElementById('rows').value;
                                var columns = document.getElementById('columns').value;
                                var table = document.getElementById("myTable");
                                globalRows = rows;
                                globalCols = columns;
                                var index = 0;
                                for (var i = 0; i < rows; i++)
                                {
                                    var row = table.insertRow(0);
                                    for (var j = 0; j < columns; j++)
                                    {
                                        var cell = row.insertCell(j);
                                        cell.innerHTML = "0";
                                        var h1 = document.getElementsByTagName("td")[j];
                                        var att1 = document.createAttribute("onclick");
                                        att1.value = "toggleNumber(this)";
                                        h1.setAttributeNode(att1);
                                    }
                                }
                                for (var i = 0; i < globalRows; i++)
                                {
                                    for (var j = 0; j < globalCols; j++)
                                    {
                                        var cell = table.rows[i].cells[j];
                                        var att = document.createAttribute("id");
                                        att.value = index;
                                        cell.setAttributeNode(att);
                                        index++;
                                    }
                                }
//                                var myTable = document.getElementById('myTable');
//                                myTable.rows[0].cells[1].innerHTML = 'Hello';
                            }
                            function resetTable()
                            {
                                var table = document.getElementById("myTable");

                                for (var i = 0; i < globalRows; i++)
                                {
                                    table.deleteRow(0);
                                }
                            }
                            function toggleNumber(val)
                            {
                                if (val.innerText == 0)
                                {
                                    val.innerHTML = "1";
                                    val.style.backgroundColor = "#7986cb";
                                } else
                                {
                                    val.innerHTML = "0";
                                    val.style.backgroundColor = "white";
                                }
                            }
                            var outer = "";
                            function reload()
                            {
                                outer = "";
                                for (var i = 0; i < globalRows; i++)
                                {
                                    var inner = "";
                                    inner = document.getElementById("myTable").rows[i].cells[0].innerHTML + ",";
                                    for (var j = 1; j < globalCols; j++)
                                    {
                                        inner += document.getElementById("myTable").rows[i].cells[j].innerHTML + ",";
                                    }
                                    outer += inner + " ";
                                }
                            }
                            function wait(ms) {
                                var start = new Date().getTime();
                                var end = start;
                                while (end < start + ms) {
                                    end = new Date().getTime();
                                }
                            }
                            function startGame()
                            {
                                $(document).ready(function () {
                                    $.post("GameOfLife",
                                            {
                                                board: outer
                                            },
                                    function (data) {
                                        outer = data;
                                        var table = document.getElementById("myTable");
                                        var outerArray = data.split(" ");

                                        for (var i = 0; i < outerArray.length; i++)
                                        {
                                            var innerArray = outerArray[i].split(",");
                                            for (var j = 0; j < innerArray.length - 1; j++)
                                            {
                                                document.getElementById("myTable").rows[i].cells[j].innerHTML = innerArray[j];
                                                if(innerArray[j] == 1)
                                                {
                                                    document.getElementById("myTable").rows[i].cells[j].style.backgroundColor = "#7986cb"
                                                }
                                                else
                                                {
                                                    document.getElementById("myTable").rows[i].cells[j].style.backgroundColor = "white"                                                    
                                                }
                                            }
                                        }
                                        wait(2000);
                                        startGame();

                                    });
                                });
                            }
                            $(document).ready(function () {
                                $("input#generate").click(function () {
                                    $("input#reset").removeAttr("disabled");
                                    $("input#confirm").removeAttr("disabled");
                                    $(this).attr("disabled", "disabled");
                                });
                                $("input#reset").click(function () {
                                    $("input#generate").removeAttr("disabled");
                                    $("input#confirm").attr("disabled", "disabled");
                                    $("input#start").attr("disabled", "disabled");
                                    $("input#rows").val('');
                                    $("input#columns").val('');
                                    $(this).attr("disabled", "disabled");
                                });
                                $("input#confirm").click(function () {
                                    $("input#generate").attr("disabled", "disabled");
                                    $("input#confirm").attr("disabled", "disabled");
                                    $("input#start").removeAttr("disabled");
                                    $(this).attr("disabled", "disabled");
                                });
                                $("input#start").click(function () {
                                    $("input#generate").attr("disabled", "disabled");
                                    $("input#confirm").attr("disabled", "disabled");
                                    $("input#reset").attr("disabled", "disabled");
                                    $("input#stop").removeAttr("disabled");
                                    $(this).attr("disabled", "disabled");
                                });
                                $("input#stop").click(function () {
                                    location.reload();
                                });
                            });
        </script>

    </body>
</html>
