# 🛒 Investigating Retail Sales: A SQL Data Cleaning Project

![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)

## 🧐 The Challenge
We often hear that "80% of a Data Analyst's job is cleaning data." I wanted to put that to the test. 

Instead of grabbing a perfect, clean dataset, I purposely chose a **"dirty" retail dataset** full of duplicates, missing values, and logic errors. My goal wasn't just to make charts, but to build a robust SQL cleaning pipeline that could save this data from being thrown away.

## 🕵️‍♂️ The "Detective Work" (Data Cleaning)
Before answering any business questions, I had to fix the foundation. Here is how I tackled the mess:

1.  **Recovering "Lost" Data (My Favorite Part):**
    I found rows where the `Item Name` was missing (NULL), but the `Price` was there. Instead of deleting these rows, I wrote a **Self-Join** query. It looked for *other* transactions with the same price and category to "fill in the blanks" for the missing names. This saved roughly **268+** rows of data!
    
2.  **The Duplicate Trap:**
    Simple `DISTINCT` commands weren't enough. I used aggregation logic to identify transaction IDs that appeared twice and removed the erroneous duplicates while keeping the valid data.

3.  **Logic Checks:**
    I found transactions where `Price * Qty` didn't equal the `Total`. I recalculated these columns to ensure financial accuracy.

## 📊 What I Found (The Insights)
Once the data was clean, I ran the numbers.
* **Top Performer:** The **BUTCHERS** category is our biggest revenue driver.
* **Growth Trends:** Using Window Functions (Running Totals), I tracked how sales accumulated over the month, noticing a clear spike during **[Period]**.

## 🛠️ Tech Stack
* **Database:** MySQL
* **Key Skills:** Window Functions, Self-Joins (for imputation), CTEs, Data Modeling.

---
*Feel free to check out `cleaning_queries.sql` to see exactly how I fixed the NULL values!*
