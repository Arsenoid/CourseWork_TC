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

        h1 {
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
            text-align: left;
            margin-bottom: 20px;
        }

        .route-item-info {
            flex: 1;
        }

        .route-item-price {
            margin-left: auto;
        }

    </style>
</head>
<body>
<div class="container">
    <h1>BLizzard Trans</h1>
    <#if user.email??>
        <h2>Имя пользователя: <i>${user.username}</i></h2>
        <form class="logout-form" action="/logout" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Выйти"/>
        </form>
        <#if user.isAdmin()>
            <form action="/admin" method="get">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Панель администратора"/>
            </form>
            <hr>
            <form action="/add_route" method="get">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Добавить новый маршрут"/>
            </form>
            <form action="/customer" method="get">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Личный кабинет заказчика"/>
            </form>
        <#elseif user.isCustomer()>
            <hr>
            <form action="/customer" method="get">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Личный кабинет заказчика"/>
            </form>
        <#elseif user.isCarrier()>
            <hr>
            <form action="/carrier" method="get">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Личный кабинет исполнителя"/>
            </form>
        </#if>
    <#else>
        <a href="/login">Войти</a>
    </#if>
    <hr>
    <#--    <form action="/vehicles" method="get">-->
    <#--        Поиск по модели авто: <input type="text" name="car_model"><br>-->
    <#--        <input type="submit" value="Поиск">-->
    <#--    </form>-->
    <h3>Доступные для выполнения маршруты</h3>
    <div class="route-list">
        <#list routes as route>
            <#if route.status == "ACTIVE">
                <div class="route-item">
                    <div class="route-item-info">
                        <p><b>${route.startLocation} - ${route.endLocation}</b></p>
                        <p><b>Создан:</b> ${route.formattedCreatedAt}</p>
                    </div>
                    <p><b>Оплата:</b> ${route.payment} руб.</p>
                    <p><a href="/${route.id}">Подробнее...</a></p>
                </div>
            </#if>
        <#else>
            <h3>Нет пердложений</h3>
        </#list>
    </div>
</div>
</body>
</html>
