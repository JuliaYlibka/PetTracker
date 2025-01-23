USE [master]
GO
/****** Object:  Database [PetTrackerBD]    Script Date: 23.01.2025 22:33:24 ******/
CREATE DATABASE [PetTrackerBD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PetTrackerBD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\PetTrackerBD.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PetTrackerBD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\PetTrackerBD_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PetTrackerBD] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PetTrackerBD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PetTrackerBD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PetTrackerBD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PetTrackerBD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PetTrackerBD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PetTrackerBD] SET ARITHABORT OFF 
GO
ALTER DATABASE [PetTrackerBD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PetTrackerBD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PetTrackerBD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PetTrackerBD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PetTrackerBD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PetTrackerBD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PetTrackerBD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PetTrackerBD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PetTrackerBD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PetTrackerBD] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PetTrackerBD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PetTrackerBD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PetTrackerBD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PetTrackerBD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PetTrackerBD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PetTrackerBD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PetTrackerBD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PetTrackerBD] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PetTrackerBD] SET  MULTI_USER 
GO
ALTER DATABASE [PetTrackerBD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PetTrackerBD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PetTrackerBD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PetTrackerBD] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [PetTrackerBD] SET DELAYED_DURABILITY = DISABLED 
GO
USE [PetTrackerBD]
GO
/****** Object:  Table [dbo].[Animal]    Script Date: 23.01.2025 22:33:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Animal](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DateBirth] [date] NULL,
	[Gender] [int] NULL,
	[Image] [nvarchar](max) NULL,
 CONSTRAINT [PK_Animal] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Gender]    Script Date: 23.01.2025 22:33:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Medicine]    Script Date: 23.01.2025 22:33:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicine](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeMed] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Medicine] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 23.01.2025 22:33:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Task]    Script Date: 23.01.2025 22:33:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DateTask] [datetime2](0) NULL,
	[Animal] [int] NOT NULL,
	[Medicine] [int] NOT NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Type]    Script Date: 23.01.2025 22:33:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 23.01.2025 22:33:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Role] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Animal]  WITH CHECK ADD  CONSTRAINT [FK_Animal_Gender] FOREIGN KEY([Gender])
REFERENCES [dbo].[Gender] ([ID])
GO
ALTER TABLE [dbo].[Animal] CHECK CONSTRAINT [FK_Animal_Gender]
GO
ALTER TABLE [dbo].[Medicine]  WITH CHECK ADD  CONSTRAINT [FK_Medicine_Type] FOREIGN KEY([TypeMed])
REFERENCES [dbo].[Type] ([ID])
GO
ALTER TABLE [dbo].[Medicine] CHECK CONSTRAINT [FK_Medicine_Type]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Animal] FOREIGN KEY([Animal])
REFERENCES [dbo].[Animal] ([ID])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Animal]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Medicine] FOREIGN KEY([Medicine])
REFERENCES [dbo].[Medicine] ([ID])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Medicine]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([ID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
USE [master]
GO
ALTER DATABASE [PetTrackerBD] SET  READ_WRITE 
GO
