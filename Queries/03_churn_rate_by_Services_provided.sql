SELECT
*
FROM (
	SELECT
	    'Online Security' AS service,
	    COUNT(CASE WHEN OnlineSecurity = 'Yes' THEN 1 END) AS customer_count,
		COUNT(CASE WHEN OnlineSecurity = 'Yes' AND churn = 'Yes' THEN 1 END) AS churned_customers,
	    ROUND(100.0 * COUNT(CASE WHEN OnlineSecurity = 'Yes' AND churn = 'Yes' THEN 1 END)/ COUNT(CASE WHEN OnlineSecurity = 'Yes' THEN 1 END)) AS churn_rate,
		SUM(monthlycharges) AS total_monthly_revenue,
        SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END) AS monthly_revenue_at_risk
	FROM telco_customer_churn
	
	UNION ALL
	
	SELECT
	    'Online Backup',
	    COUNT(CASE WHEN onlinebackup = 'Yes' THEN 1 END),
		COUNT(CASE WHEN onlinebackup = 'Yes' AND churn = 'Yes' THEN 1 END),
	    ROUND(100.0 * COUNT(CASE WHEN Onlinebackup = 'Yes' AND churn = 'Yes' THEN 1 END)/  COUNT(CASE WHEN OnlineBackup = 'Yes' THEN 1 END)),
		SUM(monthlycharges) AS total_monthly_revenue,
        SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END) AS monthly_revenue_at_risk
	FROM telco_customer_churn
	
	UNION ALL
	
	SELECT
	    'Device Protection',
	    COUNT(CASE WHEN deviceprotection = 'Yes' THEN 1 END),
		COUNT(CASE WHEN deviceprotection = 'Yes' AND churn = 'Yes' THEN 1 END),
	    ROUND(100.0 * COUNT(CASE WHEN deviceprotection = 'Yes' AND churn = 'Yes' THEN 1 END)/  COUNT(CASE WHEN deviceprotection = 'Yes' THEN 1 END)), 
		SUM(monthlycharges) AS total_monthly_revenue,
        SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END) AS monthly_revenue_at_risk
	FROM telco_customer_churn
	
	UNION ALL
	
	SELECT
	    'Tech Support',
	    COUNT(CASE WHEN techsupport = 'Yes' THEN 1 END),
		COUNT(CASE WHEN techsupport = 'Yes' AND churn = 'Yes' THEN 1 END),
	    ROUND(100.0 * COUNT(CASE WHEN techsupport = 'Yes' AND churn = 'Yes' THEN 1 END)/  COUNT(CASE WHEN techsupport = 'Yes' THEN 1 END)),
		SUM(monthlycharges) AS total_monthly_revenue,
        SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END) AS monthly_revenue_at_risk
	FROM telco_customer_churn
	
	UNION ALL
	
	SELECT
	    'Streaming TV',
	    COUNT(CASE WHEN streamingtv = 'Yes' THEN 1 END),
		COUNT(CASE WHEN Streamingtv = 'Yes' AND churn = 'Yes' THEN 1 END),
	    ROUND(100.0 * COUNT(CASE WHEN streamingtv = 'Yes' AND churn = 'Yes' THEN 1 END)/  COUNT(CASE WHEN Streamingtv = 'Yes' THEN 1 END)),
		SUM(monthlycharges) AS total_monthly_revenue,
        SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END) AS monthly_revenue_at_risk
	FROM telco_customer_churn
	
	UNION ALL
	
	SELECT
	    'Streaming Movies',
	    COUNT(CASE WHEN streamingmovies = 'Yes' THEN 1 END),
		COUNT(CASE WHEN Streamingmovies = 'Yes' AND churn = 'Yes' THEN 1 END),
	    ROUND(100.0 * COUNT(CASE WHEN streamingmovies = 'Yes' AND churn = 'Yes' THEN 1 END)/  COUNT(CASE WHEN streamingmovies = 'Yes' THEN 1 END)),
		SUM(monthlycharges) AS total_monthly_revenue,
        SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END) AS monthly_revenue_at_risk
	FROM telco_customer_churn
)	
ORDER BY churn_rate DESC
	
	
