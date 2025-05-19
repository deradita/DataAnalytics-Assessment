-- This question aims to categorize the average monthly transactions per customer into high, medium or low frequency

-- First we calculate transaction metrics per customer: 


WITH per_customer_transact AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        TIMESTAMPDIFF(MONTH, MIN(transaction_date), MAX(transaction_date)) + 1 AS tenure_months,
    -- In the above, 1 month is added to avoid division by zero for transations of the same-month
        COUNT(*) / (TIMESTAMPDIFF(MONTH, MIN(transaction_date), MAX(transaction_date)) + 1) AS avg_transactions_per_month
    FROM savings_savingsaccount
    GROUP BY owner_id
),

-- Next, we categorize customers by their average monthly transaction frequency:

/*      High Frequency - 10 or more transactions per month
		Medium Frequency - 3 to 9 transactions per month
		Low Frequency - less than 3 transactions per month
*/

categorized_customers AS (
    SELECT 
        owner_id,
        total_transactions,
        tenure_months,
        avg_transactions_per_month,
        CASE 
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM per_customer_transact
)

-- Finally, we compound results by frequency categories above:

SELECT 
    frequency_category,
    COUNT(owner_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month
FROM categorized_customers
GROUP BY frequency_category
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        WHEN frequency_category = 'Low Frequency' THEN 3
    END;
