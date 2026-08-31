SELECT
    COUNT(*) AS high_risk_profiles,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)/ COUNT(*),1) AS churn_rate
FROM telco_customer_churn
WHERE contract = 'Month-to-month'
  AND tenure <= 12
  AND internetservice = 'Fiber optic'
;