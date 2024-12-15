<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicles Management</title>
    <link rel="stylesheet" href="/css/base.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1, h4 {
            text-align: center;
            color: #333;
        }

        hr {
            border: 0;
            border-top: 1px solid #ccc;
            margin: 20px 0;
        }

        form {
            margin-top: 20px;
        }

        form input[type="text"], form input[type="email"], form input[type="password"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        form input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Vehicles Management</h1>
    <hr>
    <h3>Подробная информация о водителе ${user.username}</h3>


    <h4>Автомобили пользователя:</h4>
    <#list vehicles as vehicle>
        <div class="vehicle-item">
            <p><b>${vehicle.model}</b></p>
            <p><b>VIN:</b> ${vehicle.vin} | <a href="/vehicles/${vehicle.vin}">Подробнее...</a></p>
        </div>
    </#list>
    <#if errorMessage??>
        <h2 class="error">${errorMessage}</h2>
    </#if>
</div>
</body>
</html>
