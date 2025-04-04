SELECT 
    CAST(CID AS NVARCHAR(50)) AS CID,
	CAST(CNTRY AS NVARCHAR(50)) AS CNTRY

FROM {{ source('dev_crm_erp_database', 'raw_erp_loc_a101') }} 