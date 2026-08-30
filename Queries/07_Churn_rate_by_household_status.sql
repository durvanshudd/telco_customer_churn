SELECT
*
FROM (
	SELECT
	    'Partner' AS household_status,
	    COUNT(CASE WHEN partner = 'Yes' THEN 1 END) AS customer_count,
		COUNT(CASE WHEN partner = 'Yes' AND churn = 'Yes' THEN 1 END) AS churned_customers,
	    ROUND(100.0 * COUNT(CASE WHEN partner = 'Yes' AND churn = 'Yes' THEN 1 END)/ COUNT(CASE WHEN partner = 'Yes' THEN 1 END)) AS churn_rate,
		SUM(monthlycharges) AS total_monthly_revenue,
        SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END) AS monthly_revenue_at_risk
	FROM telco_customer_churn
	
	UNION ALL
	
	SELECT
	    'Dependents',
	    COUNT(CASE WHEN dependents = 'Yes' THEN 1 END),
		COUNT(CASE WHEN dependents = 'Yes' AND churn = 'Yes' THEN 1 END),
	    ROUND(100.0 * COUNT(CASE WHEN dependents = 'Yes' AND churn = 'Yes' THEN 1 END)/  COUNT(CASE WHEN dependents = 'Yes' THEN 1 END)),
		SUM(monthlycharges) AS total_monthly_revenue,
        SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END) AS monthly_revenue_at_risk
	FROM telco_customer_churn
)	
ORDER BY churn_rate DESC
	
	
