<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Выбор транспорта</title>
    <link rel="stylesheet" href="/css/base.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.5.1/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.5.1/dist/sweetalert2.all.min.js"></script>
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
        .selection-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 0.4s ease-out;
        }

        /* Шапка */
        .selection-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 32px 32px 28px;
            color: white;
        }

        .selection-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .cargo-info {
            margin-top: 20px;
            padding-top: 16px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            gap: 24px;
            flex-wrap: wrap;
        }

        .cargo-badge {
            background: rgba(255, 255, 255, 0.15);
            padding: 8px 20px;
            border-radius: 40px;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
        }

        .cargo-badge strong {
            font-weight: 700;
        }

        /* Основной контент */
        .selection-content {
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

        .vehicle-count {
            background: #f1f5f9;
            padding: 4px 12px;
            border-radius: 40px;
            font-size: 14px;
            font-weight: 500;
            color: #475569;
        }

        /* Сетка транспорта */
        .vehicles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 24px;
        }

        .vehicle-card {
            background: white;
            border: 1px solid #eef2f6;
            border-radius: 20px;
            transition: all 0.25s ease;
            overflow: hidden;
        }

        .vehicle-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px -12px rgba(0, 0, 0, 0.15);
            border-color: #e2e8f0;
        }

        .vehicle-card-content {
            padding: 20px;
        }

        .vehicle-model {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .vehicle-details {
            margin: 16px 0;
            padding: 12px 0;
            border-top: 1px solid #f1f5f9;
            border-bottom: 1px solid #f1f5f9;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 6px 0;
        }

        .detail-label {
            font-size: 13px;
            color: #64748b;
        }

        .detail-value {
            font-weight: 600;
            color: #0f172a;
            font-family: monospace;
        }

        .capacity-indicator {
            margin: 16px 0;
            padding: 12px;
            background: #f8fafc;
            border-radius: 14px;
        }

        .capacity-bar {
            height: 8px;
            background: #e2e8f0;
            border-radius: 4px;
            overflow: hidden;
            margin-top: 8px;
        }

        .capacity-fill {
            height: 100%;
            border-radius: 4px;
            transition: width 0.3s ease;
        }

        .capacity-fill.sufficient {
            background: #22c55e;
        }

        .capacity-fill.insufficient {
            background: #ef4444;
        }

        .capacity-text {
            font-size: 13px;
            font-weight: 500;
            margin-top: 8px;
            display: flex;
            justify-content: space-between;
        }

        .capacity-sufficient {
            color: #15803d;
        }

        .capacity-insufficient {
            color: #dc2626;
        }

        /* Кнопка выбора */
        .btn-select {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
            color: white;
            border: none;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 16px;
        }

        .btn-select:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(34, 197, 94, 0.3);
        }

        .btn-select:disabled {
            background: #94a3b8;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
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

        .add-vehicle-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 24px;
            background: #3b82f6;
            color: white;
            text-decoration: none;
            border-radius: 40px;
            font-weight: 500;
            transition: all 0.2s;
        }

        .add-vehicle-link:hover {
            background: #2563eb;
            transform: translateY(-2px);
        }

        /* Адаптивность */
        @media (max-width: 768px) {
            body {
                padding: 16px;
            }

            .selection-header {
                padding: 24px 20px;
            }

            .selection-content {
                padding: 20px;
            }

            .vehicles-grid {
                grid-template-columns: 1fr;
            }

            .cargo-info {
                flex-direction: column;
                gap: 12px;
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
    <div class="selection-card">
        <!-- ШАПКА -->
        <div class="selection-header">
            <h1>
                🚚 Выбор транспорта
            </h1>
            <p>Выберите автомобиль для выполнения маршрута</p>
            <div class="cargo-info">
                <div class="cargo-badge">
                    <span>📦</span>
                    <span>Масса груза: <strong>${route.cargo_weight!0}</strong> кг</span>
                </div>
                <div class="cargo-badge">
                    <span>📍</span>
                    <span>Маршрут: ${route.startLocation!''} → ${route.endLocation!''}</span>
                </div>
                <div class="cargo-badge">
                    <span>💰</span>
                    <span>Оплата: <strong>${route.payment!0}</strong> ₽</span>
                </div>
            </div>
        </div>

        <!-- ОСНОВНОЙ КОНТЕНТ -->
        <div class="selection-content">
            <div class="section-header">
                <div class="section-title">
                    <span class="section-icon">🚗</span>
                    <h2>Доступный транспорт</h2>
                    <span class="vehicle-count">${vehicles?size} автомобилей</span>
                </div>
            </div>

            <#if vehicles?has_content>
                <div class="vehicles-grid">
                    <#list vehicles as vehicle>
                        <#assign isSufficient = (vehicle.loadCapacity >= route.cargo_weight)>
                        <div class="vehicle-card">
                            <div class="vehicle-card-content">
                                <div class="vehicle-model">
                                    <span>🚗</span> ${vehicle.model!''}
                                </div>

                                <div class="vehicle-details">
                                    <div class="detail-row">
                                        <span class="detail-label">VIN номер</span>
                                        <span class="detail-value">${vehicle.vin!''}</span>
                                    </div>
                                    <div class="detail-row">
                                        <span class="detail-label">Грузоподъемность</span>
                                        <span class="detail-value">${vehicle.loadCapacity!0} кг</span>
                                    </div>
                                    <#if vehicle.manufactureYear?? && vehicle.manufactureYear != 0>
                                        <div class="detail-row">
                                            <span class="detail-label">Год выпуска</span>
                                            <span class="detail-value">${vehicle.manufactureYear}</span>
                                        </div>
                                    </#if>
                                    <#if vehicle.licensePlate?? && vehicle.licensePlate != "">
                                        <div class="detail-row">
                                            <span class="detail-label">Номерной знак</span>
                                            <span class="detail-value">${vehicle.licensePlate}</span>
                                        </div>
                                    </#if>
                                </div>

                                <!-- Индикатор грузоподъемности -->
                                <div class="capacity-indicator">
                                    <div class="capacity-bar">
                                        <#assign percentage = (route.cargo_weight / vehicle.loadCapacity * 100)?round>
                                        <#if (percentage > 100)>
                                            <#assign percentage = 100>
                                        </#if>
                                        <div class="capacity-fill ${isSufficient?then('sufficient', 'insufficient')}"
                                             style="width: ${percentage}%"></div>
                                    </div>
                                    <div class="capacity-text">
                                        <span>Загрузка: ${route.cargo_weight} / ${vehicle.loadCapacity} кг</span>
                                        <#if isSufficient>
                                            <span class="capacity-sufficient">✓ Подходит</span>
                                        <#else>
                                            <span class="capacity-insufficient">⚠️ Недостаточно</span>
                                        </#if>
                                    </div>
                                </div>

                                <!-- Кнопка выбора -->
                                <form id="form-${vehicle.id}"
                                      action="/carrier/select_car/create_order"
                                      method="post"
                                      style="margin: 0;">
                                    <input type="hidden" name="routeId" value="${route.id}">
                                    <input type="hidden" name="carrierId" value="${carrierId}">
                                    <input type="hidden" name="vehicleId" value="${vehicle.id}">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    <button type="submit"
                                            class="btn-select"
<#--                                            onclick="checkCapacity(${vehicle.id}, ${route.cargo_weight}, ${vehicle.loadCapacity!0})"-->
                                            <#if !isSufficient>disabled</#if>>
                                        <#if isSufficient>
                                            ✅ Выбрать этот автомобиль
                                        <#else>
                                            ⚠️ Не подходит по грузоподъемности
                                        </#if>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </#list>
                </div>
            <#else>
                <div class="empty-state">
                    <div class="empty-icon">🚗</div>
                    <h3>Нет доступного транспорта</h3>
                    <p>У вас пока нет добавленных автомобилей</p>
                    <a href="/vehicles/add_vehicle" class="add-vehicle-link">
                        ➕ Добавить транспорт
                    </a>
                </div>
            </#if>
            <!-- КНОПКА НАЗАД -->
            <div class="back-button-container">
                <a href="javascript:history.back()" class="btn-back">
                    ← Вернуться к маршруту
                </a>
            </div>
        </div>
    </div>
</div>

<#--<script>
    function checkCapacity(vehicleId, cargoWeight, loadCapacity) {
        if (loadCapacity < cargoWeight) {
            Swal.fire({
                icon: 'error',
                title: 'Недостаточно грузоподъемности',
                html: `Грузоподъемность автомобиля (<strong>${loadCapacity} кг</strong>)<br>меньше массы груза (<strong>${cargoWeight} кг</strong>)`,
                confirmButtonColor: '#ef4444',
                confirmButtonText: 'Понятно'
            });
        } else {
            Swal.fire({
                icon: 'question',
                title: 'Подтверждение',
                html: `Вы действительно хотите назначить этот автомобиль<br>на маршрут с грузом <strong>${cargoWeight} кг</strong>?`,
                showCancelButton: true,
                confirmButtonColor: '#22c55e',
                cancelButtonColor: '#ef4444',
                confirmButtonText: '✅ Да, выбрать',
                cancelButtonText: '❌ Отмена'
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('form-' + vehicleId).submit();
                }
            });
        }
    }
</script>-->
</body>
</html>