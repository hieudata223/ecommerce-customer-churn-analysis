# E-commerce Customer Churn Analysis

## Project Overview
This project analyzes customer churn behavior in an e-commerce business using SQL, Python, and Power BI.

The objective is to identify churn patterns, segment customers, and generate business insights that support retention strategies.

## Business Questions
- Which customer groups are more likely to churn?
- How do order frequency, spending, delivery performance, and review scores relate to churn?
- Which customer segments should be prioritized for retention efforts?

## Tools Used
- **SQL** — data cleaning, transformation, and customer-level feature creation
- **Python** — exploratory data analysis and churn pattern analysis
- **Power BI** — dashboard design and interactive visualization

## Dataset
This project uses the **Olist E-commerce Dataset**, including data on:
- customers
- orders
- order items
- payments
- reviews
- delivery information

## Project Workflow

### 1. SQL Data Preparation
Built a customer-level analysis table by joining and transforming multiple e-commerce tables.

Key outputs:
- total orders
- total spent
- average order value
- average review score
- average delivery days
- recency days
- late delivery rate
- churn flag

### 2. Python Analysis
Used Python to explore churn behavior and compare churned vs active customers.

Main analysis:
- churn distribution
- customer type analysis
- churn by segment
- spending and review behavior
- feature importance exploration

### 3. Power BI Dashboard
Built an interactive dashboard to present churn insights clearly for business users.

Dashboard highlights:
- Total Customers
- Churn Customers
- Churn Rate %
- Average Order Value
- Average Review Score
- Delivery and recency analysis
- Churn by customer segment
- Churn by customer type

## Repository Structure
```bash
ecommerce-customer-churn-analysis/
│
├── DashBoard/
├── Notebook/
├── SQL/
├── Screen/
├── olist-ecommerce-dataset/
└── README.md
