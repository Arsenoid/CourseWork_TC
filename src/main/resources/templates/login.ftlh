<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Вход в систему</title>
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

        /* Карточка входа */
        .login-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            width: 100%;
            max-width: 440px;
            overflow: hidden;
            animation: fadeInUp 0.5s ease-out;
        }

        /* Шапка */
        .login-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 32px 32px 28px;
            text-align: center;
            color: white;
        }

        .logo {
            font-size: 48px;
            margin-bottom: 16px;
        }

        .login-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .login-header p {
            font-size: 14px;
            color: #94a3b8;
        }

        /* Форма */
        .login-form {
            padding: 32px;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #334155;
            margin-bottom: 8px;
        }

        .form-label i {
            margin-right: 6px;
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

        /* Кнопка входа */
        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            border: none;
            border-radius: 14px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            margin-top: 8px;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        /* Сообщение об ошибке */
        .error-message {
            background: #fef2f2;
            border-left: 4px solid #ef4444;
            padding: 12px 16px;
            border-radius: 12px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: shake 0.3s ease-out;
        }

        .error-icon {
            font-size: 18px;
        }

        .error-text {
            color: #dc2626;
            font-size: 14px;
            font-weight: 500;
        }

        /* Ссылка на регистрацию */
        .register-section {
            text-align: center;
            margin-top: 24px;
            padding-top: 24px;
            border-top: 1px solid #eef2f6;
        }

        .register-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .register-link:hover {
            color: #2563eb;
            transform: translateX(4px);
        }

        /* Дополнительные ссылки */
        .extra-links {
            display: flex;
            justify-content: space-between;
            margin-top: 16px;
            font-size: 13px;
        }

        .extra-link {
            color: #64748b;
            text-decoration: none;
            transition: color 0.2s;
        }

        .extra-link:hover {
            color: #3b82f6;
        }

        /* Анимации */
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

        /* Адаптивность */
        @media (max-width: 480px) {
            body {
                padding: 16px;
            }

            .login-header {
                padding: 28px 20px;
            }

            .login-form {
                padding: 24px 20px;
            }
        }
    </style>
</head>
<body>
<div class="login-card">
    <div class="login-header">
        <div class="logo">🚚️</div>
        <h1>Blizzard Trans</h1>
        <p>Транспортная логистика</p>
    </div>

    <div class="login-form">
        <!-- Сообщение об ошибке (если есть) -->
        <#if error??>
            <div class="error-message">
                <span class="error-icon">⚠️</span>
                <span class="error-text">${error}</span>
            </div>
        </#if>

        <!-- Сообщение о выходе (если есть) -->
        <#if logout??>
            <div class="error-message" style="background: #f0fdf4; border-left-color: #22c55e;">
                <span class="error-icon">✅</span>
                <span class="error-text" style="color: #15803d;">${logout}</span>
            </div>
        </#if>

        <form action="/login" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">

            <div class="form-group">
                <label class="form-label" for="username">
                    <i>📧</i> Электронная почта
                </label>
                <input type="email"
                       id="username"
                       name="username"
                       class="form-input"
                       placeholder="ivan@example.com"
                       autofocus
                       required>
            </div>

            <div class="form-group">
                <label class="form-label" for="password">
                    <i>🔒</i> Пароль
                </label>
                <input type="password"
                       id="password"
                       name="password"
                       class="form-input"
                       placeholder="••••••••"
                       required>
            </div>

            <div class="extra-links">
                <a href="#" class="extra-link">Забыли пароль?</a>
                <span style="color: #e2e8f0;">|</span>
                <a href="#" class="extra-link">Помощь</a>
            </div>

            <button type="submit" class="btn-login">
                Войти в систему →
            </button>
        </form>

        <div class="register-section">
            <a href="/role_selection" class="register-link">
                Нет аккаунта? Зарегистрироваться →
            </a>
        </div>
    </div>
</div>

<script>
    // Автофокус на поле email при загрузке
    document.getElementById('username').focus();

    // Добавляем эффект при нажатии Enter
    document.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            const form = document.querySelector('form');
            if (form && document.activeElement?.tagName !== 'BUTTON') {
                e.preventDefault();
                form.submit();
            }
        }
    });
</script>
</body>
</html>