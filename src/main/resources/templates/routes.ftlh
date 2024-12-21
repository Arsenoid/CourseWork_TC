<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BLizzard Trans</title>
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

        .route-list {
            margin-top: 20px;
        }

        .route-item {
            border: 1px solid #ccc;
            padding: 15px;
            margin-bottom: 15px;
            background: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .route-item p {
            margin: 5px 0;
            font-size: 16px;
        }

        .route-item a {
            color: #007bff;
            text-decoration: none;
        }

        .route-item a:hover {
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

        .add-route-form {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Маршруты</h1>
    <#if user.email??>
        <h2>Имя пользователя: <i>${user.username}</i></h2>
        <form class="logout-form" action="/logout" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Выйти"/>
        </form>
        <#if user.isAdmin()>
            <a href="/admin">Панель администратора</a>
        </#if>
    <#else>
        <a href="/login">Войти</a>
    </#if>
    <hr>
<#--    <form action="/vehicles" method="get">-->
<#--        Поиск по модели авто: <input type="text" name="car_model"><br>-->
<#--        <input type="submit" value="Поиск">-->
<#--    </form>-->
    <div class="route-list">
        <#list routes as route>
            <div class="route-item">
                <p><b>${route.startLocation} - ${route.endLocation}</b></p>
                <p><b>Создан:</b> ${route.formattedCreatedAt} | <a href="/${route.id}">Подробнее...</a></p>
            </div>
        <#else>
            <h3>Нет пердложений</h3>
        </#list>
    </div>
    <hr>
    <#if user.email??>
        <h3>Добавить новый маршрут</h3>
        <form class="add-route-form" action="/add_route" method="post" enctype="multipart/form-data">
            Начальная точка: <input type="text" name="startLocation"><br><br>
            Конечная точка: <input type="text" name="endLocation"><br><br>
            Расстояние: <input type="number" name="distance"><br><br>
            Описание груза: <input type="text" name="cargo_description"><br><br>
            Масса груза: <input type="number" name="cargo_weight"><br><br>
            Оплата: <input type="number" name="payment"><br><br>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Добавить маршрут">
        </form>
    </#if>
</div>
</body>
</html>
