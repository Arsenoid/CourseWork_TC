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
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1, h4 {
            text-align: center;
            color: #333;
        }

        hr {
            border: 0;
            border-top: 1px solid #ccc;
            margin: 20px 0;
        }

        form {
            margin-top: 20px;
        }

        form input[type="text"], form input[type="email"], form input[type="password"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 15px;
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

        .error {
            color: red;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>BLizzard Trans</h1>
    <hr>
    <h4>Регистрация</h4>
    <form action="/registration" method="post">
        Имя пользователя: <input type="text" name="username"><br><br>
        Дата рождения: <input type="date" name="dateOfBirth"><br><br>
        Номер телефона: <input type="tel" name="tel_number"><br><br>
        Эл. почта: <input type="email" name="email"><br><br>
        <#if role == "ROLE_CARRIER">
            Стаж вождения (в годах): <input type="number" name="experience"><br><br>
        </#if>
        Пароль: <input type="password" name="password"><br><br>
        <input type="hidden" name="role" value="${role}">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Зарегистрироваться">
    </form>
    <#if errorMessage??>
        <h2 class="error">${errorMessage}</h2>
    </#if>
</div>
</body>
</html>
