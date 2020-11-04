--Tabela MagAdresy
CREATE TABLE [guest].[MagAdresy](
	[MgA_Id] [int] IDENTITY(1,1) NOT NULL,
	[MgA_MgOId] [int] NULL,
	[MgA_Segment1] [varchar](3) COLLATE Polish_CI_AS NULL,
	[MgA_Segment2] [varchar](3) COLLATE Polish_CI_AS NULL,
	[MgA_Segment3] [varchar](3) COLLATE Polish_CI_AS NULL,
	[MgA_Segment4] [varchar](1) COLLATE Polish_CI_AS NULL,
	[MgA_MPAId] [int] NULL,
	[MgA_Opis] [varchar](64) COLLATE Polish_CI_AS NULL,
 CONSTRAINT [MgA_Primary] PRIMARY KEY CLUSTERED 
(
	[MgA_Id] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO
--Tabela MagObszary
CREATE TABLE [guest].[MagObszary](
	[MgO_Id] [int] IDENTITY(1,1) NOT NULL,
	[MgO_MagTyp] [smallint] NULL,
	[MgO_MagNumer] [int] NULL,
	[MgO_Kod] [varchar](10) COLLATE Polish_CI_AS NULL,
	[MgO_Nazwa] [varchar](30) COLLATE Polish_CI_AS NULL,
	[MgO_Towary] [smallint] NULL,
 CONSTRAINT [MgO_Primary] PRIMARY KEY CLUSTERED 
(
	[MgO_Id] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO
--Tabela Mag_TwrLokaliz

CREATE TABLE [guest].[Mag_TwrLokaliz](
	[TwL_Id] [int] IDENTITY(1,1) NOT NULL,
	[TwL_MagId] [int] NOT NULL,
	[TwL_MgaId] [int] NOT NULL,
	[TwL_Gidlp] [int] NOT NULL,
	[TwL_TwrNumer] [int] NOT NULL,
CONSTRAINT [PK_EL_RR_TwrLokaliz] PRIMARY KEY CLUSTERED 
(
	[TwL_Id] ASC
) ON [PRIMARY]
) ON [PRIMARY]
