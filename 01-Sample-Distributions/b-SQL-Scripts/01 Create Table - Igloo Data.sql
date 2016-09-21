CREATE TABLE [GIRO2016].[IglooData] (
    [DataPerSet]        SMALLINT NOT NULL,
    [CorrStrengthID_FK] SMALLINT NOT NULL,
    [RankCorrValue]     REAL     NOT NULL,
    [TauCorrValue]      REAL     NOT NULL
);


GO

-- *** CREATE THE INDEXES AFTER INJECTING THE DATA ***
-- WILL REQUIRE ABOUT 2GB FOR FULL DATA SET AND ANOTHER 4GB FOR INDEXES
CREATE NONCLUSTERED INDEX [IX_GIRO2016_IglooData_Rank]
    ON [GIRO2016].[IglooData]([DataPerSet] ASC, [CorrStrengthID_FK] ASC, [RankCorrValue] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_GIRO2016_IglooData_Tau]
    ON [GIRO2016].[IglooData]([DataPerSet] ASC, [CorrStrengthID_FK] ASC, [TauCorrValue] ASC);