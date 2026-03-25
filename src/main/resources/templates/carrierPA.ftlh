<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Личный кабинет водителя</title>
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
            padding: 24px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Карточка-обертка */
        .dashboard-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 0.4s ease-out;
        }

        /* Шапка профиля */
        .profile-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 40px 32px;
            color: white;
        }

        .profile-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .profile-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 14px;
            border-radius: 40px;
            font-size: 14px;
            font-weight: 500;
        }

        .profile-stats {
            display: flex;
            gap: 24px;
            margin-top: 24px;
            flex-wrap: wrap;
        }

        .stat-chip {
            background: rgba(255, 255, 255, 0.1);
            padding: 8px 20px;
            border-radius: 40px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Навигация */
        .nav-bar {
            padding: 20px 32px;
            background: white;
            border-bottom: 1px solid #eef2f6;
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
        }

        .nav-links {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .nav-link {
            padding: 10px 24px;
            border-radius: 40px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .nav-link-secondary {
            background: #f1f5f9;
            color: #475569;
        }

        .nav-link-secondary:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        /* Секции */
        .content-section {
            padding: 32px;
        }

        .section {
            margin-bottom: 48px;
        }

        /* Убираем отступ у последней секции */
        .section:last-child {
            margin-bottom: 0;
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            padding-bottom: 12px;
            border-bottom: 2px solid #eef2f6;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .section-title-wrapper {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-icon {
            font-size: 28px;
        }

        .section-title {
            font-size: 22px;
            font-weight: 600;
            color: #0f172a;
        }

        .section-count {
            background: #f1f5f9;
            padding: 4px 12px;
            border-radius: 40px;
            font-size: 14px;
            font-weight: 500;
            color: #475569;
        }

        /* Сетка карточек */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
            gap: 24px;
        }

        /* Карточка маршрута */
        .route-card {
            background: white;
            border: 1px solid #eef2f6;
            border-radius: 20px;
            transition: all 0.25s ease;
            overflow: hidden;
        }

        .route-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px -12px rgba(0, 0, 0, 0.15);
            border-color: #e2e8f0;
        }

        .route-card-content {
            padding: 20px;
        }

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

        .status-in-process {
            background: #fef3c7;
            color: #b45309;
        }

        .status-in-process:before {
            content: "♻️";
            font-size: 12px;
            margin-right: 0px;
        }

        .status-completed {
            background: #e2e8f0;
            color: #334155;
        }

        .status-completed:before {
            content: "✓";
            font-weight: bold;
            margin-right: 4px;
        }

        .route-locations {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin: 12px 0;
            padding: 12px 0;
            border-top: 1px solid #f1f5f9;
            border-bottom: 1px solid #f1f5f9;
        }

        .location-point {
            text-align: center;
            flex: 1;
        }

        .location-city {
            font-weight: 700;
            font-size: 16px;
            color: #0f172a;
        }

        .location-label {
            font-size: 10px;
            color: #94a3b8;
            margin-top: 4px;
            text-transform: uppercase;
        }

        .arrow {
            font-size: 18px;
            color: #cbd5e1;
            padding: 0 8px;
        }

        .route-details {
            display: flex;
            justify-content: space-between;
            margin: 16px 0;
            gap: 12px;
            flex-wrap: wrap;
        }

        .detail {
            text-align: center;
            flex: 1;
        }

        .detail-label {
            font-size: 11px;
            color: #64748b;
        }

        .detail-value {
            font-weight: 600;
            font-size: 14px;
            color: #0f172a;
        }

        .route-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid #f1f5f9;
        }

        .btn-complete {
            padding: 10px 15px;
            background: rgba(20, 188, 84, 0.2);
            color: green;
            border: #218838 solid 1px;
            border-radius: 40px;
            font-weight: 500;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-complete:hover {
            background: rgba(106, 241, 156, 0.82);
            transform: translateY(-2px);
        }

        .btn-link {
            padding: 10px 20px;
            background: #f1f5f9;
            color: #3b82f6;
            text-decoration: none;
            border-radius: 40px;
            font-weight: 500;
            font-size: 13px;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-link:hover {
            background: #e2e8f0;
        }

        /* Карточка транспорта */
        .vehicle-card {
            background: white;
            border: 1px solid #eef2f6;
            border-radius: 20px;
            transition: all 0.25s ease;
        }

        .vehicle-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px -12px rgba(0, 0, 0, 0.15);
        }

        .vehicle-card-content {
            padding: 20px;
        }

        .vehicle-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .vehicle-model {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
        }

        .vehicle-vin {
            font-size: 12px;
            color: #64748b;
            font-family: monospace;
        }

        .vehicle-status {
            display: inline-flex;
            align-items: center;
            /*gap: 8px;*/
            padding: 7px 10px;
            border-radius: 100px;
            font-size: 11px;
            font-weight: 600;
            white-space: nowrap;
        }

        .status-free {
            background: #d8fde5;
            color: #15803d;
        }

        .status-busy {
            background: #fef3c7;
            color: #b45309;
        }

        .status-broken {
            background: #fee2e2;
            color: #dc2626;
        }

        .vehicle-footer {
            margin-top: 16px;
            padding-top: 12px;
            border-top: 1px solid #f1f5f9;
        }

        /* Пустое состояние */
        .empty-state {
            text-align: center;
            padding: 48px 20px;
            background: #fafcff;
            border-radius: 20px;
            border: 1px dashed #cbd5e1;
        }

        .empty-icon {
            font-size: 48px;
            margin-bottom: 16px;
            opacity: 0.6;
        }

        .empty-state h4 {
            color: #334155;
            margin-bottom: 8px;
            font-size: 16px;
        }

        .empty-state p {
            color: #64748b;
            font-size: 14px;
        }

        .btn-add {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 8px 14px;
            background: #22c55e;
            color: white;
            text-decoration: none;
            border-radius: 60px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-add:hover {
            background: #16a34a;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(34, 197, 94, 0.3);
        }

        /* Адаптивность */
        @media (max-width: 768px) {
            body {
                padding: 16px;
            }

            .profile-header {
                padding: 28px 20px;
            }

            .nav-bar {
                padding: 16px 20px;
                flex-direction: column;
                align-items: stretch;
            }

            .nav-links {
                justify-content: center;
            }

            .content-section {
                padding: 20px;
            }

            .cards-grid {
                grid-template-columns: 1fr;
            }

            .route-locations {
                flex-direction: column;
                gap: 8px;
            }

            .arrow {
                transform: rotate(90deg);
            }

            .route-footer {
                flex-direction: column;
                gap: 12px;
            }

            .route-footer .btn-link,
            .route-footer .btn-complete {
                width: 100%;
                justify-content: center;
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
    <div class="dashboard-card">
        <!-- ШАПКА ПРОФИЛЯ -->
        <div class="profile-header">
            <h1>
                🚚 Личный кабинет
                <span class="profile-badge">Водитель</span>
            </h1>
            <div class="profile-stats">
                <div class="stat-chip">
                    <span>👤</span>
                    <span>${user.username!''}</span>
                </div>
                <div class="stat-chip">
                    <span>📧</span>
                    <span>${user.email!''}</span>
                </div>
                <#assign activeOrders = orders?filter(o -> o.route.status == "IN_PROCESS")?size>
                <div class="stat-chip">
                    <span>🚚</span>
                    <span>Активных заказов: ${activeOrders}</span>
                </div>
            </div>
        </div>

        <!-- НАВИГАЦИЯ -->
        <div class="nav-bar">
            <div class="nav-links">
                <a href="/" class="nav-link nav-link-secondary">🏠 На главную</a>
            </div>
        </div>

        <!-- ОСНОВНОЙ КОНТЕНТ -->
        <div class="content-section">
            <!-- МОЙ ТРАНСПОРТ -->
            <div class="section">
                <div class="section-header">
                    <div class="section-title-wrapper">
                        <span class="section-icon">🚗</span>
                        <h2 class="section-title">Мой транспорт</h2>
                        <span class="section-count">${vehicles?size}</span>
                    </div>
                    <!-- КНОПКА ДОБАВЛЕНИЯ ТРАНСПОРТА -->
                    <a href="/vehicles/add_vehicle" class="btn-add">
                        ➕ Добавить транспорт
                    </a>
                </div>

                <div class="cards-grid">
                    <#assign hasVehicles = false>
                    <#list vehicles as vehicle>
                        <#assign hasVehicles = true>
                        <div class="vehicle-card">
                            <div class="vehicle-card-content">
                                <div class="vehicle-header">
                                    <div>
                                        <div class="vehicle-model">${vehicle.model!''}</div>
                                        <div class="vehicle-vin">VIN: ${vehicle.vin!''}</div>
                                    </div>
                                    <#if vehicle.status == "FREE">
                                        <span class="vehicle-status status-free">🟢 Свободен</span>
                                    <#elseif vehicle.status == "BUSY">
                                        <span class="vehicle-status status-busy">🔴 Занят</span>
                                    <#else>
                                        <span class="vehicle-status status-broken">⚠️ Неисправен</span>
                                    </#if>
                                </div>
                                <div class="vehicle-footer">
                                    <a href="/vehicles/${vehicle.vin}" class="btn-link"
                                       style="width: 100%; justify-content: center;">Подробнее →</a>
                                </div>
                            </div>
                        </div>
                    </#list>
                    <#if !hasVehicles>
                        <div class="empty-state" style="grid-column: 1 / -1;">
                            <div class="empty-icon">🚗</div>
                            <h4>Нет транспорта</h4>
                            <p>Добавьте транспортное средство, чтобы принимать заказы</p>
                        </div>
                    </#if>
                </div>
            </div>
            <!-- МАРШРУТЫ НА ВЫПОЛНЕНИИ -->
            <div class="section">
                <div class="section-header">
                    <div class="section-title-wrapper">
                        <span class="section-icon">🚚</span>
                        <h2 class="section-title">Маршруты на выполнении</h2>
                        <#assign processCount = orders?filter(o -> o.route.status == "IN_PROCESS")?size>
                        <span class="section-count">${processCount}</span>
                    </div>
                </div>

                <div class="cards-grid">
                    <#assign hasProcess = false>
                    <#list orders as order>
                        <#if order.route.status == "IN_PROCESS">
                            <#assign hasProcess = true>
                            <div class="route-card">
                                <div class="route-card-content">
                                    <div class="status-badge status-in-process">
                                        В процессе доставки
                                    </div>

                                    <div class="route-locations">
                                        <div class="location-point">
                                            <div class="location-city">${order.route.startLocation!''}</div>
                                            <div class="location-label">Отправление</div>
                                        </div>
                                        <div class="arrow">→</div>
                                        <div class="location-point">
                                            <div class="location-city">${order.route.endLocation!''}</div>
                                            <div class="location-label">Назначение</div>
                                        </div>
                                    </div>

                                    <div class="route-details">
                                        <div class="detail">
                                            <div class="detail-label">💰 Оплата</div>
                                            <div class="detail-value">${order.route.payment!0} ₽</div>
                                        </div>
                                        <div class="detail">
                                            <div class="detail-label">📏 Расстояние</div>
                                            <div class="detail-value">${order.route.distance!0} км</div>
                                        </div>
                                        <div class="detail">
                                            <div class="detail-label">📅 Принят</div>
                                            <div class="detail-value">${order.route.formattedCreatedAt!''}</div>
                                        </div>
                                    </div>

                                    <div class="route-footer">
                                        <a href="/${order.route.id}" class="btn-link">Подробнее →</a>
                                        <form action="/carrier/order/complete/${order.id}" method="post"
                                              style="margin: 0;">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                                            <button type="submit" class="btn-complete">✅ Завершить доставку</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </#if>
                    </#list>
                    <#if !hasProcess>
                        <div class="empty-state" style="grid-column: 1 / -1;">
                            <div class="empty-icon">📭</div>
                            <h4>Нет активных маршрутов</h4>
                            <p>У вас нет маршрутов на исполнении</p>
                        </div>
                    </#if>
                </div>
            </div>

            <!-- ЗАВЕРШЕННЫЕ МАРШРУТЫ -->
            <div class="section">
                <div class="section-header">
                    <div class="section-title-wrapper">
                        <span class="section-icon">✅</span>
                        <h2 class="section-title">Завершенные маршруты</h2>
                        <#assign completedCount = orders?filter(o -> o.route.status == "COMPLETED")?size>
                        <span class="section-count">${completedCount}</span>
                    </div>
                </div>

                <div class="cards-grid">
                    <#assign hasCompleted = false>
                    <#list orders as order>
                        <#if order.route.status == "COMPLETED">
                            <#assign hasCompleted = true>
                            <div class="route-card">
                                <div class="route-card-content">
                                    <div class="status-badge status-completed">
                                        Доставлен
                                    </div>

                                    <div class="route-locations">
                                        <div class="location-point">
                                            <div class="location-city">${order.route.startLocation!''}</div>
                                            <div class="location-label">Отправление</div>
                                        </div>
                                        <div class="arrow">→</div>
                                        <div class="location-point">
                                            <div class="location-city">${order.route.endLocation!''}</div>
                                            <div class="location-label">Назначение</div>
                                        </div>
                                    </div>

                                    <div class="route-details">
                                        <div class="detail">
                                            <div class="detail-label">💰 Оплата</div>
                                            <div class="detail-value">${order.route.payment!0} ₽</div>
                                        </div>
                                        <div class="detail">
                                            <div class="detail-label">📏 Расстояние</div>
                                            <div class="detail-value">${order.route.distance!0} км</div>
                                        </div>
                                        <#if order.route.formattedUpdatedAt??>
                                            <div class="detail">
                                                <div class="detail-label">📅 Завершен</div>
                                                <div class="detail-value">${order.route.formattedUpdatedAt!''}</div>
                                            </div>
                                        </#if>
                                    </div>

                                    <div class="route-footer">
                                        <a href="/${order.route.id}" class="btn-link">Подробнее →</a>
                                    </div>
                                </div>
                            </div>
                        </#if>
                    </#list>
                    <#if !hasCompleted>
                        <div class="empty-state" style="grid-column: 1 / -1;">
                            <div class="empty-icon">📦</div>
                            <h4>Нет завершенных маршрутов</h4>
                            <p>Завершенные маршруты будут отображаться здесь</p>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>