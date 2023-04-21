<!DOCTYPE html>
<html>

<?php
    include "connectdb.php";
    $whichDate = $_POST["date"];
?>

<head>
    <?php
        echo "<title>Orders On Date " . $whichDate . "</title>";
    ?>
    <link href="style.css" type="text/css" rel="stylesheet">
</head>

<body>
    <?php
        echo "<h1>Resturant Admin Tools - Orders On Date " . $whichDate . "</h1>";
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
        echo "<h2>Orders on " . $whichDate . ":</h2>";    

        $query = 'select O.id, C.firstName as CFName, C.lastName as CLName, O.price, 
                                    O.tip, E.firstName as EFName, E.lastName as ELName
                  from ((TheOrder O join PlaceOrder P on O.id=P.orderID) 
                        join Customer C on P.customerEmail=C.email)
                        join Employee E on O.delivererID=E.id
                  where O.orderDate="' . $whichDate . '"';
        $result = $connection->query($query);
        if ($result->rowCount() > 0) {
            while ($row = $result->fetch()) {
                echo "<div>";
                    echo "Order Id: " . $row["id"] . 
                        "<br> Customer Name: " . $row["CFName"] . " " . $row["CLName"] . 
                        "<br> Items Ordered: ";
                    
                    
                    $itemsOrderedQuery = 'select itemName from ItemsOrdered where orderID=' . $row["id"];
                    $itemsOrdered = $connection->query($itemsOrderedQuery);
                    echo $itemsOrdered->fetch()["itemName"];
                    while ($itemRow = $itemsOrdered->fetch()) {
                        echo ", " . $itemRow["itemName"];
                    }

                    echo "<br> Total Order Price: $" . $row["price"] . 
                        "<br> Tip: $" . $row["tip"] . 
                        "<br> Deliverer Name: " . $row["EFName"] . " " . $row["ELName"];
                    
                echo "</div><br>";
            }
        }
        else {
            // Should never happen
            echo "<p>Error occurred, no orders exist. Possible causes: inconsistent data, technical bug occurred, etc.</p>";
        }

    ?>

</body>
</html>