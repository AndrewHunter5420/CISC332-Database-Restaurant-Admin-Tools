<!DOCTYPE html>
<html>

<head>
    <title>Select Employee</title>
    <link href="style.css" type="text/css" rel="stylesheet">
</head>

<body>
    <h1>Resturant Admin Tools - Select Employee</h1>

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
        include "connectdb.php";
        $query = "select id, firstName, lastName from Employee";
        $result = $connection->query($query);

        if ($result->rowCount() > 0) {
            echo "<h2>Select employee below to view their schedule:</h2>";
            echo '<form action="employeeschedule.php" method="post">';
                
                while ($row = $result->fetch()) {
                    echo '<input type="radio" name="employee" value="';
                    echo $row["id"];
                    echo '">' . $row["firstName"] . " " . $row["lastName"] . " (Id: " . $row["id"] . ")" . "<br>";
                }
        
                echo '<input type="submit" value="Submit">';
            echo '</form>';
        }
        else {
            echo '<p>No employees found.';
        }
  
        $connection = NULL;
    ?>

</body>
</html>