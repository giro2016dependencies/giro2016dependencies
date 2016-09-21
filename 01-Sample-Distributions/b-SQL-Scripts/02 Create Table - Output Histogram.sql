CREATE TABLE [GIRO2016].[IglooData_HistogramData] (
    [DataPerSet]        SMALLINT NOT NULL,
    [RankCorrValue]     REAL     NOT NULL,
    [CorrStrengthID_FK] SMALLINT NOT NULL,
    [CountCorrStrength] SMALLINT NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_GIRO2016_IglooData_Histogram]
    ON [GIRO2016].[IglooData_HistogramData]([DataPerSet] ASC, [RankCorrValue] ASC, [CorrStrengthID_FK] ASC);