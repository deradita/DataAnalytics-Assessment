-- This question aims to estimate the Customer Life Value of each customer using the formula:

/* CLV = (total_transactions / tenure_months) × 12 × avg_profit_per_transaction
        
        - total_transactions = number of deposit transactions by the customer
        - tenure_months = length of time(in months) of being a customer
        - avg_profit_per_transaction = 0.1% (0.001) of the average transaction value

*/

-- Firstly: Calculate account tenure in months since sign up
WITH useracc_tenure AS (
  SELECT
    id AS customer_id,
    CONCAT(first_name, ' ', last_name) as name,
    TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
  FROM users_customuser 
),

-- Secondly: Count total transactions and total value per customer
transaction_summary AS (
  SELECT
    owner_id,
    COUNT(*) AS total_transactions,
    SUM(confirmed_amount) AS total_value
  FROM savings_savingsaccount
  GROUP BY owner_id
),


-- proceed to obtain estimated clv
clv_estimate AS (
  SELECT
    ut.customer_id,
    ut.name,
    ut.tenure_months,
    ts.total_transactions,
    -- Compute clv
    ROUND(
      (CAST(ts.total_transactions AS DECIMAL(10,2)) / NULLIF(ut.tenure_months, 0)) * 12 *
      (CAST((ts.total_value * 0.001) AS DECIMAL(10,2)) / NULLIF(ts.total_transactions, 0)),
      2 
    ) AS estimated_clv

-- Match up/ Join customer tenure to their transactions
  FROM useracc_tenure ut
  JOIN transaction_summary ts ON ut.customer_id = ts.owner_id
)


SELECT *
FROM clv_estimate
ORDER BY estimated_clv DESC;
