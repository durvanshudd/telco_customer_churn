SELECT
    COUNT(*) AS churned_high_risk_customers,
    ROUND(SUM(MonthlyCharges), 2) AS monthly_revenue_at_risk,
	ROUND(AVG(MonthlyCharges), 2) AS average_monthly_revenue_at_risk
FROM telco_customer_churn
WHERE contract = 'Month-to-month'
  AND tenure <= 12
  AND internetservice = 'Fiber optic'
  AND churn = 'Yes';