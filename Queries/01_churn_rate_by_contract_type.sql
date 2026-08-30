SELECT 
	contract,
	COUNT(*) AS total_customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),1) AS churn_rate,
	SUM(monthlycharges) AS total_monthly_revenue,
	SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END) AS monthly_revenue_at_risk
FROM telco_customer_churn
GROUP BY Contract
ORDER BY churn_rate DESC