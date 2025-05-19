# DataAnalytics-Assessment

## Assessment overview

This assessment entails using an SQL-based approach to analyse customer and transaction data. The following aims and tasks were successfully achieved:

### Assessment_Q1
<b>To identify high-value customers who have both savings and investment plans.</b>
This was done by writing a query which: 
- Selected customer details; concatenating the user's first name and last name.
- Performed left joins to include customers' savings accounts with confirmed deposits and funded investment plans.
- Counted savings accounts and investment plans per user.
- Calculated total deposits(<b>savings plus investment</b>).
- Filtered customers that have both savings and investment plans.
- Ordered the result by total deposit.

<b>Challenges encountered: </b>
- Handling the  NULL values in plans - The use of COALESCE helped contain NULL values interference.

### Assessment_Q2
<b>To calculate the average number of transactions per customer per month and categorize them</b>.
This was done by writing a query which:
- Calculated each customer’s account tenure by using the difference between the current date and their signup date.
- Computed the total number of transactions per customer.
- Computed the average monthly transactions.
- Categorized customers based on their average monthly transactions into <b>Low</b>, <b>Medium</b>, <b>High</b> frequency groups.
- Joined customer details to present names and other relevant information.

<i>Made use of CTEs, which help split and organise overrall steps</i>.

<b>Challenges encountered: </b>
- Managing organisation - The use of Common Table Expressions helped provide clarity to the steps I needed to take.


### Assessment_Q3
<b>To find all active accounts (savings or investments) with no transactions in the last year</b>.
This was done by writing a query which:
- Checked both deposit transactions and withdrawals to identify the most recent transaction dates.
- Merged deposit and withdrawal dates to find the absolute last transaction date.
- Filtered accounts to include only active savings or investment plans.
- Calculated duration of inactivity by comparing the last transaction date to the current date.
- Selected accounts where the last transaction was more than 365 days ago to flag as inactive.
- Ordered the results by inactivity duration.

<b>Challenges encountered: </b>
- Managing organisation - The use of Common Table Expressions helped provide clarity to the steps I needed to take.

### Assessment_Q4
<b>To estimate the customer lifetime value for each customer calculate the average number of transactions per customer per month and categorize them</b>.
This was done by writing a query which:
- Calculated each customer’s account tenure based on their signup date.
- Calculated total transactions and total transaction values per customer.
- Computed the average profit per transaction, assuming 0.1% profit on transaction value.
- Estimated the yearly Customer Lifetime Value(CLV) using the formula:
                    <b>CLV = (total_transactions / tenure_months) × 12 × avg_profit_per_transaction</b>
- Handled cases with zero tenure or transactions to avoid division errors.
- Sorted customers by estimated CLV.

<b>Challenges encountered: </b>
- Managing organisation - The use of Common Table Expressions helped provide clarity to the steps I needed to take.

## Conclusion
This assessment prioritised the need to analyze customer and transaction data through carefully structured queries. Through techniques such as Common Table Expressions, aggregation, and an intercept to edge cases like NULL values and division by zero, high-value customers with both savings and investment plans were identified, as well as inactive accounts. Based on these insights, a more targeted strategy should be adopted and prioritized towards market and resource acquisition.
