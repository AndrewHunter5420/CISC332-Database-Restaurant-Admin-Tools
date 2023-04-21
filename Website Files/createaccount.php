<!DOCTYPE html>
<html>

<head>
    <title>Create Account</title>
    <link href="style.css" type="text/css" rel="stylesheet">
</head>

<body>

    <h1>Resturant Admin Tools - Create New Account</h1>
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

        $email = $_POST["email"];
        $street = $_POST["street"];
        $city = $_POST["city"];
        $postalCode = $_POST["postalCode"];
        $phoneNumber = $_POST["phoneNumber"];
        $firstName = $_POST["firstName"];
        $lastName = $_POST["lastName"];

        $query = 'select email from Customer where email="' . $email . '"';
        $result = $connection->query($query);

        if ($result->rowCount() > 0) {
            echo "<p>This email is already in use. Please use a different email to 
                  create a new account.</p>";
        }
        else {
            $insert = 'insert into Customer values("' . 
                $email . '","' . 
                $street . '","' . 
                $city . '","' . 
                $postalCode . '","' . 
                $phoneNumber . '","' . 
                $firstName . '","' . 
                $lastName . '",' . 
                '5)';

            $numRows = $connection->exec($insert);
            echo "<p>Successfully created account.</p>";
            echo '<a href="restaurant.html">Return to homepage</a>';
        }
        $connection = NULL;
    ?>


</body>
</html>