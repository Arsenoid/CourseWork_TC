<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Транспортная логистика</title>
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
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: #0f172a;
            line-height: 1.5;
            min-height: 100vh;
        }

        /* Контейнер */
        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 24px;
        }

        /* Карточка-обертка */
        .card {
            background: white;
            border-radius: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05), 0 1px 2px rgba(0, 0, 0, 0.03);
            border: 1px solid #eef2f6;
            overflow: hidden;
        }

        /* Шапка */
        .header {
            padding: 28px 32px;
            border-bottom: 1px solid #eef2f6;
            background: white;
        }

        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 20px;
        }

        .logo h1 {
            font-size: 28px;
            font-weight: 700;
            background: linear-gradient(135deg, #2563eb, #1e40af);
            -webkit-background-clip: text;
            background-clip: text;
            color: #2563eb;
            letter-spacing: -0.3px;
        }

        .logo p {
            font-size: 13px;
            color: #64748b;
            margin-top: 4px;
        }

        .user-section {
            display: flex;
            align-items: center;
            gap: 20px;
            background: #f8fafc;
            padding: 6px 16px 6px 20px;
            border-radius: 100px;
        }

        .user-greeting {
            font-size: 14px;
            font-weight: 500;
            color: #334155;
        }

        .user-greeting i {
            color: #3b82f6;
            font-style: normal;
            font-weight: 600;
        }

        .logout-btn {
            background: none;
            border: none;
            color: #ef4444;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            padding: 8px 12px;
            border-radius: 40px;
            transition: all 0.2s;
        }

        .logout-btn:hover {
            background: #fef2f2;
        }

        /* Навигация */
        .nav-links {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 8px;
            justify-content: flex-end;
        }

        .nav-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 40px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s;
            border: none;
            cursor: pointer;
            background: #f1f5f9;
            color: #475569;
        }

        .nav-btn:hover {
            background: #e2e8f0;
            transform: translateY(-1px);
        }

        .nav-btn-primary {
            background: #3b82f6;
            color: white;
        }

        .nav-btn-primary:hover {
            background: #2563eb;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        .nav-btn-danger {
            background: #ef4444;
            color: white;
        }

        .nav-btn-danger:hover {
            background: #dc2626;
        }

        /* Секция маршрутов */
        .routes-section {
            padding: 28px 32px;
        }

        .section-title {
            font-size: 22px;
            font-weight: 600;
            color: #0f172a;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title:before {
            content: "📦";
            font-size: 24px;
        }

        /* Сетка карточек маршрутов */
        .routes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
            gap: 20px;
        }

        .route-card {
            background: white;
            border-radius: 20px;
            border: 1px solid #eef2f6;
            transition: all 0.25s ease;
            overflow: hidden;
        }

        .route-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px -12px rgba(0, 0, 0, 0.15);
            border-color: #e2e8f0;
        }

        .route-card-inner {
            padding: 20px;
        }

        /* Статус бейдж */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 12px;
            border-radius: 100px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 16px;
        }

        .status-active {
            background: #dcfce7;
            color: #15803d;
        }

        .status-active:before {
            content: "●";
            font-size: 10px;
        }

        /* Локации */
        .route-locations {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin: 16px 0;
            padding: 12px 0;
            border-top: 1px solid #f1f5f9;
            border-bottom: 1px solid #f1f5f9;
        }

        .location {
            text-align: center;
            flex: 1;
        }

        .location-city {
            font-weight: 700;
            font-size: 18px;
            color: #0f172a;
        }

        .location-label {
            font-size: 11px;
            color: #94a3b8;
            margin-top: 4px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .route-arrow {
            font-size: 20px;
            color: #cbd5e1;
            padding: 0 12px;
        }

        /* Инфо строка */
        .route-info {
            display: flex;
            justify-content: space-between;
            margin: 16px 0;
            padding: 12px;
            background: #f8fafc;
            border-radius: 14px;
        }

        .info-item {
            text-align: center;
            flex: 1;
        }

        .info-label {
            font-size: 11px;
            color: #64748b;
            margin-bottom: 4px;
        }

        .info-value {
            font-weight: 600;
            font-size: 15px;
            color: #0f172a;
        }

        /* Футер карточки */
        .route-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 16px;
        }

        .route-price {
            font-size: 24px;
            font-weight: 700;
            color: #36a761;
        }

        .route-price small {
            font-size: 13px;
            font-weight: 400;
            color: #64748b;
        }

        .details-link {
            padding: 10px 20px;
            background: #f1f5f9;
            color: #3b82f6;
            text-decoration: none;
            border-radius: 40px;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.2s;
        }

        .details-link:hover {
            background: #3b82f6;
            color: white;
        }

        .details-link:after {
            content: " →";
            transition: transform 0.2s;
            display: inline-block;
        }

        .details-link:hover:after {
            transform: translateX(3px);
        }

        /* Пустое состояние */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: #fafcff;
            border-radius: 20px;
            border: 1px dashed #cbd5e1;
        }

        .empty-icon {
            font-size: 56px;
            margin-bottom: 16px;
            opacity: 0.7;
        }

        .empty-state h3 {
            color: #334155;
            margin-bottom: 8px;
            font-size: 18px;
        }

        .empty-state p {
            color: #64748b;
            font-size: 14px;
        }

        /* Неавторизованный пользователь */
        .unauth-card {
            text-align: center;
            padding: 48px 32px;
        }

        .unauth-card h3 {
            font-size: 22px;
            margin-bottom: 12px;
        }

        .login-btn {
            display: inline-block;
            margin-top: 24px;
            padding: 12px 32px;
            background: #3b82f6;
            color: white;
            text-decoration: none;
            border-radius: 40px;
            font-weight: 500;
            transition: all 0.2s;
        }

        .login-btn:hover {
            background: #2563eb;
            transform: translateY(-2px);
        }

        .register-link {
            display: inline-block;
            margin-top: 16px;
            color: #3b82f6;
            text-decoration: none;
            font-size: 14px;
        }

        hr {
            border: none;
            border-top: 1px solid #eef2f6;
            margin: 20px 0;
        }

        /* Адаптивность */
        @media (max-width: 768px) {
            .container {
                padding: 16px;
            }

            .header {
                padding: 20px;
            }

            .routes-section {
                padding: 20px;
            }

            .routes-grid {
                grid-template-columns: 1fr;
            }

            .route-locations {
                flex-direction: column;
                gap: 10px;
            }

            .route-arrow {
                transform: rotate(90deg);
            }

            .route-info {
                flex-direction: column;
                gap: 12px;
            }

            .info-item {
                text-align: left;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .header-top {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <!-- ШАПКА -->
        <div class="header">
            <div class="header-top">
                <div class="logo">
                    <h1>️🚚 Blizzard Trans</h1>
                    <p>Транспортная логистика</p>
                </div>

                <#if user.email??>
                    <div class="user-section">
                        <span class="user-greeting">👋 Привет, <i>${user.username}</i></span>
                        <form action="/logout" method="post" style="margin: 0;">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button type="submit" class="logout-btn">Выйти</button>
                        </form>
                    </div>
                </#if>
            </div>

            <!-- НАВИГАЦИЯ ПО РОЛЯМ -->
            <#if user.email??>
                <div class="nav-links">
                    <#if user.isAdmin()>
                        <a href="/admin" class="nav-btn nav-btn-danger">👑 Админ-панель</a>
                        <a href="/customer" class="nav-btn nav-btn-primary">📋 Кабинет заказчика</a>
                        <a href="/carrier" class="nav-btn nav-btn-primary">🚚 Кабинет перевозчика</a>
                    <#elseif user.isCustomer()>
                        <a href="/customer" class="nav-btn nav-btn-primary">📋 Кабинет заказчика</a>
                    <#elseif user.isCarrier()>
                        <a href="/carrier" class="nav-btn nav-btn-primary">🚚 Кабинет перевозчика</a>
                    </#if>
                </div>
            </#if>
        </div>

        <!-- ОСНОВНОЙ КОНТЕНТ -->
        <div class="routes-section">
            <#if user.email??>
                <div class="section-title">Доступные маршруты</div>

                <div class="routes-grid">
                    <#list routes as route>
                        <#if route.status == "ACTIVE">
                            <div class="route-card">
                                <div class="route-card-inner">
                                    <div class="status-badge status-active">
                                        АКТИВЕН
                                    </div>

                                    <div class="route-locations">
                                        <div class="location">
                                            <div class="location-city">${route.startLocation}</div>
                                            <div class="location-label">Отправление</div>
                                        </div>
                                        <div class="route-arrow">→</div>
                                        <div class="location">
                                            <div class="location-city">${route.endLocation}</div>
                                            <div class="location-label">Назначение</div>
                                        </div>
                                    </div>

                                    <div class="route-info">
                                        <div class="info-item">
                                            <div class="info-label">📍 Расстояние</div>
                                            <div class="info-value">${route.distance} км</div>
                                        </div>
                                        <div class="info-item">
                                            <div class="info-label">⚖️ Масса</div>
                                            <div class="info-value">${route.cargo_weight} кг</div>
                                        </div>
                                    </div>

                                    <div class="route-footer">
                                        <div class="route-price">
                                            ${route.payment} <small>₽</small>
                                        </div>
                                        <a href="/${route.id}" class="details-link">Подробнее</a>
                                    </div>
                                </div>
                            </div>
                        </#if>
                    <#else>
                        <div class="empty-state">
                            <div class="empty-icon">📭</div>
                            <h3>Нет доступных маршрутов</h3>
                            <p>На данный момент нет активных маршрутов для отображения</p>
                        </div>
                    </#list>
                </div>

            <#else>
                <!-- НЕ АВТОРИЗОВАН -->
                <div class="unauth-card">
                    <div class="empty-icon">🔐</div>
                    <h3>Добро пожаловать в Blizzard Trans</h3>
                    <p>Войдите в систему, чтобы просматривать доступные маршруты</p>
                    <a href="/login" class="login-btn">Войти в систему →</a>
                </div>
            </#if>
        </div>
    </div>
</div>
</body>
</html>