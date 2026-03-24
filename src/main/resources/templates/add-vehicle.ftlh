<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Добавление транспорта</title>
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

        /* Секция загрузки фото */
        .upload-section {
            margin-bottom: 24px;
        }

        .upload-title {
            font-size: 16px;
            font-weight: 600;
            color: #0f172a;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .upload-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .upload-item {
            background: #f8fafc;
            border: 2px dashed #cbd5e1;
            border-radius: 20px;
            padding: 20px;
            text-align: center;
            transition: all 0.2s;
            cursor: pointer;
        }

        .upload-item:hover {
            border-color: #3b82f6;
            background: #f1f5f9;
        }

        .upload-icon {
            font-size: 32px;
            margin-bottom: 12px;
            color: #64748b;
        }

        .upload-label {
            font-size: 13px;
            color: #475569;
            margin-bottom: 8px;
        }

        .upload-input {
            display: none;
        }

        .upload-filename {
            font-size: 11px;
            color: #94a3b8;
            margin-top: 8px;
            word-break: break-all;
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

            .upload-grid {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .form-actions {
                flex-direction: column;
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
        <!-- ШАПКА -->
        <div class="form-header">
            <h1>
                🚗 Добавление транспорта
            </h1>
            <p>Заполните информацию о транспортном средстве</p>
        </div>

        <!-- ФОРМА -->
        <div class="form-content">
            <form action="/vehicles/add_vehicle" method="post" enctype="multipart/form-data">
                <input type="hidden" name="_csrf" value="${_csrf.token}">

                <!-- СЕКЦИЯ ЗАГРУЗКИ ФОТО -->
                <div class="upload-section">
                    <div class="upload-title">
                        <span>📸</span> Фотографии автомобиля
                    </div>
                    <div class="upload-grid">
                        <div class="upload-item" onclick="document.getElementById('file1').click()">
                            <div class="upload-icon">📷</div>
                            <div class="upload-label">Фото 1</div>
                            <input type="file" id="file1" name="file1" class="upload-input" accept="image/*">
                            <div class="upload-filename" id="file1-name">Файл не выбран</div>
                        </div>
                        <div class="upload-item" onclick="document.getElementById('file2').click()">
                            <div class="upload-icon">📷</div>
                            <div class="upload-label">Фото 2</div>
                            <input type="file" id="file2" name="file2" class="upload-input" accept="image/*">
                            <div class="upload-filename" id="file2-name">Файл не выбран</div>
                        </div>
                        <div class="upload-item" onclick="document.getElementById('file3').click()">
                            <div class="upload-icon">📷</div>
                            <div class="upload-label">Фото 3</div>
                            <input type="file" id="file3" name="file3" class="upload-input" accept="image/*">
                            <div class="upload-filename" id="file3-name">Файл не выбран</div>
                        </div>
                    </div>
                    <div class="input-hint">Поддерживаются форматы: JPG, PNG, GIF. Максимум 10MB</div>
                </div>

                <div class="divider"></div>

                <!-- ОСНОВНЫЕ ПОЛЯ -->
                <div class="form-grid">
                    <!-- Марка и модель -->
                    <div class="form-group form-field-full">
                        <label class="form-label" for="model">
                            <i>🚗</i> Марка и модель <span class="required-star">*</span>
                        </label>
                        <input type="text"
                               id="model"
                               name="model"
                               class="form-input"
                               placeholder="Например: Mercedes-Benz Sprinter"
                               required>
                        <div class="input-hint">Укажите марку и модель автомобиля</div>
                    </div>

                    <!-- VIN номер -->
                    <div class="form-group">
                        <label class="form-label" for="vin">
                            <i>🔑</i> VIN номер <span class="required-star">*</span>
                        </label>
                        <input type="text"
                               id="vin"
                               name="vin"
                               class="form-input"
                               placeholder="XTA1234567890ABCD"
                               required>
                        <div class="input-hint">Уникальный идентификационный номер</div>
                    </div>

                    <!-- Год выпуска -->
                    <div class="form-group">
                        <label class="form-label" for="manufactureYear">
                            <i>📅</i> Год выпуска
                        </label>
                        <input type="number"
                               id="manufactureYear"
                               name="manufactureYear"
                               class="form-input"
                               placeholder="2020"
                               min="1950"
                               max="2026">
                        <div class="input-hint">Год производства автомобиля</div>
                    </div>

                    <!-- Номерной знак -->
                    <div class="form-group">
                        <label class="form-label" for="licensePlate">
                            <i>🔢</i> Номерной знак <span class="required-star">*</span>
                        </label>
                        <input type="text"
                               id="licensePlate"
                               name="licensePlate"
                               class="form-input"
                               placeholder="А123АА 777"
                               required>
                        <div class="input-hint">Государственный регистрационный номер</div>
                    </div>

                    <!-- Тип топлива -->
                    <div class="form-group">
                        <label class="form-label" for="fuelType">
                            <i>⛽</i> Тип топлива
                        </label>
                        <input type="text"
                               id="fuelType"
                               name="fuelType"
                               class="form-input"
                               placeholder="Бензин, Дизель, Газ, Электро">
                        <div class="input-hint">Тип используемого топлива</div>
                    </div>

                    <!-- Грузоподъемность -->
                    <div class="form-group">
                        <label class="form-label" for="loadCapacity">
                            <i>⚖️</i> Грузоподъемность <span class="required-star">*</span>
                        </label>
                        <input type="number"
                               id="loadCapacity"
                               name="loadCapacity"
                               class="form-input"
                               placeholder="кг"
                               required>
                        <div class="input-hint">Максимальная масса груза в килограммах</div>
                    </div>
                </div>

                <div class="divider"></div>

                <!-- КНОПКИ -->
                <div class="form-actions">
                    <a href="/carrier" class="btn btn-secondary">
                        ← Отмена
                    </a>
                    <button type="submit" class="btn btn-primary">
                        ➕ Добавить транспорт
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Отображение имени выбранного файла
    function setupFileInput(inputId, displayId) {
        const input = document.getElementById(inputId);
        const display = document.getElementById(displayId);
        if (input) {
            input.addEventListener('change', function() {
                if (this.files && this.files[0]) {
                    display.textContent = this.files[0].name;
                } else {
                    display.textContent = 'Файл не выбран';
                }
            });
        }
    }

    setupFileInput('file1', 'file1-name');
    setupFileInput('file2', 'file2-name');
    setupFileInput('file3', 'file3-name');

    // Автофокус на первое поле
    document.getElementById('model').focus();
</script>
</body>
</html>