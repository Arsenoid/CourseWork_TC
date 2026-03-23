<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Регистрация</title>
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
            max-width: 560px;
            margin: 0 auto;
            width: 100%;
        }

        /* Карточка регистрации */
        .register-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            overflow: hidden;
            animation: fadeInUp 0.5s ease-out;
        }

        /* Шапка */
        .register-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 32px 32px 28px;
            text-align: center;
            color: white;
        }

        .logo {
            font-size: 48px;
            margin-bottom: 12px;
        }

        .register-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .role-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 16px;
            border-radius: 40px;
            font-size: 13px;
            font-weight: 500;
            margin-top: 12px;
        }

        /* Форма */
        .register-form {
            padding: 32px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #334155;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-label i {
            font-style: normal;
            font-size: 16px;
        }

        .required-star {
            color: #ef4444;
            font-size: 12px;
        }

        .form-input {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 14px;
            font-size: 15px;
            font-family: inherit;
            transition: all 0.2s;
            background: #fafcff;
        }

        .form-input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            background: white;
        }

        .form-input:hover:not(:focus) {
            border-color: #cbd5e1;
        }

        .input-hint {
            font-size: 12px;
            color: #94a3b8;
            margin-top: 6px;
        }

        /* Две колонки для полей */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        /* Кнопка регистрации */
        .btn-register {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
            color: white;
            border: none;
            border-radius: 14px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            margin-top: 8px;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(34, 197, 94, 0.3);
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
            animation: shake 0.3s ease-out;
        }

        .error-icon {
            font-size: 20px;
        }

        .error-text {
            color: #dc2626;
            font-size: 14px;
            font-weight: 500;
        }

        /* Ссылка на вход */
        .login-section {
            text-align: center;
            margin-top: 24px;
            padding-top: 20px;
            border-top: 1px solid #eef2f6;
        }

        .login-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s;
        }

        .login-link:hover {
            color: #2563eb;
            transform: translateX(4px);
        }

        /* Адаптивность */
        @media (max-width: 640px) {
            body {
                padding: 16px;
            }

            .register-header {
                padding: 28px 24px;
            }

            .register-form {
                padding: 24px 20px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
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

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="register-card">
        <!-- ШАПКА -->
        <div class="register-header">
            <div class="logo">🚚️</div>
            <h1>Создание аккаунта</h1>
            <p>Присоединяйтесь к Blizzard Trans</p>
            <#if role == "ROLE_CARRIER">
                <span class="role-badge">🚚 Регистрация как Исполнитель (Водитель)</span>
            <#elseif role == "ROLE_CUSTOMER">
                <span class="role-badge">📋 Регистрация как Заказчик</span>
            </#if>
        </div>

        <!-- ФОРМА -->
        <div class="register-form">
            <form action="/registration" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="hidden" name="role" value="${role}">

                <div class="form-row">
                    <!-- Имя пользователя -->
                    <div class="form-group">
                        <label class="form-label" for="username">
                            <i>👤</i> Имя пользователя <span class="required-star">*</span>
                        </label>
                        <input type="text"
                               id="username"
                               name="username"
                               class="form-input"
                               placeholder="Как вас зовут?"
                               autofocus
                               required>
                    </div>

                    <!-- Дата рождения -->
                    <div class="form-group">
                        <label class="form-label" for="dateOfBirth">
                            <i>🎂</i> Дата рождения
                        </label>
                        <input type="date"
                               id="dateOfBirth"
                               name="dateOfBirth"
                               class="form-input">
                        <div class="input-hint">Необязательно</div>
                    </div>
                </div>

                <div class="form-row">
                    <!-- Номер телефона -->
                    <div class="form-group">
                        <label class="form-label" for="tel_number">
                            <i>📱</i> Номер телефона
                        </label>
                        <input type="tel"
                               id="tel_number"
                               name="tel_number"
                               class="form-input"
                               placeholder="+7 (999) 123-45-67">
                        <div class="input-hint">Для связи с вами</div>
                    </div>

                    <!-- Электронная почта -->
                    <div class="form-group">
                        <label class="form-label" for="email">
                            <i>📧</i> Электронная почта <span class="required-star">*</span>
                        </label>
                        <input type="email"
                               id="email"
                               name="email"
                               class="form-input"
                               placeholder="ivan@example.com"
                               required>
                    </div>
                </div>

                <!-- Поле для водителей (стаж) -->
                <#if role == "ROLE_CARRIER">
                    <div class="form-group">
                        <label class="form-label" for="experience">
                            <i>⏱️</i> Стаж вождения <span class="required-star">*</span>
                        </label>
                        <input type="number"
                               id="experience"
                               name="experience"
                               class="form-input"
                               placeholder="Количество лет"
                               min="0"
                               max="70"
                               required>
                        <div class="input-hint">Укажите ваш водительский стаж в годах</div>
                    </div>
                </#if>

                <!-- Пароль -->
                <div class="form-group">
                    <label class="form-label" for="password">
                        <i>🔒</i> Пароль <span class="required-star">*</span>
                    </label>
                    <input type="password"
                           id="password"
                           name="password"
                           class="form-input"
                           placeholder="Минимум 6 символов"
                           required>
                    <div class="input-hint">Придумайте надежный пароль</div>
                </div>

                <button type="submit" class="btn-register">
                    Зарегистрироваться
                </button>
            </form>

            <!-- Сообщение об ошибке -->
            <#if errorMessage??>
                <div class="error-message">
                    <span class="error-icon">⚠️</span>
                    <span class="error-text">${errorMessage}</span>
                </div>
            </#if>

            <!-- Ссылка на вход -->
            <div class="login-section">
                <a href="/login" class="login-link">
                    Уже есть аккаунт? Войти в систему →
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    // Автофокус на поле имени
    document.getElementById('username').focus();

    // Валидация пароля (опционально)
    const passwordInput = document.getElementById('password');
    if (passwordInput) {
        passwordInput.addEventListener('input', function() {
            if (this.value.length > 0 && this.value.length < 6) {
                this.style.borderColor = '#ef4444';
            } else {
                this.style.borderColor = '#e2e8f0';
            }
        });
    }
</script>
</body>
</html>