
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    Declare @START_TIME DATETIME,@END_TIME DATETIME;
	BEGIN TRY
    PRINT '======================================';
	PRINT 'Loading Data';
	PRINT '======================================';

	PRINT '*************Loading CRM Data ******************';
	SET @START_TIME=GETDATE();
	PRINT '<< TRUNCATING DATA :bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;
	PRINT '<< INSERTING DATA into table:bronze.crm_cust_info';
	BULK INSERT bronze.crm_cust_info
	from 'C:\Users\Pooja Pore\Downloads\datawarehouse_project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	WITH(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK);
	SET @END_TIME=GETDATE();
	PRINT 'Loading Time:'+ CAST(DATEDIFF(second,@START_TIME,@END_TIME) as NVARCHAR(15));

	PRINT '<< TRUNCATING DATA :bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;
	PRINT '<< INSERTING DATA into table:bronze.crm_prd_info';
	BULK INSERT bronze.crm_prd_info
	from 'C:\Users\Pooja Pore\Downloads\datawarehouse_project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	WITH(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK);

	PRINT '<< TRUNCATING DATA :bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details;
	PRINT '<< INSERTING DATA into table:bronze.crm_sales_details';
	BULK INSERT bronze.crm_sales_details
	from 'C:\Users\Pooja Pore\Downloads\datawarehouse_project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	WITH(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK);
	PRINT '*************Loading ERP Data ******************';

	PRINT '<< TRUNCATING DATA :bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;
	PRINT '<< INSERTING DATA into table:bronze.erp_cust_az12';
	BULK INSERT bronze.erp_cust_az12
	from 'C:\Users\Pooja Pore\Downloads\datawarehouse_project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	WITH(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK);

	PRINT '<< TRUNCATING DATA :bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;
	PRINT '<< INSERTING DATA into table:bronze.erp_loc_a101';
	BULK INSERT bronze.erp_loc_a101
	from 'C:\Users\Pooja Pore\Downloads\datawarehouse_project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	WITH(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK);

	PRINT '<< TRUNCATING DATA :bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	PRINT '<< INSERTING DATA into table:bronze.erp_px_cat_g1v2';
	BULK INSERT bronze.erp_px_cat_g1v2
	from 'C:\Users\Pooja Pore\Downloads\datawarehouse_project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK);

	END TRY

	BEGIN CATCH
	PRINT '+++++++++++++++++++++++++++++++++++++++++++++++++++++++';
	PRINT 'ERROR OCCURED WHILE LOADING BRONZE LAYER';
	PRINT 'ERROR MESSAGE:'+ ERROR_MESSAGE() ;
	PRINT 'ERROR NUMBER:'+ CAST(ERROR_NUMBER() AS NVARCHAR(50));
	PRINT '+++++++++++++++++++++++++++++++++++++++++++++++++++++++';


	END CATCH


END

EXEC bronze.load_bronze;


