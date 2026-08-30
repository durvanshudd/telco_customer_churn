SELECT
	charge_category,
    COUNT(*) AS total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),1) AS churn_rate,
	SUM(monthlycharges) AS total_monthly_revenue,
	SUM(CASE WHEN churn = 'Yes' THEN monthlycharges ELSE 0 END) AS monthly_revenue_at_risk
FROM( 
	SELECT
		tenure,
		monthlycharges,
		(tenure*monthlycharges) AS expected_total_charges,
		totalcharges,
		churn,
		CASE
			WHEN totalcharges < (tenure*monthlycharges) THEN 'Discounted'
			WHEN totalcharges = (tenure*monthlycharges) THEN 'Regular Charges'
			WHEN totalcharges > (tenure*monthlycharges) THEN 'Additional Charges'
		END AS charge_category
	FROM telco_customer_churn
)
GROUP BY charge_category
ORDER BY churn_rate DESC