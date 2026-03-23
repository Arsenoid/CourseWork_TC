<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Выбор роли</title>
    <link rel="stylesheet" href="/css/base.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            width: 100%;
        }

        /* Карточка выбора */
        .role-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            overflow: hidden;
            animation: fadeInUp 0.5s ease-out;
        }

        /* Шапка */
        .role-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 40px 32px;
            text-align: center;
            color: white;
        }

        .logo {
            font-size: 56px;
            margin-bottom: 16px;
        }

        .role-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 12px;
        }

        .role-header p {
            font-size: 15px;
            color: #94a3b8;
        }

        /* Основной контент */
        .role-content {
            padding: 40px 32px;
        }

        .role-question {
            text-align: center;
            margin-bottom: 40px;
        }

        .role-question h2 {
            font-size: 24px;
            font-weight: 600;
            color: #0f172a;
            margin-bottom: 8px;
        }

        .role-question p {
            color: #64748b;
            font-size: 14px;
        }

        /* Сетка ролей */
        .roles-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
            margin-bottom: 32px;
        }

        .role-option {
            background: #f8fafc;
            border: 2px solid #eef2f6;
            border-radius: 24px;
            padding: 32px 24px;
            text-align: center;
            text-decoration: none;
            transition: all 0.3s ease;
            display: block;
            cursor: pointer;
        }

        .role-option:hover {
            transform: translateY(-6px);
            border-color: #3b82f6;
            box-shadow: 0 20px 30px -12px rgba(59, 130, 246, 0.2);
            background: white;
        }

        .role-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .role-title {
            font-size: 22px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 12px;
        }

        .role-description {
            font-size: 14px;
            color: #64748b;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .role-features {
            list-style: none;
            padding: 0;
            margin-top: 16px;
        }

        .role-features li {
            font-size: 13px;
            color: #475569;
            padding: 6px 0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .role-features li:before {
            content: "✓";
            color: #22c55e;
            font-weight: bold;
        }

        .role-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 24px;
            background: #3b82f6;
            color: white;
            border-radius: 40px;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.2s;
        }

        .role-option:hover .role-button {
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        /* Дополнительная информация */
        .info-section {
            text-align: center;
            padding-top: 24px;
            border-top: 1px solid #eef2f6;
            margin-top: 8px;
        }

        .info-section p {
            font-size: 13px;
            color: #64748b;
        }

        .login-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
        }

        .login-link:hover {
            text-decoration: underline;
        }

        /* Адаптивность */
        @media (max-width: 768px) {
            body {
                padding: 16px;
            }

            .role-header {
                padding: 32px 24px;
            }

            .role-content {
                padding: 28px 20px;
            }

            .roles-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .role-option {
                padding: 24px 20px;
            }

            .role-icon {
                font-size: 48px;
            }

            .role-title {
                font-size: 20px;
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="role-card">
        <!-- ШАПКА -->
        <div class="role-header">
            <div class="logo">🚚</div>
            <h1>Blizzard Trans</h1>
            <p>Транспортная логистика</p>
        </div>

        <!-- ОСНОВНОЙ КОНТЕНТ -->
        <div class="role-content">
            <div class="role-question">
                <h2>Кем вы являетесь?</h2>
                <p>Выберите роль, которая соответствует вашей деятельности</p>
            </div>

            <div class="roles-grid">
                <!-- Роль: Исполнитель (Водитель) -->
                <a href="/registration?role=ROLE_CARRIER" class="role-option">
                    <div class="role-icon">🚚</div>
                    <div class="role-title">Исполнитель</div>
                    <div class="role-description">
                        Выполняете перевозки и доставку грузов
                    </div>
                    <ul class="role-features">
                        <li>Управление автопарком</li>
                        <li>Прием заказов на доставку</li>
                        <li>Отслеживание маршрутов</li>
                    </ul>
                    <span class="role-button">Выбрать →</span>
                </a>

                <!-- Роль: Заказчик -->
                <a href="/registration?role=ROLE_CUSTOMER" class="role-option">
                    <div class="role-icon">📋</div>
                    <div class="role-title">Заказчик</div>
                    <div class="role-description">
                        Заказываете перевозку грузов
                    </div>
                    <ul class="role-features">
                        <li>Создание маршрутов</li>
                        <li>Управление заказами</li>
                        <li>Отслеживание доставки</li>
                    </ul>
                    <span class="role-button">Выбрать →</span>
                </a>
            </div>

            <div class="info-section">
                <p>Уже есть аккаунт? <a href="/login" class="login-link">Войти в систему</a></p>
            </div>
        </div>
    </div>
</div>
</body>
</html>