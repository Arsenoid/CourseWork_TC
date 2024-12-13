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

        .vehicle-list {
            margin-top: 20px;
        }

        .vehicle-item {
            border: 1px solid #ccc;
            padding: 15px;
            margin-bottom: 15px;
            background: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .vehicle-item p {
            margin: 5px 0;
            font-size: 16px;
        }

        .vehicle-item a {
            color: #007bff;
            text-decoration: none;
        }

        .vehicle-item a:hover {
            text-decoration: underline;
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

        hr {
            border: 0;
            border-top: 1px solid #ccc;
            margin: 20px 0;
        }

        .logout-form {
            text-align: center;
            margin-bottom: 20px;
        }

        .add-vehicle-form {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Транспорт</h1>
    <#if user.email??>
        <h2>Имя пользователя: <i>${user.username}</i></h2>
        <form class="logout-form" action="/logout" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Выйти"/>
        </form>
    <#else>
        <a href="/login">Войти</a>
    </#if>
    <hr>
    <form action="/vehicles" method="get">
        Поиск по модели авто: <input type="text" name="car_model"><br>
        <input type="submit" value="Поиск">
    </form>
    <div class="vehicle-list">
        <#list vehicles as vehicle>
            <div class="vehicle-item">
                <p><b>${vehicle.model}</b></p>
                <p><b>VIN:</b> ${vehicle.vin} | <a href="vehicles/${vehicle.vin}">Подробнее...</a></p>
            </div>
        <#else>
            <h3>Нет подходящего транспорта</h3>
        </#list>
    </div>
    <hr>
    <#if user.email??>
        <h3>Добавить новый транспорт</h3>
        <form class="add-vehicle-form" action="/vehicles/add_vehicle" method="post" enctype="multipart/form-data">
            VIN: <input type="text" name="vin"><br><br>
            Модель: <input type="text" name="model"><br><br>
            Фото: <input type="file" name="file1"><br><br>
            Фото: <input type="file" name="file2"><br><br>
            Фото: <input type="file" name="file3"><br><br>
            Год выпуска: <input type="number" name="manufacture_year"><br><br>
            Номерной знак: <input type="text" name="registration"><br><br>
            Тип топлива: <input type="text" name="fuel_type"><br><br>
            Вместимость: <input type="number" name="capacity"><br><br>
            Статус: <input type="text" name="status"><br><br>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Добавить товар">
        </form>
    </#if>
</div>
</body>
</html>
