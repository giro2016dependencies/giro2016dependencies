Declare @DataPerSetTABLE Table (DataPerSet smallint);
Declare @ObsCorrValuesTABLE Table (CorrValue real);

Insert Into @DataPerSetTABLE
	select distinct DataPerSet
	from GIRO2016.IglooData
	where DataPerSet<=10
	order by DataPerSet;

Declare @DataPerSetCurrent smallint, @ObsCorrValueCurrent real;
	
While ((Select Count(*) From @DataPerSetTABLE)>0)
	Begin
		Set @DataPerSetCurrent=(Select Top 1 DataPerSet From @DataPerSetTABLE)

			Insert Into @ObsCorrValuesTABLE
				select distinct RankCorrValue
				from GIRO2016.IglooData
				where DataPerSet=@DataPerSetCurrent
				order by RankCorrValue;

			While ((Select Count(*) From @ObsCorrValuesTABLE)>0)
				Begin
					Set @ObsCorrValueCurrent=(Select Top 1 CorrValue From @ObsCorrValuesTABLE)

						INSERT INTO GIRO2016.IglooData_HistogramData
							SELECT 
								DataPerSet,
								RankCorrValue, 
								CorrStrengthID_FK, 
								Count(CorrStrengthID_FK) AS CountCorrStrength
							FROM 
								GIRO2016.IglooData
							WHERE 
								(DataPerSet=@DataPersetCurrent and RankCorrValue>@ObsCorrValueCurrent-0.0001 and RankCorrValue<@ObsCorrValueCurrent+0.0001)
							GROUP BY DataPerSet,RankCorrValue,CorrStrengthID_FK
							ORDER BY DataPerSet,RankCorrValue,CorrStrengthID_FK;

					Delete @ObsCorrValuesTABLE Where CorrValue=@ObsCorrValueCurrent
				End
		Delete @DataPerSetTABLE Where DataPerSet=@DataPerSetCurrent
	End