<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Детали маршрута</title>
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
            max-width: 900px;
            margin: 0 auto;
        }

        /* Карточка */
        .card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        /* Шапка карточки */
        .card-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 32px 32px 28px;
            color: white;
            position: relative;
        }

        .card-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 12px;
            letter-spacing: -0.3px;
        }

        .route-path {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 16px;
        }

        .path-point {
            background: rgba(255, 255, 255, 0.15);
            padding: 8px 20px;
            border-radius: 40px;
            font-weight: 500;
            font-size: 15px;
        }

        .path-arrow {
            font-size: 20px;
            color: #94a3b8;
        }

        /* Статус бейдж в шапке */
        .status-badge-large {
            position: absolute;
            top: 32px;
            right: 32px;
            padding: 8px 20px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .status-active {
            background: #22c55e;
            color: white;
        }

        .status-in-process {
            background: #f59e0b;
            color: white;
        }

        .status-completed {
            background: #64748b;
            color: white;
        }

        /* Основной контент */
        .card-content {
            padding: 32px;
        }

        /* Секции */
        .info-section {
            margin-bottom: 32px;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #0f172a;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 2px solid #eef2f6;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Сетка деталей */
        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .detail-item {
            background: #f8fafc;
            padding: 16px 20px;
            border-radius: 20px;
            transition: all 0.2s;
        }

        .detail-item:hover {
            background: #f1f5f9;
            transform: translateY(-2px);
        }

        .detail-label {
            font-size: 13px;
            font-weight: 500;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .detail-value {
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
        }

        .detail-value-small {
            font-size: 16px;
            font-weight: 500;
        }

        /* Блок контактов */
        .contact-card {
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            border: 1px solid #eef2f6;
            border-radius: 20px;
            padding: 20px;
            margin-top: 16px;
        }

        .contact-row {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid #eef2f6;
        }

        .contact-row:last-child {
            border-bottom: none;
        }

        .contact-icon {
            width: 40px;
            height: 40px;
            background: #eef2ff;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .contact-info {
            flex: 1;
        }

        .contact-label {
            font-size: 12px;
            color: #64748b;
        }

        .contact-value {
            font-weight: 600;
            color: #0f172a;
        }

        /* Блок действий */
        .actions-section {
            display: flex;
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
            margin-top: 32px;
            padding-top: 24px;
            border-top: 2px solid #eef2f6;
        }

        .btn {
            padding: 12px 28px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back {
            background: #f1f5f9;
            color: #475569;
        }

        .btn-back:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        .btn-danger {
            background: #ef4444;
            color: white;
        }

        .btn-danger:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        .btn-success {
            background: #22c55e;
            color: white;
        }

        .btn-success:hover {
            background: #16a34a;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(34, 197, 94, 0.3);
        }

        /* Примечания */
        .notes-block {
            background: #fefce8;
            border-left: 4px solid #eab308;
            padding: 16px 20px;
            border-radius: 16px;
            margin-top: 20px;
        }

        .notes-block p {
            color: #854d0e;
            margin: 0;
        }

        /* Адаптивность */
        @media (max-width: 768px) {
            body {
                padding: 16px;
            }

            .card-header {
                padding: 24px 20px;
            }

            .status-badge-large {
                position: static;
                display: inline-block;
                margin-top: 16px;
            }

            .card-content {
                padding: 24px 20px;
            }

            .details-grid {
                grid-template-columns: 1fr;
            }

            .actions-section {
                flex-direction: column;
            }

            .btn {
                justify-content: center;
            }

            .route-path {
                flex-direction: column;
                align-items: flex-start;
            }

            .path-arrow {
                transform: rotate(90deg);
                align-self: center;
            }
        }

        /* Анимация появления */
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

        .card {
            animation: fadeInUp 0.4s ease-out;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <!-- ШАПКА С ГРАДИЕНТОМ -->
        <div class="card-header">
            <h1>📦 Детали маршрута</h1>
            <div class="route-path">
                <span class="path-point">📍 ${route.startLocation!''}</span>
                <span class="path-arrow">→</span>
                <span class="path-point">🎯 ${route.endLocation!''}</span>
            </div>

            <!-- СТАТУС (динамический) -->
            <#if status??>
                <#if status == "Заказ создан и ожидает обработки.">
                    <div class="status-badge-large status-active">
                        ⏳ ${status}
                    </div>
                <#elseif status == "Заказ находится в процессе доставки.">
                    <div class="status-badge-large status-in-process">
                        🚚 ${status}
                    </div>
                <#else>
                    <div class="status-badge-large status-completed">
                        ✅ ${status}
                    </div>
                </#if>
            </#if>
        </div>

        <!-- ОСНОВНОЙ КОНТЕНТ -->
        <div class="card-content">
            <!-- ИНФОРМАЦИЯ О МАРШРУТЕ -->
            <div class="info-section">
                <div class="section-title">
                    <span>📋</span> Информация о перевозке
                </div>
                <div class="details-grid">
                    <div class="detail-item">
                        <div class="detail-label">📏 Расстояние</div>
                        <div class="detail-value">${route.distance!0} км</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">⚖️ Вес груза</div>
                        <div class="detail-value">${route.cargo_weight!0} кг</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">💰 Оплата</div>
                        <div class="detail-value">${route.payment!0} ₽</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">📅 Размещён</div>
                        <div class="detail-value-small">${route.formattedCreatedAt!''}</div>
                    </div>
                    <#if route.updatedAt??>
                        <div class="detail-item">
                            <div class="detail-label">🔄 Обновлено</div>
                            <div class="detail-value-small">${route.formattedUpdatedAt!''}</div>
                        </div>
                    </#if>
                </div>
            </div>

            <!-- ОПИСАНИЕ ГРУЗА -->
            <div class="info-section">
                <div class="section-title">
                    <span>📦</span> Описание груза
                </div>
                <div class="detail-item" style="background: #f8fafc;">
                    <div class="detail-value-small">${route.cargo_description!'Нет описания'}</div>
                </div>
            </div>

            <!-- КОНТАКТЫ ЗАКАЗЧИКА -->
            <div class="info-section">
                <div class="section-title">
                    <span>👤</span> Контактные данные
                </div>
                <div class="contact-card">
                    <div class="contact-row">
                        <div class="contact-icon">👤</div>
                        <div class="contact-info">
                            <div class="contact-label">Заказчик</div>
                            <div class="contact-value">${route.customer.username!'Не указан'}</div>
                        </div>
                    </div>
                    <div class="contact-row">
                        <div class="contact-icon">📧</div>
                        <div class="contact-info">
                            <div class="contact-label">Email</div>
                            <div class="contact-value">${route.customer.email!'Не указан'}</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ПРИМЕЧАНИЯ (если есть) -->
            <#if route.order_notes?? && route.order_notes != "">
                <div class="notes-block">
                    <p>📝 <strong>Примечания к заказу:</strong> ${route.order_notes}</p>
                </div>
            </#if>

            <!-- ДЕЙСТВИЯ -->
            <div class="actions-section">
                <button onclick="window.location.href='/'" class="btn btn-back">
                    ← Вернуться к списку
                </button>

                <#if user.id == route.customer.id || user.isAdmin()>
                    <form action="/delete_route/${route.id}" method="post" style="margin: 0;">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <button type="submit" class="btn btn-danger">
                            🗑️ Удалить маршрут
                        </button>
                    </form>
                </#if>

                <#if (user.isCarrier() || user.isAdmin()) && status == "Заказ создан и ожидает обработки.">
                    <form action="/carrier/select_car" method="post" style="margin: 0;">
                        <input type="hidden" name="carrierId" value="${user.id}">
                        <input type="hidden" name="routeId" value="${route.id}">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <button type="submit" class="btn btn-success">
                            🚚 Взять в работу
                        </button>
                    </form>
                </#if>
            </div>
        </div>
    </div>
</div>

<script>
    // Плавное появление карточки
    document.addEventListener('DOMContentLoaded', function() {
        const card = document.querySelector('.card');
        if (card) {
            card.style.animation = 'fadeInUp 0.5s ease-out';
        }
    });
</script>
</body>
</html>