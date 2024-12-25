<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Редактировать маршрут</title>
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
    <h1>Редактировать маршрут</h1>
    <form class="add-route-form" action="/customer/edit_route/${route.id}" method="post" enctype="multipart/form-data">
        <label for="startLocation">Начальная точка:</label>
        <input type="text" id="startLocation" name="startLocation" value="${route.startLocation}" required><br><br>

        <label for="endLocation">Конечная точка:</label>
        <input type="text" id="endLocation" name="endLocation" value="${route.endLocation}" required><br><br>

        <label for="distance">Расстояние:</label>
        <input type="number" id="distance" name="distance" value="${route.distance}"><br><br>

        <label for="cargo_description">Описание груза:</label>
        <input type="text" id="cargo_description" name="cargo_description" value="${route.cargo_description}"><br><br>

        <label for="cargo_weight">Масса груза:</label>
        <input type="number" id="cargo_weight" name="cargo_weight" value="${route.cargo_weight}" required><br><br>

        <label for="payment">Оплата:</label>
        <input type="number" id="payment" name="payment" value="${route.payment}" required><br><br>

        <label for="order_notes">Примечания к заказу:</label>
        <input type="text" id="order_notes" name="order_notes" value="${route.order_notes}"><br><br>

        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Сохранить">
    </form>

</div>
</body>
</html>
