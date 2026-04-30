# Информационно-справочная система для управления транспортной компанией

![Java](https://img.shields.io/badge/Java-21-orange?style=flat-square)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-brightgreen?style=flat-square)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-blue?style=flat-square)
![Spring Security](https://img.shields.io/badge/Spring%20Security-6.x-green?style=flat-square)

## 📋 Описание проекта

**Дипломная работа студента группы ПИ22-2 Финансового университета при Правительстве РФ**

Данный проект представляет собой клиент-серверное веб-приложение для автоматизации работы транспортной компании. Система разработана с использованием современного стека технологий Java и Spring, включает разграничение прав доступа для двух типов пользователей: менеджеров и водителей.

**Основная цель** — оптимизация процессов планирования маршрутов, учета транспортных средств и контроля выполнения заказов.

---

## ✨ Функциональные возможности

### Для менеджеров компании
- Создание, редактирование и удаление маршрутов
- Назначение водителей на маршруты
- Просмотр статусов всех заказов в реальном времени
- Управление заказами (отслеживание выполнения)

### Для водителей
- Добавление и управление собственным автопарком
- Просмотр доступных маршрутов
- Принятие маршрутов к исполнению
- Обновление статуса выполняемых заказов
- Отслеживание истории своих заказов

### Общий функционал
- Регистрация и авторизация пользователей
- Разграничение прав доступа на основе ролей
- Безопасное хранение данных
- Интуитивно понятный веб-интерфейс

---

## 🛠 Технологический стек

| Компонент | Технология |
|-----------|------------|
| **Язык программирования** | Java 21 |
| **Фреймворк** | Spring Boot 3.x |
| **Веб-слой** | Spring MVC |
| **Доступ к данным** | Spring Data JPA, Hibernate |
| **Безопасность** | Spring Security, BCrypt, CSRF-защита |
| **База данных** | PostgreSQL 14+ |
| **Шаблонизатор** | Freemarker |
| **Сборка** | Maven |
| **Версионирование** | Git |

---

## 📁 Структура проекта
```
CourseWork_TC/
├── src/
│   ├── main/
│   │   ├── java/com/example/coursework_tc/
│   │   │   ├── config/                 # Spring: безопасность и прочая конфигурация
│   │   │   ├── controller/           # MVC и REST: страницы, API телеметрии и сессий
│   │   │   ├── dto/                    # Объекты запросов/ответов для API
│   │   │   │   ├── api/                # Общие ответы об ошибках и т.п.
│   │   │   │   ├── session/          # DTO сессий трекинга
│   │   │   │   └── telemetry/        # DTO точек телеметрии
│   │   │   ├── exception/              # Исключения предметной области и валидации
│   │   │   ├── model/                  # JPA-сущности
│   │   │   │   └── enums/              # Перечисления (роли, статусы и др.)
│   │   │   ├── repository/           # Spring Data JPA
│   │   │   ├── service/                # Интерфейсы сервисов
│   │   │   │   └── impl/               # Реализации бизнес-логики
│   │   └── resources/
│   │       ├── css/                    # Стили веб-интерфейса
│   │       ├── db/migration/           # Flyway: версии схемы БД
│   │       ├── static/                 # Статика (изображения и др.)
│   │       └── templates/              # Freemarker-шаблоны страниц
│   └── test/
│       └── java/com/example/coursework_tc/  # Автотесты (в т.ч. controller)
├── .mvn/                               # Обертка Maven (wrapper)
├── README.md                           # Описание проекта
├── pom.xml                             # Зависимости и сборка Maven
├── mvnw                                # Запуск Maven wrapper (Unix/macOS)
└── mvnw.cmd                            # Запуск Maven wrapper (Windows)
```

Главный класс Spring Boot лежит в корне пакета `coursework_tc` рядом с перечисленными пакетами. Файлы конфигурации (`application.yaml` и др.) — в `src/main/resources/` на верхнем уровне этой папки.

---

## 🚀 Запуск проекта локально

### Предварительные требования
- JDK 21 или выше
- Maven 3.8+
- PostgreSQL 14+
- Git

### Пошаговая инструкция

**1. Клонирование репозитория**
```bash
git clone https://github.com/Arsenoid/CourseWork_TC.git
cd CourseWork_TC
```

**2. Настройка базы данных**

```sql
CREATE DATABASE transport_company_db;
```

**3. Настройка подключения к БД через переменные окружения**

Приложение читает настройки из переменных окружения (см. `src/main/resources/application.yaml`).

Обязательные переменные для локального запуска:

```bash
export SPRING_DATASOURCE_URL="jdbc:postgresql://localhost:5432/transport_company_db"
export SPRING_DATASOURCE_USERNAME="root"
export SPRING_DATASOURCE_PASSWORD="root"
```

**4. Сборка проекта**

```bash
mvn clean package
```

**5. Запуск приложения**

```bash
java -jar target/CourseWorkTcApplication.jar
```

Или через Maven:

```bash
mvn spring-boot:run
```

**6. Доступ к приложению**

Открой браузер и перейди по адресу:
```
http://localhost:8080
```

### Важно!
- Убедись, что PostgreSQL запущен перед стартом приложения
- База данных `transport_company_db` должна быть создана заранее (или используй свою и поменяй `SPRING_DATASOURCE_URL`)
- При первом запуске таблицы создадутся автоматически (`SPRING_JPA_HIBERNATE_DDL_AUTO=update`)
