/*
	Usage: 
		Call from within loop that varies @correlation
		between -0.995 and 0.985 to get data for [-100%,98.5%), [-98.5%,97.5%), …., [98.5%,100%]
*/

CREATE PROCEDURE [GIRO2016].[CalculateHistogramData]
	@CorrelationValue	REAL,
	@DataPerset			SMALLINT

AS
	DECLARE @Upper REAL
	DECLARE @Lower REAL

	/*
		Want to run columns, [-100%,98.5%), [-98.5%,97.5%), …., [98.5%,100%]
	*/
	IF abs(@CorrelationValue - 0.985)<0.0001
		BEGIN
			SELECT @Upper = 1.00000001
			SELECT @Lower = @CorrelationValue
		END
	ELSE 
		BEGIN
			IF abs(@CorrelationValue - -0.995)<0.0001
				BEGIN
					SELECT @Upper = @CorrelationValue + 0.01
					SELECT @Lower = -1
				END
			ELSE
				BEGIN
					SELECT @Upper = @CorrelationValue + 0.01
					SELECT @Lower = @CorrelationValue
				END
		END

	/*
		
	*/
	DECLARE @CorrCentralBucketValue REAL
	SELECT @CorrCentralBucketValue = ROUND((@Upper + @Lower) / 2, 4)

	INSERT INTO 
		IglooData_HistogramData_Temp
	SELECT 
		@DataPerset AS DataPerSet,
		@CorrCentralBucketValue AS RankCorrValue, 
		CorrStrengthID_FK, 
		Count(CorrStrengthID_FK) AS CountCorrStrength
	FROM 
		GIRO2016.IglooData
	WHERE 
		(GIRO2016.IglooData.RankCorrValue >= @Lower AND GIRO2016.IglooData.RankCorrValue < @Upper) 
			AND
			DataPerSet=@DataPerset
	GROUP BY DataPerSet,CorrStrengthID_FK
	ORDER BY DataPerSet,CorrStrengthID_FK;

RETURN 0