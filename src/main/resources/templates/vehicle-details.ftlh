<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Details</title>
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

        .images {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .images img {
            width: 800px; /* Уменьшенная ширина */
            height: 600px; /* Уменьшенная высота */
            object-fit: cover; /* Сохранение пропорций */
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .vehicle-details {
            margin-top: 20px;
        }

        .vehicle-details p {
            margin-bottom: 10px;
            font-size: 16px;
        }

        .vehicle-details strong {
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
            background-color: #c82333; /* Темнее при наведении */
        }

    </style>
</head>
<body>
<div class="container">
    <h1>Подробная информация</h1>
    <div class="images">
        <#list images as img>
            <img src="/api/v1/vehicles/images/${img.id}" height="200px">
        </#list>
    </div>
    <div class="vehicle-details">
        <p><strong>VIN:</strong> ${vehicle.vin}</p>
        <p><strong>Model:</strong> ${vehicle.model}</p>
        <p><strong>Manufacture Year:</strong> ${vehicle.manufacture_year}</p>
        <p><strong>Registration:</strong> ${vehicle.registration}</p>
        <p><strong>Fuel Type:</strong> ${vehicle.fuel_type}</p>
        <p><strong>Capacity:</strong> ${vehicle.capacity}</p>
        <p><strong>Status:</strong> ${vehicle.status}</p>
        <p><strong>Owner:</strong> <a href="/user/${vehicle.user.id}">${vehicle.user.username}</a></p>
        <#if user.id == vehicle.user.id>
            <form action="/vehicles/delete_vehicle/${vehicle.id}" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" class="delete-button" value="Удалить авто"/>
            </form>
        </#if>
    </div>
    <button onclick="window.location.href='/vehicles'">Back to List</button>
</div>
</body>
</html>
