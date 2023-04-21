<!DOCTYPE html>
<html>

<head>
    <title>Number of Orders</title>
    <link href="style.css" type="text/css" rel="stylesheet">
</head>

<body>

    <h1>Resturant Admin Tools - Number of Orders</h1>
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
        $query = "select orderDate, count(*) as NumOrders from TheOrder group by orderDate;";
        $result = $connection->query($query);

        if ($result->rowCount() > 0) {
            echo "<h2>Number of Orders by Date:</h2>";
            echo "<table>";
                echo "<tr><th>Date</th><th>Number of Orders</th></tr>";
                
            while ($row = $result->fetch()) {
                echo "<tr><td>".$row["orderDate"]."</td><td>".$row["NumOrders"]."</td></tr>";
            }

            echo "</table><br>";

            echo "<h2>List All Order Details On Specified Date:</h2>";
            echo "<p>Select date below then click the submit button:</p>";

            echo '<form action="showorders.php" method="post">';

            $query = "select distinct orderDate from TheOrder";
            $result = $connection->query($query);
            if ($result->rowCount() > 0) {
                while ($row = $result->fetch()) {
                    echo '<input type="radio" name="date" value="';
                    echo $row["orderDate"];
                    echo '">' . $row["orderDate"] . "<br>";
                }
                
                echo '<input type="submit" value="Submit">';
                echo "</form>";
            }
            else {
                // Should never happen, since first query should've returned nothing first
                echo "<p>Error occurred. Couldn't retreive dates order were placed on.</p>";
            }
        }
        else {
            echo "<p>No Orders Found.</p>";
        }

        $connection = NULL;
    ?>

</body>
</html>