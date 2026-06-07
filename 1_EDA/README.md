# 📊 EDA Project: Data Engineer Skills Analysis  

![Image](..\Images\1_1_Project1_EDA.png)  

This project explores **job postings data** to uncover insights into the most in-demand, highest-paying, and optimal skills for **Data Engineers**, with a focus on **remote positions**.  
The analysis is structured into three SQL files, each answering a specific research question.

---
![Image](..\Images\1_2_Data_Warehouse.png) 
## 📂 Files Overview

### 1. `file1.sql` → Most In-Demand Skills
**Question:** What are the most in-demand skills for data engineers?  
- Joins job postings with skills tables.  
- Filters for **Data Engineer** roles.  
- Identifies the **top 10 skills** by demand count.  
- Focuses on **remote job postings**.  

**Why:** Reveals the most valuable skills for data engineers seeking remote work.  

**Sample Output:**
| Skill       | Demand Count |
|-------------|--------------|
| SQL         | 233,132      |
| Python      | 224,102      |
| AWS         | 130,205      |
| Azure       | 128,822      |
| Spark       | 106,904      |

---

### 2. `file2.sql` → Highest-Paying Skills
**Question:** What are the highest-paying skills for data engineers?  
- Calculates **median salary** for each skill.  
- Focuses on **remote positions** with specified salaries.  
- Includes **skill frequency** to balance salary with demand.  

**Why:** Identifies which skills command the highest compensation while also showing how common they are.  

**Sample Output:**
| Skill      | Median Salary | Frequency |
|------------|---------------|-----------|
| Rust       | $210,000      | 232       |
| Terraform  | $184,000      | 3,248     |
| Golang     | $184,000      | 912       |
| Spring     | $175,500      | 364       |
| Neo4j      | $170,000      | 277       |

---

### 3. `file3.sql` → Optimal Skills (Demand + Salary)
**Question:** What are the most optimal skills for data engineers—balancing both demand and salary?  
- Creates a **ranking column (`optimal_score`)** combining demand count and median salary.  
- Uses a **log transformation** to balance rare high-paying skills vs. widely in-demand ones.  
- Focuses on **remote Data Engineer positions** with annual salaries.  

**Why:** Highlights skills that are both **market-relevant** and **financially rewarding**.  

**Sample Output:**
| Skill      | Jobs | Median Salary | Optimal Score |
|------------|------|---------------|---------------|
| Terraform  | 193  | $184,000      | 0.97          |
| Python     | 1133 | $135,000      | 0.95          |
| SQL        | 1128 | $130,000      | 0.91          |
| AWS        | 783  | $137,320      | 0.91          |
| Airflow    | 386  | $150,000      | 0.89          |

---

## 🚀 How to Run
1. Open DuckDB and connect to your dataset:
   ```bash
   duckdb md:data_jobs
