Declare @DataPerSetTABLE Table (DataPerSet smallint);


Insert Into @DataPerSetTABLE
	select distinct DataPerSet
	from GIRO2016.IglooData
	where DataPerSet>10 --Update this per DataPerSet
	order by DataPerSet;

DECLARE @CorrValue REAL, @DataPerSetCurrent smallint

While ((Select Count(*) From @DataPerSetTABLE)>0)
	Begin
		Set @DataPerSetCurrent=(Select Top 1 DataPerSet From @DataPerSetTABLE)

		SELECT @CorrValue = -0.995

		WHILE @CorrValue<0.995
			BEGIN
					 EXEC GIRO2016.CalculateHistogramData @CorrValue, @DataPerSetCurrent

					 SELECT @CorrValue = @CorrValue + 0.01
			END

		Delete @DataPerSetTABLE Where DataPerSet=@DataPerSetCurrent
	END


