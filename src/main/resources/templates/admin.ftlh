<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Админ-панель</title>
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
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Карточка-обертка */
        .admin-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 0.4s ease-out;
        }

        /* Шапка профиля */
        .admin-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 40px 32px;
            color: white;
        }

        .admin-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .admin-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 14px;
            border-radius: 40px;
            font-size: 14px;
            font-weight: 500;
        }

        .admin-stats {
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

        .nav-link-primary {
            background: #3b82f6;
            color: white;
        }

        .nav-link-primary:hover {
            background: #2563eb;
            transform: translateY(-2px);
        }

        .nav-link-secondary {
            background: #f1f5f9;
            color: #475569;
        }

        .nav-link-secondary:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        /* Основной контент */
        .content-section {
            padding: 32px;
        }

        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
            padding-bottom: 12px;
            border-bottom: 2px solid #eef2f6;
            flex-wrap: wrap;
            gap: 16px;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-icon {
            font-size: 28px;
        }

        .section-title h2 {
            font-size: 22px;
            font-weight: 600;
            color: #0f172a;
        }

        .user-count {
            background: #f1f5f9;
            padding: 4px 12px;
            border-radius: 40px;
            font-size: 14px;
            font-weight: 500;
            color: #475569;
        }

        /* Таблица пользователей */
        .users-table-container {
            overflow-x: auto;
            border-radius: 20px;
            border: 1px solid #eef2f6;
        }

        .users-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        .users-table th {
            text-align: left;
            padding: 16px 20px;
            background: #f8fafc;
            font-weight: 600;
            color: #1e293b;
            border-bottom: 2px solid #eef2f6;
        }

        .users-table td {
            padding: 16px 20px;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }

        .users-table tr:hover {
            background: #fafcff;
        }

        .users-table tr:last-child td {
            border-bottom: none;
        }

        /* Статус активности */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 12px;
            border-radius: 100px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-active {
            background: #dcfce7;
            color: #15803d;
        }

        .status-active:before {
            content: "●";
            font-size: 10px;
        }

        .status-banned {
            background: #fee2e2;
            color: #dc2626;
        }

        .status-banned:before {
            content: "●";
            font-size: 10px;
        }

        /* Роли */
        .roles-list {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
        }

        .role-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 40px;
            font-size: 11px;
            font-weight: 500;
        }

        .role-admin {
            background: #eef2ff;
            color: #3b82f6;
        }

        .role-customer {
            background: #dcfce7;
            color: #15803d;
        }

        .role-carrier {
            background: #fef3c7;
            color: #b45309;
        }

        /* Кнопки действий */
        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn-action {
            padding: 6px 14px;
            border-radius: 40px;
            font-size: 12px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-ban {
            background: #fee2e2;
            color: #dc2626;
            padding: 8px 14px;
        }

        .btn-ban:hover {
            background: #fecaca;
            transform: translateY(-1px);
        }

        .btn-unban {
            background: #dcfce7;
            color: #15803d;
        }

        .btn-unban:hover {
            background: #bbf7d0;
            transform: translateY(-1px);
        }

        .btn-edit {
            background: #fef3c7;
            color: #b45309;
        }

        .btn-edit:hover {
            background: #fde68a;
            transform: translateY(-1px);
        }

        .btn-view {
            background: #f1f5f9;
            color: #3b82f6;
        }

        .btn-view:hover {
            background: #e2e8f0;
            transform: translateY(-1px);
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
            opacity: 0.6;
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

        /* Адаптивность */
        @media (max-width: 1024px) {
            .users-table th,
            .users-table td {
                padding: 12px 16px;
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 16px;
            }

            .admin-header {
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

            .section-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .users-table {
                font-size: 12px;
            }

            .users-table th,
            .users-table td {
                padding: 10px 12px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 6px;
            }

            .btn-action {
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
    <div class="admin-card">
        <!-- ШАПКА АДМИН-ПАНЕЛИ -->
        <div class="admin-header">
            <h1>
                👑 Админ-панель
                <span class="admin-badge">Управление пользователями</span>
            </h1>
            <div class="admin-stats">
                <div class="stat-chip">
                    <span>👥</span>
                    <span>Всего пользователей: ${users?size}</span>
                </div>
                <div class="stat-chip">
                    <span>🟢</span>
                    <span>Активных: ${users?filter(u -> u.active == true)?size}</span>
                </div>
                <div class="stat-chip">
                    <span>🔴</span>
                    <span>Забаненных: ${users?filter(u -> u.active == false)?size}</span>
                </div>
            </div>
        </div>

        <!-- НАВИГАЦИЯ -->
        <div class="nav-bar">
            <div class="nav-links">
                <a href="/" class="nav-link nav-link-secondary">🏠 На главную</a>
                <a href="/customer" class="nav-link nav-link-secondary">📋 Кабинет заказчика</a>
                <a href="/carrier" class="nav-link nav-link-secondary">🚚 Кабинет водителя</a>
            </div>
            <form action="/logout" method="post" style="margin: 0;">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <button type="submit" class="nav-link nav-link-secondary" style="background: #fee2e2; color: #dc2626; cursor: pointer;">🚪 Выйти</button>
            </form>
        </div>

        <!-- ОСНОВНОЙ КОНТЕНТ -->
        <div class="content-section">
            <div class="section-header">
                <div class="section-title">
                    <span class="section-icon">👥</span>
                    <h2>Управление пользователями</h2>
                    <span class="user-count">${users?size} пользователей</span>
                </div>
            </div>

            <#if users?has_content>
                <div class="users-table-container">
                    <table class="users-table">
                        <thead>
                        <tr>
                            <th>Email</th>
                            <th>Статус</th>
                            <th>Роли</th>
                            <th>Действия</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list users as user>
                            <tr>
                                <td>
                                    <strong>${user.email!''}</strong>
                                </td>
                                <td>
                                    <#if user.active>
                                        <span class="status-badge status-active">Активен</span>
                                    <#else>
                                        <span class="status-badge status-banned">Забанен</span>
                                    </#if>
                                </td>
                                <td>
                                    <div class="roles-list">
                                        <#list user.roles as role>
                                            <#if role == "ADMIN">
                                                <span class="role-badge role-admin">👑 Админ</span>
                                            <#elseif role == "CUSTOMER">
                                                <span class="role-badge role-customer">📋 Заказчик</span>
                                            <#elseif role == "CARRIER">
                                                <span class="role-badge role-carrier">🚚 Водитель</span>
                                            <#else>
                                                <span class="role-badge">${role}</span>
                                            </#if>
                                        </#list>
                                    </div>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <!-- Бан/Разбан -->
                                        <form action="/admin/user/ban/${user.id}" method="post" style="margin: 0;">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                                            <#if user.active>
                                                <button type="submit" class="btn-action btn-ban">🔨 Забанить</button>
                                            <#else>
                                                <button type="submit" class="btn-action btn-unban">✅ Разбанить</button>
                                            </#if>
                                        </form>
                                        <!-- Редактирование роли -->
                                        <a href="/admin/user/edit/${user.id}" class="btn-action btn-edit">✏️ Роли</a>
                                        <!-- Подробная информация -->
                                        <a href="/user/${user.id}" class="btn-action btn-view">👤 Подробнее</a>
                                    </div>
                                </td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            <#else>
                <div class="empty-state">
                    <div class="empty-icon">👥</div>
                    <h3>Нет пользователей</h3>
                    <p>В системе пока нет зарегистрированных пользователей</p>
                </div>
            </#if>
        </div>
    </div>
</div>
</body>
</html>