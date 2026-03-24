<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Детали транспорта</title>
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
            max-width: 1000px;
            margin: 0 auto;
        }

        /* Карточка */
        .vehicle-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 0.4s ease-out;
        }

        /* Шапка */
        .vehicle-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 32px 32px 28px;
            color: white;
        }

        .vehicle-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .vehicle-vin-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 14px;
            border-radius: 40px;
            font-size: 13px;
            font-family: monospace;
            letter-spacing: 0.5px;
        }

        /* Галерея изображений */
        .gallery-section {
            padding: 24px 32px 0;
        }

        .gallery-title {
            font-size: 16px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .images-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        .image-card {
            background: #f8fafc;
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid #eef2f6;
            transition: all 0.2s;
        }

        .image-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px -12px rgba(0, 0, 0, 0.15);
        }

        .image-card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            display: block;
        }

        .no-images {
            text-align: center;
            padding: 60px 20px;
            background: #fafcff;
            border-radius: 20px;
            border: 1px dashed #cbd5e1;
        }

        .no-images-icon {
            font-size: 48px;
            margin-bottom: 12px;
            opacity: 0.5;
        }

        .no-images p {
            color: #64748b;
            font-size: 14px;
        }

        /* Детали транспорта */
        .details-section {
            padding: 24px 32px;
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 24px;
        }

        .detail-item {
            background: #f8fafc;
            padding: 16px 20px;
            border-radius: 20px;
            transition: all 0.2s;
        }

        .detail-item:hover {
            background: #f1f5f9;
        }

        .detail-label {
            font-size: 12px;
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
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
        }

        /* Статус */
        .status-section {
            margin-bottom: 24px;
            padding: 16px 20px;
            background: #f8fafc;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
        }

        .status-label {
            font-size: 14px;
            font-weight: 500;
            color: #475569;
        }

        .status-badge-large {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 20px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
        }

        .status-free {
            background: #dcfce7;
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

        /* Владелец */
        .owner-section {
            margin-bottom: 32px;
            padding: 16px 20px;
            background: #f8fafc;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
        }

        .owner-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 20px;
            background: #eef2ff;
            color: #3b82f6;
            text-decoration: none;
            border-radius: 40px;
            font-weight: 500;
            transition: all 0.2s;
        }

        .owner-link:hover {
            background: #e2e8f0;
            transform: translateX(4px);
        }

        /* Кнопки действий */
        .actions-section {
            display: flex;
            gap: 16px;
            margin-top: 16px;
            padding-top: 24px;
            border-top: 2px solid #eef2f6;
            flex-wrap: wrap;
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

        .btn-primary {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3);
        }

        .btn-edit {
            background: #fef3c7;
            color: #b45309;
        }

        .btn-edit:hover {
            background: #fde68a;
            transform: translateY(-2px);
        }

        .btn-delete {
            background: #fee2e2;
            color: #dc2626;
        }

        .btn-delete:hover {
            background: #fecaca;
            transform: translateY(-2px);
        }

        .btn-back {
            background: #f1f5f9;
            color: #475569;
        }

        .btn-back:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        /* Адаптивность */
        @media (max-width: 768px) {
            body {
                padding: 16px;
            }

            .vehicle-header {
                padding: 24px 20px;
            }

            .gallery-section {
                padding: 20px 20px 0;
            }

            .details-section {
                padding: 20px;
            }

            .details-grid {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .status-section {
                flex-direction: column;
                text-align: center;
            }

            .owner-section {
                flex-direction: column;
                text-align: center;
            }

            .actions-section {
                flex-direction: column;
            }

            .btn {
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
    <div class="vehicle-card">
        <!-- ШАПКА -->
        <div class="vehicle-header">
            <h1>
                🚗 Детали транспорта
                <span class="vehicle-vin-badge">VIN: ${vehicle.vin!''}</span>
            </h1>
            <p>${vehicle.model!''}</p>
        </div>

        <!-- ГАЛЕРЕЯ ИЗОБРАЖЕНИЙ -->
        <#if images?has_content>
            <div class="gallery-section">
                <div class="gallery-title">
                    <span>📸</span> Фотографии
                </div>
                <div class="images-grid">
                    <#list images as img>
                        <div class="image-card">
                            <img src="/api/v1/vehicles/images/${img.id}" alt="Фото транспорта">
                        </div>
                    </#list>
                </div>
            </div>
        </#if>

        <!-- ДЕТАЛИ ТРАНСПОРТА -->
        <div class="details-section">
            <div class="details-grid">
                <div class="detail-item">
                    <div class="detail-label">🚗 Марка и модель</div>
                    <div class="detail-value">${vehicle.model!''}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">📅 Год выпуска</div>
                    <div class="detail-value">${vehicle.manufactureYear!''}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">🔢 Номерной знак</div>
                    <div class="detail-value">${vehicle.licensePlate!''}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">⛽ Тип топлива</div>
                    <div class="detail-value">${vehicle.fuelType!''}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">⚖️ Грузоподъемность</div>
                    <div class="detail-value">${vehicle.loadCapacity!0} кг</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">🔑 VIN номер</div>
                    <div class="detail-value" style="font-family: monospace;">${vehicle.vin!''}</div>
                </div>
            </div>

            <!-- СТАТУС -->
            <div class="status-section">
                <span class="status-label">📊 Текущий статус:</span>
                <#if vehicle.status == "FREE">
                    <span class="status-badge-large status-free">🟢 Свободен</span>
                <#elseif vehicle.status == "BUSY">
                    <span class="status-badge-large status-busy">🔴 На рейсе</span>
                <#else>
                    <span class="status-badge-large status-broken">⚠️ Неисправен</span>
                </#if>
            </div>

            <!-- ВЛАДЕЛЕЦ -->
            <div class="owner-section">
                <span class="status-label">👤 Владелец:</span>
                <a href="/user/${vehicle.user.id}" class="owner-link">
                    ${vehicle.user.username!''} → <span style="font-size: 12px;">${vehicle.user.email!''}</span>
                </a>
            </div>

            <!-- КНОПКИ ДЕЙСТВИЙ -->
            <#if user.id == vehicle.user.id>
                <div class="actions-section">
                    <button onclick="window.location.href='/carrier'" class="btn btn-back">← Вернуться к списку</button>
                    <form action="/vehicles/edit_vehicle/${vehicle.vin}" method="get" style="margin: 0;">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <button type="submit" class="btn btn-edit">✏️ Редактировать</button>
                    </form>
                    <form action="/vehicles/delete_vehicle/${vehicle.id}" method="post" style="margin: 0;">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <button type="submit" class="btn btn-delete">🗑️ Удалить авто</button>
                    </form>
                </div>
            <#else>
                <div class="actions-section">
                    <button onclick="window.location.href='/carrier'" class="btn btn-back">← Вернуться к списку</button>
                </div>
            </#if>
        </div>
    </div>
</div>
</body>
</html>