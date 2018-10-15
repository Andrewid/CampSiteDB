

select * from campgrounds;
select * from campsites;
select * from reservations;
--select * from addresses;
--select * from users;
--select * from amenity;
--select * from campground_amenity;
--select * from campsite_amenity;



-- Write a query that shows the revenue generated by each campground, broken out by month for June, July, August, and September.



SELECT 
	CampgroundName, 
	JUNE,
	JULY,
	AUGUST,
	SEPTEMBER,
	OCTOBER

FROM
	(
		
		SELECT 
			CampgroundName,
			MONTH,
			SUM(Invoice_Total) AS MONTHLY_TOTAL
		FROM
		(

		
			SELECT 
				CG.CampgroundName,
				--CheckIn_Date,
				--CheckOut_Date,
				CASE 
					WHEN MONTH(CheckIn_Date) = 6 THEN 'JUNE'
					WHEN MONTH(CheckIn_Date) = 7 THEN 'JULY'
					WHEN MONTH(CheckIn_Date) = 8 THEN 'AUGUST'
					WHEN MONTH(CheckIn_Date) = 9 THEN 'SEPTEMBER'
					WHEN MONTH(CheckIn_Date) = 10 THEN 'OCTOBER'
				END AS MONTH,
				Invoice_Total
			FROM
				CampGrounds CG
				INNER JOIN CampSites CS ON CG.CampgroundID = CS.CampgroundID
				INNER JOIN Reservations RES ON CS.CampSiteID = RES.CampsiteID
			) AS REVENUE_BY_MONTH
		GROUP BY CampgroundName, MONTH
	
	) AS Revenue_Table

PIVOT
	(

		SUM(MONTHLY_TOTAL)
		FOR MONTH
		IN (JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER)

	) AS Revenue_Pivot