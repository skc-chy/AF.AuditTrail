
/****** Object:  StoredProcedure [dbo].[DeleteEmployee]    Script Date: 7/16/2016 11:18:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteEmployee] 
	-- Add the parameters for the stored procedure here
	@EmpID uniqueidentifier
	
AS
BEGIN
	DELETE FROM dbo.Employee WHERE EmpID=@EmpID
END

GO
/****** Object:  StoredProcedure [dbo].[GetEmployee]    Script Date: 7/16/2016 11:18:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmployee] 
	@Name nvarchar(50) = NULL
AS
BEGIN

    -- Insert statements for procedure here
    if @Name is Null
    Begin
	SELECT EmpID,Name,[Address],Email,Phone from dbo.Employee
	End
	else
	Begin
	SELECT EmpID,Name,[Address],Email,Phone from dbo.Employee where Name=@Name
	End
END

GO
/****** Object:  StoredProcedure [dbo].[InsertEmployee]    Script Date: 7/16/2016 11:18:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertEmployee] 
	-- Add the parameters for the stored procedure here
	@EmpID uniqueidentifier,
	@Name Varchar(50),
	@Address Varchar(50),
	@Email Varchar(50),
	@Phone Varchar(50)
AS
BEGIN
	Insert into dbo.Employee(EmpID,Name,[Address],Email,Phone) Values(@EmpID,@Name,@Address,@Email,@Phone)
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployee]    Script Date: 7/16/2016 11:18:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEmployee] 
	-- Add the parameters for the stored procedure here
	@EmpID uniqueidentifier,
	@Address Varchar(50),
	@Email Varchar(50),
	@Phone Varchar(50)
AS
BEGIN
	UPDATE dbo.Employee SET [Address]=@Address,Email=@Email,Phone=@Phone WHERE EmpID=@EmpID
END

GO
/****** Object:  Table [dbo].[Employee]    Script Date: 7/16/2016 11:18:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmpID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
