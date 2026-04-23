# Информационно-справочная система для управления транспортной компанией

![Java](https://img.shields.io/badge/Java-21-orange?style=flat-square)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-brightgreen?style=flat-square)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-blue?style=flat-square)
![Spring Security](https://img.shields.io/badge/Spring%20Security-6.x-green?style=flat-square)

## 📋 Описание проекта

**Курсовая работа студента группы ПИ22-2 Финансового университета при Правительстве РФ**

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
│   └── main/
│       ├── java/com/example/coursework_tc/
│       │   ├── config/               # Конфигурационные классы (SecurityConfig)
│       │   ├── controller/            # Контроллеры (обработка запросов)
│       │   │   ├── AdminController.java
│       │   │   ├── CarrierController.java
│       │   │   ├── CustomerController.java
│       │   │   ├── RouteController.java
│       │   │   └── VehicleController.java
│       │   ├── model/                 # Сущности и перечисления
│       │   │   ├── enums/              # Role, RouteStatus, VehicleStatus
│       │   │   ├── User.java
│       │   │   ├── Route.java
│       │   │   ├── Vehicle.java
│       │   │   └── Order.java
│       │   ├── repository/             # Интерфейсы для работы с БД (JPA)
│       │   ├── service/                 # Бизнес-логика
│       │   │   ├── impl/                # Реализации сервисов
│       │   │   └── *Service.java        # Интерфейсы сервисов
│       │   └── CourseWorkTcApplication.java  # Точка входа
│       └── resources/
│           ├── templates/               # Freemarker шаблоны (.ftlh)
│           │   ├── login.ftlh
│           │   ├── registration.ftlh
│           │   ├── routes.ftlh
│           │   ├── customerPA.ftlh
│           │   ├── carrierPA.ftlh
│           │   └── ...
│           └── application.yaml          # Конфигурация приложения
├── docs/                                 # Документация и скриншоты
│   └── screenshots/                       # Изображения интерфейса
├── README.md                               # Этот файл
└── pom.xml                                  # Maven зависимости
```

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
CREATE DATABASE transport_company;
```

**3. Настройка подключения к БД через переменные окружения**

Приложение читает настройки из переменных окружения (см. `src/main/resources/application.yaml`).

Обязательные переменные для локального запуска:

```bash
export SPRING_DATASOURCE_URL="jdbc:postgresql://localhost:5432/transport_company"
export SPRING_DATASOURCE_USERNAME="root"
export SPRING_DATASOURCE_PASSWORD="root"
```

Опционально:

```bash
export SPRING_JPA_HIBERNATE_DDL_AUTO="update"   # create / validate / none
export SERVER_PORT="8080"
```

Если используешь zsh, можно сложить эти экспорты в `~/.zshrc` (или в отдельный локальный скрипт) и не коммитить их в репозиторий.

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
- База данных `transport_company` должна быть создана заранее (или используй свою и поменяй `SPRING_DATASOURCE_URL`)
- При первом запуске таблицы создадутся автоматически (`SPRING_JPA_HIBERNATE_DDL_AUTO=update`)
