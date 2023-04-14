SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[AuditType](
	[DataTypeID] [int] NOT NULL,
	[DataType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AuditType] PRIMARY KEY CLUSTERED 
(
	[DataTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AuditValue](
	[DataID] [uniqueidentifier] NOT NULL,
	[Data] [nvarchar](max) NOT NULL,
	[AuditID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AuditValue] PRIMARY KEY CLUSTERED 
(
	[DataID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[AuditTrail](
	[AuditID] [uniqueidentifier] NOT NULL,
	[RecordID] [varchar](255) NOT NULL,
	[ParentRecordID] [varchar](255) NULL,
	[ModuleID] [uniqueidentifier] NOT NULL,
	[DataTypeID] [int] NOT NULL,
	[ChangeType] [int] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_AuditTrail] PRIMARY KEY CLUSTERED 
(
	[AuditID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AuditSerialized](
	[DataID] [uniqueidentifier] NOT NULL,
	[Data] [xml] NOT NULL,
	[AuditID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AuditSerialized] PRIMARY KEY CLUSTERED 
(
	[DataID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[AuditSerialized]  WITH CHECK ADD  CONSTRAINT [FK_AuditSerialized_AuditTrail] FOREIGN KEY([AuditID])
REFERENCES [dbo].[AuditTrail] ([AuditID])
GO

ALTER TABLE [dbo].[AuditSerialized] CHECK CONSTRAINT [FK_AuditSerialized_AuditTrail]
GO


ALTER TABLE [dbo].[AuditValue]  WITH CHECK ADD  CONSTRAINT [FK_AuditValue_AuditTrail] FOREIGN KEY([AuditID])
REFERENCES [dbo].[AuditTrail] ([AuditID])
GO

ALTER TABLE [dbo].[AuditValue] CHECK CONSTRAINT [FK_AuditValue_AuditTrail]
GO

ALTER TABLE [dbo].[AuditTrail]  WITH CHECK ADD  CONSTRAINT [FK_AuditTrail_AuditType] FOREIGN KEY([DataTypeID])
REFERENCES [dbo].[AuditType] ([DataTypeID])
GO

ALTER TABLE [dbo].[AuditTrail] CHECK CONSTRAINT [FK_AuditTrail_AuditType]
GO


/*** Create SP's***/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[GetAuditDataValue]    Script Date: 8/20/2016 12:42:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAuditDataValue]
@AuditID uniqueidentifier
AS
BEGIN
    SELECT DATA FROM dbo.AuditValue 
    WHERE AuditID = @AuditID
END

GO

/****** Object:  StoredProcedure [dbo].[GetAuditDataXML]    Script Date: 8/20/2016 12:42:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAuditDataXML]
@AuditID uniqueidentifier
AS
BEGIN
SELECT DATA FROM dbo.AuditSerialized 
    WHERE AuditID = @AuditID
END

GO

/****** Object:  StoredProcedure [dbo].[GetAuditRecordsAll]    Script Date: 8/20/2016 12:42:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAuditRecordsAll]

AS
BEGIN
	SELECT 
	AuditID,
	RecordID,
	ParentRecordID,
	ModuleID,
	DataTypeID,
	ChangeType,
	ModifiedBy,
	ModifiedOn
	FROM dbo.AUDITTRAIL
	
END

GO

/****** Object:  StoredProcedure [dbo].[GetAuditRecordsByModuleID]    Script Date: 8/20/2016 12:42:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAuditRecordsByModuleID]
@ModuleID uniqueidentifier
AS
BEGIN
	SELECT 
	AuditID,
	RecordID,
	ParentRecordID,
	ModuleID,
	DataTypeID,
	ChangeType,
	ModifiedBy,
	ModifiedOn
	FROM dbo.AUDITTRAIL
	WHERE ModuleID = @ModuleID
END

GO

/****** Object:  StoredProcedure [dbo].[GetAuditTrailDataTypeByAuditID]    Script Date: 8/20/2016 12:42:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC AT.GetAuditTrailDataTypeByRecordID 'd862e739-bd40-499d-8e38-f810dc462395'
CREATE PROCEDURE [dbo].[GetAuditTrailDataTypeByAuditID]  
@AuditID uniqueidentifier  
AS  
BEGIN  
 SELECT DataTypeID FROM dbo.AUDITTRAIL Where AuditID =@AuditID  
END

GO

/****** Object:  StoredProcedure [dbo].[SaveAuditTrail]    Script Date: 8/20/2016 12:42:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SaveAuditTrail]
@AuditID uniqueIdentifier,
@RecordID varchar(50),
@ParentRecordID varchar(50),
@ModuleID uniqueIdentifier, 
@ModifiedBy uniqueIdentifier, 
@ChangeType int, 
@ModifiedOn datetime,
@DataTypeID int,
--For Audit Data
@AuditValue nvarchar(max) = null,
@AuditSerialize xml = null,
@DataID uniqueIdentifier
AS
BEGIN
INSERT INTO dbo.AuditTrail
(
	AuditID,
	RecordID,
	ParentRecordID,
	ModuleID,
	DataTypeID,
	ChangeType,
	ModifiedBy,
	ModifiedOn
)
Values
(
	@AuditID,
	@RecordID,
	@ParentRecordID,
	@ModuleID,
	@DataTypeID,
	@ChangeType,
	@ModifiedBy,
	@ModifiedOn
)

IF @DataTypeID = ( SELECT DataTypeID FROM dbo.AUDITTYPE Where DataType = 'string')
	BEGIN
    INSERT INTO dbo.AuditValue 
    ( 
		AuditID, 
		DataID, 
		Data
	) 
	VALUES
	(
		@AuditID, @DataID, @AuditValue
	)
	END
ELSE 
	IF @DataTypeID = ( SELECT DataTypeID FROM dbo.AUDITTYPE Where DataType = 'xml')
		BEGIN
		INSERT INTO DBO.AuditSerialized
		( 
			AuditID, 
			DataID, 
			Data
		) 
		VALUES
		(
			@AuditID, @DataID, @AuditSerialize
		)
		END
END

GO

/***** Insert Records ****/

INSERT INTO [DBO].[AuditType] ([DataTypeID],[DataType]) VALUES(1,'string')

GO

INSERT INTO [DBO].[AuditType] ([DataTypeID],[DataType]) VALUES(2,'xml')

GO