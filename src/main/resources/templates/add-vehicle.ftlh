<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Добавить новый транспорт</title>
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
            max-width: 1200px;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1, h2, h3 {
            text-align: center;
            color: #333;
        }

        form {
            margin-bottom: 20px;
        }

        form input[type="text"], form input[type="number"], form input[type="file"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
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
    </style>
</head>
<body>
<div class="container">
    <h3>Добавить новый транспорт</h3>
    <form class="add-vehicle-form" action="/vehicles/add_vehicle" method="post" enctype="multipart/form-data">
        Фото: <input type="file" name="file1"><br><br>
        Фото: <input type="file" name="file2"><br><br>
        Фото: <input type="file" name="file3"><br><br>
        Марка и модель: <input type="text" name="model" required><br><br>
        VIN номер: <input type="text" name="vin" required><br><br>
        Год выпуска: <input type="number" name="manufactureYear"><br><br>
        Номерной знак: <input type="text" name="licensePlate" required><br><br>
        Тип топлива: <input type="text" name="fuelType"><br><br>
        Грузоподъемность: <input type="number" name="loadCapacity" required><br><br>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Добавить транспорт">
    </form>
</div>
</body>
</html>
