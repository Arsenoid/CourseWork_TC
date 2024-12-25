<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Личный кабинет заказчика</title>
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

        .add-route-form {
            max-width: 600px;
            margin: 0 auto;
        }

        .add-route-form label {
            display: block;
            margin-bottom: 5px;
        }

        .add-route-form input[type="text"],
        .add-route-form input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .add-route-form input[type="submit"] {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
            display: block;
            margin: 0 auto;
            transition: background-color 0.3s;
        }

        .add-route-form input[type="submit"]:hover {
            background-color: #218838;
        }

        .complete-button {
            background-color: #dc3545; /* Красный цвет для кнопки завершения */
            border-radius: 4px; /* Скругленные углы */
            padding: 10px 20px;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .complete-button:hover {
            background-color: #c82333;
        }

        .edit-button {
            background-color: #ffc107; /* Желтый цвет для кнопки редактирования */
            border-radius: 4px; /* Скругленные углы */
            padding: 10px 20px;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .edit-button:hover {
            background-color: #e0a800;
        }

        .delete-button {
            background-color: #dc3545; /* Красный цвет для кнопки удаления */
            border-radius: 4px; /* Скругленные углы */
            padding: 10px 20px;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-left: 10px; /* Отступ слева для кнопки удаления */
        }

        .delete-button:hover {
            background-color: #c82333;
        }

        .add-route-link {
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

        .add-route-link:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Личный кабинет заказчика</h1>
    <h2>Имя пользователя: <i>${user.username}</i></h2>
    <a href="/" class="add-route-link">Вернуться на главную</a>
    <hr>
    <h3>Размещенные заказы</h3>
    <div class="route-list">
        <div class="route-item">
            <#list routes as route>
                <#if route.status == "ACTIVE">
                    <div class="route-item-info">
                        <p><b>${route.startLocation} - ${route.endLocation}</b></p>
                        <p><b>Создан:</b> ${route.formattedCreatedAt} | <a href="/${route.id}">Подробнее...</a></p>
                    </div>
                    <div class="route-item-actions">
                        <form action="/customer/edit_route/${route.id}" method="get" style="display: inline;">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="submit" class="edit-button" value="Изменить">
                        </form>
                        <form action="/customer/delete_route/${route.id}" method="post" style="display: inline;">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="submit" class="delete-button" value="Удалить">
                        </form>
                    </div>
                </#if>
            </#list>
        </div>
    </div>

    <hr>

    <h3>Заказы на исполнении</h3>
    <div class="route-list">
        <div class="route-item">
            <#list routes as route>
                <#if route.status == "IN_PROCESS">
                    <div class="route-item-info">
                        <p><b>${route.startLocation} - ${route.endLocation}</b></p>
                        <p><b>Принят в работу:</b> ${route.formattedUpdatedAt} | <a href="/${route.id}">Подробнее...</a>
                        </p>
                    </div>
                </#if>
            </#list>
        </div>
    </div>

    <hr>

    <h3>Выполненные заказы</h3>
    <div class="route-list">
        <div class="route-item">
            <#list routes as route>
                <#if route.status == "COMPLETED">
                    <div class="route-item-info">
                        <p><b>${route.startLocation} - ${route.endLocation}</b></p>
                        <p><b>Завершен:</b> ${route.formattedUpdatedAt} | <a href="/${route.id}">Подробнее...</a></p>
                    </div>
                </#if>
            </#list>
        </div>
    </div>
    <hr>
    <a href="/customer/add_route" class="add-route-link">Добавить новый маршрут</a>
</div>
</body>
</html>
