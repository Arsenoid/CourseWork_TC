<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Личный кабинет исполнителя</title>
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

        .route-list, .vehicle-list {
            margin-top: 20px;
        }

        .route-item, .vehicle-item {
            border: 1px solid #ccc;
            padding: 15px;
            margin-bottom: 15px;
            background: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .route-item p, .vehicle-item p {
            margin: 5px 0;
            font-size: 16px;
        }

        .route-item a, .vehicle-item a {
            color: #007bff;
            text-decoration: none;
        }

        .route-item a:hover, .vehicle-item a:hover {
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

        .complete-button {
            background-color: #dc3545; /* Красный цвет для кнопки завершения */
            border-radius: 4px; /* Скругленные углы */
            padding: 10px 20px;
            margin-left: auto; /* Выравнивание кнопки по правому краю */
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .complete-button:hover {
            background-color: #c82333;
        }


        .route-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid #ccc;
            padding: 15px;
            margin-bottom: 15px;
            background: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .route-item-info {
            flex: 1;
        }

        .route-item-actions {
            margin-left: auto;
        }

        .add-vehicle-link {
            display: inline-block;
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
        }

        .add-vehicle-link:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Личный кабинет исполнителя</h1>
    <h2>Имя пользователя: <i>${user.username}</i></h2>
    <hr>
    <h3>Маршруты на выполнении</h3>
    <div class="route-list">
        <#list orders as order>
            <#if order.route.status == "IN_PROCESS">
                <div class="route-item">
                    <div class="route-item-info">
                        <p><b>${order.route.startLocation} - ${order.route.endLocation}</b></p>
                        <p><b>Оплата:</b> ${order.route.payment} руб.</p>
                        <p><b>Принят в работу:</b> ${order.route.formattedCreatedAt} | <a href="/${order.route.id}">Подробнее...</a></p>
                    </div>
                    <div class="route-item-actions">
                        <form action="/carrier/order/complete/${order.id}" method="post" style="display: inline;">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="submit" class="complete-button" value="Транспортировка завершена">
                        </form>
                    </div>
                </div>
            </#if>
        <#else>
            <h3>Нет маршрутов</h3>
        </#list>
    </div>
    <hr>
    <h3>Завершенные маршруты</h3>
    <div class="route-list">
        <#list orders as order>
            <#if order.route.status == "COMPLETED">
                <div class="route-item">
                    <div class="route-item-info">
                        <p><b>${order.route.startLocation} - ${order.route.endLocation}</b></p>
                        <p><b>Оплата:</b> ${order.route.payment} руб.</p>
                        <p><b>Завершен:</b> ${order.route.formattedUpdatedAt} | <a href="/${order.route.id}">Подробнее...</a>
                        </p>
                    </div>
                </div>
            </#if>
        <#else>
            <h3>Нет маршрутов</h3>
        </#list>
        <hr>
        <h3>Мой транспорт</h3>
        <div class="vehicle-list">
            <#list vehicles as vehicle>
                <div class="vehicle-item">
                    <p><b>${vehicle.model}</b></p>
                    <p><b>VIN:</b> ${vehicle.vin}</p>
                    <#if vehicle.status == "FREE">
                        <p><b>Статус:</b> Свободен | <a href="vehicles/${vehicle.vin}">Подробнее...</a></p>
                    <#elseif vehicle.status = "BUSY">
                        <p><b>Статус:</b> На рейсе | <a href="vehicles/${vehicle.vin}">Подробнее...</a></p>
                    <#else>
                        <p><b>Статус:</b> Неисправен | <a href="vehicles/${vehicle.vin}">Подробнее...</a></p>
                    </#if>
                </div>
            <#else>
                <h3>Нет транспорта</h3>
            </#list>
        </div>
        <hr>
        <a href="/vehicles/add_vehicle" class="add-vehicle-link">Добавить новый транспорт</a>

    </div>
</div>
</body>
</html>
