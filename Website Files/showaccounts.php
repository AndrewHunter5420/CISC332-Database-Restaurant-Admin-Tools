<!DOCTYPE html>
<html>

<head>
    <title>All Accounts</title>
    <link href="style.css" type="text/css" rel="stylesheet">
</head>

<body>

    <h1>Resturant Admin Tools - All Accounts</h1>
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
        $query = "select * from Customer";
        $result = $connection->query($query);

        if ($result->rowCount() > 0) {
            echo "<h2>All Customer Accounts:</h2>";
            echo "<table>";
                echo "<tr><th>Email</th>
                      <th>Address</th>
                      <th>City</th>
                      <th>Postal Code</th>
                      <th>Phone Number</th>
                      <th>Name</th>
                      <th>Total Credits</th></tr>";
                
            while ($row = $result->fetch()) {
                echo "<tr><td>".$row["email"]."</td>
                      <td>".$row["street"]."</td>
                      <td>".$row["city"]."</td>
                      <td>".$row["postalCode"]."</td>
                      <td>".$row["phoneNumber"]."</td>
                      <td>".$row["firstName"] . " " . $row["lastName"] . "</td>
                      <td>".$row["totalCredits"]."</td>
                      </tr>";
            }

            echo "</table>";
        }
        else {
            echo "<p>No Accounts Found.</p>";
        }

        $connection = NULL;
    ?>

</body>
</html>