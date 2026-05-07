<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Редактирование профиля</title>
    <link rel="stylesheet" href="/css/base.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: #0f172a;
            line-height: 1.5;
            min-height: 100vh;
            padding: 24px;
        }

        .container { max-width: 800px; margin: 0 auto; }

        .profile-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 0.4s ease-out;
        }

        /* Шапка — один в один с user-info */
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

        .profile-header h1 { font-size: 28px; font-weight: 700; margin-bottom: 8px; }
        .profile-header p  { color: #94a3b8; font-size: 14px; }

        .role-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 16px;
            border-radius: 40px;
            font-size: 13px;
            font-weight: 500;
            margin-top: 16px;
        }

        /* Контент */
        .profile-content { padding: 32px; }

        .info-section { margin-bottom: 32px; }

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

        /* Сетка полей */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .form-group { display: flex; flex-direction: column; gap: 7px; }
        .form-group.full { grid-column: 1 / -1; }

        .form-label {
            font-size: 12px;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: .4px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .form-input {
            background: #f8fafc;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 12px 15px;
            font-size: 14px;
            font-family: inherit;
            color: #0f172a;
            transition: border-color .15s, box-shadow .15s, background .15s;
        }

        .form-input:focus {
            outline: none;
            border-color: #3b82f6;
            background: white;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, .1);
        }

        /* Ошибка */
        .alert-error {
            background: #fef2f2;
            border-left: 4px solid #ef4444;
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
            color: #dc2626;
            font-weight: 500;
        }

        /* Кнопки */
        .actions-section {
            display: flex;
            gap: 12px;
            margin-top: 32px;
            padding-top: 24px;
            border-top: 2px solid #eef2f6;
        }

        .btn {
            padding: 12px 28px;
            border-radius: 40px;
            font-size: 14px;
            font-weight: 600;
            font-family: inherit;
            cursor: pointer;
            text-decoration: none;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all .2s;
        }

        .btn-primary {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            flex: 1;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, .3);
        }

        .btn-secondary { background: #f1f5f9; color: #475569; }
        .btn-secondary:hover { background: #e2e8f0; transform: translateY(-2px); }

        /* Адаптивность */
        @media (max-width: 768px) {
            body { padding: 16px; }
            .profile-header { padding: 32px 24px; }
            .profile-content { padding: 24px; }
            .form-grid { grid-template-columns: 1fr; }
            .actions-section { flex-direction: column; }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="profile-card">

        <!-- ШАПКА -->
        <div class="profile-header">
            <div class="avatar">
                <#if user.isAdmin()>👑
                <#elseif user.isCustomer()>📋
                <#elseif user.isCarrier()>🚚
                <#else>👤</#if>
            </div>
            <h1>${user.username!''}</h1>
            <p>${user.email!''}</p>
            <div class="role-badge">
                <#if user.isAdmin()>👑 Администратор
                <#elseif user.isCustomer()>📋 Заказчик
                <#elseif user.isCarrier()>🚚 Водитель
                <#else>Пользователь</#if>
            </div>
        </div>

        <!-- ФОРМА -->
        <div class="profile-content">

            <#if errorMessage??>
                <div class="alert-error">⚠️ ${errorMessage}</div>
            </#if>

            <form action="/profile/edit" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">

                <div class="info-section">
                    <div class="section-title"><span>📋</span> Основные данные</div>
                    <div class="form-grid">

                        <div class="form-group full">
                            <label class="form-label"><span>👤</span> Имя пользователя</label>
                            <input class="form-input" type="text" name="username"
                                   required value="${user.username!''}">
                        </div>

                        <div class="form-group">
                            <label class="form-label"><span>📧</span> Email</label>
                            <input class="form-input" type="email" name="email"
                                   required value="${user.email!''}">
                        </div>

                        <div class="form-group">
                            <label class="form-label"><span>📱</span> Телефон</label>
                            <input class="form-input" type="tel" name="tel_number"
                                   placeholder="+7 (___) ___-__-__"
                                   value="${user.tel_number!''}">
                        </div>

                        <div class="form-group">
                            <label class="form-label"><span>🎂</span> Дата рождения</label>
                            <input class="form-input" type="date" name="dateOfBirth"
                                   value="${user.dateOfBirth!''}">
                        </div>

                        <div class="form-group">
                            <label class="form-label"><span>⏱️</span> Стаж вождения (лет)</label>
                            <input class="form-input" type="number" name="experience"
                                   min="0" max="80" value="${user.experience!0}">
                        </div>

                    </div>
                </div>

                <div class="actions-section">
                    <a class="btn btn-secondary" href="javascript:history.back()">← Отмена</a>
                    <button class="btn btn-primary" type="submit">💾 Сохранить изменения</button>
                </div>

            </form>
        </div>
    </div>
</div>
</body>
</html>
