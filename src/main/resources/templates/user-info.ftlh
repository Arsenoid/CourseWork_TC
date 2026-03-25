<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Профиль пользователя</title>
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
            max-width: 800px;
            margin: 0 auto;
        }

        /* Карточка профиля */
        .profile-card {
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
            text-align: center;
        }

        .avatar {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 40px;
        }

        .profile-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .profile-header p {
            color: #94a3b8;
            font-size: 14px;
        }

        .role-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 16px;
            border-radius: 40px;
            font-size: 13px;
            font-weight: 500;
            margin-top: 16px;
        }

        /* Основной контент */
        .profile-content {
            padding: 32px;
        }

        /* Секция информации */
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

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .info-item {
            background: #f8fafc;
            padding: 16px 20px;
            border-radius: 20px;
            transition: all 0.2s;
        }

        .info-item:hover {
            background: #f1f5f9;
            transform: translateY(-2px);
        }

        .info-label {
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

        .info-value {
            font-size: 16px;
            font-weight: 600;
            color: #0f172a;
        }

        /* Секция автомобилей */
        .vehicles-section {
            margin-top: 32px;
        }

        .vehicles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 16px;
        }

        .vehicle-card {
            background: #f8fafc;
            border: 1px solid #eef2f6;
            border-radius: 20px;
            padding: 16px;
            transition: all 0.2s;
        }

        .vehicle-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px -8px rgba(0, 0, 0, 0.1);
            border-color: #e2e8f0;
        }

        .vehicle-model {
            font-weight: 700;
            font-size: 16px;
            color: #0f172a;
            margin-bottom: 8px;
        }

        .vehicle-vin {
            font-size: 12px;
            color: #64748b;
            font-family: monospace;
            margin-bottom: 12px;
        }

        .vehicle-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 13px;
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s;
        }

        .vehicle-link:hover {
            color: #2563eb;
            transform: translateX(4px);
        }

        /* Пустое состояние */
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            background: #fafcff;
            border-radius: 20px;
            border: 1px dashed #cbd5e1;
        }

        .empty-icon {
            font-size: 48px;
            margin-bottom: 12px;
            opacity: 0.6;
        }

        .empty-state h4 {
            color: #334155;
            margin-bottom: 6px;
            font-size: 16px;
        }

        .empty-state p {
            color: #64748b;
            font-size: 14px;
        }

        /* Кнопка назад */
        .back-button-container {
            margin-top: 32px;
            padding-top: 24px;
            border-top: 2px solid #eef2f6;
            text-align: center;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 28px;
            background: #f1f5f9;
            color: #475569;
            text-decoration: none;
            border-radius: 60px;
            font-weight: 500;
            transition: all 0.2s;
        }

        .btn-back:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        /* Сообщение об ошибке */
        .error-message {
            background: #fef2f2;
            border-left: 4px solid #ef4444;
            padding: 14px 18px;
            border-radius: 12px;
            margin-top: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .error-icon {
            font-size: 20px;
        }

        .error-text {
            color: #dc2626;
            font-size: 14px;
            font-weight: 500;
        }

        /* Адаптивность */
        @media (max-width: 768px) {
            body {
                padding: 16px;
            }

            .profile-header {
                padding: 32px 24px;
            }

            .profile-content {
                padding: 24px;
            }

            .info-grid {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .vehicles-grid {
                grid-template-columns: 1fr;
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
    <div class="profile-card">
        <!-- ШАПКА ПРОФИЛЯ -->
        <div class="profile-header">
            <div class="avatar">
                <#if user.roles?has_content>
                    <#if user.isCarrier()>
                        🚚
                    <#elseif user.isCustomer()>
                        📋
                    <#elseif user.isAdmin()>
                        👑
                    <#else>
                        👤
                    </#if>
                <#else>
                    👤
                </#if>
            </div>
            <h1>${user.username!''}</h1>
            <p>${user.email!''}</p>
            <div class="role-badge">
                <#if user.roles?has_content>
                    <#if user.isAdmin()>
                        👑 Администратор
                    <#elseif user.isCustomer()>
                        📋 Заказчик
                    <#elseif user.isCarrier()>
                        🚚 Водитель
                    </#if>
                <#else>
                    Пользователь
                </#if>
            </div>
        </div>

        <!-- ОСНОВНОЙ КОНТЕНТ -->
        <div class="profile-content">
            <!-- ИНФОРМАЦИЯ О ПОЛЬЗОВАТЕЛЕ -->
            <div class="info-section">
                <div class="section-title">
                    <span>📋</span> Основная информация
                </div>
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">
                            <span>👤</span> Имя пользователя
                        </div>
                        <div class="info-value">${user.username!''}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">
                            <span>📧</span> Email
                        </div>
                        <div class="info-value">${user.email!''}</div>
                    </div>
                    <#if user.dateOfBirth?? && user.dateOfBirth != "">
                        <div class="info-item">
                            <div class="info-label">
                                <span>🎂</span> Дата рождения
                            </div>
                            <div class="info-value">${user.dateOfBirth}</div>
                        </div>
                    </#if>
                    <#if user.tel_number?? && user.tel_number != "">
                        <div class="info-item">
                            <div class="info-label">
                                <span>📱</span> Телефон
                            </div>
                            <div class="info-value">${user.tel_number}</div>
                        </div>
                    </#if>
                    <#if user.experience?? && user.experience != 0>
                        <div class="info-item">
                            <div class="info-label">
                                <span>⏱️</span> Стаж вождения
                            </div>
                            <div class="info-value">${user.experience} лет</div>
                        </div>
                    </#if>
                    <div class="info-item">
                        <div class="info-label">
                            <span>🔑</span> ID пользователя
                        </div>
                        <div class="info-value">${user.id}</div>
                    </div>
                </div>
            </div>

            <!-- АВТОМОБИЛИ ПОЛЬЗОВАТЕЛЯ -->
            <div class="vehicles-section">
                <div class="section-title">
                    <span>🚗</span> Автомобили пользователя
                    <span class="vehicle-count" style="background: #f1f5f9; padding: 2px 10px; border-radius: 40px; font-size: 12px;">${vehicles?size}</span>
                </div>

                <#if vehicles?has_content>
                    <div class="vehicles-grid">
                        <#list vehicles as vehicle>
                            <div class="vehicle-card">
                                <div class="vehicle-model">${vehicle.model!''}</div>
                                <div class="vehicle-vin">VIN: ${vehicle.vin!''}</div>
                                <a href="/vehicles/${vehicle.vin}" class="vehicle-link">
                                    Подробнее →
                                </a>
                            </div>
                        </#list>
                    </div>
                <#else>
                    <div class="empty-state">
                        <div class="empty-icon">🚗</div>
                        <h4>Нет автомобилей</h4>
                        <p>У пользователя пока нет зарегистрированных автомобилей</p>
                    </div>
                </#if>
            </div>

            <!-- КНОПКА НАЗАД -->
            <div class="back-button-container">
                <a href="javascript:history.back()" class="btn-back">
                    ← Вернуться назад
                </a>
            </div>

            <!-- СООБЩЕНИЕ ОБ ОШИБКЕ -->
            <#if errorMessage??>
                <div class="error-message">
                    <span class="error-icon">⚠️</span>
                    <span class="error-text">${errorMessage}</span>
                </div>
            </#if>
        </div>
    </div>
</div>
</body>
</html>