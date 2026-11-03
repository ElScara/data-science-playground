# Air Cargo Flight Operations Database Analysis

A comprehensive relational database analysis and backend implementation in MySQL for an air cargo and passenger transportation network. This project focuses on database schema design, revenue and customer querying, database administration, index optimization, analytical aggregation, and procedural programming using stored procedures, stored functions, views, and cursors.

---

## 📁 Repository Contents

* [`AirCargo_SourceCode.sql`](AirCargo_SourceCode.sql): Complete MySQL script containing table definition, DDL constraints, DQL queries, DBA user creation, indexing with query execution plans, views, stored procedures, functions, and cursor workflows.
* [`AirCargo_SourceCode.txt`](AirCargo_SourceCode.txt): Plain-text reference copy of the SQL queries and procedural routines.
* [`AirCargo_Analyis_brief.pdf`](AirCargo_Analyis_brief.pdf): Project scope, business problem statement, database requirements, and query objectives.
* [`Flight_Operations_Database_Analysis.pdf`](Flight_Operations_Database_Analysis.pdf): Formal project report detailing the database schema, business query solutions, query execution outputs, and performance evaluations.

---

## 🎯 Analytical & Technical Objectives

* **Schema Definition & Integrity:** Create and enforce constraints (`UNIQUE`, `NOT NULL`, `CHECK`) on flight and route tables.
* **Customer & Revenue Extraction:** Query registered passengers across routes, compute revenue generated per travel class (e.g., Business class), and extract brand-specific customer segments (e.g., Emirates).
* **Security & Administration:** Provision dedicated DBA users (`new_dba_user`) with defined host access and scoped privileges on `aircargo_db`.
* **Performance Tuning:** Implement B-tree indexes (`idx_route_id`) on high-traffic transactional tables (`passengers_on_flights`) and analyze access paths via `EXPLAIN`.
* **Advanced Aggregations & Window Functions:** Compute class-level maximum price partitions (`MAX() OVER(PARTITION BY ...)`) and hierarchical sales subtotals across aircraft using `GROUP BY ... WITH ROLLUP`.
* **Procedural Programming:**
  * **Views:** Build abstraction layers (`business_class_view`) for passenger booking profiles.
  * **Stored Procedures:** Dynamic route-range extraction with schema validation (`SIGNAL SQLSTATE`), distance-based route filtering (`> 2000` miles), and categorical distance tagging (`SDT`, `IDT`, `LDT`).
  * **Stored Functions:** Custom business logic (`CheckComplimentary`) evaluating entitlement to complimentary flight services based on ticket class.
  * **Cursors:** Cursor-driven iterative retrieval (`scott_cursor`) with standard `NOT FOUND` exception handlers.

---

## 🛠️ Tools & Technologies

* **Database Engine:** MySQL
* **Language:** SQL / MySQL Procedural Dialect
* **Core Concepts:** DDL, DML, DQL, DCL, Indexing, Window Functions, Views, Stored Procedures, User-Defined Functions, Cursors

---

## 🔬 Database Operations & Query Breakdown

All operations implemented in [`AirCargo_SourceCode.sql`](AirCargo_SourceCode.sql) cover:

1. **Table Creation & Data Constraints:**
   * Designed `route_details` enforcing positive distance checks (`distance_miles > 0`) and valid flight number identifiers.
2. **Business Reporting Queries:**
   * Passenger volume and gross revenue calculation for Business class bookings.
   * Multi-table inner joins between `customer` and `ticket_details` to isolate active ticketed flyers.
   * Conditional threshold status tagging (`IF(Total_Revenue > 10000, ...)`) on aggregate sales.
3. **Database Administration & Index Optimization:**
   * Role and user provisioning: `CREATE USER 'new_dba_user'@'localhost'` with full database privileges.
   * Index creation on `passengers_on_flights(route_id)` with `EXPLAIN` query plan inspection to verify index lookups.
4. **Analytical Window Functions & Grouping Sets:**
   * Partitioned window functions evaluating maximum ticket price per cabin class without collapsing record granularity.
   * Multi-level rollup aggregation (`WITH ROLLUP`) summarizing customer spend per aircraft.
5. **Stored Routines & Logic:**
   * `GetPassengersByRoute`: Stored procedure checking table existence in `information_schema` and throwing user-friendly custom error codes if missing.
   * `GroupFlightDistances`: Implements `CASE` logic categorizing distances into Short Distance Travel (`SDT`), Intermediate (`IDT`), and Long Distance (`LDT`).
   * `CheckComplimentary` & `GetComplimentaryDetails`: Deterministic function and procedure pairing to flag complimentary amenities for Business and Economy Plus passengers.
   * `GetCustomerScott`: Demonstrates procedural cursor mechanics (`DECLARE ... CURSOR`, `FETCH`, `CONTINUE HANDLER`) targeting specific customer name patterns.

---

## 🚀 Execution Guide

1. Clone this repository or open [`AirCargo_SourceCode.sql`](AirCargo_SourceCode.sql).
2. Connect to your MySQL server (via MySQL Workbench, CLI, or preferred client).
3. Ensure the base schema and underlying tables (`customer`, `routes`, `passengers_on_flights`, `ticket_details`) are selected or active:
   ```sql
   USE aircargo_db;
