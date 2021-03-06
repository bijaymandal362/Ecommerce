USE [master]
GO
/****** Object:  Database [E_CommerceWebsite]    Script Date: 12/14/2020 8:32:42 PM ******/
CREATE DATABASE [E_CommerceWebsite]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'E_CommerceWebsite', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\E_CommerceWebsite.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'E_CommerceWebsite_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\E_CommerceWebsite_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [E_CommerceWebsite] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [E_CommerceWebsite].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [E_CommerceWebsite] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET ARITHABORT OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [E_CommerceWebsite] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [E_CommerceWebsite] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET  DISABLE_BROKER 
GO
ALTER DATABASE [E_CommerceWebsite] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [E_CommerceWebsite] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET RECOVERY FULL 
GO
ALTER DATABASE [E_CommerceWebsite] SET  MULTI_USER 
GO
ALTER DATABASE [E_CommerceWebsite] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [E_CommerceWebsite] SET DB_CHAINING OFF 
GO
ALTER DATABASE [E_CommerceWebsite] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [E_CommerceWebsite] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [E_CommerceWebsite] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'E_CommerceWebsite', N'ON'
GO
ALTER DATABASE [E_CommerceWebsite] SET QUERY_STORE = OFF
GO
USE [E_CommerceWebsite]
GO
/****** Object:  Table [dbo].[tblCart]    Script Date: 12/14/2020 8:32:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCart](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[CartId] [nvarchar](50) NULL,
	[ProductId] [int] NULL,
	[Count] [int] NULL,
	[DateCreated] [date] NULL,
 CONSTRAINT [PK_tblRecord] PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 12/14/2020 8:32:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrder]    Script Date: 12/14/2020 8:32:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrder](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Firstname] [nvarchar](50) NULL,
	[Lastname] [nvarchar](50) NULL,
	[Address] [nvarchar](500) NULL,
	[Phone] [nvarchar](50) NULL,
	[Total] [decimal](18, 0) NULL,
	[OrderDate] [date] NULL,
	[DeliveredStatus] [nvarchar](50) NULL,
	[Latitude] [nvarchar](50) NULL,
	[Longitude] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblOrder] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrderDetail]    Script Date: 12/14/2020 8:32:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetail](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [decimal](18, 0) NULL,
 CONSTRAINT [PK_tblOrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 12/14/2020 8:32:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProduct](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NULL,
	[ProductName] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[UnitPrice] [decimal](18, 0) NULL,
	[SellingPrice] [decimal](18, 0) NULL,
	[Photo] [nvarchar](50) NULL,
	[IsSpecial] [bit] NULL,
 CONSTRAINT [PK_tblProduct] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 12/14/2020 8:32:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRole](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblRole] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 12/14/2020 8:32:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Fullname] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUserRole]    Script Date: 12/14/2020 8:32:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUserRole](
	[UserRoleId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_tblUserRole] PRIMARY KEY CLUSTERED 
(
	[UserRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblCart] ON 

INSERT [dbo].[tblCart] ([RecordId], [CartId], [ProductId], [Count], [DateCreated]) VALUES (1, N'Sachin', 11, 2, CAST(N'2020-12-13' AS Date))
INSERT [dbo].[tblCart] ([RecordId], [CartId], [ProductId], [Count], [DateCreated]) VALUES (2, N'Sachin', 17, 1, CAST(N'2020-12-13' AS Date))
INSERT [dbo].[tblCart] ([RecordId], [CartId], [ProductId], [Count], [DateCreated]) VALUES (4, N'Ram', 14, 1, CAST(N'2020-12-13' AS Date))
INSERT [dbo].[tblCart] ([RecordId], [CartId], [ProductId], [Count], [DateCreated]) VALUES (5, N'Ram', 16, 1, CAST(N'2020-12-13' AS Date))
SET IDENTITY_INSERT [dbo].[tblCart] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCategory] ON 

INSERT [dbo].[tblCategory] ([CategoryId], [CategoryName]) VALUES (1, N'Snacks1')
INSERT [dbo].[tblCategory] ([CategoryId], [CategoryName]) VALUES (2, N'ColdDrinks')
INSERT [dbo].[tblCategory] ([CategoryId], [CategoryName]) VALUES (3, N'Beer')
INSERT [dbo].[tblCategory] ([CategoryId], [CategoryName]) VALUES (4, N'ChowChow')
INSERT [dbo].[tblCategory] ([CategoryId], [CategoryName]) VALUES (5, N'Chocolate')
INSERT [dbo].[tblCategory] ([CategoryId], [CategoryName]) VALUES (6, N'Biscuit')
INSERT [dbo].[tblCategory] ([CategoryId], [CategoryName]) VALUES (8, N'Juice')
INSERT [dbo].[tblCategory] ([CategoryId], [CategoryName]) VALUES (31, N'Laptop')
SET IDENTITY_INSERT [dbo].[tblCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[tblOrder] ON 

INSERT [dbo].[tblOrder] ([OrderId], [Username], [Firstname], [Lastname], [Address], [Phone], [Total], [OrderDate], [DeliveredStatus], [Latitude], [Longitude]) VALUES (1, N'Sachin', N'Satyam', N'Tiwari', N'Kuleshwor-14,Kathmandu', N'9861211848', CAST(330 AS Decimal(18, 0)), CAST(N'2020-12-13' AS Date), N'Confirmed', NULL, NULL)
SET IDENTITY_INSERT [dbo].[tblOrder] OFF
GO
SET IDENTITY_INSERT [dbo].[tblOrderDetail] ON 

INSERT [dbo].[tblOrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (1, 1, 11, 1, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[tblOrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (2, 1, 17, 1, CAST(300 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[tblOrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[tblProduct] ON 

INSERT [dbo].[tblProduct] ([ProductId], [CategoryId], [ProductName], [Description], [UnitPrice], [SellingPrice], [Photo], [IsSpecial]) VALUES (11, 6, N'Coconut', N'Coconut Biscuit', CAST(20 AS Decimal(18, 0)), CAST(30 AS Decimal(18, 0)), N'of29.png', 1)
INSERT [dbo].[tblProduct] ([ProductId], [CategoryId], [ProductName], [Description], [UnitPrice], [SellingPrice], [Photo], [IsSpecial]) VALUES (12, 2, N'Fanta', N'Fanta ', CAST(40 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), N'of28.png', 1)
INSERT [dbo].[tblProduct] ([ProductId], [CategoryId], [ProductName], [Description], [UnitPrice], [SellingPrice], [Photo], [IsSpecial]) VALUES (13, 2, N'sprite', N'Sprite', CAST(40 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), N'of22.png', 1)
INSERT [dbo].[tblProduct] ([ProductId], [CategoryId], [ProductName], [Description], [UnitPrice], [SellingPrice], [Photo], [IsSpecial]) VALUES (14, 6, N'Monaco', N'Monaco', CAST(22 AS Decimal(18, 0)), CAST(25 AS Decimal(18, 0)), N'wi.png', 1)
INSERT [dbo].[tblProduct] ([ProductId], [CategoryId], [ProductName], [Description], [UnitPrice], [SellingPrice], [Photo], [IsSpecial]) VALUES (15, 8, N'Litchi', N'Litchi', CAST(40 AS Decimal(18, 0)), CAST(66 AS Decimal(18, 0)), N'of33.png', 0)
INSERT [dbo].[tblProduct] ([ProductId], [CategoryId], [ProductName], [Description], [UnitPrice], [SellingPrice], [Photo], [IsSpecial]) VALUES (16, 1, N'Chowmein', N'Chowmein', CAST(140 AS Decimal(18, 0)), CAST(150 AS Decimal(18, 0)), N'co3.jpg', 0)
INSERT [dbo].[tblProduct] ([ProductId], [CategoryId], [ProductName], [Description], [UnitPrice], [SellingPrice], [Photo], [IsSpecial]) VALUES (17, 1, N'Momo', N'Hot Momo', CAST(200 AS Decimal(18, 0)), CAST(300 AS Decimal(18, 0)), N'co2.jpg', 0)
INSERT [dbo].[tblProduct] ([ProductId], [CategoryId], [ProductName], [Description], [UnitPrice], [SellingPrice], [Photo], [IsSpecial]) VALUES (18, 5, N'Cadbury', N'Cadbury', CAST(50 AS Decimal(18, 0)), CAST(60 AS Decimal(18, 0)), N'ba2.jpg', 1)
INSERT [dbo].[tblProduct] ([ProductId], [CategoryId], [ProductName], [Description], [UnitPrice], [SellingPrice], [Photo], [IsSpecial]) VALUES (19, 5, N'Kitkat', N'KitKat', CAST(50 AS Decimal(18, 0)), CAST(60 AS Decimal(18, 0)), N'ba1.jpg', 1)
INSERT [dbo].[tblProduct] ([ProductId], [CategoryId], [ProductName], [Description], [UnitPrice], [SellingPrice], [Photo], [IsSpecial]) VALUES (20, 4, N'Wai wai', N'WaWai', CAST(18 AS Decimal(18, 0)), CAST(25 AS Decimal(18, 0)), N'of3.png', 1)
INSERT [dbo].[tblProduct] ([ProductId], [CategoryId], [ProductName], [Description], [UnitPrice], [SellingPrice], [Photo], [IsSpecial]) VALUES (21, 4, N'Mayoes', N'Mayoes', CAST(22 AS Decimal(18, 0)), CAST(30 AS Decimal(18, 0)), N'of6.png', 0)
SET IDENTITY_INSERT [dbo].[tblProduct] OFF
GO
SET IDENTITY_INSERT [dbo].[tblRole] ON 

INSERT [dbo].[tblRole] ([RoleId], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[tblRole] ([RoleId], [RoleName]) VALUES (2, N'User')
SET IDENTITY_INSERT [dbo].[tblRole] OFF
GO
SET IDENTITY_INSERT [dbo].[tblUser] ON 

INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Fullname], [Email]) VALUES (1, N'Sachin', N'Sachin', N'Sachin Tiwari', N'Tiwari2sachin@gmail.com')
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Fullname], [Email]) VALUES (2, N'Ram', N'Ram1', N'Ram Sharma', N'Ram@gmail.com')
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Fullname], [Email]) VALUES (3, N'Shyam', N'shyam', N'Shyam Karki', N'Shyam@gmail.com')
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Fullname], [Email]) VALUES (4, N'Sachin123', N'123', N'Sachin', N'SachinTIwari@gmail.com')
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Fullname], [Email]) VALUES (5, N'Sachin11', N'123', N'Sachin', N'Tiwari2sachin@gmail.com')
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Fullname], [Email]) VALUES (6, N'Hari', N'Hari123', N'Hari Sharma', N'Hari@gmail.com')
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Fullname], [Email]) VALUES (7, N'Sachin1234', N'Hari123', N'Sachin', N'Tiwari2sachin@gmail.com')
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Fullname], [Email]) VALUES (8, N'Shyam111', N'Hari123', N'Hari Sharma', N'Hari@gmail.com')
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Fullname], [Email]) VALUES (9, N'Sachin', N'123', N'Shyam Karki', N'Tiwari2sachin@gmail.com')
SET IDENTITY_INSERT [dbo].[tblUser] OFF
GO
SET IDENTITY_INSERT [dbo].[tblUserRole] ON 

INSERT [dbo].[tblUserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (1, 1, 1)
INSERT [dbo].[tblUserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (3, 2, 2)
INSERT [dbo].[tblUserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (4, 3, 2)
INSERT [dbo].[tblUserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (5, 4, 2)
INSERT [dbo].[tblUserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (6, 5, 2)
INSERT [dbo].[tblUserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (7, 6, 1)
INSERT [dbo].[tblUserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (8, 7, 1)
INSERT [dbo].[tblUserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (9, 8, 1)
INSERT [dbo].[tblUserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (10, 9, 1)
SET IDENTITY_INSERT [dbo].[tblUserRole] OFF
GO
ALTER TABLE [dbo].[tblCart]  WITH CHECK ADD  CONSTRAINT [FK_tblCart_tblProduct] FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProduct] ([ProductId])
GO
ALTER TABLE [dbo].[tblCart] CHECK CONSTRAINT [FK_tblCart_tblProduct]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblOrder] FOREIGN KEY([OrderId])
REFERENCES [dbo].[tblOrder] ([OrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblOrder]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblProduct] FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProduct] ([ProductId])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblProduct]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblCategory] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[tblCategory] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblCategory]
GO
ALTER TABLE [dbo].[tblUserRole]  WITH CHECK ADD  CONSTRAINT [FK_tblUserRole_tblRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[tblRole] ([RoleId])
GO
ALTER TABLE [dbo].[tblUserRole] CHECK CONSTRAINT [FK_tblUserRole_tblRole]
GO
ALTER TABLE [dbo].[tblUserRole]  WITH CHECK ADD  CONSTRAINT [FK_tblUserRole_tblUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblUserRole] CHECK CONSTRAINT [FK_tblUserRole_tblUser]
GO
USE [master]
GO
ALTER DATABASE [E_CommerceWebsite] SET  READ_WRITE 
GO
