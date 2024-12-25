<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Добавление нового маршрута</title>
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
    </style>
</head>
<body>
<div class="container">
    <h1>Добавить новый маршрут</h1>
    <hr>
    <form class="add-route-form" action="/customer/add_route" method="post" enctype="multipart/form-data">
        <label for="startLocation">Начальная точка:</label>
        <input type="text" id="startLocation" name="startLocation" required><br><br>

        <label for="endLocation">Конечная точка:</label>
        <input type="text" id="endLocation" name="endLocation" required><br><br>

        <label for="distance">Расстояние:</label>
        <input type="number" id="distance" name="distance" required><br><br>

        <label for="cargo_description">Описание груза:</label>
        <input type="text" id="cargo_description" name="cargo_description"><br><br>

        <label for="cargo_weight">Масса груза:</label>
        <input type="number" id="cargo_weight" name="cargo_weight" required><br><br>

        <label for="payment">Оплата:</label>
        <input type="number" id="payment" name="payment" required><br><br>

        <label for="order_notes">Примечания к заказу:</label>
        <input type="text" id="order_notes" name="order_notes"><br><br>

        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Добавить маршрут">
    </form>
</div>
</body>
</html>
