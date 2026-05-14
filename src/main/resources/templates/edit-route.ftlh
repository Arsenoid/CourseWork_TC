<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Route Tracer — Редактирование маршрута</title>
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

        .route-path {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 20px;
            padding-top: 16px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .path-point {
            background: rgba(255, 255, 255, 0.1);
            padding: 6px 16px;
            border-radius: 40px;
            font-size: 14px;
        }

        .path-arrow {
            color: #94a3b8;
            font-size: 18px;
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
            background: white;
        }

        .form-input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .form-input:hover:not(:focus) {
            border-color: #cbd5e1;
        }

        textarea.form-input {
            resize: vertical;
            min-height: 100px;
        }

        /* Группа кнопок */
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
            background: #3b82f6;
            color: white;
            flex: 1;
        }

        .btn-primary:hover {
            background: #2563eb;
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

        /* Разделитель */
        .divider {
            margin: 24px 0;
            border: none;
            border-top: 1px solid #eef2f6;
        }

        /* Подсказки */
        .input-hint {
            font-size: 12px;
            color: #94a3b8;
            margin-top: 4px;
        }

        .form-alert {
            display: none;
            margin-bottom: 20px;
            padding: 12px 14px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 500;
            border: 1px solid transparent;
        }

        .form-alert.show {
            display: block;
        }

        .form-alert.error {
            background: #fef2f2;
            color: #dc2626;
            border-color: #fecaca;
        }

        .route-calc-row {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .distance-input {
            width: 220px;
            max-width: 100%;
        }

        .btn-calc-route {
            background: #eff6ff;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
            padding: 11px 16px;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            white-space: nowrap;
        }

        .btn-calc-route:hover {
            background: #dbeafe;
            transform: translateY(-1px);
        }

        .btn-calc-route:disabled {
            opacity: .65;
            cursor: not-allowed;
            transform: none;
        }

        .distance-status {
            font-size: 12px;
            min-height: 18px;
            margin-top: 4px;
        }

        .distance-status.info { color: #64748b; }
        .distance-status.loading { color: #b45309; }
        .distance-status.success { color: #15803d; }
        .distance-status.error { color: #dc2626; }

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

            .route-calc-row {
                flex-direction: column;
                align-items: stretch;
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

        .form-card {
            animation: fadeInUp 0.4s ease-out;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="form-card">
        <!-- ШАПКА -->
        <div class="form-header">
            <h1>
                ✏️ Редактирование маршрута
            </h1>
            <p>Измените данные маршрута и сохраните изменения</p>

            <div class="route-path">
                <span class="path-point">📍 ${route.startLocation!''}</span>
                <span class="path-arrow">→</span>
                <span class="path-point">🎯 ${route.endLocation!''}</span>
            </div>
        </div>

        <!-- ФОРМА -->
        <div class="form-content">
            <form action="/customer/edit_route/${route.id}" method="post" enctype="multipart/form-data">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <#if formError??>
                    <div class="form-alert error show">⚠️ ${formError}</div>
                </#if>
                <div class="form-alert error" id="clientErrorAlert"></div>

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
                               value="${route.startLocation!''}"
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
                               value="${route.endLocation!''}"
                               placeholder="Например: Санкт-Петербург, Невский пр. 10"
                               required>
                        <div class="input-hint">Точный адрес доставки груза</div>
                    </div>

                    <!-- Расстояние -->
                    <div class="form-group form-field-full">
                        <label class="form-label" for="distance">
                            <i>📏</i> Расстояние
                        </label>
                        <div class="route-calc-row">
                            <input type="number"
                                   id="distance"
                                   name="distance"
                                   class="form-input distance-input"
                               value="${(route.distance!0)?c}"
                                   placeholder="км"
                                   step="0.1"
                                   readonly
                                   required>
                            <button type="button" id="manualDistanceBtn" class="btn-calc-route">Ввести вручную</button>
                        </div>
                        <div class="distance-status info" id="distanceStatus">Введите точки: расстояние считается автоматически. Если не сработало — включите ручной ввод.</div>
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
                               value="${(route.payment!0)?c}"
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
                               value="${(route.cargo_weight!0)?c}"
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
                                  placeholder="Опишите груз: характеристики, особые условия перевозки...">${route.cargo_description!''}</textarea>
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
                                  placeholder="Дополнительная информация для перевозчика...">${route.order_notes!''}</textarea>
                        <div class="input-hint">Любые дополнительные пожелания или инструкции</div>
                    </div>
                </div>

                <div class="divider"></div>

                <!-- КНОПКИ -->
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
    const startInput = document.getElementById('startLocation');
    const endInput = document.getElementById('endLocation');
    const distanceInput = document.getElementById('distance');
    const manualButton = document.getElementById('manualDistanceBtn');
    const distanceStatus = document.getElementById('distanceStatus');
    const form = document.querySelector('form[action^="/customer/edit_route/"]');
    const clientErrorAlert = document.getElementById('clientErrorAlert');
    let calcTimer = null;
    let requestVersion = 0;

    function setDistanceState(state, text) {
        distanceStatus.className = 'distance-status ' + state;
        distanceStatus.textContent = text;
    }

    function showClientError(message) {
        clientErrorAlert.textContent = '⚠️ ' + message;
        clientErrorAlert.classList.add('show');
    }

    function clearClientError() {
        clientErrorAlert.textContent = '';
        clientErrorAlert.classList.remove('show');
    }

    async function geocode(address) {
        const url = 'https://nominatim.openstreetmap.org/search?q='
            + encodeURIComponent(address)
            + '&format=json&limit=1&accept-language=ru';
        const response = await fetch(url, { headers: { 'User-Agent': 'RouteTracerApp/1.0' } });
        const data = await response.json();
        if (!Array.isArray(data) || !data.length) {
            throw new Error('Адрес не найден: ' + address);
        }
        return { lat: parseFloat(data[0].lat), lon: parseFloat(data[0].lon) };
    }

    async function fetchOsrmDistance(startCoord, endCoord) {
        const url = 'https://router.project-osrm.org/route/v1/driving/'
            + startCoord.lon + ',' + startCoord.lat + ';'
            + endCoord.lon + ',' + endCoord.lat
            + '?overview=false';
        const response = await fetch(url);
        const data = await response.json();
        if (data.code !== 'Ok' || !Array.isArray(data.routes) || !data.routes.length) {
            throw new Error('Маршрут между точками не найден');
        }
        return Math.round((data.routes[0].distance / 1000) * 10) / 10;
    }

    async function calculateDistance() {
        const start = startInput.value.trim();
        const end = endInput.value.trim();
        clearClientError();

        if (!start || !end) {
            distanceInput.value = '';
            setDistanceState('error', 'Укажите начальную и конечную точку');
            return;
        }

        const currentVersion = ++requestVersion;
        manualButton.disabled = true;
        distanceInput.value = '';
        setDistanceState('loading', 'Идет расчет маршрута...');

        try {
            const [startCoord, endCoord] = await Promise.all([geocode(start), geocode(end)]);
            const km = await fetchOsrmDistance(startCoord, endCoord);

            if (currentVersion !== requestVersion) return;
            distanceInput.value = km;
            distanceInput.readOnly = true;
            setDistanceState('success', '✓ Расстояние рассчитано: ' + km + ' км');
        } catch (error) {
            if (currentVersion !== requestVersion) return;
            distanceInput.value = '';
            setDistanceState('error', error.message);
        } finally {
            if (currentVersion === requestVersion) {
                manualButton.disabled = false;
            }
        }
    }

    function scheduleRealtimeCalculation() {
        clearTimeout(calcTimer);
        distanceInput.value = '';
        setDistanceState('info', 'Адрес изменен, пересчитываю...');
        calcTimer = setTimeout(calculateDistance, 900);
    }

    startInput.addEventListener('input', scheduleRealtimeCalculation);
    endInput.addEventListener('input', scheduleRealtimeCalculation);

    manualButton.addEventListener('click', function () {
        const enabled = !distanceInput.readOnly;
        if (enabled) {
            distanceInput.readOnly = true;
            manualButton.textContent = 'Ввести вручную';
            setDistanceState('info', 'Ручной ввод выключен. Авторасчет активен.');
            if (startInput.value.trim() && endInput.value.trim()) {
                calculateDistance();
            }
        } else {
            distanceInput.readOnly = false;
            distanceInput.focus();
            manualButton.textContent = 'Отключить ручной';
            setDistanceState('info', 'Ручной ввод включен. Введите расстояние в км.');
        }
    });

    form.addEventListener('submit', function (e) {
        if (!distanceInput.value) {
            e.preventDefault();
            showClientError('Расстояние не рассчитано. Проверьте адреса или включите ручной ввод.');
            setDistanceState('error', 'Перед сохранением укажите расстояние');
        }
    });
</script>
</body>
</html>