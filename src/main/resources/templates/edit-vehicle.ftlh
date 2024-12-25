<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Редактировать автомобиль</title>
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
    <h1>Редактировать автомобиль</h1>
    <form class="edit-vehicle-form" action="/vehicles/edit_vehicle/${vehicle.id}" method="post" enctype="multipart/form-data">
        <label for="vin">VIN номер:</label>
        <input type="text" id="vin" name="vin" value="${vehicle.vin}" required><br><br>

        <label for="model">Марка и модель:</label>
        <input type="text" id="model" name="model" value="${vehicle.model}" required><br><br>

        <label for="manufactureYear">Год выпуска:</label>
        <input type="number" id="manufactureYear" name="manufactureYear" value="${vehicle.manufactureYear}" required><br><br>

        <label for="licensePlate">Номерной знак:</label>
        <input type="text" id="licensePlate" name="licensePlate" value="${vehicle.licensePlate}" required><br><br>

        <label for="fuelType">Тип топлива:</label>
        <input type="text" id="fuelType" name="fuelType" value="${vehicle.fuelType}" required><br><br>

        <label for="loadCapacity">Грузоподъемность:</label>
        <input type="number" id="loadCapacity" name="loadCapacity" value="${vehicle.loadCapacity}" required><br><br>

        <label for="file1">Фото 1:</label>
        <input type="file" id="file1" name="file1"><br><br>

        <label for="file2">Фото 2:</label>
        <input type="file" id="file2" name="file2"><br><br>

        <label for="file3">Фото 3:</label>
        <input type="file" id="file3" name="file3"><br><br>

        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Сохранить">
    </form>
</div>
</body>
</html>
