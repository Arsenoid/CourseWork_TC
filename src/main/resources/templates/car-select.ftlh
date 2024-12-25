<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Мой транспорт</title>
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.5.1/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.5.1/dist/sweetalert2.all.min.js"></script>
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

        h1, h3 {
            text-align: center;
            color: #333;
        }

        .vehicle-list {
            margin-top: 20px;
        }

        .vehicle-item {
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

        .select-button {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .select-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<div class="container">
    <h3>Мой транспорт</h3>
    <h4>Масса груза: ${route.cargo_weight} кг</h4>
    <div class="vehicle-list">
        <#list vehicles as vehicle>
            <div class="vehicle-item" id="vehicle-${vehicle.id}">
                <div>
                    <p><b>${vehicle.model}</b></p>
                    <p><b>VIN:</b> ${vehicle.vin}</p>
                    <p><b>Грузоподъемность:</b> ${vehicle.loadCapacity} кг</p>
                </div>
                <div>
                    <form id="form-${vehicle.id}" action="/carrier/select_car/create_order" method="post" style="display: inline;" onsubmit="handleSubmit(event, ${vehicle.id}, ${route.cargo_weight}, ${vehicle.loadCapacity})">
                        <input type="hidden" name="routeId" value="${route.id}">
                        <input type="hidden" name="carrierId" value="${carrierId}">
                        <input type="hidden" name="vehicleId" value="${vehicle.id}">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" class="select-button" value="Выбрать">
                    </form>
                </div>
            </div>
        <#else>
            <h3>Нет транспорта</h3>
        </#list>
    </div>
</div>

<script>
    function handleSubmit(event, vehicleId, cargoWeight, loadCapacity) {
        event.preventDefault();
        if (loadCapacity < cargoWeight) {
            Swal.fire({
                icon: 'error',
                title: 'Ошибка',
                text: 'Грузоподъемность автомобиля меньше массы груза!'
            });
        } else {
            document.getElementById('form-' + vehicleId).submit();
        }
    }
</script>
</body>
</html>
