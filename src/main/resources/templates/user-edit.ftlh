<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Редактирование пользователя</title>
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
            max-width: 700px;
            margin: 0 auto;
        }

        .form-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 0.4s ease-out;
        }

        .form-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 32px 32px 28px;
            color: white;
        }

        .form-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-info {
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .user-badge {
            background: rgba(255, 255, 255, 0.15);
            padding: 6px 16px;
            border-radius: 40px;
            font-size: 13px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .form-content {
            padding: 32px;
        }

        .roles-section {
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

        .roles-stack {
            display: flex;
            flex-direction: column;
            gap: 16px;
            margin-bottom: 24px;
        }

        .role-card {
            background: #f8fafc;
            border: 2px solid #eef2f6;
            border-radius: 20px;
            padding: 20px;
            transition: all 0.2s;
            cursor: pointer;
        }

        .role-card:hover {
            border-color: #cbd5e1;
            background: #f1f5f9;
        }

        .role-card.selected {
            border-color: #3b82f6;
            background: #eff6ff;
        }

        .role-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .role-icon {
            font-size: 28px;
        }

        .role-name {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
        }

        .role-description {
            font-size: 13px;
            color: #64748b;
            margin-bottom: 16px;
            line-height: 1.4;
        }

        .role-checkbox {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 12px;
            padding-top: 12px;
            border-top: 1px solid #e2e8f0;
        }

        .role-checkbox input {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #3b82f6;
        }

        .role-checkbox label {
            font-size: 14px;
            font-weight: 500;
            color: #334155;
            cursor: pointer;
        }

        .form-actions {
            display: flex;
            gap: 16px;
            margin-top: 24px;
            padding-top: 24px;
            border-top: 2px solid #eef2f6;
        }

        .btn {
            padding: 12px 28px;
            border-radius: 60px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            justify-content: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            flex: 1;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3);
        }

        .btn-secondary {
            background: #f1f5f9;
            color: #475569;
        }

        .btn-secondary:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        .warning-note {
            background: #fefce8;
            border-left: 4px solid #eab308;
            padding: 12px 16px;
            border-radius: 12px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 13px;
            color: #854d0e;
        }

        @media (max-width: 768px) {
            body {
                padding: 16px;
            }

            .form-header {
                padding: 24px 20px;
            }

            .form-content {
                padding: 24px 20px;
            }

            .roles-stack {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            .user-info {
                flex-direction: column;
                gap: 10px;
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
    <div class="form-card">
        <div class="form-header">
            <h1>
                ✏️ Редактирование пользователя
            </h1>
            <p>Управление ролями и правами доступа</p>
            <div class="user-info">
                <div class="user-badge">
                    <span>👤</span>
                    <span>${user.username!''}</span>
                </div>
                <div class="user-badge">
                    <span>📧</span>
                    <span>${user.email!''}</span>
                </div>
                <div class="user-badge">
                    <span>ID: ${user.id}</span>
                </div>
            </div>
        </div>

        <div class="form-content">
            <form action="/admin/user/edit" method="post">
                <input type="hidden" name="userId" value="${user.id}">
                <input type="hidden" name="_csrf" value="${_csrf.token}">

                <div class="roles-section">
                    <div class="section-title">
                        <span>🔑</span> Назначение ролей
                    </div>

                    <div class="warning-note">
                        <span>⚠️</span>
                        <span>Изменение ролей может повлиять на доступ пользователя к функциям системы</span>
                    </div>

                    <div class="roles-stack">
                        <!-- Роль Администратора -->
                        <div class="role-card ${user.isAdmin()?then('selected', '')}" onclick="toggleCheckbox('role_ADMIN')">
                            <div class="role-header">
                                <div class="role-icon">👑</div>
                                <div class="role-name">Администратор</div>
                            </div>
                            <div class="role-description">
                                Полный доступ к системе. Управление пользователями, маршрутами и транспортом.
                            </div>
                            <div class="role-checkbox">
                                <input type="checkbox"
                                       id="role_ADMIN"
                                       name="ADMIN"
                                        ${user.isAdmin()?then('checked', '')}
                                       onclick="event.stopPropagation()">
                                <label for="role_ADMIN">
                                    <#if user.isAdmin()>
                                        Роль активна
                                    <#else>
                                        Назначить роль
                                    </#if>
                                </label>
                            </div>
                        </div>

                        <!-- Роль Заказчика -->
                        <div class="role-card ${user.isCustomer()?then('selected', '')}" onclick="toggleCheckbox('role_CUSTOMER')">
                            <div class="role-header">
                                <div class="role-icon">📋</div>
                                <div class="role-name">Заказчик</div>
                            </div>
                            <div class="role-description">
                                Создание и управление маршрутами. Отслеживание статуса доставки.
                            </div>
                            <div class="role-checkbox">
                                <input type="checkbox"
                                       id="role_CUSTOMER"
                                       name="CUSTOMER"
                                        ${user.isCustomer()?then('checked', '')}
                                       onclick="event.stopPropagation()">
                                <label for="role_CUSTOMER">
                                    <#if user.isCustomer()>
                                        Роль активна
                                    <#else>
                                        Назначить роль
                                    </#if>
                                </label>
                            </div>
                        </div>

                        <!-- Роль Водителя -->
                        <div class="role-card ${user.isCarrier()?then('selected', '')}" onclick="toggleCheckbox('role_CARRIER')">
                            <div class="role-header">
                                <div class="role-icon">🚚</div>
                                <div class="role-name">Водитель</div>
                            </div>
                            <div class="role-description">
                                Прием заказов на доставку. Управление автопарком.
                            </div>
                            <div class="role-checkbox">
                                <input type="checkbox"
                                       id="role_CARRIER"
                                       name="CARRIER"
                                        ${user.isCarrier()?then('checked', '')}
                                       onclick="event.stopPropagation()">
                                <label for="role_CARRIER">
                                    <#if user.isCarrier()>
                                        Роль активна
                                    <#else>
                                        Назначить роль
                                    </#if>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="javascript:history.back()" class="btn btn-secondary">
                        ← Отмена
                    </a>
                    <button type="submit" class="btn btn-primary">
                        💾 Сохранить изменения
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function toggleCheckbox(checkboxId) {
        const checkbox = document.getElementById(checkboxId);
        if (checkbox) {
            checkbox.checked = !checkbox.checked;
            const card = checkbox.closest('.role-card');
            if (card) {
                if (checkbox.checked) {
                    card.classList.add('selected');
                } else {
                    card.classList.remove('selected');
                }
            }
        }
    }

    // Обновляем текст лейбла и стиль карточки при изменении чекбокса
    document.querySelectorAll('input[type="checkbox"]').forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const label = this.nextElementSibling;
            if (label && label.tagName === 'LABEL') {
                if (this.checked) {
                    label.innerHTML = 'Роль активна';
                } else {
                    label.innerHTML = 'Назначить роль';
                }
            }
            const card = this.closest('.role-card');
            if (card) {
                if (this.checked) {
                    card.classList.add('selected');
                } else {
                    card.classList.remove('selected');
                }
            }
        });
    });
</script>
</body>
</html>