<!DOCTYPE html>
<html>

<?php
    include "connectdb.php";
    $id = $_POST["employee"];
?>

<head>
    <?php
        echo "<title> Employee " . $id . " Schedule</title>";
    ?>
    <link href="style.css" type="text/css" rel="stylesheet">
</head>

<body>
    <?php
        echo "<h1>Resturant Admin Tools - Employee " . $id . " Schedule</h1>";
    ?>

    <nav>
        <ul>
            <li><a href="restaurant.html">Home</a></li>
            <li><a href="numberoforders.php">Number Of Orders</a></li>
            <li><a href="createnewaccount.html">Create New Account</a></li>
            <li><a href="selectemployee.php">Employee Schedule</a></li>
            <li><a href="showaccounts.php">All Accounts</a></li>
        </ul>
    </nav>

    <hr>
    <br>

    <?php
        echo "<h2>Employee " . $id . " schedule Mon-Fri (Note: Sat. and Sun. shifts not included):</h2>"; 

        $query = 'select startTime, endTime, DateOfShift from Schedule 
                  where employeeID="' . $id . '" and DAYOFWEEK(DateOfShift)!=1 and DAYOFWEEK(DateOfShift)!=7
                  order by DateOfShift ASC';
        $result = $connection->query($query);
        if ($result->rowCount() > 0) {
            while ($row = $result->fetch()) {
                echo "<div>";
                    echo date('l', strtotime($row["DateOfShift"])) . " (" . $row["DateOfShift"] . ")<br>" . 
                        "Start Time: " . $row["startTime"] . "<br>" . 
                        "End Time: " . $row["endTime"];
                echo "</div><br>";
            }
        }
        else {
            echo "<p>Employee " . $id . " doesn't have any scheduled shifts from Monday to Friday.</p>";
        }

    ?>

</body>
</html>