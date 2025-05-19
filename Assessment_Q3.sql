-- This question aims to find all active savings or investment accounts with no form of transaction in the last 365 days



-- Firstly: Get the date of the last deposit
WITH last_transact AS (
    SELECT plan_id, MAX(transaction_date) AS last_transaction_date
    FROM savings_savingsaccount
    GROUP BY plan_id
),

-- Secondly: Get the date of the last withdrawal
last_withdrawal AS (
    SELECT plan_id, MAX(transaction_date) AS last_transaction_date
    FROM withdrawals_withdrawal
    GROUP BY plan_id
),

-- Thirdly: Merge both transactions
total_transact AS (
    SELECT
        plan.id AS plan_id,
        plan.owner_id,
        CASE
            WHEN plan.is_regular_savings = TRUE THEN 'Savings'
            WHEN plan.is_a_fund = TRUE THEN 'Investment'
            ELSE 'Other'
        END AS type,
        GREATEST(
            COALESCE(lt.last_transaction_date, '1900-01-01'),
            COALESCE(lw.last_transaction_date, '1900-01-01')
        ) AS last_transaction_date
    FROM plans_plan plan
    LEFT JOIN last_transact lt ON plan.id = lt.plan_id
    LEFT JOIN last_withdrawal lw ON plan.id = lw.plan_id
    WHERE (plan.is_regular_savings = TRUE OR plan.is_a_fund = TRUE)
      AND COALESCE(plan.is_archived, FALSE) = FALSE
      AND COALESCE(plan.is_deleted, FALSE) = FALSE
)

-- Calculate the inactive days
SELECT
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    DATEDIFF(CURDATE(), last_transaction_date) AS inactivity_days
FROM total_transact
WHERE last_transaction_date < DATE_SUB(CURDATE(), INTERVAL 365 DAY)
ORDER BY inactivity_days DESC;
