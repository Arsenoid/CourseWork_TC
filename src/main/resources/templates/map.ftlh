<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Route Tracer — Трекер маршрутов</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Яндекс.Карты API 2.1 — российский картографический сервис -->
    <!-- Получить ключ: https://developer.tech.yandex.ru/ → «JavaScript API и HTTP Геокодер» -->
    <!-- Заменить YOUR_YANDEX_MAPS_API_KEY на свой ключ -->
    <style>
        .ymaps-2-1-79-map-copyrights-promo { display: none !important; }
    </style>
    <style>
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #f1f5f9;
            color: #0f172a;
            height: 100vh;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        /* ── HEADER ─────────────────────────────────────────────── */
        .app-header {
            height: 60px;
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            flex-shrink: 0;
            gap: 16px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 0;
        }

        .app-header h1 {
            font-size: 17px;
            font-weight: 700;
            white-space: nowrap;
        }

        .vehicle-badge {
            background: rgba(255,255,255,0.15);
            padding: 4px 12px;
            border-radius: 40px;
            font-size: 13px;
            white-space: nowrap;
            max-width: 220px;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .btn-header-back {
            background: rgba(255,255,255,0.12);
            border: none;
            color: white;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: background .15s;
            white-space: nowrap;
        }
        .btn-header-back:hover { background: rgba(255,255,255,0.22); }

        .header-status {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            flex-shrink: 0;
        }

        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #64748b;
            transition: background .3s;
        }
        .status-dot.active   { background: #22c55e; box-shadow: 0 0 0 3px rgba(34,197,94,.25); }
        .status-dot.error    { background: #ef4444; }
        .status-dot.warning  { background: #f59e0b; }

        /* ── BODY ────────────────────────────────────────────────── */
        .app-body {
            display: flex;
            flex: 1;
            min-height: 0;
        }

        /* ── LEFT PANEL ──────────────────────────────────────────── */
        .control-panel {
            width: 340px;
            flex-shrink: 0;
            background: white;
            border-right: 1px solid #e2e8f0;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .tabs {
            display: flex;
            border-bottom: 1px solid #e2e8f0;
            flex-shrink: 0;
        }
        .tab {
            flex: 1;
            padding: 14px;
            background: none;
            border: none;
            font-size: 14px;
            font-weight: 500;
            color: #64748b;
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all .15s;
        }
        .tab:hover { color: #3b82f6; background: #f8fafc; }
        .tab.active { color: #3b82f6; border-bottom-color: #3b82f6; }

        .panel-scroll {
            flex: 1;
            overflow-y: auto;
            padding: 16px;
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .hidden { display: none !important; }

        /* ── CONTROL SECTIONS ─────────────────────────────────────── */
        .section {
            background: #f8fafc;
            border-radius: 16px;
            padding: 14px;
        }
        .section-title {
            font-size: 11px;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: .5px;
            margin-bottom: 10px;
        }

        .form-label {
            display: block;
            font-size: 12px;
            font-weight: 500;
            color: #475569;
            margin-bottom: 5px;
        }
        .form-input {
            width: 100%;
            padding: 9px 12px;
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            font-size: 14px;
            font-family: inherit;
            outline: none;
            transition: border-color .15s;
            background: white;
        }
        .form-input:focus { border-color: #3b82f6; }

        .source-select {
            display: flex;
            gap: 8px;
        }
        .source-btn {
            flex: 1;
            padding: 8px;
            border-radius: 10px;
            border: 2px solid #e2e8f0;
            background: white;
            font-size: 13px;
            font-weight: 500;
            color: #64748b;
            cursor: pointer;
            text-align: center;
            transition: all .15s;
        }
        .source-btn.selected {
            border-color: #3b82f6;
            background: #eff6ff;
            color: #2563eb;
        }

        /* ── BUTTONS ─────────────────────────────────────────────── */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            padding: 10px 20px;
            border-radius: 40px;
            border: none;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all .15s;
            text-decoration: none;
            font-family: inherit;
        }
        .btn:disabled { opacity: .45; cursor: not-allowed; }
        .btn-primary {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            color: white;
            width: 100%;
        }
        .btn-primary:hover:not(:disabled) { box-shadow: 0 6px 16px rgba(59,130,246,.35); transform: translateY(-1px); }
        .btn-danger {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            width: 100%;
        }
        .btn-danger:hover:not(:disabled) { box-shadow: 0 6px 16px rgba(239,68,68,.3); transform: translateY(-1px); }
        .btn-secondary {
            background: #f1f5f9;
            color: #475569;
            width: 100%;
        }
        .btn-secondary:hover:not(:disabled) { background: #e2e8f0; }

        .track-actions {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        /* ── INFO BLOCKS ──────────────────────────────────────────── */
        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 13px;
        }
        .info-row:last-child { border-bottom: none; }
        .info-key  { color: #64748b; font-weight: 500; }
        .info-val  { color: #0f172a; font-weight: 600; font-family: monospace; font-size: 12px; }

        /* ── ALERT BOX ────────────────────────────────────────────── */
        .alert {
            padding: 10px 14px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 500;
            display: none;
        }
        .alert.show { display: block; }
        .alert-error   { background: #fef2f2; color: #dc2626; }
        .alert-success { background: #f0fdf4; color: #16a34a; }
        .alert-info    { background: #eff6ff; color: #2563eb; }

        /* ── SESSION CARDS ────────────────────────────────────────── */
        .sessions-list {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-top: 4px;
        }
        .session-card {
            background: white;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            padding: 10px 12px;
            cursor: pointer;
            transition: all .15s;
        }
        .session-card:hover {
            border-color: #3b82f6;
            background: #eff6ff;
            transform: translateX(2px);
        }
        .session-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 4px;
        }
        .session-id-label {
            font-size: 13px;
            font-weight: 700;
            color: #0f172a;
        }
        .badge {
            padding: 2px 8px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        .badge-active   { background: #dcfce7; color: #16a34a; }
        .badge-finished { background: #f1f5f9; color: #64748b; }
        .session-meta {
            font-size: 12px;
            color: #64748b;
        }
        .empty-text {
            font-size: 13px;
            color: #94a3b8;
            text-align: center;
            padding: 16px 0;
        }

        /* ── MAP AREA ────────────────────────────────────────────── */
        .map-wrapper {
            flex: 1;
            position: relative;
            min-width: 0;
        }

        #ymap {
            width: 100%;
            height: 100%;
        }

        .map-loading {
            position: absolute;
            inset: 0;
            background: #f8fafc;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 12px;
            z-index: 10;
            transition: opacity .3s;
        }
        .map-loading.hidden { opacity: 0; pointer-events: none; }

        .spinner {
            width: 36px;
            height: 36px;
            border: 3px solid #e2e8f0;
            border-top-color: #3b82f6;
            border-radius: 50%;
            animation: spin .7s linear infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }

        .map-loading p { font-size: 14px; color: #64748b; font-weight: 500; }

        /* ── COORD DISPLAY ───────────────────────────────────────── */
        .coord-display {
            font-size: 12px;
            font-family: monospace;
            color: #475569;
            font-weight: 600;
            background: #f1f5f9;
            padding: 6px 10px;
            border-radius: 8px;
            margin-top: 4px;
        }

        /* ── RESPONSIVE ──────────────────────────────────────────── */
        @media (max-width: 640px) {
            .control-panel { width: 100%; height: 45vh; border-right: none; border-bottom: 1px solid #e2e8f0; }
            .app-body { flex-direction: column; }
            .map-wrapper { flex: 1; }
            .vehicle-badge { display: none; }
        }
    </style>
</head>
<body>

<!-- ═══════════ HEADER ═══════════ -->
<header class="app-header">
    <div class="header-left">
        <a href="javascript:history.back()" class="btn-header-back">← Назад</a>
        <h1>Трекер маршрутов</h1>
        <#if vehicle??>
            <span class="vehicle-badge">${vehicle.model!''} · ${vehicle.licensePlate!''}</span>
        </#if>
    </div>
    <div class="header-status">
        <span class="status-dot" id="statusDot"></span>
        <span id="statusText">Не активен</span>
    </div>
</header>

<!-- ═══════════ BODY ═══════════ -->
<div class="app-body">

    <!-- ───── LEFT PANEL ───── -->
    <aside class="control-panel">
        <div class="tabs">
            <button class="tab active" id="tabTracking" onclick="switchTab('tracking')">📍 Запись</button>
            <button class="tab" id="tabSession" onclick="switchTab('session')">🗂 Просмотр</button>
        </div>

        <!-- TRACKING PANEL -->
        <div class="panel-scroll" id="panelTracking">

            <!-- Alert -->
            <div class="alert" id="trackAlert"></div>

            <!-- Vehicle ID -->
            <div class="section">
                <div class="section-title">Транспорт</div>
                <#if vehicle??>
                    <div class="info-row">
                        <span class="info-key">Модель</span>
                        <span class="info-val">${vehicle.model!''}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-key">Номер</span>
                        <span class="info-val">${vehicle.licensePlate!''}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-key">ID</span>
                        <span class="info-val">${vehicleId?c}</span>
                    </div>
                <#else>
                    <label class="form-label" for="vehicleIdInput">ID транспортного средства</label>
                    <input class="form-input" type="number" id="vehicleIdInput" placeholder="например: 1" min="1">
                </#if>
            </div>

            <!-- Source selector -->
            <div class="section">
                <div class="section-title">Источник данных</div>
                <div class="source-select">
                    <button class="source-btn selected" id="srcBrowser" onclick="selectSource('BROWSER')">
                        📡 Браузер
                    </button>
                    <button class="source-btn" id="srcSimulator" onclick="selectSource('SIMULATOR')">
                        🤖 Симулятор
                    </button>
                </div>
                <p style="font-size:12px;color:#94a3b8;margin-top:8px;" id="sourceHint">
                    Использует GPS браузера для записи реального маршрута.
                </p>
            </div>

            <!-- Start / Continue / Stop -->
            <div class="track-actions">
                <button class="btn btn-primary" id="btnStart" onclick="startTracking()">
                    ▶ Начать запись
                </button>
                <button class="btn btn-secondary" id="btnContinue" onclick="continueTracking()">
                    ↻ Продолжить запись
                </button>
                <button class="btn btn-danger hidden" id="btnStop" onclick="stopTracking()">
                    ■ Остановить запись
                </button>
            </div>

            <!-- Current position -->
            <div class="section" id="posSection" style="display:none;">
                <div class="section-title">Текущая позиция</div>
                <div class="coord-display" id="coordDisplay">— , —</div>
                <div class="info-row" style="margin-top:8px;">
                    <span class="info-key">Скорость</span>
                    <span class="info-val" id="speedDisplay">— км/ч</span>
                </div>
                <div class="info-row">
                    <span class="info-key">Точек записано</span>
                    <span class="info-val" id="pointsCount">0</span>
                </div>
                <div class="info-row">
                    <span class="info-key">Сессия ID</span>
                    <span class="info-val" id="activeSessionDisplay">—</span>
                </div>
            </div>

            <!-- View session link (shown after stop) -->
            <div id="viewSessionLink" style="display:none;">
                <button class="btn btn-secondary" onclick="viewFinishedSession()">
                    🗂 Просмотреть сессию
                </button>
            </div>

        </div>

        <!-- SESSION PANEL -->
        <div class="panel-scroll hidden" id="panelSession">

            <div class="alert" id="sessionAlert"></div>

            <div class="section">
                <div class="section-title">Открыть сессию по ID</div>
                <label class="form-label" for="sessionIdInput">ID сессии</label>
                <div style="display:flex;gap:8px;margin-bottom:10px;">
                    <input class="form-input" type="number" id="sessionIdInput" placeholder="например: 42" min="1" style="flex:1;">
                    <button class="btn btn-primary" style="width:auto;padding:9px 16px;" onclick="loadSessionFromInput()">
                        Открыть
                    </button>
                </div>
            </div>

            <!-- Session info (shown after load) -->
            <div class="section hidden" id="sessionInfoBlock">
                <div class="section-title">Информация о сессии</div>
                <div class="info-row">
                    <span class="info-key">Статус</span>
                    <span class="info-val" id="si-status">—</span>
                </div>
                <div class="info-row">
                    <span class="info-key">Источник</span>
                    <span class="info-val" id="si-source">—</span>
                </div>
                <div class="info-row">
                    <span class="info-key">Начало</span>
                    <span class="info-val" id="si-started">—</span>
                </div>
                <div class="info-row">
                    <span class="info-key">Конец</span>
                    <span class="info-val" id="si-ended">—</span>
                </div>
                <div class="info-row">
                    <span class="info-key">Точек</span>
                    <span class="info-val" id="si-points">—</span>
                </div>
            </div>

            <!-- Sessions list (loaded if vehicleId set) -->
            <#if vehicleId??>
            <div class="section">
                <div class="section-title">Сессии транспорта</div>
                <div class="sessions-list" id="sessionsList">
                    <p class="empty-text">Загрузка...</p>
                </div>
            </div>
            </#if>

        </div>
    </aside>

    <!-- ───── MAP ───── -->
    <div class="map-wrapper">
        <div id="ymap"></div>
        <div class="map-loading" id="mapLoading">
            <div class="spinner"></div>
            <p>Загрузка карты…</p>
        </div>
    </div>
</div>

<!-- ═══════════ ЯНДЕКС.КАРТЫ API 2.1 ═══════════ -->
<script src="https://api-maps.yandex.ru/2.1/?lang=ru_RU&apikey=YOUR_YANDEX_MAPS_API_KEY" type="text/javascript"></script>

<script>
    // ── CONFIG FROM SERVER ────────────────────────────────────────
    const VEHICLE_ID      = <#if vehicleId??>${vehicleId?c}<#else>null</#if>;
    const INITIAL_SESSION = <#if sessionId??>${sessionId?c}<#else>null</#if>;
    const ROUTE_ID        = <#if routeId??>${routeId?c}<#else>null</#if>;
    <#if vehicle?? && vehicle.lastLatitude?? && vehicle.lastLongitude??>
    const VEHICLE_LAST_POS = [${vehicle.lastLatitude?c}, ${vehicle.lastLongitude?c}];
    <#else>
    const VEHICLE_LAST_POS = null;
    </#if>

    // ── CONSTANTS ─────────────────────────────────────────────────
    const MOSCOW = [55.7558, 37.6176];
    const POLL_MS = 3000;
    const SIM_MS  = 2000;
    const GEO_WATCH_OPTIONS = {
        enableHighAccuracy: true,
        maximumAge: 60000,
        timeout: 45000
    };
    const GEO_FALLBACK_OPTIONS = {
        enableHighAccuracy: false,
        maximumAge: 60000,
        timeout: 45000
    };
    const GEO_POLL_MS = 15000;

    // ── STATE ─────────────────────────────────────────────────────
    let map            = null;
    let currentMarker  = null;
    let routePolyline  = null;
    let startMarker    = null;
    let endMarker      = null;
    let routePoints    = [];
    let activeSession  = null;   // {id, source, vehicleId}
    let currentVehicle = VEHICLE_ID;
    let selectedSource = 'BROWSER';
    let isTracking     = false;
    let pointsRecorded = 0;

    let pollingTimer   = null;
    let simTimer       = null;
    let geoWatchId     = null;
    let geoPollTimer   = null;
    let lastGeoTime    = 0;
    let simState       = null;
    let telemetrySaveWarned = false;

    // ── MAP INIT (Яндекс.Карты API 2.1) ──────────────────────────
    ymaps.ready(function initMap() {
        const center = VEHICLE_LAST_POS || MOSCOW;
        map = new ymaps.Map('ymap', {
            center: center,
            zoom: 13,
            controls: ['zoomControl', 'fullscreenControl']
        });

        hideMapLoading();

        if (INITIAL_SESSION) {
            switchTab('session');
            document.getElementById('sessionIdInput').value = INITIAL_SESSION;
            loadSession(INITIAL_SESSION);
        }

        if (VEHICLE_ID) {
            loadSessionsList(VEHICLE_ID);
        }
    });

    function hideMapLoading() {
        const el = document.getElementById('mapLoading');
        el.classList.add('hidden');
        setTimeout(() => el.style.display = 'none', 350);
    }

    // ── TAB SWITCHING ─────────────────────────────────────────────
    function switchTab(tab) {
        document.getElementById('tabTracking').classList.toggle('active', tab === 'tracking');
        document.getElementById('tabSession').classList.toggle('active', tab === 'session');
        document.getElementById('panelTracking').classList.toggle('hidden', tab !== 'tracking');
        document.getElementById('panelSession').classList.toggle('hidden', tab !== 'session');
    }

    // ── SOURCE SELECTION ──────────────────────────────────────────
    function selectSource(src) {
        if (isTracking) return;
        selectedSource = src;
        document.getElementById('srcBrowser').classList.toggle('selected', src === 'BROWSER');
        document.getElementById('srcSimulator').classList.toggle('selected', src === 'SIMULATOR');
        document.getElementById('sourceHint').textContent = src === 'BROWSER'
            ? 'Использует GPS браузера для записи реального маршрута.'
            : 'Симулирует движение транспорта, отправляя синтетические точки.';
    }

    // ── VEHICLE ID HELPER ─────────────────────────────────────────
    function getVehicleId() {
        if (currentVehicle) return currentVehicle;
        const input = document.getElementById('vehicleIdInput');
        const val = input ? parseInt(input.value, 10) : NaN;
        if (isNaN(val) || val < 1) {
            showAlert('trackAlert', 'Введите корректный ID транспортного средства.', 'error');
            return null;
        }
        currentVehicle = val;
        return val;
    }

    // ── START / STOP TRACKING ─────────────────────────────────────
    async function startTracking() {
        clearAlert('trackAlert');
        const vId = getVehicleId();
        if (!vId) return;
        if (!ROUTE_ID) {
            showAlert('trackAlert', 'Для старта трекинга откройте карту со страницы маршрута (кнопка «Открыть трекинг») или добавьте routeId в адрес: /map?vehicleId=…&routeId=…', 'error');
            return;
        }

        setBtnTracking(true);
        setStatus('Запуск…', 'warning');

        try {
            const session = await apiPost('/api/sessions', {
                vehicleId: vId,
                source: selectedSource,
                routeId: ROUTE_ID
            });
            activeSession = session;
            pointsRecorded = 0;

            document.getElementById('activeSessionDisplay').textContent = session.id;
            document.getElementById('posSection').style.display = '';
            document.getElementById('viewSessionLink').style.display = 'none';
            document.getElementById('pointsCount').textContent = '0';

            clearMap();
            routePoints = [];

            if (selectedSource === 'BROWSER') {
                startBrowserSource(vId, session.id);
            } else {
                startSimulatorSource(vId, session.id);
            }

            isTracking = true;
            telemetrySaveWarned = false;
            setStatus('Запись активна', 'active');
        } catch (e) {
            setBtnTracking(false);
            showAlert('trackAlert', 'Ошибка запуска: ' + e.message, 'error');
            setStatus('Ошибка', 'error');
        }
    }

    async function continueTracking() {
        clearAlert('trackAlert');
        if (isTracking) {
            showAlert('trackAlert', 'Запись уже идёт — сначала остановите её.', 'info');
            return;
        }
        const vId = getVehicleId();
        if (!vId) return;

        switchTab('tracking');
        setStatus('Поиск активной сессии…', 'warning');

        try {
            const sessions = await apiGet('/api/sessions?vehicleId=' + vId);
            const active = (sessions || []).find(s => s.status === 'ACTIVE');
            if (!active) {
                setStatus('Не активен', '');
                showAlert('trackAlert',
                    'Нет активной сессии для этого транспорта. Нажмите «Начать запись» (нужен маршрут в URL).',
                    'error');
                return;
            }
            if (ROUTE_ID != null && active.routeId != null && Number(active.routeId) !== Number(ROUTE_ID)) {
                setStatus('Не активен', '');
                showAlert('trackAlert',
                    'Активная сессия привязана к другому маршруту (#' + active.routeId + '). Откройте карту с нужным routeId или завершите ту сессию.',
                    'error');
                return;
            }

            setBtnTracking(true);
            setStatus('Возобновление…', 'warning');

            const session = await apiGet('/api/sessions/' + active.id);
            const src = session.source === 'SIMULATOR' ? 'SIMULATOR' : 'BROWSER';
            selectSource(src);

            clearMap();
            let points = [];
            try {
                points = await apiGet('/api/sessions/' + active.id + '/points') || [];
            } catch (ignore) {
                points = [];
            }
            points.sort((a, b) => new Date(a.recordedAt) - new Date(b.recordedAt));
            routePoints = points.map(p => [p.latitude, p.longitude]);
            redrawRoute();
            pointsRecorded = points.length;
            document.getElementById('pointsCount').textContent = String(pointsRecorded);

            if (points.length > 0) {
                const last = points[points.length - 1];
                ymRemove(currentMarker);
                currentMarker = new ymaps.Placemark([last.latitude, last.longitude], {
                    hintContent: 'Текущая позиция',
                    balloonContent: last.latitude.toFixed(5) + ', ' + last.longitude.toFixed(5)
                }, {
                    preset: 'islands#blueCircleDotIcon'
                });
                map.geoObjects.add(currentMarker);
                document.getElementById('coordDisplay').textContent =
                    last.latitude.toFixed(6) + ', ' + last.longitude.toFixed(6);
                if (points.length >= 2) {
                    fitToRoute();
                } else {
                    map.panTo([last.latitude, last.longitude], { duration: 400 });
                }
            }

            activeSession = session;
            document.getElementById('activeSessionDisplay').textContent = String(session.id);
            document.getElementById('posSection').style.display = '';
            document.getElementById('viewSessionLink').style.display = 'none';

            if (src === 'BROWSER') {
                startBrowserSource(vId, session.id);
            } else {
                startSimulatorSource(vId, session.id);
            }
            isTracking = true;
            telemetrySaveWarned = false;
            setStatus('Запись активна', 'active');
            showAlert('trackAlert',
                'Продолжаем сессию #' + session.id + (pointsRecorded > 0 ? ' (точек в базе: ' + pointsRecorded + ').' : '.'),
                'success');
        } catch (e) {
            setBtnTracking(false);
            setStatus('Ошибка', 'error');
            showAlert('trackAlert', 'Не удалось продолжить: ' + e.message, 'error');
        }
    }

    async function stopTracking() {
        if (!activeSession) return;
        setBtnTracking(false);

        try {
            if (selectedSource === 'BROWSER') stopBrowserSource();
            else stopSimulatorSource();

            await apiPost('/api/sessions/' + activeSession.id + '/stop', {});
            setStatus('Запись остановлена', '');
            showAlert('trackAlert', 'Сессия #' + activeSession.id + ' завершена. Записано точек: ' + pointsRecorded, 'success');
            document.getElementById('viewSessionLink').style.display = '';
        } catch (e) {
            showAlert('trackAlert', 'Ошибка остановки: ' + e.message, 'error');
        } finally {
            isTracking = false;
        }
    }

    function viewFinishedSession() {
        if (!activeSession) return;
        switchTab('session');
        document.getElementById('sessionIdInput').value = activeSession.id;
        loadSession(activeSession.id);
    }

    function setBtnTracking(tracking) {
        document.getElementById('btnStart').classList.toggle('hidden', tracking);
        document.getElementById('btnContinue').classList.toggle('hidden', tracking);
        document.getElementById('btnStop').classList.toggle('hidden', !tracking);
        const src1 = document.getElementById('srcBrowser');
        const src2 = document.getElementById('srcSimulator');
        src1.disabled = tracking;
        src2.disabled = tracking;
    }

    // ── BROWSER GEOLOCATION ───────────────────────────────────────
    function startBrowserSource(vId, sessionId) {
        if (!navigator.geolocation) {
            showAlert('trackAlert', 'Геолокация не поддерживается этим браузером.', 'error');
            stopTracking();
            return;
        }
        lastGeoTime = 0;
        geoWatchId = navigator.geolocation.watchPosition(
            pos => onGeoSuccess(pos, vId, sessionId),
            err => onGeoError(err),
            GEO_WATCH_OPTIONS
        );
        // Polling fallback: if watchPosition hasn't fired recently, force a fresh fix
        geoPollTimer = setInterval(() => {
            if (Date.now() - lastGeoTime > GEO_POLL_MS) {
                navigator.geolocation.getCurrentPosition(
                    pos => onGeoSuccess(pos, vId, sessionId),
                    err => onGeoError(err),
                    GEO_FALLBACK_OPTIONS
                );
            }
        }, GEO_POLL_MS);
    }

    function stopBrowserSource() {
        if (geoWatchId !== null) {
            navigator.geolocation.clearWatch(geoWatchId);
            geoWatchId = null;
        }
        if (geoPollTimer !== null) {
            clearInterval(geoPollTimer);
            geoPollTimer = null;
        }
    }

    function onGeoError(err) {
        if (err.code === 1) {
            // PERMISSION_DENIED — do not finish session automatically; pause capture
            pauseActiveCapture('Доступ к геолокации запрещён. Сессия не завершена: выдайте доступ и нажмите «Продолжить запись».');
        } else {
            // POSITION_UNAVAILABLE (2) or TIMEOUT (3) — transient, keep waiting
            setStatus('Ожидание GPS…', 'warning');
            const code = err.code === 2 ? 'POSITION_UNAVAILABLE' : err.code === 3 ? 'TIMEOUT' : 'UNKNOWN';
            const message = err.message || '(без текста от браузера)';
            console.warn('Геолокация: временная ошибка [' + code + ']:', message);
        }
    }

    function pauseActiveCapture(message) {
        stopBrowserSource();
        stopSimulatorSource();
        isTracking = false;
        setBtnTracking(false);
        setStatus('Пауза: нет геодоступа', 'warning');
        showAlert('trackAlert', message, 'error');
    }

    async function onGeoSuccess(pos, vId, sessionId) {
        lastGeoTime = Date.now();
        if (isTracking) setStatus('Запись активна', 'active');
        const { latitude: lat, longitude: lon, speed } = pos.coords;
        const speedKmh = speed != null ? +(speed * 3.6).toFixed(1) : null;
        try {
            await sendTelemetry(vId, lat, lon, speedKmh, 'BROWSER', sessionId);
            updatePosition(lat, lon);
            if (speedKmh != null) document.getElementById('speedDisplay').textContent = speedKmh + ' км/ч';
            telemetrySaveWarned = false;
        } catch (e) {
            console.error('Geo telemetry error:', e);
            setStatus('GPS есть, ошибка отправки', 'warning');
            if (!telemetrySaveWarned) {
                showAlert('trackAlert', 'Координаты получены, но не удалось отправить точку на сервер. Запись продолжится автоматически.', 'error');
                telemetrySaveWarned = true;
            }
        }
    }

    // ── SIMULATOR ─────────────────────────────────────────────────
    function startSimulatorSource(vId, sessionId) {
        const start = VEHICLE_LAST_POS || MOSCOW;
        simState = {
            lat:     start[0],
            lon:     start[1],
            heading: Math.random() * 360,
            speed:   35 + Math.random() * 20   // km/h
        };
        simulatorTick(vId, sessionId);
        simTimer = setInterval(() => simulatorTick(vId, sessionId), SIM_MS);
    }

    function stopSimulatorSource() {
        if (simTimer !== null) { clearInterval(simTimer); simTimer = null; }
        simState = null;
    }

    async function simulatorTick(vId, sessionId) {
        if (!simState) return;
        // Vary speed and heading slightly
        simState.speed   += (Math.random() - 0.5) * 6;
        simState.speed    = Math.max(15, Math.min(80, simState.speed));
        simState.heading += (Math.random() - 0.5) * 25;

        const distM    = simState.speed * (SIM_MS / 1000) / 3.6;
        const headRad  = simState.heading * Math.PI / 180;
        simState.lat  += (Math.cos(headRad) * distM) / 111320;
        simState.lon  += (Math.sin(headRad) * distM) / (111320 * Math.cos(simState.lat * Math.PI / 180));

        const speedKmh = +simState.speed.toFixed(1);
        try {
            await sendTelemetry(vId, simState.lat, simState.lon, speedKmh, 'SIMULATOR', sessionId);
            updatePosition(simState.lat, simState.lon, true);
            document.getElementById('speedDisplay').textContent = speedKmh + ' км/ч';
        } catch (e) {
            console.error('Sim telemetry error:', e);
        }
    }

    // ── MAP HELPERS (Яндекс.Карты API 2.1) ───────────────────────
    function ymRemove(obj) {
        if (obj && map) map.geoObjects.remove(obj);
    }

    function updatePosition(lat, lon, follow = false) {
        routePoints.push([lat, lon]);
        pointsRecorded++;
        document.getElementById('pointsCount').textContent = pointsRecorded;
        document.getElementById('coordDisplay').textContent =
            lat.toFixed(6) + ', ' + lon.toFixed(6);

        redrawRoute();

        ymRemove(currentMarker);
        currentMarker = new ymaps.Placemark([lat, lon], {
            hintContent: 'Текущая позиция',
            balloonContent: lat.toFixed(5) + ', ' + lon.toFixed(5)
        }, {
            preset: 'islands#blueCircleDotIcon'
        });
        map.geoObjects.add(currentMarker);

        if (follow || routePoints.length <= 2) {
            map.panTo([lat, lon], { duration: 400 });
        }
    }

    function redrawRoute() {
        ymRemove(routePolyline);
        routePolyline = null;
        if (routePoints.length < 2) return;
        routePolyline = new ymaps.Polyline(routePoints, {}, {
            strokeColor: '#3b82f6',
            strokeWidth: 5,
            strokeOpacity: 0.85
        });
        map.geoObjects.add(routePolyline);
    }

    function clearMap() {
        ymRemove(currentMarker);  currentMarker  = null;
        ymRemove(routePolyline);  routePolyline  = null;
        ymRemove(startMarker);    startMarker    = null;
        ymRemove(endMarker);      endMarker      = null;
        routePoints = [];
    }

    function fitToRoute() {
        if (!map || !routePolyline) return;
        const bounds = map.geoObjects.getBounds();
        if (bounds) map.setBounds(bounds, { checkZoomRange: true, zoomMargin: 50 });
    }

    // ── SESSION VIEWER ────────────────────────────────────────────
    function loadSessionFromInput() {
        const val = parseInt(document.getElementById('sessionIdInput').value, 10);
        if (isNaN(val) || val < 1) {
            showAlert('sessionAlert', 'Введите корректный ID сессии.', 'error');
            return;
        }
        loadSession(val);
    }

    async function loadSession(sessionId) {
        clearAlert('sessionAlert');
        document.getElementById('sessionInfoBlock').classList.add('hidden');
        showAlert('sessionAlert', 'Загрузка сессии…', 'info');

        try {
            const [session, points] = await Promise.all([
                apiGet('/api/sessions/' + sessionId),
                apiGet('/api/sessions/' + sessionId + '/points')
            ]);

            clearAlert('sessionAlert');
            clearMap();

            if (!points || points.length === 0) {
                showAlert('sessionAlert', 'Сессия не содержит точек маршрута.', 'info');
                updateSessionInfo(session, 0);
                return;
            }

            points.sort((a, b) => new Date(a.recordedAt) - new Date(b.recordedAt));
            routePoints = points.map(p => [p.latitude, p.longitude]);
            redrawRoute();

            // Start marker
            const first = points[0];
            startMarker = new ymaps.Placemark([first.latitude, first.longitude], {
                hintContent: 'Начало маршрута',
                balloonContent: 'Начало маршрута · ' + formatTime(first.recordedAt)
            }, {
                preset: 'islands#greenCircleDotIcon'
            });
            map.geoObjects.add(startMarker);

            // End marker
            const last = points[points.length - 1];
            endMarker = new ymaps.Placemark([last.latitude, last.longitude], {
                hintContent: 'Конец маршрута',
                balloonContent: 'Конец маршрута · ' + formatTime(last.recordedAt)
            }, {
                preset: 'islands#redCircleDotIcon'
            });
            map.geoObjects.add(endMarker);

            fitToRoute();
            updateSessionInfo(session, points.length);
        } catch (e) {
            showAlert('sessionAlert', 'Ошибка загрузки: ' + e.message, 'error');
        }
    }

    function updateSessionInfo(session, pointCount) {
        document.getElementById('si-status').textContent  = formatStatus(session.status);
        document.getElementById('si-source').textContent  = formatSource(session.source);
        document.getElementById('si-started').textContent = formatTime(session.startedAt);
        document.getElementById('si-ended').textContent   = session.endedAt ? formatTime(session.endedAt) : '—';
        document.getElementById('si-points').textContent  = pointCount;
        document.getElementById('sessionInfoBlock').classList.remove('hidden');
    }

    async function loadSessionsList(vehicleId) {
        const container = document.getElementById('sessionsList');
        if (!container) return;
        try {
            const sessions = await apiGet('/api/sessions?vehicleId=' + vehicleId);
            if (!sessions || sessions.length === 0) {
                container.innerHTML = '<p class="empty-text">Нет записанных сессий</p>';
                return;
            }
            sessions.sort((a, b) => new Date(b.startedAt) - new Date(a.startedAt));
            container.innerHTML = sessions.map(s =>
                '<div class="session-card" onclick="openSessionCard(' + s.id + ')">' +
                    '<div class="session-card-header">' +
                        '<span class="session-id-label">Сессия #' + s.id + '</span>' +
                        '<span class="badge ' + (s.status === 'ACTIVE' ? 'badge-active' : 'badge-finished') + '">' +
                            formatStatus(s.status) +
                        '</span>' +
                    '</div>' +
                    '<div class="session-meta">' + formatSource(s.source) + ' · ' + formatTime(s.startedAt) + '</div>' +
                '</div>'
            ).join('');
        } catch (e) {
            if (container) container.innerHTML = '<p class="empty-text">Не удалось загрузить</p>';
        }
    }

    function openSessionCard(sessionId) {
        document.getElementById('sessionIdInput').value = sessionId;
        loadSession(sessionId);
    }

    // ── API ───────────────────────────────────────────────────────
    async function apiPost(url, body) {
        const resp = await fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(body)
        });
        if (!resp.ok) {
            const err = await resp.json().catch(() => ({ message: resp.statusText }));
            throw new Error(err.message || 'HTTP ' + resp.status);
        }
        return resp.json();
    }

    async function apiGet(url) {
        const resp = await fetch(url);
        if (!resp.ok) throw new Error('HTTP ' + resp.status);
        return resp.json();
    }

    async function sendTelemetry(vehicleId, lat, lon, speedKmh, source, sessionId) {
        return apiPost('/api/telemetry', {
            vehicleId, latitude: lat, longitude: lon,
            speedKmh, source, sessionId,
            recordedAt: new Date().toISOString()
        });
    }

    // ── STATUS / ALERT HELPERS ────────────────────────────────────
    function setStatus(text, type) {
        document.getElementById('statusText').textContent = text;
        const dot = document.getElementById('statusDot');
        dot.className = 'status-dot' + (type ? ' ' + type : '');
    }

    function showAlert(id, msg, type) {
        const el = document.getElementById(id);
        el.className = 'alert show alert-' + type;
        el.textContent = msg;
    }

    function clearAlert(id) {
        const el = document.getElementById(id);
        el.className = 'alert';
        el.textContent = '';
    }

    // ── FORMAT HELPERS ────────────────────────────────────────────
    function formatTime(iso) {
        if (!iso) return '—';
        return new Date(iso).toLocaleString('ru-RU', {
            day: '2-digit', month: '2-digit', year: '2-digit',
            hour: '2-digit', minute: '2-digit'
        });
    }

    function formatStatus(s) {
        return s === 'ACTIVE' ? 'Активна' : s === 'FINISHED' ? 'Завершена' : s;
    }

    function formatSource(s) {
        return s === 'BROWSER' ? '📡 Браузер' : s === 'SIMULATOR' ? '🤖 Симулятор' : s === 'TRACKER_API' ? '📟 Трекер' : s;
    }
</script>
</body>
</html>
