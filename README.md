Project readme-


---

# 🛒 E-Commerce Product Data Engineering Project

**Bronze → Silver → Gold | SQL-first | Python ingestion | Lakehouse Architecture**

---

📌 Project Overview

This project simulates a real-world e-commerce product data platform using modern data engineering principles.

The goal is to design an end-to-end data pipeline that ingests raw operational and event data, refines it through structured layers, and produces business-ready analytical datasets.

The architecture follows a Lakehouse approach with clear Bronze, Silver, and Gold layers, focusing on data correctness, scalability, and product metrics rather than dashboards or UI.

🧠 Why E-Commerce Domain?

E-commerce is one of the most data-intensive product domains and is widely used by product companies to evaluate data engineering skills.

This domain helps demonstrate:

Event-driven data modeling

High-volume transactional processing

Incremental & late-arriving data handling

Revenue vs intent modeling

Product-level metrics (funnels, AOV, retention)

This project complements enterprise domains (like Insurance) by showcasing product-scale data thinking.

🧩 Core Business Concepts
Concept	Description
Users	Customers interacting with the platform
Products	Items sold, with changing prices & categories
Orders	Transactions with lifecycle state changes
Payments	Actual money flow, refunds, failures
Events	User behavior (views, carts, checkout)

Key principle: Orders ≠ Revenue
Revenue is derived only from successful payments.

🏗 Architecture Overview
Raw Sources → Bronze (Raw) → Silver (Cleaned) → Gold (Business)

Technology Scope

Python – ingestion & validation

SQL – transformations & modeling

PostgreSQL / SQLite – warehouse simulation

AWS S3 (optional) – cloud storage (intro level)

🟤 Bronze Layer – Raw Data Foundation
Purpose

The Bronze layer preserves raw, immutable source data exactly as it arrives from operational systems.

No business logic or transformations are applied at this stage.

Bronze = Truth Preservation

🔌 Source Systems Simulated

Transactional DB – Orders & Payments

Master Data – Users & Products

Event Stream – User behavioral events

These represent typical systems found in real product companies.

---

## 📁 Bronze Storage Structure

```
data/
 └── bronze/
     ├── users/
     ├── products/
     ├── orders/
     ├── order_items/
     ├── payments/
     └── events/
```

---

## 🧾 Bronze Table Schemas

---

### 🟤 `users_raw`

Stores raw user profile data from the application database.

| Column Name    | Description                                   |
| -------------- | --------------------------------------------- |
| user_id        | Unique identifier assigned by the application |
| name           | User full name                                |
| email          | User email address (may be duplicated)        |
| phone          | Phone number (optional)                       |
| created_at     | User signup timestamp                         |
| updated_at     | Last profile update timestamp                 |
| source_system  | Originating system (e.g., app_db)             |
| ingestion_time | Timestamp when data was ingested              |

**Data reality**

* Same email may appear for multiple users
* Users update profiles
* Many users never place orders

---

### 🟤 `products_raw`

Stores raw product catalog data.

| Column Name     | Description                     |
| --------------- | ------------------------------- |
| product_id      | Unique product / SKU identifier |
| product_name    | Product display name            |
| category        | Product category                |
| price           | Current product price           |
| available_stock | Available inventory count       |
| updated_at      | Last catalog update timestamp   |
| source_system   | Catalog service                 |
| ingestion_time  | Ingestion timestamp             |

**Data reality**

* Prices change frequently
* Category corrections happen late
* Historical prices must not be overwritten

---

### 🟤 `orders_raw`

Stores raw order lifecycle data.

| Column Name    | Description                          |
| -------------- | ------------------------------------ |
| order_id       | Unique order identifier              |
| user_id        | Customer who placed the order        |
| order_status   | CREATED / PAID / SHIPPED / CANCELLED |
| order_amount   | Total order value at creation time   |
| order_ts       | Order creation timestamp             |
| updated_at     | Timestamp of status change           |
| source_system  | Order service                        |
| ingestion_time | Ingestion timestamp                  |

**Data reality**

* Same order_id appears multiple times
* Orders change status over time
* Orders can be cancelled after payment

---

### 🟤 `order_items_raw`

Stores line-item level order data.

| Column Name    | Description                      |
| -------------- | -------------------------------- |
| order_item_id  | Unique identifier for order item |
| order_id       | Parent order identifier          |
| product_id     | Purchased product identifier     |
| quantity       | Number of units                  |
| item_price     | Product price at purchase time   |
| source_system  | Order service                    |
| ingestion_time | Ingestion timestamp              |

**Data reality**

* One order can have multiple items
* Item price ≠ current product price

---

### 🟤 `payments_raw`

Stores raw payment transaction data.

| Column Name    | Description                           |
| -------------- | ------------------------------------- |
| payment_id     | Unique payment transaction identifier |
| order_id       | Associated order                      |
| payment_status | SUCCESS / FAILED / REFUNDED           |
| payment_amount | Amount paid or refunded               |
| payment_ts     | Payment transaction timestamp         |
| source_system  | Payment gateway                       |
| ingestion_time | Ingestion timestamp                   |

**Data reality**

* Failed payments exist
* Refunds may occur days later
* Revenue derived only from successful payments

---

### 🟤 `events_raw`

Stores raw user interaction events.

| Column Name    | Description                    |
| -------------- | ------------------------------ |
| event_id       | Unique event identifier        |
| user_id        | User identifier (nullable)     |
| session_id     | Browser/app session identifier |
| event_type     | view / add_to_cart / checkout  |
| event_ts       | Event timestamp (client-side)  |
| device_type    | web / mobile                   |
| source_system  | Tracking SDK                   |
| ingestion_time | Server ingestion timestamp     |

**Data reality**

* Events arrive late
* Duplicate events possible
* Event time ≠ ingestion time
* Some events have no user_id

---

## 📏 Bronze Layer Design Rules

* No deduplication
* No joins
* No business transformations
* Raw data is immutable

Allowed operations:

* Schema parsing
* Metadata enrichment (`ingestion_time`, `source_system`)

---

## 🧠 Key Business Rules Defined Early

1. **Orders ≠ Revenue**
   Revenue is derived only from successful payments.

2. **Latest order status wins**
   Orders are mutable and state-driven.

3. **Events are unreliable but valuable**
   Used for funnel analysis, not financial metrics.

4. **Historical accuracy is mandatory**
   Past orders must not be recalculated using current prices.

---

## 🎯 What This Demonstrates

* Real-world product data complexity
* Correct handling of raw data
* Foundation for scalable transformations
* Product-company–style thinking

---

## 🚀 Next Phase

➡ **Silver Layer**

* Deduplication
* Incremental logic
* Data quality checks
* SCD handling

---

