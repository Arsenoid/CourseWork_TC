<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Создание маршрута</title>
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

        /* Карточка формы */
        .form-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 0.4s ease-out;
        }

        /* Шапка */
        .form-header {
            background: linear-gradient(135deg, #1559c5 0%, #182442 100%);
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

        .form-header p {
            color: #94a3b8;
            font-size: 14px;
        }

        /* Основная форма */
        .form-content {
            padding: 32px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
        }

        .form-field-full {
            grid-column: span 2;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-label {
            font-size: 14px;
            font-weight: 500;
            color: #334155;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-label i {
            font-style: normal;
            font-size: 18px;
        }

        .required-star {
            color: #ef4444;
            font-size: 12px;
        }

        .form-input {
            padding: 12px 16px;
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

        textarea.form-input {
            resize: vertical;
            min-height: 80px;
        }

        /* Подсказки */
        .input-hint {
            font-size: 12px;
            color: #94a3b8;
            margin-top: 4px;
        }

        /* Разделитель */
        .divider {
            margin: 24px 0;
            border: none;
            border-top: 1px solid #eef2f6;
        }

        /* Кнопки */
        .form-actions {
            display: flex;
            gap: 16px;
            margin-top: 32px;
            padding-top: 24px;
            border-top: 2px solid #eef2f6;
        }

        .btn {
            padding: 14px 28px;
            border-radius: 60px;
            font-weight: 600;
            font-size: 15px;
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
            background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
            color: white;
            flex: 1;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(34, 197, 94, 0.3);
        }

        .btn-secondary {
            background: #f1f5f9;
            color: #475569;
        }

        .btn-secondary:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        /* Адаптивность */
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

            .form-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .form-field-full {
                grid-column: span 1;
            }

            .form-actions {
                flex-direction: column;
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
    </style>
</head>
<body>
<div class="container">
    <div class="form-card">
        <!-- ШАПКА -->
        <div class="form-header">
            <h1>
                ➕ Создание маршрута
            </h1>
            <p>Заполните информацию о перевозке, чтобы найти исполнителя</p>
        </div>

        <!-- ФОРМА -->
        <div class="form-content">
            <form action="/customer/add_route" method="post" enctype="multipart/form-data">
                <input type="hidden" name="_csrf" value="${_csrf.token}">

                <div class="form-grid">
                    <!-- Начальная точка -->
                    <div class="form-group form-field-full">
                        <label class="form-label" for="startLocation">
                            <i>📍</i> Начальная точка <span class="required-star">*</span>
                        </label>
                        <input type="text"
                               id="startLocation"
                               name="startLocation"
                               class="form-input"
                               placeholder="Например: Москва, ул. Тверская 1"
                               required>
                        <div class="input-hint">Точный адрес отправления груза</div>
                    </div>

                    <!-- Конечная точка -->
                    <div class="form-group form-field-full">
                        <label class="form-label" for="endLocation">
                            <i>🎯</i> Конечная точка <span class="required-star">*</span>
                        </label>
                        <input type="text"
                               id="endLocation"
                               name="endLocation"
                               class="form-input"
                               placeholder="Например: Санкт-Петербург, Невский пр. 10"
                               required>
                        <div class="input-hint">Точный адрес доставки груза</div>
                    </div>

                    <!-- Расстояние -->
                    <div class="form-group">
                        <label class="form-label" for="distance">
                            <i>📏</i> Расстояние <span class="required-star">*</span>
                        </label>
                        <input type="number"
                               id="distance"
                               name="distance"
                               class="form-input"
                               placeholder="км"
                               step="0.1"
                               required>
                        <div class="input-hint">Расстояние в километрах</div>
                    </div>

                    <!-- Оплата -->
                    <div class="form-group">
                        <label class="form-label" for="payment">
                            <i>💰</i> Оплата <span class="required-star">*</span>
                        </label>
                        <input type="number"
                               id="payment"
                               name="payment"
                               class="form-input"
                               placeholder="руб."
                               required>
                        <div class="input-hint">Сумма оплаты за доставку</div>
                    </div>

                    <!-- Масса груза -->
                    <div class="form-group">
                        <label class="form-label" for="cargo_weight">
                            <i>⚖️</i> Масса груза <span class="required-star">*</span>
                        </label>
                        <input type="number"
                               id="cargo_weight"
                               name="cargo_weight"
                               class="form-input"
                               placeholder="кг"
                               required>
                        <div class="input-hint">Вес груза в килограммах</div>
                    </div>

                    <!-- Описание груза -->
                    <div class="form-group">
                        <label class="form-label" for="cargo_description">
                            <i>📦</i> Описание груза
                        </label>
                        <textarea id="cargo_description"
                                  name="cargo_description"
                                  class="form-input"
                                  rows="3"
                                  placeholder="Характеристики, особые условия перевозки..."></textarea>
                        <div class="input-hint">Детальное описание груза для перевозчика</div>
                    </div>

                    <!-- Примечания к заказу -->
                    <div class="form-group form-field-full">
                        <label class="form-label" for="order_notes">
                            <i>📝</i> Примечания к заказу
                        </label>
                        <textarea id="order_notes"
                                  name="order_notes"
                                  class="form-input"
                                  rows="2"
                                  placeholder="Дополнительная информация для перевозчика..."></textarea>
                        <div class="input-hint">Любые дополнительные пожелания или инструкции</div>
                    </div>
                </div>

                <!-- КНОПКИ -->
                <div class="form-actions">
                    <a onclick="history.back()" class="btn btn-secondary">
                        ← Отмена
                    </a>
                    <button type="submit" class="btn btn-primary">
                        ➕ Создать маршрут
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Автофокус на первое поле
    document.getElementById('startLocation').focus();
</script>
</body>
</html>