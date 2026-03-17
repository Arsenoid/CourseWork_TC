# Информационно-справочная система для управления транспортной компанией

![Java](https://img.shields.io/badge/Java-21-orange?style=flat-square)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-brightgreen?style=flat-square)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat-square)
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
| **База данных** | MySQL 8.0 |
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
- MySQL 8.0
- Git

### Пошаговая инструкция

**1. Клонирование репозитория**
```bash
git clone https://github.com/Arsenoid/CourseWork_TC.git
cd CourseWork_TC
```

**2. Настройка базы данных**

```sql
CREATE DATABASE transport_company_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```
**3. Настройка подключения к БД**

Открой файл `src/main/resources/application.yaml` и укажи свои данные:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/transport_company_db
    username: root
    password: your_password
    driver-class-name: com.mysql.cj.jdbc.Driver
  jpa:
    hibernate:
      ddl-auto: update
    database: mysql
    database-platform: org.hibernate.dialect.MySQLDialect
    show-sql: false
    properties:
      hibernate:
        format_sql: true
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
- Убедись, что MySQL сервер запущен перед запуском приложения
- База данных `transport_company_db` должна быть создана заранее
- При первом запуске таблицы создадутся автоматически (`ddl-auto: update`)
