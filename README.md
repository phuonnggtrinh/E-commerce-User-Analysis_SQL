# Explore-E-commerce-Dataset-SQL-
## 1. Introduction
This project is about exploring an eCommerce dataset using SQL in Google BigQuery. The dataset comes from the public Google Analytics dataset and includes information from an eCommerce website.
## 2. Requirements
- Google Cloud Platform account
- Google BigQuery API eneble
- SQL query editor or IDE
## 3. Dataset access
The e-commerce dataset is available in the public Google BigQuery dataset. Here's how to access it on Google BigQuery:
1. Log in to your Google Cloud Platform account and create a new project.
2. Go to the BigQuery dashboard and choose the project you just created.
3. In the left-hand menu, click on "Add Data" and then choose "Search Projects".
4. Type in the project ID "bigquery-public-data.google_analytics_sample.ga_sessions" and press "Enter".
5. Find and click on the "ga_sessions_" table to open the dataset.
## 4. Exploring the Dataset
Use SQL in Google BigQuery to query the Google Analytics dataset. This will help you run queries to find the information needed to answer business questions.

**Query 01: calculate total visit, pageview, and transaction for Jan, Feb and March 2017 (order by month)**

- **SQL Code**
<img width="500" alt="Screenshot 2024-10-19 at 16 38 37" src="https://github.com/user-attachments/assets/f4050a35-99a5-43a5-93a7-65aab5ee1061">

- **Result**

<img width="571" alt="Screenshot 2024-10-19 at 16 39 16" src="https://github.com/user-attachments/assets/db3d529f-23cc-4f7a-b913-04b0f27414b1">

**Query 02: Bounce rate per traffic source in July 2017**

* **SQL Code**
<img width="629" alt="Screenshot 2024-10-19 at 16 45 01" src="https://github.com/user-attachments/assets/71dca610-1edc-4811-9a39-e64184ef9946">

* **Result**
<img width="532" alt="Screenshot 2024-10-19 at 16 45 40" src="https://github.com/user-attachments/assets/0f8fefa5-8f40-4a19-95fd-a34d9f34c329">

**Query 3: Revenue by traffic source by week, by month in June 2017**

* **SQL Code**
<img width="575" alt="Screenshot 2024-10-19 at 16 51 47" src="https://github.com/user-attachments/assets/aee4c4e8-1106-4b37-8313-1bda22d3bc11">

* **Result**
<img width="721" alt="Screenshot 2024-10-19 at 16 52 07" src="https://github.com/user-attachments/assets/915397f2-3686-48bb-a366-bbc9b49ea63f">

**Query 04: Average number of product pageviews by purchaser type (purchasers vs non-purchasers) in June, July 2017**
* **SQL Code**
<img width="657" alt="Screenshot 2024-10-19 at 17 01 08" src="https://github.com/user-attachments/assets/561f6aa6-3633-451a-b134-f2871aa00780">

* **Result**
<img width="468" alt="Screenshot 2024-10-19 at 16 58 54" src="https://github.com/user-attachments/assets/d5338397-e7fc-4b21-918d-10d749a007bd">

**Query 05: Average number of transactions per user that purchased in July 2017**
* **SQL Code**
<img width="717" alt="Screenshot 2024-10-19 at 17 04 20" src="https://github.com/user-attachments/assets/2e86bdd5-42e7-4bcc-adac-eea73de5a2d2">

* **Result**
<img width="292" alt="Screenshot 2024-10-19 at 17 04 41" src="https://github.com/user-attachments/assets/5f5e1a35-199b-40f1-b287-6a7f95c31a17">

**Query 06: Average amount of money spent per session. Only include purchaser data in July 2017**
* **SQL Code**
<img width="729" alt="Screenshot 2024-10-19 at 17 06 32" src="https://github.com/user-attachments/assets/c84535e1-e2ee-43e1-928d-7bd0d9e6aafd">
* **Result**
<img width="277" alt="Screenshot 2024-10-19 at 17 05 55" src="https://github.com/user-attachments/assets/599b9057-6828-4c65-af72-9da1a7599cdf">

**Query 07: Other products purchased by customers who purchased product "YouTube Men's Vintage Henley" in July 2017. Output should show product name and the quantity was ordered.**
* **SQL Code**
<img width="550" alt="Screenshot 2024-10-19 at 17 09 00" src="https://github.com/user-attachments/assets/e62ef155-11a4-44f2-a393-3cd5edcd4eda">

* **Result**
<img width="328" alt="Screenshot 2024-10-19 at 17 09 21" src="https://github.com/user-attachments/assets/11bce3aa-06a6-458e-bbb7-626ff4137e68">

**Query 08: Calculate cohort map from product view to add to cart to purchase in Jan, Feb and March 2017.**
* **SQL Code**
<img width="953" alt="Screenshot 2024-10-19 at 17 11 54" src="https://github.com/user-attachments/assets/472dc7fb-9094-4e77-a68c-d41928ca533f">

* **Result**
<img width="825" alt="Screenshot 2024-10-19 at 17 12 21" src="https://github.com/user-attachments/assets/20aee932-08a3-4db4-b646-e58c52ebfecd">

## V. Conclusion
- In summary, my exploration of the eCommerce dataset using SQL on Google BigQuery, based on the Google Analytics data, has uncovered several useful insights. 
- By analyzing the dataset, I have gained important information about total visits, pageviews, transactions, bounce rates, and revenue by traffic source, which can guide future business decisions.
- The next step would be to visualize these insights and trends using tools like Power BI or Tableau for deeper analysis. 
- Overall, this project has shown how powerful SQL and big data tools like Google BigQuery can be in understanding large datasets.
