USE [master]
GO
/****** Object:  Database [InvoiceAPI]    Script Date: 25-12-2023 13:37:31 ******/
CREATE DATABASE [InvoiceAPI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'InvoiceAPI', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\InvoiceAPI.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'InvoiceAPI_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\InvoiceAPI_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [InvoiceAPI] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [InvoiceAPI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [InvoiceAPI] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [InvoiceAPI] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [InvoiceAPI] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [InvoiceAPI] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [InvoiceAPI] SET ARITHABORT OFF 
GO
ALTER DATABASE [InvoiceAPI] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [InvoiceAPI] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [InvoiceAPI] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [InvoiceAPI] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [InvoiceAPI] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [InvoiceAPI] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [InvoiceAPI] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [InvoiceAPI] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [InvoiceAPI] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [InvoiceAPI] SET  DISABLE_BROKER 
GO
ALTER DATABASE [InvoiceAPI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [InvoiceAPI] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [InvoiceAPI] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [InvoiceAPI] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [InvoiceAPI] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [InvoiceAPI] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [InvoiceAPI] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [InvoiceAPI] SET RECOVERY FULL 
GO
ALTER DATABASE [InvoiceAPI] SET  MULTI_USER 
GO
ALTER DATABASE [InvoiceAPI] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [InvoiceAPI] SET DB_CHAINING OFF 
GO
ALTER DATABASE [InvoiceAPI] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [InvoiceAPI] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [InvoiceAPI] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [InvoiceAPI] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'InvoiceAPI', N'ON'
GO
ALTER DATABASE [InvoiceAPI] SET QUERY_STORE = ON
GO
ALTER DATABASE [InvoiceAPI] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [InvoiceAPI]
GO
/****** Object:  Table [dbo].[Manufacturers]    Script Date: 25-12-2023 13:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Manufacturers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 25-12-2023 13:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ManufacturerId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseHistories]    Script Date: 25-12-2023 13:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseHistories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceId] [int] NOT NULL,
	[RateId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.PurchaseHistories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rates]    Script Date: 25-12-2023 13:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rates](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [real] NOT NULL,
	[Date] [datetime] NOT NULL,
	[ProductId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Rates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 25-12-2023 13:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 25-12-2023 13:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 25-12-2023 13:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [nvarchar](128) NOT NULL,
	[FirstName] [varchar](128) NOT NULL,
	[LastName] [varchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Manufacturers] ON 

INSERT [dbo].[Manufacturers] ([Id], [Name], [IsDeleted]) VALUES (1, N'Apple', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [IsDeleted]) VALUES (2, N'Samsung', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [IsDeleted]) VALUES (4, N'Sony', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [IsDeleted]) VALUES (5, N'Dell', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [IsDeleted]) VALUES (7, N'LG', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [IsDeleted]) VALUES (8, N'Asus', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [IsDeleted]) VALUES (9, N'OnePlus', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [IsDeleted]) VALUES (11, N'Xiaomi', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [IsDeleted]) VALUES (12, N'string', 1)
INSERT [dbo].[Manufacturers] ([Id], [Name], [IsDeleted]) VALUES (13, N'Abvc', 1)
SET IDENTITY_INSERT [dbo].[Manufacturers] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (1, N'iPhone14 Plus', 1, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (2, N'iPad Air', 1, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (3, N'MacBook Air', 1, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (4, N'AirPods Pro', 1, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (5, N'iWatch SE', 1, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (6, N'Galaxy S23', 2, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (7, N'Galaxy Tab S9 FE', 2, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (8, N'Galaxy Book Pro', 2, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (9, N'Galaxy Watch 6', 2, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (10, N'Galaxy Buds 2', 2, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (11, N'Xperia 1', 4, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (12, N'Xperia Tablet Z', 4, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (13, N'VAIO SE14', 4, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (14, N'Sony WH-1000XM4', 4, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (15, N'Inspiron 14', 5, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (16, N'LG Gram 14', 7, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (17, N'Velvet', 7, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (18, N'Rog Phone 5s', 8, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (19, N'ROG Strix G15', 8, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (20, N'Nord CE 3', 9, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (21, N'Buds Pro 2', 9, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (22, N'Xiaomi 11T Pro', 11, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (23, N'Note 12 Pro', 11, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (24, N'NoteBook Ultra', 11, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (25, N'Pad 6 Max', 11, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (26, N'Band 6', 11, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (27, N'Airdots 3', 11, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (28, N'Iphone 14 ', 1, 0)
INSERT [dbo].[Products] ([Id], [Name], [ManufacturerId], [IsDeleted]) VALUES (30, N'String', 1, 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchaseHistories] ON 

INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [RateId], [Quantity], [Date], [IsDeleted]) VALUES (1, 101, 3, 1, CAST(N'2023-11-27T22:47:21.407' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [RateId], [Quantity], [Date], [IsDeleted]) VALUES (2, 101, 2, 1, CAST(N'2023-11-27T22:47:21.407' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [RateId], [Quantity], [Date], [IsDeleted]) VALUES (3, 102, 4, 1, CAST(N'2023-11-27T22:47:21.407' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [RateId], [Quantity], [Date], [IsDeleted]) VALUES (4, 103, 5, 1, CAST(N'2023-12-22T22:47:21.407' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[PurchaseHistories] OFF
GO
SET IDENTITY_INSERT [dbo].[Rates] ON 

INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (1, 63999, CAST(N'2023-11-23T18:11:12.330' AS DateTime), 1, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (2, 42500, CAST(N'2023-11-23T21:05:48.350' AS DateTime), 2, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (3, 105000, CAST(N'2023-11-23T21:25:41.630' AS DateTime), 3, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (4, 35000, CAST(N'2023-11-23T21:36:23.797' AS DateTime), 4, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (5, 27000, CAST(N'2023-11-23T21:38:15.993' AS DateTime), 5, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (6, 75000, CAST(N'2023-11-23T21:40:08.487' AS DateTime), 6, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (7, 46999, CAST(N'2023-11-23T21:41:22.700' AS DateTime), 7, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (8, 109174, CAST(N'2023-11-23T21:42:36.077' AS DateTime), 8, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (9, 36000, CAST(N'2023-11-23T21:45:25.990' AS DateTime), 9, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (10, 6090, CAST(N'2023-11-23T21:47:14.207' AS DateTime), 10, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (11, 15500, CAST(N'2023-11-23T21:51:15.020' AS DateTime), 11, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (12, 15500, CAST(N'2023-11-23T21:51:57.427' AS DateTime), 12, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (13, 84990, CAST(N'2023-11-23T21:54:45.807' AS DateTime), 13, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (14, 19999, CAST(N'2023-11-23T22:00:11.577' AS DateTime), 14, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (15, 71999, CAST(N'2023-11-23T22:02:48.027' AS DateTime), 15, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (16, 119999, CAST(N'2023-11-23T22:03:44.463' AS DateTime), 16, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (17, 15200, CAST(N'2023-11-23T22:04:48.033' AS DateTime), 17, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (18, 45999, CAST(N'2023-11-23T22:08:15.387' AS DateTime), 18, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (19, 93990, CAST(N'2023-11-23T22:37:00.177' AS DateTime), 19, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (20, 28999, CAST(N'2023-11-23T22:38:26.343' AS DateTime), 20, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (21, 11999, CAST(N'2023-11-23T22:39:40.197' AS DateTime), 21, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (22, 28858, CAST(N'2023-11-23T22:42:07.970' AS DateTime), 22, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (23, 19999, CAST(N'2023-11-23T22:43:15.667' AS DateTime), 23, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (24, 46990, CAST(N'2023-11-23T22:44:37.257' AS DateTime), 24, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (25, 32999, CAST(N'2023-11-23T22:45:46.973' AS DateTime), 25, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (26, 3299, CAST(N'2023-11-23T22:47:21.407' AS DateTime), 26, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (27, 8999, CAST(N'2023-11-23T22:48:28.237' AS DateTime), 27, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [IsDeleted]) VALUES (28, 159999, CAST(N'2023-11-23T22:47:21.407' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Rates] OFF
GO
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'feb7726a-43ce-4dfb-bb4d-ff8950f23e4b', N'CanManageUsers')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'6b75b5cb-14d5-488b-a0cb-454c43605822', N'feb7726a-43ce-4dfb-bb4d-ff8950f23e4b')
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'6b75b5cb-14d5-488b-a0cb-454c43605822', N'Admin', N'Admin', N'admin@abc.com', 0, N'ADzQslFvm3Fp5SDQtMws3Cgc9oYl5IQG6pgPpZ0HXEPlwtHIXFEXcJWWbTRGlB2nzA==', N'59255171-7a84-4b39-9887-864ff3b0726f', NULL, 0, 0, NULL, 1, 0, N'admin@abc.com')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Manufacturers]    Script Date: 25-12-2023 13:37:31 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Manufacturers] ON [dbo].[Manufacturers]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ManufacturerId]    Script Date: 25-12-2023 13:37:31 ******/
CREATE NONCLUSTERED INDEX [IX_ManufacturerId] ON [dbo].[Products]
(
	[ManufacturerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Products]    Script Date: 25-12-2023 13:37:31 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Products] ON [dbo].[Products]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RateId]    Script Date: 25-12-2023 13:37:31 ******/
CREATE NONCLUSTERED INDEX [IX_RateId] ON [dbo].[PurchaseHistories]
(
	[RateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductId]    Script Date: 25-12-2023 13:37:31 ******/
CREATE NONCLUSTERED INDEX [IX_ProductId] ON [dbo].[Rates]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Products_dbo.Manufacturers_ManufacturerId] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_dbo.Products_dbo.Manufacturers_ManufacturerId]
GO
ALTER TABLE [dbo].[PurchaseHistories]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PurchaseHistories_dbo.Rates_RateId] FOREIGN KEY([RateId])
REFERENCES [dbo].[Rates] ([Id])
GO
ALTER TABLE [dbo].[PurchaseHistories] CHECK CONSTRAINT [FK_dbo.PurchaseHistories_dbo.Rates_RateId]
GO
ALTER TABLE [dbo].[Rates]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Rates_dbo.Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rates] CHECK CONSTRAINT [FK_dbo.Rates_dbo.Products_ProductId]
GO
USE [master]
GO
ALTER DATABASE [InvoiceAPI] SET  READ_WRITE 
GO
