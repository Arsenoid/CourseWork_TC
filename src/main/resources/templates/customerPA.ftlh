<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Личный кабинет заказчика</title>
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
        }

        /* Шапка профиля */
        .profile-header {
            background: linear-gradient(135deg, #22385a 0%, #0f172a 100%);
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
        }

        .nav-link-secondary {
            background: #f1f5f9;
            color: #475569;
            padding: 10px 24px;
            border-radius: 40px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .nav-link-secondary:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        /* Секции заказов */
        .orders-section {
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

        /* Сетка заказов */
        .orders-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 24px;
        }

        .order-card {
            background: white;
            border: 1px solid #eef2f6;
            border-radius: 20px;
            transition: all 0.25s ease;
            overflow: hidden;
        }

        .order-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px -12px rgba(0, 0, 0, 0.15);
            border-color: #e2e8f0;
        }

        .order-card-content {
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

        .status-in-process {
            background: #fef3c7;
            color: #b45309;
        }

        .status-in-process:before {
            content: "🚚";
            font-size: 12px;
            margin-right: 4px;
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

        /* Локации */
        .order-locations {
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

        /* Детали заказа */
        .order-details {
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

        /* Действия - для активных заказов (две строки) */
        .order-actions-stacked {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid #f1f5f9;
        }

        .order-actions-row {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .order-actions-full {
            width: 100%;
        }

        .order-actions-full button,
        .order-actions-full .btn-delete {
            width: 100%;
            justify-content: center;
        }

        /* Действия - для остальных заказов (одна строка) */
        .order-actions-inline {
            display: flex;
            gap: 12px;
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid #f1f5f9;
        }

        /* Кнопки */
        .btn-sm {
            padding: 8px 16px;
            border-radius: 40px;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            white-space: nowrap;
            flex: 1;
            justify-content: center;
        }

        .btn-edit {
            background: #fef3c7;
            color: #b45309;
        }

        .btn-edit:hover {
            background: #fde68a;
            transform: translateY(-1px);
        }

        .btn-delete {
            background: #fee2e2;
            color: #dc2626;
        }

        .btn-delete:hover {
            background: #fecaca;
            transform: translateY(-1px);
        }

        .btn-link {
            background: #f1f5f9;
            color: #3b82f6;
        }

        .btn-link:hover {
            background: #e2e8f0;
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
            }

            .orders-section {
                padding: 20px;
            }

            .orders-grid {
                grid-template-columns: 1fr;
            }

            .order-locations {
                flex-direction: column;
                gap: 8px;
            }

            .arrow {
                transform: rotate(90deg);
            }

            .order-actions-row {
                flex: 1;
            }

            .order-actions-row .btn-sm {
                flex: 1;
                justify-content: center;
            }
        }

        /* Анимация */
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

        .dashboard-card {
            animation: fadeInUp 0.4s ease-out;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="dashboard-card">
        <!-- ШАПКА ПРОФИЛЯ -->
        <div class="profile-header">
            <h1>
                👋 Личный кабинет
                <span class="profile-badge">Заказчик</span>
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
            </div>
        </div>

        <!-- НАВИГАЦИЯ -->
        <div class="nav-bar">
            <a href="/" class="nav-link-secondary">🏠 На главную</a>
        </div>

        <!-- ЗАКАЗЫ -->
        <div class="orders-section">
            <!-- РАЗМЕЩЕННЫЕ ЗАКАЗЫ (ACTIVE) -->
            <div class="section">
                <div class="section-header">
                    <div class="section-title-wrapper">
                        <span class="section-icon">📋</span>
                        <h2 class="section-title">Размещенные заказы</h2>
                        <#assign activeCount = routes?filter(r -> r.status == "ACTIVE")?size>
                        <span class="section-count">${activeCount}</span>
                    </div>
                    <a href="/customer/add_route" class="btn-add">
                        ➕ Разместить новый заказ
                    </a>
                </div>

                <div class="orders-grid">
                    <#assign hasActive = false>
                    <#list routes as route>
                        <#if route.status == "ACTIVE">
                            <#assign hasActive = true>
                            <div class="order-card">
                                <div class="order-card-content">
                                    <div class="status-badge status-active">
                                        Ожидает исполнителя
                                    </div>

                                    <div class="order-locations">
                                        <div class="location-point">
                                            <div class="location-city">${route.startLocation!''}</div>
                                            <div class="location-label">Отправление</div>
                                        </div>
                                        <div class="arrow">→</div>
                                        <div class="location-point">
                                            <div class="location-city">${route.endLocation!''}</div>
                                            <div class="location-label">Назначение</div>
                                        </div>
                                    </div>

                                    <div class="order-details">
                                        <div class="detail">
                                            <div class="detail-label">💰 Оплата</div>
                                            <div class="detail-value">${route.payment!0} ₽</div>
                                        </div>
                                        <div class="detail">
                                            <div class="detail-label">📏 Расстояние</div>
                                            <div class="detail-value">${route.distance!0} км</div>
                                        </div>
                                        <div class="detail">
                                            <div class="detail-label">📅 Создан</div>
                                            <div class="detail-value">${route.formattedCreatedAt!''}</div>
                                        </div>
                                    </div>

                                    <!-- КНОПКИ В ДВЕ СТРОКИ: Редактировать и Подробнее на одной, Удалить отдельно -->
                                    <div class="order-actions-stacked">
                                        <div class="order-actions-row">
                                            <a href="/customer/edit_route/${route.id}" class="btn-sm btn-edit">✏️
                                                Редактировать</a>
                                            <a href="/${route.id}" class="btn-sm btn-link">Подробнее →</a>
                                        </div>
                                        <div class="order-actions-full">
                                            <form action="/customer/delete_route/${route.id}" method="post"
                                                  style="margin: 0;">
                                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                                <button type="submit" class="btn-sm btn-delete"
                                                        style="width: 100%; justify-content: center;">🗑️ Удалить маршрут
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </#if>
                    </#list>
                    <#if !hasActive>
                        <div class="empty-state" style="grid-column: 1 / -1;">
                            <div class="empty-icon">📭</div>
                            <h4>Нет размещенных заказов</h4>
                            <p>Создайте новый маршрут, чтобы найти исполнителя</p>
                        </div>
                    </#if>
                </div>
            </div>

            <!-- ЗАКАЗЫ НА ИСПОЛНЕНИИ (IN_PROCESS) -->
            <div class="section">
                <div class="section-header">
                    <div class="section-title-wrapper">
                        <span class="section-icon">🚚</span>
                        <h2 class="section-title">Заказы на исполнении</h2>
                        <#assign processCount = routes?filter(r -> r.status == "IN_PROCESS")?size>
                        <span class="section-count">${processCount}</span>
                    </div>
                </div>

                <div class="orders-grid">
                    <#assign hasProcess = false>
                    <#list routes as route>
                        <#if route.status == "IN_PROCESS">
                            <#assign hasProcess = true>
                            <div class="order-card">
                                <div class="order-card-content">
                                    <div class="status-badge status-in-process">
                                        В процессе доставки
                                    </div>

                                    <div class="order-locations">
                                        <div class="location-point">
                                            <div class="location-city">${route.startLocation!''}</div>
                                            <div class="location-label">Отправление</div>
                                        </div>
                                        <div class="arrow">→</div>
                                        <div class="location-point">
                                            <div class="location-city">${route.endLocation!''}</div>
                                            <div class="location-label">Назначение</div>
                                        </div>
                                    </div>

                                    <div class="order-details">
                                        <div class="detail">
                                            <div class="detail-label">💰 Оплата</div>
                                            <div class="detail-value">${route.payment!0} ₽</div>
                                        </div>
                                        <div class="detail">
                                            <div class="detail-label">📏 Расстояние</div>
                                            <div class="detail-value">${route.distance!0} км</div>
                                        </div>
                                        <#if route.formattedUpdatedAt??>
                                            <div class="detail">
                                                <div class="detail-label">📅 Принят</div>
                                                <div class="detail-value">${route.formattedUpdatedAt!''}</div>
                                            </div>
                                        </#if>
                                    </div>

                                    <!-- КНОПКИ В ОДНУ СТРОКУ -->
                                    <div class="order-actions-inline">
                                        <a href="/${route.id}" class="btn-sm btn-link">Подробнее →</a>
                                    </div>
                                </div>
                            </div>
                        </#if>
                    </#list>
                    <#if !hasProcess>
                        <div class="empty-state" style="grid-column: 1 / -1;">
                            <div class="empty-icon">🚚</div>
                            <h4>Нет заказов на исполнении</h4>
                            <p>Когда водитель примет ваш заказ, он появится здесь</p>
                        </div>
                    </#if>
                </div>
            </div>

            <!-- ВЫПОЛНЕННЫЕ ЗАКАЗЫ (COMPLETED) -->
            <div class="section">
                <div class="section-header">
                    <div class="section-title-wrapper">
                        <span class="section-icon">✅</span>
                        <h2 class="section-title">Выполненные заказы</h2>
                        <#assign completedCount = routes?filter(r -> r.status == "COMPLETED")?size>
                        <span class="section-count">${completedCount}</span>
                    </div>
                </div>

                <div class="orders-grid">
                    <#assign hasCompleted = false>
                    <#list routes as route>
                        <#if route.status == "COMPLETED">
                            <#assign hasCompleted = true>
                            <div class="order-card">
                                <div class="order-card-content">
                                    <div class="status-badge status-completed">
                                        Доставлен
                                    </div>

                                    <div class="order-locations">
                                        <div class="location-point">
                                            <div class="location-city">${route.startLocation!''}</div>
                                            <div class="location-label">Отправление</div>
                                        </div>
                                        <div class="arrow">→</div>
                                        <div class="location-point">
                                            <div class="location-city">${route.endLocation!''}</div>
                                            <div class="location-label">Назначение</div>
                                        </div>
                                    </div>

                                    <div class="order-details">
                                        <div class="detail">
                                            <div class="detail-label">💰 Оплата</div>
                                            <div class="detail-value">${route.payment!0} ₽</div>
                                        </div>
                                        <div class="detail">
                                            <div class="detail-label">📏 Расстояние</div>
                                            <div class="detail-value">${route.distance!0} км</div>
                                        </div>
                                        <#if route.formattedUpdatedAt??>
                                            <div class="detail">
                                                <div class="detail-label">📅 Завершен</div>
                                                <div class="detail-value">${route.formattedUpdatedAt!''}</div>
                                            </div>
                                        </#if>
                                    </div>

                                    <!-- КНОПКИ В ОДНУ СТРОКУ -->
                                    <div class="order-actions-inline">
                                        <a href="/${route.id}" class="btn-sm btn-link">Подробнее →</a>
                                    </div>
                                </div>
                            </div>
                        </#if>
                    </#list>
                    <#if !hasCompleted>
                        <div class="empty-state" style="grid-column: 1 / -1;">
                            <div class="empty-icon">📦</div>
                            <h4>Нет выполненных заказов</h4>
                            <p>Завершенные заказы будут отображаться здесь</p>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>