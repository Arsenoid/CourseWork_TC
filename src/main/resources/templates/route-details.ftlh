<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Route Details</title>
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
            margin-bottom: 20px;
        }

        .route-details {
            margin-top: 20px;
        }

        .route-details p {
            margin-bottom: 10px;
            font-size: 16px;
        }

        .route-details strong {
            font-weight: bold;
        }

        button {
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

        button:hover {
            background-color: #218838;
        }

        .delete-button {
            background-color: #dc3545; /* Красный цвет для кнопки удаления */
            border-radius: 4px; /* Скругленные углы */
            padding: 10px 20px;
            margin-top: 10px;
        }

        .delete-button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Подробная информация о маршруте</h1>
    <div class="route-details">
        <p><strong>ID:</strong> ${route.id}</p>
        <p><strong>Начальная точка:</strong> ${route.startLocation}</p>
        <p><strong>Конечная точка:</strong> ${route.endLocation}</p>
        <p><strong>Дистанция:</strong> ${route.distance} км</p>
        <p><strong>Описание груза:</strong> ${route.cargo_description}</p>
        <p><strong>Вес груза:</strong> ${route.cargo_weight} кг</p>
        <p><strong>Оплата:</strong> ${route.payment} руб.</p>
<#--        <p><strong>Статус:</strong> ${route.status}</p>-->
        <p><strong>Создано:</strong> ${route.formattedCreatedAt}</p>
        <#if route.updatedAt??>
            <p><strong>Обновлено:</strong> ${route.formattedUpdatedAt}</p>
        </#if>
        <#if user.id == route.customer.id>
            <form action="/delete_route/${route.id}" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" class="delete-button" value="Удалить маршрут"/>
            </form>
        </#if>
    </div>
    <button onclick="window.location.href='/'">Back to List</button>
</div>
</body>
</html>
