/*
ZADANIE 1
*/
SELECT 
CONCAT(MgO_Kod,' - ',MgA_Segment1,' - ',MgA_Segment2,' - ',MgA_Segment3, CASE WHEN MgA_Segment4 > '' THEN CONCAT(' - ',MgA_Segment4) END) AS Identyfikator_adresu
FROM guest.MagObszary INNER JOIN guest.MagAdresy on MagAdresy.MgA_MgOId=MagObszary.MgO_Id
WHERE MagObszary.MgO_Kod = N'A' AND MagObszary.MgO_MagNumer = 1


/*
ZADANIE 2
*/

SELECT 
CONCAT(MgO_Kod,' - ',MgA_Segment1,' - ',MgA_Segment2,' - ',MgA_Segment3, CASE WHEN MgA_Segment4 > '' THEN CONCAT(' - ',MgA_Segment4) END) AS Identyfikator_adresu
FROM guest.MagObszary INNER JOIN guest.MagAdresy on MagAdresy.MgA_MgOId=MagObszary.MgO_Id
INNER JOIN guest.Mag_TwrLokaliz on MagAdresy.MgA_Id = Mag_TwrLokaliz.TwL_MgaId
WHERE MagObszary.MgO_Kod = 'A' AND MagObszary.MgO_MagNumer = 1 AND Mag_TwrLokaliz.TwL_TwrNumer = 878

/*
ZADANIE 3
*/

SELECT 
CONCAT(MgO_Kod,' - ',MgA_Segment1,' - ',MgA_Segment2,' - ',MgA_Segment3, CASE WHEN MgA_Segment4 > '' THEN CONCAT(' - ',MgA_Segment4) END) AS Identyfikator_adresu
FROM guest.MagObszary INNER JOIN guest.MagAdresy on MagAdresy.MgA_MgOId=MagObszary.MgO_Id
LEFT JOIN guest.Mag_TwrLokaliz on MagAdresy.MgA_Id = Mag_TwrLokaliz.TwL_MgaId
WHERE MagObszary.MgO_Kod = N'A' AND MagObszary.MgO_MagNumer = 1 AND Mag_TwrLokaliz.TwL_Id IS NULL

/*
ZADANIE 4
*/
IF NOT EXISTS (
 SELECT 1 FROM sys.columns 
          WHERE Name = N'MgA_Opis'
          AND Object_ID = Object_ID(N'[guest].[MagAdresy]')
)
 BEGIN
  ALTER TABLE [guest].[MagAdresy] ADD  [MgA_Opis] VARCHAR(64) COLLATE Polish_CI_AS NULL;
 END

/*ZADANIE 5*/

CREATE TRIGGER TR_MagAdresy_IU 
ON [guest].[MagAdresy]
AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [guest].[MagAdresy]
	SET MgA_Opis = CONCAT(i.MgA_MgOId,i.MgA_Segment1 ,i.MgA_Segment2 ,i.MgA_Segment3 , i.MgA_Segment4)
	FROM [guest].[MagAdresy] INNER JOIN inserted i on i.MgA_Id = MagAdresy.MgA_Id
END

/*ZADANIE 6*/

CREATE TRIGGER TR_MagAdresy_DLokalizacjaPreferowana
ON [guest].[MagAdresy]
AFTER DELETE
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT 1 FROM deleted d INNER JOIN guest.Mag_TwrLokaliz ON d.MgA_Id = Mag_TwrLokaliz.TwL_MgaId)
	 BEGIN
		ROLLBACK;
		THROW 50001, 'Usuniecie nie mozliwe',1;
	 END
END
