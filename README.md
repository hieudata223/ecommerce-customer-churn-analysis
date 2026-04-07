# E-commerce Customer Churn Analysis

## Project Overview
This project analyzes customer churn behavior in an e-commerce business using SQL, Python, and Power BI.

The goal is to identify churn patterns, segment customers, and generate business insights that support customer retention strategies.

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
```

## Dashboard Preview
![Dashboard Preview](./Screen/Screenshot%202026-04-07%20185949.png)

## Key Insights
- One-time buyers are more likely to churn than repeat buyers
- Customers with lower review scores tend to show higher churn rates
- Long recency is strongly associated with churn risk
- Delivery experience may influence customer retention
- Customer segmentation helps identify high-risk groups for targeted actions

## Business Recommendations
- Build retention campaigns for one-time buyers
- Re-engage inactive customers before churn risk becomes too high
- Improve delivery experience to reduce negative customer outcomes
- Use churn segmentation to prioritize high-risk customer groups

## How to Use
### SQL
Run the SQL scripts in the `SQL` folder to prepare the analysis dataset.

### Python
Open the notebook in the `Notebook` folder and run the analysis step by step.

### Power BI
Open the Power BI file in the `DashBoard` folder to explore the interactive dashboard.

## Author
**Hieu Data**  
Aspiring Data Analyst skilled in SQL, Python, and Power BI.

## GitHub
[https://github.com/hieudata223](https://github.com/hieudata223)
