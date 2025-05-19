-- This question aims to extract customers with at least one funded savings plan and one funded investment plan

-- Select output columns
SELECT 
    user.id AS owner_id, 

    CONCAT(user.first_name, ' ', user.last_name) AS name, 

    COUNT(DISTINCT(savings.id)) AS savings_count,  

    COUNT(DISTINCT(plan.id)) AS investment_count,  

    ROUND(SUM(COALESCE(savings.confirmed_amount, 0) + COALESCE(plan.amount, 0)) / 100, 2) AS total_deposits
    -- Total deposits from both confirmed savings and investment plans, converted from kobo to Naira
    --  and rounded to 2 decimal places

FROM users_customuser user 

-- Next, perform a merge with savings accounts where the user has made confirmed deposits
LEFT JOIN savings_savingsaccount savings 
    ON user.id = savings.owner_id AND savings.confirmed_amount > 0

-- Join with investment plans (where is_a_fund = 1)
LEFT JOIN plans_plan plan 
    ON user.id = plan.owner_id AND plan.is_a_fund = 1 AND plan.amount > 0

GROUP BY owner_id, name  

-- Only include users who have both savings and investment plans
HAVING savings_count > 0 AND investment_count > 0  

ORDER BY total_deposits  
