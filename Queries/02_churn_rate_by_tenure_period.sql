SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        WHEN tenure <= 60 THEN '48-60 months'
		WHEN tenure <= 72 THEN '60-72 months'
    END AS tenure_bucket,
    COUNT(*) AS total_customers,
	COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_rate,
	SUM(monthlycharges) AS total_monthly_revenue,
SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END) AS monthly_revenue_at_risk
FROM telco_customer_churn
GROUP BY tenure_bucket
ORDER BY MIN(tenure);