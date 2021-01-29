USE [master]
GO
/****** Object:  Database [azure-javier]    Script Date: 29/01/2021 10:37:58 ******/
CREATE DATABASE [azure-javier]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'azure-javier', FILENAME = N'C:\Databases\MSSQL14.MSSQLSERVER\MSSQL\DATA\azure-javier.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'azure-javier_log', FILENAME = N'C:\Databases\MSSQL14.MSSQLSERVER\MSSQL\DATA\azure-javier_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [azure-javier] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [azure-javier].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [azure-javier] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [azure-javier] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [azure-javier] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [azure-javier] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [azure-javier] SET ARITHABORT OFF 
GO
ALTER DATABASE [azure-javier] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [azure-javier] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [azure-javier] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [azure-javier] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [azure-javier] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [azure-javier] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [azure-javier] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [azure-javier] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [azure-javier] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [azure-javier] SET  ENABLE_BROKER 
GO
ALTER DATABASE [azure-javier] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [azure-javier] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [azure-javier] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [azure-javier] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [azure-javier] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [azure-javier] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [azure-javier] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [azure-javier] SET RECOVERY FULL 
GO
ALTER DATABASE [azure-javier] SET  MULTI_USER 
GO
ALTER DATABASE [azure-javier] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [azure-javier] SET DB_CHAINING OFF 
GO
ALTER DATABASE [azure-javier] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [azure-javier] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [azure-javier] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'azure-javier', N'ON'
GO
ALTER DATABASE [azure-javier] SET QUERY_STORE = OFF
GO
USE [azure-javier]
GO
/****** Object:  UserDefinedFunction [dbo].[HashContraseñaUsuario]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Función que devuelve una cadena codificada a partor del correo y la contraseña de un usuario
CREATE   FUNCTION [dbo].[HashContraseñaUsuario] (@Correo Varchar(60), @Password Varchar(15)) RETURNS Binary(20) AS
BEGIN
	DECLARE @PasswordCodificado Binary(20)

	SET @PasswordCodificado = HASHBYTES('SHA1', @Correo+@Password)

	RETURN @PasswordCodificado
END
GO
/****** Object:  UserDefinedFunction [dbo].[LoginUsuario]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Función que comprueba si existe un usuario con las credenciales pasadas por parámetros
CREATE   FUNCTION [dbo].[LoginUsuario] (@Correo Varchar(60), @Password Varchar(15)) RETURNS Bit AS
BEGIN
	DECLARE @PasswordCodificado Binary(20)
	DECLARE @Existe Bit = 0

	SET @PasswordCodificado = HASHBYTES('SHA1', @Correo+@Password)

	IF EXISTS(SELECT * FROM Usuarios WHERE Correo = @Correo AND PasswordCodificada = @PasswordCodificado)
	BEGIN
		SET @Existe = 1
	END

	RETURN @Existe
END
GO
/****** Object:  Table [dbo].[Apuestas]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Apuestas](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_usuario] [int] NOT NULL,
	[ID_partido] [int] NOT NULL,
	[Dinero_apostado] [smallmoney] NOT NULL,
	[Fecha] [smalldatetime] NOT NULL,
	[Comprobada] [bit] NOT NULL,
	[Cuota] [decimal](4, 2) NULL,
 CONSTRAINT [PKApuestas] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipos]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipos](
	[ID] [char](4) NOT NULL,
	[Nombre] [varchar](20) NOT NULL,
	[Ciudad] [varchar](25) NULL,
	[Pais] [varchar](20) NULL,
 CONSTRAINT [PKEquipos] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GanadoresPartidos]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GanadoresPartidos](
	[IDApuesta] [int] NOT NULL,
	[Resultado] [char](1) NOT NULL,
 CONSTRAINT [PKGanadoresPartidos] PRIMARY KEY CLUSTERED 
(
	[IDApuesta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Handicaps]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Handicaps](
	[IDApuesta] [int] NOT NULL,
	[Handicap] [smallint] NOT NULL,
 CONSTRAINT [PKHandicaps] PRIMARY KEY CLUSTERED 
(
	[IDApuesta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimientos]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimientos](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_usuario] [int] NOT NULL,
	[Dinero] [smallmoney] NOT NULL,
	[Fecha] [date] NOT NULL,
 CONSTRAINT [PKMovimientos] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OversUnders]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OversUnders](
	[IDApuesta] [int] NOT NULL,
	[Over/Under] [bit] NOT NULL,
	[Numero] [decimal](2, 1) NOT NULL,
 CONSTRAINT [PKOversUnders] PRIMARY KEY CLUSTERED 
(
	[IDApuesta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partidos]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partidos](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDLocal] [char](4) NOT NULL,
	[IDVisitante] [char](4) NOT NULL,
	[GolesLocal] [tinyint] NOT NULL,
	[GolesVisitante] [tinyint] NOT NULL,
	[Finalizado] [bit] NOT NULL,
	[Fecha] [smalldatetime] NULL,
	[AperturaApuestas]  AS (dateadd(day,(-5),[Fecha])),
	[CierreApuestas]  AS (dateadd(minute,(-2),[Fecha])),
	[LimiteO/U] [smallmoney] NOT NULL,
	[LimiteGP] [smallmoney] NOT NULL,
	[LimiteHP] [smallmoney] NOT NULL,
 CONSTRAINT [PKPartidos] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Correo] [varchar](60) NOT NULL,
	[Password] [varchar](15) NOT NULL,
	[Saldo] [smallmoney] NOT NULL,
	[PasswordCodificada] [binary](20) NOT NULL,
 CONSTRAINT [PKUsuarios] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Apuestas] ON 

INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (1, 17, 26, 96.0000, CAST(N'2021-01-03T20:00:00' AS SmallDateTime), 1, CAST(3.58 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (2, 18, 219, 135.0000, CAST(N'2020-08-25T17:00:00' AS SmallDateTime), 1, CAST(4.76 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (3, 25, 97, 67.0000, CAST(N'2020-10-14T17:00:00' AS SmallDateTime), 1, CAST(5.45 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (4, 15, 121, 63.0000, CAST(N'2020-11-08T17:00:00' AS SmallDateTime), 1, CAST(3.95 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (5, 43, 252, 67.0000, CAST(N'2020-12-26T17:00:00' AS SmallDateTime), 1, CAST(7.31 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (6, 36, 5, 174.0000, CAST(N'2020-10-09T19:00:00' AS SmallDateTime), 1, CAST(4.56 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (7, 43, 148, 77.0000, CAST(N'2020-10-11T21:00:00' AS SmallDateTime), 1, CAST(3.59 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (8, 15, 21, 86.0000, CAST(N'2020-09-17T16:00:00' AS SmallDateTime), 1, CAST(4.71 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (9, 41, 2, 176.0000, CAST(N'2020-10-30T17:00:00' AS SmallDateTime), 1, CAST(2.80 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (10, 37, 279, 179.0000, CAST(N'2020-10-08T21:00:00' AS SmallDateTime), 1, CAST(5.25 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (11, 26, 258, 80.0000, CAST(N'2020-08-29T16:00:00' AS SmallDateTime), 1, CAST(8.75 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (12, 18, 17, 186.0000, CAST(N'2020-12-09T13:00:00' AS SmallDateTime), 1, CAST(2.76 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (13, 48, 86, 172.0000, CAST(N'2020-08-26T12:00:00' AS SmallDateTime), 1, CAST(2.81 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (14, 49, 125, 197.0000, CAST(N'2020-12-14T21:00:00' AS SmallDateTime), 1, CAST(5.30 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (15, 5, 269, 142.0000, CAST(N'2020-10-09T16:00:00' AS SmallDateTime), 1, CAST(2.67 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (16, 48, 16, 113.0000, CAST(N'2020-10-09T17:00:00' AS SmallDateTime), 1, CAST(9.90 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (17, 28, 64, 139.0000, CAST(N'2020-08-24T20:00:00' AS SmallDateTime), 1, CAST(8.21 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (18, 20, 152, 135.0000, CAST(N'2020-11-17T16:00:00' AS SmallDateTime), 1, CAST(3.23 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (19, 27, 278, 108.0000, CAST(N'2020-11-07T21:00:00' AS SmallDateTime), 1, CAST(1.68 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (20, 35, 18, 171.0000, CAST(N'2020-12-25T15:00:00' AS SmallDateTime), 1, CAST(8.26 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (21, 40, 92, 169.0000, CAST(N'2020-10-06T17:00:00' AS SmallDateTime), 1, CAST(7.99 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (22, 5, 102, 163.0000, CAST(N'2021-01-19T21:00:00' AS SmallDateTime), 1, CAST(3.05 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (23, 32, 143, 85.0000, CAST(N'2020-10-29T16:00:00' AS SmallDateTime), 1, CAST(4.11 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (24, 50, 32, 158.0000, CAST(N'2020-12-16T19:00:00' AS SmallDateTime), 1, CAST(2.58 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (25, 19, 18, 167.0000, CAST(N'2020-12-22T15:00:00' AS SmallDateTime), 1, CAST(4.35 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (26, 3, 82, 81.0000, CAST(N'2021-01-19T15:00:00' AS SmallDateTime), 1, CAST(8.17 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (27, 38, 97, 88.0000, CAST(N'2020-10-13T17:00:00' AS SmallDateTime), 1, CAST(6.70 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (28, 17, 228, 64.0000, CAST(N'2020-12-18T21:00:00' AS SmallDateTime), 1, CAST(4.69 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (29, 35, 249, 173.0000, CAST(N'2020-12-22T17:00:00' AS SmallDateTime), 1, CAST(7.48 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (30, 37, 259, 84.0000, CAST(N'2020-10-07T20:00:00' AS SmallDateTime), 1, CAST(8.44 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (31, 50, 148, 73.0000, CAST(N'2020-10-10T21:00:00' AS SmallDateTime), 1, CAST(8.36 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (32, 33, 165, 99.0000, CAST(N'2020-09-04T21:00:00' AS SmallDateTime), 1, CAST(4.54 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (33, 27, 157, 61.0000, CAST(N'2020-12-13T18:00:00' AS SmallDateTime), 1, CAST(8.76 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (34, 28, 298, 64.0000, CAST(N'2021-01-16T18:00:00' AS SmallDateTime), 1, CAST(7.87 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (35, 15, 2, 66.0000, CAST(N'2020-10-28T17:00:00' AS SmallDateTime), 1, CAST(8.53 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (36, 43, 115, 156.0000, CAST(N'2020-11-10T20:00:00' AS SmallDateTime), 1, CAST(5.47 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (37, 11, 299, 77.0000, CAST(N'2020-12-14T13:00:00' AS SmallDateTime), 1, CAST(3.92 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (38, 34, 115, 188.0000, CAST(N'2020-11-12T20:00:00' AS SmallDateTime), 1, CAST(3.70 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (39, 17, 259, 117.0000, CAST(N'2020-10-09T20:00:00' AS SmallDateTime), 1, CAST(8.88 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (40, 10, 297, 134.0000, CAST(N'2020-11-23T17:00:00' AS SmallDateTime), 1, CAST(5.37 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (41, 46, 52, 99.0000, CAST(N'2020-11-30T20:00:00' AS SmallDateTime), 1, CAST(7.32 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (42, 3, 81, 96.0000, CAST(N'2020-11-11T13:00:00' AS SmallDateTime), 1, CAST(7.50 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (43, 31, 86, 142.0000, CAST(N'2020-08-27T12:00:00' AS SmallDateTime), 1, CAST(3.98 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (44, 14, 279, 186.0000, CAST(N'2020-10-07T21:00:00' AS SmallDateTime), 1, CAST(5.45 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (45, 13, 220, 183.0000, CAST(N'2021-01-05T16:00:00' AS SmallDateTime), 1, CAST(7.78 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (46, 47, 157, 189.0000, CAST(N'2020-12-13T18:00:00' AS SmallDateTime), 1, CAST(4.08 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (47, 4, 249, 105.0000, CAST(N'2020-12-23T17:00:00' AS SmallDateTime), 1, CAST(7.17 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (48, 3, 253, 88.0000, CAST(N'2020-11-04T18:00:00' AS SmallDateTime), 1, CAST(5.76 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (49, 47, 90, 137.0000, CAST(N'2020-11-09T18:00:00' AS SmallDateTime), 1, CAST(7.15 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (50, 29, 85, 124.0000, CAST(N'2020-10-21T15:00:00' AS SmallDateTime), 1, CAST(4.80 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (51, 18, 295, 124.0000, CAST(N'2020-12-29T14:00:00' AS SmallDateTime), 1, CAST(7.93 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (52, 25, 294, 160.0000, CAST(N'2020-09-21T13:00:00' AS SmallDateTime), 1, CAST(6.00 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (53, 50, 220, 115.0000, CAST(N'2021-01-04T16:00:00' AS SmallDateTime), 1, CAST(9.50 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (54, 13, 239, 195.0000, CAST(N'2020-11-14T16:00:00' AS SmallDateTime), 1, CAST(1.32 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (55, 45, 173, 133.0000, CAST(N'2020-12-12T15:00:00' AS SmallDateTime), 1, CAST(3.20 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (56, 30, 297, 102.0000, CAST(N'2020-11-21T17:00:00' AS SmallDateTime), 1, CAST(7.33 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (57, 12, 226, 139.0000, CAST(N'2020-09-24T17:00:00' AS SmallDateTime), 1, CAST(4.38 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (58, 12, 102, 174.0000, CAST(N'2021-01-15T21:00:00' AS SmallDateTime), 1, CAST(8.97 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (59, 11, 113, 91.0000, CAST(N'2020-12-06T13:00:00' AS SmallDateTime), 1, CAST(1.29 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (60, 7, 78, 85.0000, CAST(N'2020-09-23T21:00:00' AS SmallDateTime), 1, CAST(2.57 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (61, 19, 115, 173.0000, CAST(N'2020-11-10T20:00:00' AS SmallDateTime), 1, CAST(6.55 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (62, 9, 82, 84.0000, CAST(N'2021-01-23T15:00:00' AS SmallDateTime), 1, CAST(8.35 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (63, 16, 42, 54.0000, CAST(N'2020-11-15T17:00:00' AS SmallDateTime), 1, CAST(6.60 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (64, 15, 187, 92.0000, CAST(N'2021-01-18T20:00:00' AS SmallDateTime), 1, CAST(8.68 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (65, 26, 146, 183.0000, CAST(N'2020-10-02T19:00:00' AS SmallDateTime), 1, CAST(2.77 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (66, 20, 78, 170.0000, CAST(N'2020-09-22T21:00:00' AS SmallDateTime), 1, CAST(2.35 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (67, 48, 17, 198.0000, CAST(N'2020-12-11T13:00:00' AS SmallDateTime), 1, CAST(8.76 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (68, 9, 101, 173.0000, CAST(N'2020-08-30T20:00:00' AS SmallDateTime), 1, CAST(9.50 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (69, 16, 219, 99.0000, CAST(N'2020-08-26T17:00:00' AS SmallDateTime), 1, CAST(8.62 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (70, 19, 130, 57.0000, CAST(N'2020-12-07T20:00:00' AS SmallDateTime), 1, CAST(1.51 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (71, 17, 239, 162.0000, CAST(N'2020-11-14T16:00:00' AS SmallDateTime), 1, CAST(9.68 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (72, 27, 10, 142.0000, CAST(N'2021-01-09T18:00:00' AS SmallDateTime), 1, CAST(2.97 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (73, 50, 283, 106.0000, CAST(N'2020-10-17T14:00:00' AS SmallDateTime), 1, CAST(3.29 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (74, 30, 295, 164.0000, CAST(N'2020-12-27T14:00:00' AS SmallDateTime), 1, CAST(1.40 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (75, 5, 125, 89.0000, CAST(N'2020-12-17T21:00:00' AS SmallDateTime), 1, CAST(4.27 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (76, 34, 95, 157.0000, CAST(N'2020-09-21T16:00:00' AS SmallDateTime), 1, CAST(5.11 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (77, 19, 200, 83.0000, CAST(N'2020-12-20T12:00:00' AS SmallDateTime), 1, CAST(3.16 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (78, 36, 200, 124.0000, CAST(N'2020-12-23T12:00:00' AS SmallDateTime), 1, CAST(4.24 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (79, 45, 97, 182.0000, CAST(N'2020-10-13T17:00:00' AS SmallDateTime), 1, CAST(7.36 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (80, 8, 64, 86.0000, CAST(N'2020-08-25T20:00:00' AS SmallDateTime), 1, CAST(6.82 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (81, 31, 79, 141.0000, CAST(N'2020-12-30T20:00:00' AS SmallDateTime), 1, CAST(3.46 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (82, 2, 238, 65.0000, CAST(N'2020-11-04T13:00:00' AS SmallDateTime), 1, CAST(5.41 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (83, 2, 185, 118.0000, CAST(N'2020-09-06T18:00:00' AS SmallDateTime), 1, CAST(2.48 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (84, 23, 64, 126.0000, CAST(N'2020-08-26T20:00:00' AS SmallDateTime), 1, CAST(6.33 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (85, 23, 77, 67.0000, CAST(N'2021-01-19T18:00:00' AS SmallDateTime), 1, CAST(7.37 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (86, 45, 81, 129.0000, CAST(N'2020-11-09T13:00:00' AS SmallDateTime), 1, CAST(8.48 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (87, 50, 28, 132.0000, CAST(N'2020-10-28T20:00:00' AS SmallDateTime), 1, CAST(1.71 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (88, 1, 213, 141.0000, CAST(N'2020-12-28T17:00:00' AS SmallDateTime), 1, CAST(5.27 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (89, 14, 166, 60.0000, CAST(N'2021-01-02T15:00:00' AS SmallDateTime), 1, CAST(4.15 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (90, 6, 271, 88.0000, CAST(N'2020-12-04T19:00:00' AS SmallDateTime), 1, CAST(9.90 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (91, 20, 213, 135.0000, CAST(N'2020-12-26T17:00:00' AS SmallDateTime), 1, CAST(2.11 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (92, 22, 184, 183.0000, CAST(N'2020-08-30T16:00:00' AS SmallDateTime), 1, CAST(5.07 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (93, 20, 36, 101.0000, CAST(N'2020-11-11T14:00:00' AS SmallDateTime), 1, CAST(8.05 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (94, 12, 238, 62.0000, CAST(N'2020-11-05T13:00:00' AS SmallDateTime), 1, CAST(9.04 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (95, 30, 101, 162.0000, CAST(N'2020-08-29T20:00:00' AS SmallDateTime), 1, CAST(3.83 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (96, 8, 36, 138.0000, CAST(N'2020-11-11T14:00:00' AS SmallDateTime), 1, CAST(2.70 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (97, 1, 26, 135.0000, CAST(N'2021-01-02T20:00:00' AS SmallDateTime), 1, CAST(3.20 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (98, 46, 250, 126.0000, CAST(N'2020-10-12T15:00:00' AS SmallDateTime), 1, CAST(2.22 AS Decimal(4, 2)))
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (99, 18, 191, 140.0000, CAST(N'2020-09-30T20:00:00' AS SmallDateTime), 1, CAST(9.99 AS Decimal(4, 2)))
GO
INSERT [dbo].[Apuestas] ([ID], [ID_usuario], [ID_partido], [Dinero_apostado], [Fecha], [Comprobada], [Cuota]) VALUES (100, 14, 187, 169.0000, CAST(N'2021-01-21T20:00:00' AS SmallDateTime), 1, CAST(8.83 AS Decimal(4, 2)))
SET IDENTITY_INSERT [dbo].[Apuestas] OFF
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'AJAX', N'Ajax', N'Amsterdam', N'Holanda')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'BARC', N'FC Barcelona', N'Barcelona', N'España')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'BAYM', N'Bayern', N'Munich', N'Alemania')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'BENF', N'Benfica', N'Lisboa', N'Portugal')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'BODO', N'Borussia Dortmund', N'Dortmund', N'Alemania')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'CSKM', N'PFC CSKA Moscu', N'Moscú', N'Rusia')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'GTFE', N'Getafe CF', N'Getafe', N'España')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'INTM', N'Inter', N'Milan', N'Italia')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'JUVT', N'Juventus', N'Turin', N'Italia')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'LIVL', N'Liverpool FC', N'Liverpool', N'Reino Unido')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'MANC', N'Manchester City', N'Manchester', N'Reino Unido')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'MANU', N'Manchester United', N'Manchester', N'Reino Unido')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'OLYL', N'Olympique de Lion', N'Lion', N'Francia')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'OPRT', N'FC Oporto', N'Oporto', N'Portugal')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'PASG', N'Paris Saint Germain', N'Paris', N'Francia')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'RBET', N'Real Betis', N'Sevilla', N'España')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'RMAD', N'Real Madrid', N'Madrid', N'España')
INSERT [dbo].[Equipos] ([ID], [Nombre], [Ciudad], [Pais]) VALUES (N'ROMA', N'AS Roma', N'Roma', N'Italia')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (4, N'X')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (5, N'X')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (6, N'X')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (12, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (16, N'1')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (18, N'1')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (20, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (21, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (23, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (29, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (36, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (37, N'1')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (45, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (46, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (47, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (48, N'1')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (50, N'X')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (52, N'X')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (55, N'X')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (61, N'1')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (63, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (64, N'1')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (65, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (67, N'1')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (69, N'X')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (71, N'1')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (74, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (75, N'X')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (77, N'1')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (79, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (80, N'X')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (81, N'X')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (83, N'1')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (87, N'X')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (92, N'1')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (97, N'2')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (98, N'X')
INSERT [dbo].[GanadoresPartidos] ([IDApuesta], [Resultado]) VALUES (100, N'1')
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (13, -2)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (14, 2)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (15, 3)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (17, -3)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (22, -1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (25, 2)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (26, -2)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (32, -2)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (35, 1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (42, 1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (43, 2)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (44, -1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (49, -3)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (51, 1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (54, 3)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (58, 2)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (59, -3)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (60, -3)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (62, -1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (66, 1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (68, -3)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (70, 1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (72, 1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (73, -1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (76, 2)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (78, 1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (84, -1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (85, 3)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (86, -1)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (89, -2)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (94, -2)
INSERT [dbo].[Handicaps] ([IDApuesta], [Handicap]) VALUES (95, -2)
SET IDENTITY_INSERT [dbo].[Movimientos] ON 

INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (1, 17, -96.0000, CAST(N'2021-01-03' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (2, 17, 343.6800, CAST(N'2021-01-03' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (3, 18, -135.0000, CAST(N'2020-08-25' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (4, 25, -67.0000, CAST(N'2020-10-14' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (5, 15, -63.0000, CAST(N'2020-11-08' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (6, 43, -67.0000, CAST(N'2020-12-26' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (7, 36, -174.0000, CAST(N'2020-10-09' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (8, 43, -77.0000, CAST(N'2020-10-11' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (9, 43, 276.4300, CAST(N'2020-10-11' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (10, 15, -86.0000, CAST(N'2020-09-17' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (11, 41, -176.0000, CAST(N'2020-10-30' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (12, 37, -179.0000, CAST(N'2020-10-08' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (13, 26, -80.0000, CAST(N'2020-08-29' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (14, 26, 700.0000, CAST(N'2020-08-29' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (15, 18, -186.0000, CAST(N'2020-12-09' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (16, 18, 513.3600, CAST(N'2020-12-09' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (17, 48, -172.0000, CAST(N'2020-08-26' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (18, 49, -197.0000, CAST(N'2020-12-14' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (19, 5, -142.0000, CAST(N'2020-10-09' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (20, 48, -113.0000, CAST(N'2020-10-09' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (21, 28, -139.0000, CAST(N'2020-08-24' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (22, 20, -135.0000, CAST(N'2020-11-17' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (23, 27, -108.0000, CAST(N'2020-11-07' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (24, 27, 181.4400, CAST(N'2020-11-07' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (25, 35, -171.0000, CAST(N'2020-12-25' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (26, 40, -169.0000, CAST(N'2020-10-06' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (27, 5, -163.0000, CAST(N'2021-01-19' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (28, 5, 497.1500, CAST(N'2021-01-19' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (29, 32, -85.0000, CAST(N'2020-10-29' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (30, 32, 349.3500, CAST(N'2020-10-29' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (31, 50, -158.0000, CAST(N'2020-12-16' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (32, 50, 407.6400, CAST(N'2020-12-16' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (33, 19, -167.0000, CAST(N'2020-12-22' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (34, 3, -81.0000, CAST(N'2021-01-19' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (35, 38, -88.0000, CAST(N'2020-10-13' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (36, 38, 589.6000, CAST(N'2020-10-13' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (37, 17, -64.0000, CAST(N'2020-12-18' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (38, 35, -173.0000, CAST(N'2020-12-22' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (39, 37, -84.0000, CAST(N'2020-10-07' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (40, 37, 708.9600, CAST(N'2020-10-07' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (41, 50, -73.0000, CAST(N'2020-10-10' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (42, 50, 610.2800, CAST(N'2020-10-10' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (43, 33, -99.0000, CAST(N'2020-09-04' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (44, 27, -61.0000, CAST(N'2020-12-13' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (45, 27, 534.3600, CAST(N'2020-12-13' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (46, 28, -64.0000, CAST(N'2021-01-16' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (47, 28, 503.6800, CAST(N'2021-01-16' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (48, 15, -66.0000, CAST(N'2020-10-28' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (49, 43, -156.0000, CAST(N'2020-11-10' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (50, 11, -77.0000, CAST(N'2020-12-14' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (51, 11, 301.8400, CAST(N'2020-12-14' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (52, 34, -188.0000, CAST(N'2020-11-12' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (53, 17, -117.0000, CAST(N'2020-10-09' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (54, 10, -134.0000, CAST(N'2020-11-23' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (55, 46, -99.0000, CAST(N'2020-11-30' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (56, 46, 724.6800, CAST(N'2020-11-30' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (57, 3, -96.0000, CAST(N'2020-11-11' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (58, 31, -142.0000, CAST(N'2020-08-27' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (59, 14, -186.0000, CAST(N'2020-10-07' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (60, 13, -183.0000, CAST(N'2021-01-05' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (61, 47, -189.0000, CAST(N'2020-12-13' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (62, 47, 771.1200, CAST(N'2020-12-13' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (63, 4, -105.0000, CAST(N'2020-12-23' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (64, 3, -88.0000, CAST(N'2020-11-04' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (65, 3, 506.8800, CAST(N'2020-11-04' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (66, 47, -137.0000, CAST(N'2020-11-09' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (67, 29, -124.0000, CAST(N'2020-10-21' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (68, 29, 595.2000, CAST(N'2020-10-21' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (69, 18, -124.0000, CAST(N'2020-12-29' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (70, 18, 983.3200, CAST(N'2020-12-29' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (71, 25, -160.0000, CAST(N'2020-09-21' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (72, 25, 960.0000, CAST(N'2020-09-21' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (73, 50, -115.0000, CAST(N'2021-01-04' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (74, 13, -195.0000, CAST(N'2020-11-14' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (75, 45, -133.0000, CAST(N'2020-12-12' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (76, 30, -102.0000, CAST(N'2020-11-21' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (77, 30, 747.6600, CAST(N'2020-11-21' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (78, 12, -139.0000, CAST(N'2020-09-24' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (79, 12, 608.8200, CAST(N'2020-09-24' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (80, 12, -174.0000, CAST(N'2021-01-15' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (81, 11, -91.0000, CAST(N'2020-12-06' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (82, 7, -85.0000, CAST(N'2020-09-23' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (83, 19, -173.0000, CAST(N'2020-11-10' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (84, 19, 1133.1500, CAST(N'2020-11-10' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (85, 9, -84.0000, CAST(N'2021-01-23' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (86, 16, -54.0000, CAST(N'2020-11-15' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (87, 15, -92.0000, CAST(N'2021-01-18' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (88, 15, 798.5600, CAST(N'2021-01-18' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (89, 26, -183.0000, CAST(N'2020-10-02' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (90, 20, -170.0000, CAST(N'2020-09-22' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (91, 48, -198.0000, CAST(N'2020-12-11' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (92, 9, -173.0000, CAST(N'2020-08-30' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (93, 16, -99.0000, CAST(N'2020-08-26' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (94, 19, -57.0000, CAST(N'2020-12-07' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (95, 17, -162.0000, CAST(N'2020-11-14' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (96, 17, 1568.1600, CAST(N'2020-11-14' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (97, 27, -142.0000, CAST(N'2021-01-09' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (98, 50, -106.0000, CAST(N'2020-10-17' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (99, 50, 348.7400, CAST(N'2020-10-17' AS Date))
GO
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (100, 30, -164.0000, CAST(N'2020-12-27' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (101, 30, 229.6000, CAST(N'2020-12-27' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (102, 5, -89.0000, CAST(N'2020-12-17' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (103, 34, -157.0000, CAST(N'2020-09-21' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (104, 19, -83.0000, CAST(N'2020-12-20' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (105, 36, -124.0000, CAST(N'2020-12-23' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (106, 45, -182.0000, CAST(N'2020-10-13' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (107, 8, -86.0000, CAST(N'2020-08-25' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (108, 31, -141.0000, CAST(N'2020-12-30' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (109, 2, -65.0000, CAST(N'2020-11-04' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (110, 2, -118.0000, CAST(N'2020-09-06' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (111, 23, -126.0000, CAST(N'2020-08-26' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (112, 23, 797.5800, CAST(N'2020-08-26' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (113, 23, -67.0000, CAST(N'2021-01-19' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (114, 45, -129.0000, CAST(N'2020-11-09' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (115, 50, -132.0000, CAST(N'2020-10-28' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (116, 1, -141.0000, CAST(N'2020-12-28' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (117, 1, 743.0700, CAST(N'2020-12-28' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (118, 14, -60.0000, CAST(N'2021-01-02' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (119, 6, -88.0000, CAST(N'2020-12-04' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (120, 6, 871.2000, CAST(N'2020-12-04' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (121, 20, -135.0000, CAST(N'2020-12-26' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (122, 22, -183.0000, CAST(N'2020-08-30' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (123, 20, -101.0000, CAST(N'2020-11-11' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (124, 12, -62.0000, CAST(N'2020-11-05' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (125, 30, -162.0000, CAST(N'2020-08-29' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (126, 8, -138.0000, CAST(N'2020-11-11' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (127, 1, -135.0000, CAST(N'2021-01-02' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (128, 46, -126.0000, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (129, 46, 279.7200, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (130, 18, -140.0000, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (131, 18, 1398.6000, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (132, 14, -169.0000, CAST(N'2021-01-21' AS Date))
INSERT [dbo].[Movimientos] ([ID], [ID_usuario], [Dinero], [Fecha]) VALUES (133, 14, 1492.2700, CAST(N'2021-01-21' AS Date))
SET IDENTITY_INSERT [dbo].[Movimientos] OFF
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (1, 1, CAST(0.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (2, 1, CAST(3.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (3, 0, CAST(1.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (7, 0, CAST(2.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (8, 1, CAST(4.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (9, 0, CAST(0.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (10, 0, CAST(0.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (11, 0, CAST(0.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (19, 0, CAST(1.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (24, 1, CAST(4.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (27, 0, CAST(2.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (28, 0, CAST(0.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (30, 1, CAST(2.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (31, 0, CAST(5.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (33, 0, CAST(3.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (34, 0, CAST(5.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (38, 0, CAST(1.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (39, 0, CAST(2.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (40, 1, CAST(5.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (41, 0, CAST(2.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (53, 1, CAST(4.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (56, 1, CAST(0.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (57, 0, CAST(5.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (82, 1, CAST(5.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (88, 1, CAST(2.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (90, 1, CAST(2.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (91, 0, CAST(0.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (93, 0, CAST(1.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (96, 1, CAST(2.5 AS Decimal(2, 1)))
INSERT [dbo].[OversUnders] ([IDApuesta], [Over/Under], [Numero]) VALUES (99, 1, CAST(1.5 AS Decimal(2, 1)))
SET IDENTITY_INSERT [dbo].[Partidos] ON 

INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (1, N'AJAX', N'BARC', 0, 0, 0, CAST(N'2021-04-08T20:00:00' AS SmallDateTime), 1985.4800, 4726.7700, 4083.5600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (2, N'AJAX', N'BAYM', 1, 2, 1, CAST(N'2020-11-01T17:00:00' AS SmallDateTime), 9241.3300, 7262.6700, 4922.8600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (3, N'AJAX', N'BENF', 3, 0, 1, CAST(N'2020-10-13T19:00:00' AS SmallDateTime), 5631.2200, 6971.6000, 4413.1300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (4, N'AJAX', N'BODO', 0, 0, 0, CAST(N'2021-08-07T13:00:00' AS SmallDateTime), 2437.5600, 4783.7900, 4975.8000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (5, N'AJAX', N'CSKM', 0, 1, 1, CAST(N'2020-10-13T19:00:00' AS SmallDateTime), 4036.7200, 8870.5300, 1624.8200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (6, N'AJAX', N'GTFE', 0, 0, 0, CAST(N'2021-04-06T21:00:00' AS SmallDateTime), 8809.3600, 3509.7000, 5605.2900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (7, N'AJAX', N'INTM', 0, 0, 0, CAST(N'2021-08-14T21:00:00' AS SmallDateTime), 3556.0000, 3692.9900, 4149.4600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (8, N'AJAX', N'JUVT', 3, 2, 1, CAST(N'2021-01-09T20:00:00' AS SmallDateTime), 8093.3500, 5835.1700, 5144.4500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (9, N'AJAX', N'LIVL', 0, 0, 0, CAST(N'2021-04-08T19:00:00' AS SmallDateTime), 7871.0700, 1733.0100, 7298.8600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (10, N'AJAX', N'MANC', 0, 0, 1, CAST(N'2021-01-11T18:00:00' AS SmallDateTime), 3340.5300, 2583.1500, 4639.2800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (11, N'AJAX', N'MANU', 0, 0, 0, CAST(N'2021-02-10T12:00:00' AS SmallDateTime), 1915.2400, 6141.5300, 1012.2800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (12, N'AJAX', N'OLYL', 0, 0, 0, CAST(N'2021-03-21T18:00:00' AS SmallDateTime), 7612.2400, 4245.5100, 3937.7400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (13, N'AJAX', N'OPRT', 0, 0, 0, CAST(N'2021-02-04T18:00:00' AS SmallDateTime), 5586.0500, 8381.7600, 9527.8300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (14, N'AJAX', N'PASG', 0, 0, 0, CAST(N'2021-06-14T20:00:00' AS SmallDateTime), 4024.0400, 5196.3300, 8263.5300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (15, N'AJAX', N'RBET', 2, 1, 1, CAST(N'2020-11-17T17:00:00' AS SmallDateTime), 4071.7200, 4112.7700, 1337.8500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (16, N'AJAX', N'RMAD', 1, 1, 1, CAST(N'2020-10-13T17:00:00' AS SmallDateTime), 9864.7600, 1627.4000, 3137.1700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (17, N'AJAX', N'ROMA', 0, 2, 1, CAST(N'2020-12-13T13:00:00' AS SmallDateTime), 5920.3100, 3540.4300, 5417.2900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (18, N'BARC', N'AJAX', 3, 2, 1, CAST(N'2020-12-27T15:00:00' AS SmallDateTime), 4739.4800, 4973.8100, 5077.8800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (19, N'BARC', N'BAYM', 0, 0, 0, CAST(N'2021-08-05T20:00:00' AS SmallDateTime), 1235.7400, 3730.9300, 1120.9500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (20, N'BARC', N'BENF', 0, 0, 0, CAST(N'2021-05-06T21:00:00' AS SmallDateTime), 7935.3600, 5982.0500, 7960.9700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (21, N'BARC', N'BODO', 0, 1, 1, CAST(N'2020-09-19T16:00:00' AS SmallDateTime), 5192.3100, 9641.1600, 1089.6500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (22, N'BARC', N'CSKM', 3, 1, 1, CAST(N'2021-01-02T15:00:00' AS SmallDateTime), 2210.1600, 8022.0100, 1436.0300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (23, N'BARC', N'GTFE', 0, 0, 0, CAST(N'2021-03-02T20:00:00' AS SmallDateTime), 6444.3200, 2379.1500, 6198.4100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (24, N'BARC', N'INTM', 3, 1, 1, CAST(N'2020-10-27T12:00:00' AS SmallDateTime), 6035.0900, 4664.1600, 7984.3000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (25, N'BARC', N'JUVT', 0, 0, 0, CAST(N'2021-03-06T19:00:00' AS SmallDateTime), 1572.5200, 5956.5900, 3426.6200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (26, N'BARC', N'LIVL', 2, 2, 1, CAST(N'2021-01-07T20:00:00' AS SmallDateTime), 9626.0000, 3454.1100, 7020.2800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (27, N'BARC', N'MANC', 0, 0, 0, CAST(N'2021-07-22T16:00:00' AS SmallDateTime), 5240.0900, 8743.0300, 7445.4300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (28, N'BARC', N'MANU', 3, 0, 1, CAST(N'2020-11-02T20:00:00' AS SmallDateTime), 2971.6800, 6433.2900, 3912.1800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (29, N'BARC', N'OLYL', 0, 0, 0, CAST(N'2021-01-30T16:00:00' AS SmallDateTime), 4090.0800, 1348.3300, 9494.4500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (30, N'BARC', N'OPRT', 0, 0, 1, CAST(N'2020-12-09T14:00:00' AS SmallDateTime), 6957.8600, 7869.7800, 2350.3000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (31, N'BARC', N'PASG', 0, 0, 0, CAST(N'2021-06-11T15:00:00' AS SmallDateTime), 2578.3200, 3295.3900, 9628.7900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (32, N'BARC', N'RBET', 3, 2, 1, CAST(N'2020-12-17T19:00:00' AS SmallDateTime), 3902.4400, 4901.5100, 4267.2300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (33, N'BARC', N'RMAD', 0, 0, 0, CAST(N'2021-06-21T15:00:00' AS SmallDateTime), 5375.1500, 7801.0300, 8810.9400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (34, N'BARC', N'ROMA', 0, 0, 0, CAST(N'2021-04-29T14:00:00' AS SmallDateTime), 1370.7800, 1157.2400, 3920.4100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (35, N'BAYM', N'AJAX', 0, 0, 0, CAST(N'2021-07-01T15:00:00' AS SmallDateTime), 4314.2300, 2131.1000, 7623.3600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (36, N'BAYM', N'BARC', 1, 1, 1, CAST(N'2020-11-15T14:00:00' AS SmallDateTime), 6812.5900, 3772.2400, 2153.5000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (37, N'BAYM', N'BENF', 0, 0, 0, CAST(N'2021-08-23T15:00:00' AS SmallDateTime), 8991.5500, 2990.0100, 7780.9500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (38, N'BAYM', N'BODO', 0, 0, 1, CAST(N'2021-01-14T16:00:00' AS SmallDateTime), 6021.6600, 2394.5700, 6472.1600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (39, N'BAYM', N'CSKM', 0, 0, 0, CAST(N'2021-04-13T18:00:00' AS SmallDateTime), 6994.0300, 4528.5100, 2974.8300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (40, N'BAYM', N'GTFE', 0, 0, 0, CAST(N'2021-07-03T14:00:00' AS SmallDateTime), 1974.0800, 8417.1700, 7212.3900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (41, N'BAYM', N'INTM', 0, 0, 0, CAST(N'2021-03-01T18:00:00' AS SmallDateTime), 5729.9900, 1484.3200, 6406.5500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (42, N'BAYM', N'JUVT', 1, 1, 1, CAST(N'2020-11-17T17:00:00' AS SmallDateTime), 9350.3200, 5103.2800, 1918.8000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (43, N'BAYM', N'LIVL', 3, 1, 1, CAST(N'2020-09-20T15:00:00' AS SmallDateTime), 1013.7600, 1463.8800, 2467.0300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (44, N'BAYM', N'MANC', 0, 0, 0, CAST(N'2021-04-01T12:00:00' AS SmallDateTime), 6351.4000, 7326.6500, 6162.9200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (45, N'BAYM', N'MANU', 0, 0, 0, CAST(N'2021-02-01T13:00:00' AS SmallDateTime), 6691.8100, 7714.6500, 3343.4200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (46, N'BAYM', N'OLYL', 0, 0, 0, CAST(N'2021-02-11T17:00:00' AS SmallDateTime), 6868.7400, 1608.7000, 7453.4100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (47, N'BAYM', N'OPRT', 0, 0, 0, CAST(N'2021-03-25T21:00:00' AS SmallDateTime), 8170.1400, 2579.2200, 5513.2000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (48, N'BAYM', N'PASG', 0, 0, 0, CAST(N'2021-03-15T17:00:00' AS SmallDateTime), 7887.8700, 9701.8100, 1923.3400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (49, N'BAYM', N'RBET', 2, 2, 1, CAST(N'2020-09-28T17:00:00' AS SmallDateTime), 2830.3800, 1910.9600, 8073.9700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (50, N'BAYM', N'RMAD', 0, 0, 0, CAST(N'2021-06-06T15:00:00' AS SmallDateTime), 1124.2600, 6647.0600, 4782.1200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (51, N'BAYM', N'ROMA', 1, 0, 1, CAST(N'2020-11-13T21:00:00' AS SmallDateTime), 7951.9000, 8155.1500, 2333.8300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (52, N'BENF', N'AJAX', 0, 0, 1, CAST(N'2020-12-03T20:00:00' AS SmallDateTime), 3660.7200, 5292.3800, 9678.2300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (53, N'BENF', N'BARC', 0, 0, 0, CAST(N'2021-03-07T15:00:00' AS SmallDateTime), 5927.0400, 7699.6900, 3890.3300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (54, N'BENF', N'BAYM', 2, 2, 1, CAST(N'2020-09-27T14:00:00' AS SmallDateTime), 7902.9300, 2326.3900, 5248.8200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (55, N'BENF', N'BODO', 3, 1, 1, CAST(N'2020-09-05T14:00:00' AS SmallDateTime), 4220.3100, 8872.4000, 1914.3800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (56, N'BENF', N'CSKM', 0, 0, 0, CAST(N'2021-04-01T13:00:00' AS SmallDateTime), 7349.2900, 4828.8800, 1038.2000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (57, N'BENF', N'GTFE', 1, 0, 1, CAST(N'2020-09-15T15:00:00' AS SmallDateTime), 2177.3900, 7113.7000, 6631.2000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (58, N'BENF', N'INTM', 0, 0, 0, CAST(N'2021-02-07T19:00:00' AS SmallDateTime), 3223.2600, 1535.9000, 2683.1100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (59, N'BENF', N'JUVT', 0, 0, 0, CAST(N'2021-04-22T14:00:00' AS SmallDateTime), 2568.7400, 7826.9200, 3763.3400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (60, N'BENF', N'LIVL', 0, 0, 0, CAST(N'2021-07-24T21:00:00' AS SmallDateTime), 6275.1800, 6010.7700, 1158.7600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (61, N'BENF', N'MANC', 0, 0, 0, CAST(N'2021-06-27T21:00:00' AS SmallDateTime), 8763.5000, 2498.7300, 6007.2000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (62, N'BENF', N'MANU', 0, 0, 0, CAST(N'2021-03-14T17:00:00' AS SmallDateTime), 8370.0200, 1655.6600, 4204.7700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (63, N'BENF', N'OLYL', 0, 0, 0, CAST(N'2021-08-27T13:00:00' AS SmallDateTime), 7071.3400, 1085.2900, 2697.7800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (64, N'BENF', N'OPRT', 3, 0, 1, CAST(N'2020-08-28T20:00:00' AS SmallDateTime), 3177.2000, 1386.1700, 3828.8500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (65, N'BENF', N'PASG', 0, 0, 0, CAST(N'2021-04-21T16:00:00' AS SmallDateTime), 4739.2800, 2771.6500, 1666.0300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (66, N'BENF', N'RBET', 0, 0, 0, CAST(N'2021-03-22T15:00:00' AS SmallDateTime), 6475.0300, 7581.7100, 1785.7700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (67, N'BENF', N'RMAD', 0, 0, 0, CAST(N'2021-07-06T17:00:00' AS SmallDateTime), 2139.3600, 6476.7300, 3597.8500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (68, N'BENF', N'ROMA', 0, 0, 0, CAST(N'2021-05-01T12:00:00' AS SmallDateTime), 3398.6400, 1357.9700, 8777.9400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (69, N'BODO', N'AJAX', 0, 0, 0, CAST(N'2021-02-01T14:00:00' AS SmallDateTime), 4140.9400, 9750.8600, 8983.0200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (70, N'BODO', N'BARC', 0, 1, 1, CAST(N'2020-12-29T16:00:00' AS SmallDateTime), 5810.3200, 8434.0200, 9413.5700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (71, N'BODO', N'BAYM', 0, 0, 0, CAST(N'2021-05-04T15:00:00' AS SmallDateTime), 5903.5100, 8393.8800, 6967.5400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (72, N'BODO', N'BENF', 3, 2, 1, CAST(N'2020-12-19T12:00:00' AS SmallDateTime), 9937.8000, 7208.9400, 4012.9400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (73, N'BODO', N'CSKM', 1, 2, 1, CAST(N'2020-08-31T19:00:00' AS SmallDateTime), 8986.0600, 1823.0600, 4202.9500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (74, N'BODO', N'GTFE', 0, 0, 0, CAST(N'2021-05-18T19:00:00' AS SmallDateTime), 7581.7100, 6195.0800, 3133.3800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (75, N'BODO', N'INTM', 0, 0, 0, CAST(N'2021-06-08T13:00:00' AS SmallDateTime), 9676.2200, 7605.1200, 4209.7500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (76, N'BODO', N'JUVT', 0, 0, 0, CAST(N'2021-04-30T20:00:00' AS SmallDateTime), 5125.8400, 8714.3900, 8087.1900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (77, N'BODO', N'LIVL', 2, 2, 1, CAST(N'2021-01-21T18:00:00' AS SmallDateTime), 7584.3600, 3646.4200, 5806.6300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (78, N'BODO', N'MANC', 2, 1, 1, CAST(N'2020-09-26T21:00:00' AS SmallDateTime), 6849.6400, 5001.6700, 4879.4500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (79, N'BODO', N'MANU', 0, 1, 1, CAST(N'2021-01-01T20:00:00' AS SmallDateTime), 4920.1200, 2856.5800, 2727.1900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (80, N'BODO', N'OLYL', 0, 0, 0, CAST(N'2021-04-21T18:00:00' AS SmallDateTime), 6294.9900, 5774.6300, 1605.9400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (81, N'BODO', N'OPRT', 0, 1, 1, CAST(N'2020-11-12T13:00:00' AS SmallDateTime), 7132.8900, 2748.4000, 9467.5700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (82, N'BODO', N'PASG', 2, 2, 1, CAST(N'2021-01-24T15:00:00' AS SmallDateTime), 7562.0600, 1278.2700, 2291.8100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (83, N'BODO', N'RBET', 0, 0, 0, CAST(N'2021-07-21T19:00:00' AS SmallDateTime), 4149.1600, 7923.6700, 7276.1900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (84, N'BODO', N'RMAD', 0, 0, 0, CAST(N'2021-08-05T21:00:00' AS SmallDateTime), 9217.2000, 9533.7700, 3071.8700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (85, N'BODO', N'ROMA', 0, 0, 1, CAST(N'2020-10-23T15:00:00' AS SmallDateTime), 2178.7700, 1172.7600, 1729.8600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (86, N'CSKM', N'AJAX', 2, 0, 1, CAST(N'2020-08-29T12:00:00' AS SmallDateTime), 3551.8500, 8548.9300, 3704.6000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (87, N'CSKM', N'BARC', 0, 0, 0, CAST(N'2021-04-22T16:00:00' AS SmallDateTime), 8042.8000, 2029.7300, 8948.1400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (88, N'CSKM', N'BAYM', 0, 0, 0, CAST(N'2021-02-24T12:00:00' AS SmallDateTime), 2439.4600, 4821.5000, 6683.4800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (89, N'CSKM', N'BENF', 0, 2, 1, CAST(N'2020-11-26T13:00:00' AS SmallDateTime), 2603.1700, 2187.8200, 2781.4400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (90, N'CSKM', N'BODO', 3, 2, 1, CAST(N'2020-11-10T18:00:00' AS SmallDateTime), 3582.5400, 9600.4700, 9511.3000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (91, N'CSKM', N'GTFE', 0, 0, 0, CAST(N'2021-02-07T16:00:00' AS SmallDateTime), 1046.0600, 7576.3000, 2967.6300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (92, N'CSKM', N'INTM', 3, 1, 1, CAST(N'2020-10-09T17:00:00' AS SmallDateTime), 3442.5000, 9787.3900, 2115.8300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (93, N'CSKM', N'JUVT', 0, 0, 0, CAST(N'2021-05-07T16:00:00' AS SmallDateTime), 3910.3100, 5398.6000, 7930.0000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (94, N'CSKM', N'LIVL', 0, 0, 0, CAST(N'2021-05-17T18:00:00' AS SmallDateTime), 7115.3300, 8854.3600, 5991.1300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (95, N'CSKM', N'MANC', 1, 1, 1, CAST(N'2020-09-25T16:00:00' AS SmallDateTime), 2450.9200, 7949.7500, 4182.0000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (96, N'CSKM', N'MANU', 0, 0, 0, CAST(N'2021-05-03T16:00:00' AS SmallDateTime), 5684.4000, 5125.0200, 7847.2600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (97, N'CSKM', N'OLYL', 1, 1, 1, CAST(N'2020-10-18T17:00:00' AS SmallDateTime), 6020.0400, 4195.4500, 5948.3500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (98, N'CSKM', N'OPRT', 3, 0, 1, CAST(N'2020-12-09T21:00:00' AS SmallDateTime), 3948.9000, 8537.4100, 9321.7600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (99, N'CSKM', N'PASG', 0, 0, 0, CAST(N'2021-03-22T21:00:00' AS SmallDateTime), 8337.5700, 6719.9900, 5971.0400)
GO
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (100, N'CSKM', N'RBET', 1, 0, 1, CAST(N'2020-12-05T12:00:00' AS SmallDateTime), 2314.5000, 1211.9300, 5736.7500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (101, N'CSKM', N'RMAD', 0, 0, 1, CAST(N'2020-09-01T20:00:00' AS SmallDateTime), 1062.1900, 7054.6300, 2801.6900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (102, N'CSKM', N'ROMA', 3, 1, 1, CAST(N'2021-01-20T21:00:00' AS SmallDateTime), 2341.9600, 6165.3200, 1628.4100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (103, N'GTFE', N'AJAX', 3, 0, 1, CAST(N'2020-11-04T16:00:00' AS SmallDateTime), 1417.3700, 5665.3500, 5778.1700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (104, N'GTFE', N'BARC', 0, 0, 0, CAST(N'2021-01-29T14:00:00' AS SmallDateTime), 4488.1400, 3360.6300, 3679.7600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (105, N'GTFE', N'BAYM', 0, 0, 0, CAST(N'2021-03-13T12:00:00' AS SmallDateTime), 6214.3100, 4825.6500, 5981.1000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (106, N'GTFE', N'BENF', 2, 0, 1, CAST(N'2020-10-07T16:00:00' AS SmallDateTime), 1028.4100, 8242.5100, 1756.8700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (107, N'GTFE', N'BODO', 0, 0, 0, CAST(N'2021-06-19T19:00:00' AS SmallDateTime), 8017.9000, 1428.8300, 8473.4600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (108, N'GTFE', N'CSKM', 0, 0, 0, CAST(N'2021-03-28T21:00:00' AS SmallDateTime), 8291.2000, 4167.5400, 6174.4600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (109, N'GTFE', N'INTM', 0, 0, 0, CAST(N'2021-03-10T18:00:00' AS SmallDateTime), 2931.2500, 5061.4000, 1384.6200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (110, N'GTFE', N'JUVT', 0, 0, 0, CAST(N'2021-07-06T17:00:00' AS SmallDateTime), 1924.9300, 5639.7300, 5000.0400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (111, N'GTFE', N'LIVL', 0, 0, 0, CAST(N'2021-05-25T20:00:00' AS SmallDateTime), 9833.0000, 9376.7300, 7090.9200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (112, N'GTFE', N'MANC', 0, 0, 0, CAST(N'2021-03-04T21:00:00' AS SmallDateTime), 2752.2700, 4402.8900, 5160.0900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (113, N'GTFE', N'MANU', 2, 0, 1, CAST(N'2020-12-09T13:00:00' AS SmallDateTime), 5471.1200, 2195.3000, 4005.1900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (114, N'GTFE', N'OLYL', 0, 0, 0, CAST(N'2021-07-09T16:00:00' AS SmallDateTime), 5418.6500, 4641.8800, 8168.3500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (115, N'GTFE', N'OPRT', 3, 1, 1, CAST(N'2020-11-15T20:00:00' AS SmallDateTime), 5070.5600, 4279.4800, 7088.3300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (116, N'GTFE', N'PASG', 0, 0, 0, CAST(N'2021-06-23T19:00:00' AS SmallDateTime), 7767.0400, 7326.4500, 2757.6400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (117, N'GTFE', N'RBET', 1, 1, 1, CAST(N'2020-11-13T18:00:00' AS SmallDateTime), 4106.7700, 3299.0900, 3167.6600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (118, N'GTFE', N'RMAD', 3, 2, 1, CAST(N'2020-11-18T15:00:00' AS SmallDateTime), 2094.5300, 4843.3600, 6206.6500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (119, N'GTFE', N'ROMA', 0, 0, 0, CAST(N'2021-07-13T13:00:00' AS SmallDateTime), 3174.8600, 9821.0600, 6934.2800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (120, N'INTM', N'AJAX', 0, 1, 1, CAST(N'2020-11-29T18:00:00' AS SmallDateTime), 3586.7100, 3420.2900, 8370.7200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (121, N'INTM', N'BARC', 3, 2, 1, CAST(N'2020-11-13T17:00:00' AS SmallDateTime), 5372.8600, 4548.7800, 1423.1300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (122, N'INTM', N'BAYM', 0, 0, 0, CAST(N'2021-08-01T16:00:00' AS SmallDateTime), 2380.5600, 9559.4400, 6607.4000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (123, N'INTM', N'BENF', 0, 0, 0, CAST(N'2021-06-16T14:00:00' AS SmallDateTime), 9013.1100, 9407.0600, 7211.4900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (124, N'INTM', N'BODO', 0, 0, 0, CAST(N'2021-07-14T14:00:00' AS SmallDateTime), 5669.5200, 8620.1000, 8144.3500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (125, N'INTM', N'CSKM', 2, 0, 1, CAST(N'2020-12-18T21:00:00' AS SmallDateTime), 1811.5800, 4470.1300, 4585.9900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (126, N'INTM', N'GTFE', 0, 0, 0, CAST(N'2021-01-30T19:00:00' AS SmallDateTime), 7025.2500, 2342.8400, 7306.1500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (127, N'INTM', N'JUVT', 0, 0, 0, CAST(N'2021-08-01T12:00:00' AS SmallDateTime), 4518.9000, 6358.2400, 5684.2100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (128, N'INTM', N'LIVL', 0, 0, 0, CAST(N'2021-04-26T14:00:00' AS SmallDateTime), 7572.0700, 3329.7800, 8686.8900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (129, N'INTM', N'MANC', 0, 0, 0, CAST(N'2021-03-23T20:00:00' AS SmallDateTime), 2309.2600, 3740.0800, 4607.6600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (130, N'INTM', N'MANU', 0, 1, 1, CAST(N'2020-12-09T20:00:00' AS SmallDateTime), 7651.0600, 3886.4300, 1299.2100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (131, N'INTM', N'OLYL', 0, 0, 0, CAST(N'2021-04-03T14:00:00' AS SmallDateTime), 5541.2000, 5222.0600, 8757.1300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (132, N'INTM', N'OPRT', 0, 0, 0, CAST(N'2021-06-30T19:00:00' AS SmallDateTime), 1410.6400, 5268.0900, 7974.6000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (133, N'INTM', N'PASG', 0, 0, 0, CAST(N'2021-03-11T18:00:00' AS SmallDateTime), 3749.3400, 8067.2900, 8370.6600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (134, N'INTM', N'RBET', 0, 0, 0, CAST(N'2021-04-29T20:00:00' AS SmallDateTime), 9530.7500, 1948.8300, 7469.8200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (135, N'INTM', N'RMAD', 0, 0, 0, CAST(N'2021-02-27T13:00:00' AS SmallDateTime), 2697.7400, 2958.1400, 1984.7600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (136, N'INTM', N'ROMA', 3, 0, 1, CAST(N'2020-10-04T15:00:00' AS SmallDateTime), 1986.9900, 3074.9000, 3914.6200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (137, N'JUVT', N'AJAX', 0, 1, 1, CAST(N'2020-12-27T18:00:00' AS SmallDateTime), 1443.4500, 7956.0400, 8989.0000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (138, N'JUVT', N'BARC', 0, 0, 0, CAST(N'2021-06-28T12:00:00' AS SmallDateTime), 1003.5000, 9519.6500, 6775.5300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (139, N'JUVT', N'BAYM', 3, 1, 1, CAST(N'2020-11-07T17:00:00' AS SmallDateTime), 2056.2200, 4490.6300, 8536.4100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (140, N'JUVT', N'BENF', 0, 1, 1, CAST(N'2020-11-01T18:00:00' AS SmallDateTime), 2178.6100, 1795.9400, 1164.9300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (141, N'JUVT', N'BODO', 0, 0, 0, CAST(N'2021-07-18T20:00:00' AS SmallDateTime), 8053.5800, 3174.1600, 4215.5100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (142, N'JUVT', N'CSKM', 0, 0, 0, CAST(N'2021-01-31T20:00:00' AS SmallDateTime), 5767.8300, 3878.3200, 9136.3700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (143, N'JUVT', N'GTFE', 0, 1, 1, CAST(N'2020-11-03T16:00:00' AS SmallDateTime), 6001.1900, 3246.4600, 6500.6000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (144, N'JUVT', N'INTM', 1, 0, 1, CAST(N'2021-01-06T19:00:00' AS SmallDateTime), 3940.0500, 3799.9700, 9412.3700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (145, N'JUVT', N'LIVL', 0, 0, 0, CAST(N'2021-07-10T13:00:00' AS SmallDateTime), 4099.4400, 6202.1900, 3928.2300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (146, N'JUVT', N'MANC', 2, 2, 1, CAST(N'2020-10-03T19:00:00' AS SmallDateTime), 8492.8000, 9764.8800, 7517.8500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (147, N'JUVT', N'MANU', 0, 0, 0, CAST(N'2021-03-30T20:00:00' AS SmallDateTime), 3711.0600, 2052.9200, 7155.2700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (148, N'JUVT', N'OLYL', 2, 0, 1, CAST(N'2020-10-12T21:00:00' AS SmallDateTime), 5527.4500, 6911.6000, 9203.5900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (149, N'JUVT', N'OPRT', 0, 0, 0, CAST(N'2021-02-10T20:00:00' AS SmallDateTime), 7115.7000, 3381.8400, 6584.8100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (150, N'JUVT', N'PASG', 0, 0, 0, CAST(N'2021-06-11T13:00:00' AS SmallDateTime), 3830.8700, 3123.9500, 2742.8500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (151, N'JUVT', N'RBET', 0, 1, 1, CAST(N'2020-12-22T14:00:00' AS SmallDateTime), 8473.8900, 5648.5100, 5806.3000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (152, N'JUVT', N'RMAD', 2, 2, 1, CAST(N'2020-11-21T16:00:00' AS SmallDateTime), 6445.6600, 3490.6900, 8495.0700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (153, N'JUVT', N'ROMA', 0, 0, 0, CAST(N'2021-02-19T13:00:00' AS SmallDateTime), 2710.1200, 9935.2200, 2362.0800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (154, N'LIVL', N'AJAX', 0, 0, 0, CAST(N'2021-04-20T21:00:00' AS SmallDateTime), 9972.7700, 4173.5000, 5478.2800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (155, N'LIVL', N'BARC', 0, 0, 0, CAST(N'2021-05-01T15:00:00' AS SmallDateTime), 2656.5600, 1889.8300, 7676.6300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (156, N'LIVL', N'BAYM', 0, 0, 0, CAST(N'2021-07-04T15:00:00' AS SmallDateTime), 4413.1300, 8561.8300, 6161.5500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (157, N'LIVL', N'BENF', 0, 1, 1, CAST(N'2020-12-15T18:00:00' AS SmallDateTime), 9485.1900, 2962.1100, 1132.1500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (158, N'LIVL', N'BODO', 0, 0, 0, CAST(N'2021-08-19T12:00:00' AS SmallDateTime), 4328.9200, 8870.2300, 1230.8700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (159, N'LIVL', N'CSKM', 0, 0, 0, CAST(N'2021-06-29T13:00:00' AS SmallDateTime), 1037.5800, 6785.1600, 1320.5200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (160, N'LIVL', N'GTFE', 0, 0, 0, CAST(N'2021-01-27T15:00:00' AS SmallDateTime), 6927.0400, 1337.9500, 8498.2500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (161, N'LIVL', N'INTM', 0, 0, 0, CAST(N'2021-02-05T16:00:00' AS SmallDateTime), 7702.4300, 2713.7000, 7699.3400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (162, N'LIVL', N'JUVT', 3, 1, 1, CAST(N'2020-12-09T17:00:00' AS SmallDateTime), 9161.6600, 9795.6400, 1670.0900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (163, N'LIVL', N'MANC', 0, 0, 0, CAST(N'2021-07-24T19:00:00' AS SmallDateTime), 5729.8200, 7782.0300, 4438.8100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (164, N'LIVL', N'MANU', 0, 0, 0, CAST(N'2021-08-18T14:00:00' AS SmallDateTime), 4251.3000, 7049.8500, 7717.0300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (165, N'LIVL', N'OLYL', 1, 0, 1, CAST(N'2020-09-06T21:00:00' AS SmallDateTime), 2802.6800, 2036.4800, 1113.4600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (166, N'LIVL', N'OPRT', 1, 1, 1, CAST(N'2021-01-07T15:00:00' AS SmallDateTime), 4907.4500, 2364.8600, 2775.9500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (167, N'LIVL', N'PASG', 0, 0, 0, CAST(N'2021-05-10T17:00:00' AS SmallDateTime), 6171.0200, 7830.5200, 1786.6200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (168, N'LIVL', N'RBET', 0, 0, 0, CAST(N'2021-02-05T14:00:00' AS SmallDateTime), 5382.6800, 4489.0100, 9127.3900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (169, N'LIVL', N'RMAD', 0, 0, 0, CAST(N'2021-07-22T21:00:00' AS SmallDateTime), 5379.6300, 8128.4400, 2603.1200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (170, N'LIVL', N'ROMA', 0, 0, 0, CAST(N'2021-06-29T19:00:00' AS SmallDateTime), 6174.6400, 5942.9600, 6756.3000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (171, N'MANC', N'AJAX', 0, 0, 0, CAST(N'2021-06-28T15:00:00' AS SmallDateTime), 5936.9000, 8191.3500, 5208.0200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (172, N'MANC', N'BARC', 2, 2, 1, CAST(N'2020-12-29T21:00:00' AS SmallDateTime), 1726.2100, 2642.0100, 9338.5400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (173, N'MANC', N'BAYM', 1, 0, 1, CAST(N'2020-12-13T15:00:00' AS SmallDateTime), 1954.9300, 4009.6400, 3899.2100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (174, N'MANC', N'BENF', 0, 0, 0, CAST(N'2021-05-15T14:00:00' AS SmallDateTime), 5947.6100, 8111.3400, 2451.9200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (175, N'MANC', N'BODO', 1, 0, 1, CAST(N'2021-01-22T12:00:00' AS SmallDateTime), 8969.3400, 7150.5700, 8433.7200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (176, N'MANC', N'CSKM', 0, 0, 0, CAST(N'2021-05-13T12:00:00' AS SmallDateTime), 5914.8300, 3671.8200, 8795.9200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (177, N'MANC', N'GTFE', 0, 0, 0, CAST(N'2021-06-25T12:00:00' AS SmallDateTime), 8900.3100, 6874.4600, 2065.2900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (178, N'MANC', N'INTM', 1, 1, 1, CAST(N'2020-12-29T18:00:00' AS SmallDateTime), 3629.3800, 1979.3800, 3887.9800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (179, N'MANC', N'JUVT', 2, 0, 1, CAST(N'2020-12-12T20:00:00' AS SmallDateTime), 3709.5800, 2761.5400, 9569.2700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (180, N'MANC', N'LIVL', 3, 2, 1, CAST(N'2020-11-07T19:00:00' AS SmallDateTime), 2763.2600, 6311.5000, 9307.7700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (181, N'MANC', N'MANU', 0, 0, 0, CAST(N'2021-01-25T16:00:00' AS SmallDateTime), 9350.6700, 4712.6000, 6053.4200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (182, N'MANC', N'OLYL', 0, 0, 0, CAST(N'2021-01-28T15:00:00' AS SmallDateTime), 4146.9800, 2139.9100, 4646.1600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (183, N'MANC', N'OPRT', 0, 0, 0, CAST(N'2021-08-21T17:00:00' AS SmallDateTime), 2360.4200, 6666.8700, 9873.4900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (184, N'MANC', N'PASG', 1, 1, 1, CAST(N'2020-08-31T16:00:00' AS SmallDateTime), 4834.2100, 7694.4400, 6432.2500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (185, N'MANC', N'RBET', 0, 0, 1, CAST(N'2020-09-11T18:00:00' AS SmallDateTime), 8371.7700, 5852.0700, 4104.7400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (186, N'MANC', N'RMAD', 0, 0, 0, CAST(N'2021-05-03T16:00:00' AS SmallDateTime), 8421.4600, 6274.6200, 4665.7600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (187, N'MANC', N'ROMA', 3, 0, 1, CAST(N'2021-01-22T20:00:00' AS SmallDateTime), 1974.1300, 9634.3600, 1769.1300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (188, N'MANU', N'AJAX', 3, 1, 1, CAST(N'2020-10-16T20:00:00' AS SmallDateTime), 4551.2400, 8684.2300, 4268.2200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (189, N'MANU', N'BARC', 3, 2, 1, CAST(N'2020-11-26T17:00:00' AS SmallDateTime), 7911.1100, 2160.8900, 5900.5500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (190, N'MANU', N'BAYM', 0, 0, 0, CAST(N'2021-05-11T16:00:00' AS SmallDateTime), 8020.7100, 7948.6200, 3600.7900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (191, N'MANU', N'BENF', 0, 2, 1, CAST(N'2020-10-01T20:00:00' AS SmallDateTime), 2009.8200, 9038.0700, 9722.5500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (192, N'MANU', N'BODO', 0, 0, 0, CAST(N'2021-02-23T17:00:00' AS SmallDateTime), 2398.6800, 5141.1700, 2578.2700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (193, N'MANU', N'CSKM', 1, 0, 1, CAST(N'2020-09-15T19:00:00' AS SmallDateTime), 3539.0800, 4236.1200, 2704.4800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (194, N'MANU', N'GTFE', 0, 0, 0, CAST(N'2021-06-30T16:00:00' AS SmallDateTime), 6666.7200, 6145.6800, 7069.1300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (195, N'MANU', N'INTM', 0, 0, 0, CAST(N'2021-06-26T21:00:00' AS SmallDateTime), 1102.1000, 3550.3900, 8038.6400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (196, N'MANU', N'JUVT', 0, 0, 0, CAST(N'2021-04-30T12:00:00' AS SmallDateTime), 3812.9500, 5190.7400, 7752.3300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (197, N'MANU', N'LIVL', 3, 0, 1, CAST(N'2020-09-28T15:00:00' AS SmallDateTime), 7740.4700, 1386.5300, 6101.3700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (198, N'MANU', N'MANC', 0, 0, 0, CAST(N'2021-08-11T12:00:00' AS SmallDateTime), 9233.1200, 8614.8300, 4611.8900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (199, N'MANU', N'OLYL', 0, 1, 1, CAST(N'2021-01-14T12:00:00' AS SmallDateTime), 6198.4200, 7739.2300, 7744.4000)
GO
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (200, N'MANU', N'OPRT', 1, 2, 1, CAST(N'2020-12-24T12:00:00' AS SmallDateTime), 8074.9500, 1302.0500, 6774.7700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (201, N'MANU', N'PASG', 3, 1, 1, CAST(N'2021-01-07T18:00:00' AS SmallDateTime), 8513.5400, 2909.5800, 6668.1200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (202, N'MANU', N'RBET', 0, 0, 0, CAST(N'2021-03-20T19:00:00' AS SmallDateTime), 2752.2400, 8936.2900, 5402.0500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (203, N'MANU', N'RMAD', 0, 0, 0, CAST(N'2021-08-01T15:00:00' AS SmallDateTime), 5612.7500, 3397.1500, 5410.7800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (204, N'MANU', N'ROMA', 0, 0, 0, CAST(N'2021-03-31T12:00:00' AS SmallDateTime), 9511.8300, 9235.7900, 9844.0700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (205, N'OLYL', N'AJAX', 0, 0, 0, CAST(N'2021-04-13T19:00:00' AS SmallDateTime), 2786.0500, 2828.4200, 2432.1100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (206, N'OLYL', N'BARC', 0, 0, 0, CAST(N'2021-06-28T16:00:00' AS SmallDateTime), 6044.0100, 4111.5100, 9337.9400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (207, N'OLYL', N'BAYM', 0, 0, 1, CAST(N'2020-12-25T21:00:00' AS SmallDateTime), 8727.5500, 2318.2700, 2303.7100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (208, N'OLYL', N'BENF', 0, 0, 0, CAST(N'2021-08-03T14:00:00' AS SmallDateTime), 5002.9800, 3858.7000, 7258.9500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (209, N'OLYL', N'BODO', 2, 2, 1, CAST(N'2020-10-23T16:00:00' AS SmallDateTime), 3076.3900, 8216.6100, 8219.9500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (210, N'OLYL', N'CSKM', 0, 0, 0, CAST(N'2021-03-22T19:00:00' AS SmallDateTime), 6948.5200, 4994.3000, 1128.6400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (211, N'OLYL', N'GTFE', 0, 0, 0, CAST(N'2021-04-15T13:00:00' AS SmallDateTime), 1583.2900, 7670.2300, 3562.2400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (212, N'OLYL', N'INTM', 0, 0, 0, CAST(N'2021-04-22T19:00:00' AS SmallDateTime), 1530.5800, 5904.3800, 8498.9700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (213, N'OLYL', N'JUVT', 3, 0, 1, CAST(N'2020-12-29T17:00:00' AS SmallDateTime), 2353.4400, 2363.6500, 3976.9600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (214, N'OLYL', N'LIVL', 0, 0, 0, CAST(N'2021-04-22T18:00:00' AS SmallDateTime), 2012.0300, 6499.8200, 4805.9900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (215, N'OLYL', N'MANC', 0, 0, 0, CAST(N'2021-05-29T19:00:00' AS SmallDateTime), 3455.0500, 8063.3100, 6522.8100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (216, N'OLYL', N'MANU', 0, 0, 0, CAST(N'2021-04-02T12:00:00' AS SmallDateTime), 7402.8300, 9678.1200, 5632.1200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (217, N'OLYL', N'OPRT', 0, 0, 0, CAST(N'2021-06-05T19:00:00' AS SmallDateTime), 9999.6500, 3122.9000, 1058.8200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (218, N'OLYL', N'PASG', 0, 0, 0, CAST(N'2021-08-07T14:00:00' AS SmallDateTime), 3975.2000, 5026.8900, 1482.7800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (219, N'OLYL', N'RBET', 0, 1, 1, CAST(N'2020-08-30T17:00:00' AS SmallDateTime), 3727.3800, 5878.8500, 8480.4300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (220, N'OLYL', N'RMAD', 2, 1, 1, CAST(N'2021-01-09T16:00:00' AS SmallDateTime), 2232.0700, 4855.4500, 9854.1000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (221, N'OLYL', N'ROMA', 0, 0, 0, CAST(N'2021-05-23T12:00:00' AS SmallDateTime), 7800.5800, 2669.5000, 3325.9700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (222, N'OPRT', N'AJAX', 0, 1, 1, CAST(N'2020-10-13T16:00:00' AS SmallDateTime), 8197.8100, 1036.7100, 3560.8500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (223, N'OPRT', N'BARC', 0, 0, 0, CAST(N'2021-03-01T13:00:00' AS SmallDateTime), 2026.0700, 6842.4600, 6923.4500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (224, N'OPRT', N'BAYM', 0, 0, 0, CAST(N'2021-01-27T14:00:00' AS SmallDateTime), 4654.0000, 3593.8200, 4938.0200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (225, N'OPRT', N'BENF', 0, 0, 0, CAST(N'2021-02-22T21:00:00' AS SmallDateTime), 7867.0600, 6648.8600, 4470.4200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (226, N'OPRT', N'BODO', 2, 2, 1, CAST(N'2020-09-25T17:00:00' AS SmallDateTime), 5781.2800, 5953.6800, 7539.0100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (227, N'OPRT', N'CSKM', 0, 0, 0, CAST(N'2021-04-25T16:00:00' AS SmallDateTime), 9327.4000, 7117.9600, 1916.4500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (228, N'OPRT', N'GTFE', 2, 0, 1, CAST(N'2020-12-21T21:00:00' AS SmallDateTime), 2173.8200, 9655.1500, 8259.2600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (229, N'OPRT', N'INTM', 0, 2, 1, CAST(N'2020-10-07T21:00:00' AS SmallDateTime), 6556.0000, 4372.9400, 5350.7400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (230, N'OPRT', N'JUVT', 0, 2, 1, CAST(N'2020-10-06T12:00:00' AS SmallDateTime), 1140.8800, 2944.4800, 3982.1900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (231, N'OPRT', N'LIVL', 0, 0, 0, CAST(N'2021-08-07T15:00:00' AS SmallDateTime), 8631.1200, 4870.3800, 1609.6800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (232, N'OPRT', N'MANC', 2, 1, 1, CAST(N'2020-10-05T12:00:00' AS SmallDateTime), 4528.4100, 6797.6100, 5318.2900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (233, N'OPRT', N'MANU', 0, 0, 0, CAST(N'2021-05-22T18:00:00' AS SmallDateTime), 9944.4400, 7038.3800, 6632.6500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (234, N'OPRT', N'OLYL', 2, 2, 1, CAST(N'2021-01-04T18:00:00' AS SmallDateTime), 9026.2600, 1470.6600, 6501.9600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (235, N'OPRT', N'PASG', 1, 1, 1, CAST(N'2020-10-01T12:00:00' AS SmallDateTime), 2378.4300, 5307.1500, 2903.3800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (236, N'OPRT', N'RBET', 0, 1, 1, CAST(N'2020-09-24T17:00:00' AS SmallDateTime), 9087.9100, 9695.2700, 2684.7200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (237, N'OPRT', N'RMAD', 0, 2, 1, CAST(N'2020-10-05T15:00:00' AS SmallDateTime), 8428.4600, 1404.7900, 5916.7200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (238, N'OPRT', N'ROMA', 1, 1, 1, CAST(N'2020-11-08T13:00:00' AS SmallDateTime), 3751.2300, 2140.9900, 8287.0200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (239, N'PASG', N'AJAX', 3, 1, 1, CAST(N'2020-11-16T16:00:00' AS SmallDateTime), 5994.0800, 6777.9500, 9771.1900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (240, N'PASG', N'BARC', 0, 0, 0, CAST(N'2021-04-19T19:00:00' AS SmallDateTime), 2394.8000, 9646.8100, 6085.1300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (241, N'PASG', N'BAYM', 0, 0, 0, CAST(N'2021-08-07T15:00:00' AS SmallDateTime), 6809.3500, 2342.2100, 7337.9800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (242, N'PASG', N'BENF', 0, 0, 0, CAST(N'2021-01-29T21:00:00' AS SmallDateTime), 2658.0300, 8500.0900, 3858.9800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (243, N'PASG', N'BODO', 0, 0, 0, CAST(N'2021-04-15T13:00:00' AS SmallDateTime), 8777.6500, 8351.8400, 7842.7900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (244, N'PASG', N'CSKM', 0, 0, 1, CAST(N'2020-10-07T20:00:00' AS SmallDateTime), 8402.6200, 3589.5900, 4266.9900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (245, N'PASG', N'GTFE', 0, 0, 0, CAST(N'2021-07-09T17:00:00' AS SmallDateTime), 9488.3300, 8808.3600, 9241.4300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (246, N'PASG', N'INTM', 0, 1, 1, CAST(N'2020-09-13T15:00:00' AS SmallDateTime), 8448.0100, 8549.5600, 1416.3900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (247, N'PASG', N'JUVT', 0, 0, 0, CAST(N'2021-08-17T19:00:00' AS SmallDateTime), 1180.2800, 5093.7800, 5994.0600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (248, N'PASG', N'LIVL', 0, 0, 0, CAST(N'2021-04-22T21:00:00' AS SmallDateTime), 7715.8800, 2528.5500, 6907.8300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (249, N'PASG', N'MANC', 3, 2, 1, CAST(N'2020-12-24T17:00:00' AS SmallDateTime), 7068.6000, 7085.5400, 6277.2500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (250, N'PASG', N'MANU', 0, 0, 1, CAST(N'2020-10-16T15:00:00' AS SmallDateTime), 5072.0800, 5067.2300, 9355.1800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (251, N'PASG', N'OLYL', 0, 0, 0, CAST(N'2021-05-02T17:00:00' AS SmallDateTime), 5103.8100, 6151.3000, 6881.3600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (252, N'PASG', N'OPRT', 3, 2, 1, CAST(N'2020-12-30T17:00:00' AS SmallDateTime), 4999.0700, 6750.9400, 2292.1600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (253, N'PASG', N'RBET', 3, 1, 1, CAST(N'2020-11-06T18:00:00' AS SmallDateTime), 6859.8300, 4538.1700, 3583.0500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (254, N'PASG', N'RMAD', 0, 0, 0, CAST(N'2021-06-09T15:00:00' AS SmallDateTime), 1340.8300, 8539.6000, 1889.2200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (255, N'PASG', N'ROMA', 2, 2, 1, CAST(N'2020-10-24T12:00:00' AS SmallDateTime), 6788.3100, 2055.4300, 6662.1900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (256, N'RBET', N'AJAX', 0, 0, 0, CAST(N'2021-07-21T17:00:00' AS SmallDateTime), 7002.9500, 8324.4100, 8257.1900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (257, N'RBET', N'BARC', 0, 0, 0, CAST(N'2021-06-13T15:00:00' AS SmallDateTime), 3075.7200, 4523.9400, 5954.5800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (258, N'RBET', N'BAYM', 0, 0, 1, CAST(N'2020-09-03T16:00:00' AS SmallDateTime), 6873.6800, 2313.9000, 1235.0800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (259, N'RBET', N'BENF', 3, 0, 1, CAST(N'2020-10-11T20:00:00' AS SmallDateTime), 8140.9900, 8699.3100, 4365.6300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (260, N'RBET', N'BODO', 0, 0, 0, CAST(N'2021-05-02T14:00:00' AS SmallDateTime), 5370.7500, 9044.5400, 8597.9900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (261, N'RBET', N'CSKM', 0, 0, 0, CAST(N'2021-07-15T12:00:00' AS SmallDateTime), 6522.9300, 7031.7100, 7428.6200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (262, N'RBET', N'GTFE', 2, 0, 1, CAST(N'2020-12-30T14:00:00' AS SmallDateTime), 4424.0400, 5166.2400, 9914.4200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (263, N'RBET', N'INTM', 0, 0, 0, CAST(N'2021-04-22T15:00:00' AS SmallDateTime), 1469.4300, 1549.9900, 6695.0800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (264, N'RBET', N'JUVT', 3, 1, 1, CAST(N'2020-11-26T21:00:00' AS SmallDateTime), 6042.1100, 7698.7100, 2203.4600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (265, N'RBET', N'LIVL', 0, 0, 0, CAST(N'2021-08-17T21:00:00' AS SmallDateTime), 6575.0200, 9855.5900, 2918.3400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (266, N'RBET', N'MANC', 0, 0, 0, CAST(N'2021-07-14T15:00:00' AS SmallDateTime), 2161.8800, 1958.9700, 2377.3500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (267, N'RBET', N'MANU', 1, 1, 1, CAST(N'2021-01-21T19:00:00' AS SmallDateTime), 4459.0500, 1175.3400, 6737.6800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (268, N'RBET', N'OLYL', 0, 0, 0, CAST(N'2021-06-20T18:00:00' AS SmallDateTime), 3016.0800, 9173.4700, 6311.6100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (269, N'RBET', N'OPRT', 0, 1, 1, CAST(N'2020-10-14T16:00:00' AS SmallDateTime), 9194.4300, 6196.0300, 3838.3100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (270, N'RBET', N'PASG', 0, 0, 0, CAST(N'2021-05-20T21:00:00' AS SmallDateTime), 6628.6400, 9132.1800, 7538.5000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (271, N'RBET', N'RMAD', 1, 2, 1, CAST(N'2020-12-07T19:00:00' AS SmallDateTime), 4008.3100, 5315.6300, 3401.7400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (272, N'RBET', N'ROMA', 0, 0, 0, CAST(N'2021-08-18T16:00:00' AS SmallDateTime), 9319.6300, 4260.5000, 7269.6100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (273, N'RMAD', N'AJAX', 0, 0, 0, CAST(N'2021-01-31T20:00:00' AS SmallDateTime), 9333.3500, 2963.3700, 1858.2100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (274, N'RMAD', N'BARC', 0, 0, 0, CAST(N'2021-07-30T19:00:00' AS SmallDateTime), 8437.2100, 3393.1700, 4815.6200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (275, N'RMAD', N'BAYM', 0, 0, 0, CAST(N'2021-04-16T12:00:00' AS SmallDateTime), 5349.8600, 3941.2400, 9701.1700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (276, N'RMAD', N'BENF', 0, 0, 0, CAST(N'2021-02-13T14:00:00' AS SmallDateTime), 1542.5600, 8909.0200, 6034.6300)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (277, N'RMAD', N'BODO', 0, 0, 0, CAST(N'2021-03-03T12:00:00' AS SmallDateTime), 2489.2800, 4928.0400, 9471.2200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (278, N'RMAD', N'CSKM', 0, 1, 1, CAST(N'2020-11-12T21:00:00' AS SmallDateTime), 1797.1600, 6288.2700, 5157.0500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (279, N'RMAD', N'GTFE', 0, 2, 1, CAST(N'2020-10-09T21:00:00' AS SmallDateTime), 6841.2000, 5955.9200, 9968.2100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (280, N'RMAD', N'INTM', 0, 0, 0, CAST(N'2021-06-06T15:00:00' AS SmallDateTime), 7352.3400, 7684.4500, 4672.0200)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (281, N'RMAD', N'JUVT', 0, 0, 0, CAST(N'2021-05-29T13:00:00' AS SmallDateTime), 8621.0600, 9892.0500, 9737.5900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (282, N'RMAD', N'LIVL', 0, 0, 0, CAST(N'2021-02-17T12:00:00' AS SmallDateTime), 4668.8500, 9301.3200, 1540.7700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (283, N'RMAD', N'MANC', 2, 0, 1, CAST(N'2020-10-19T14:00:00' AS SmallDateTime), 2136.0500, 6543.8600, 3427.6900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (284, N'RMAD', N'MANU', 0, 0, 0, CAST(N'2021-05-24T12:00:00' AS SmallDateTime), 9028.4300, 7375.4500, 8141.4900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (285, N'RMAD', N'OLYL', 3, 0, 1, CAST(N'2020-12-11T18:00:00' AS SmallDateTime), 4959.5500, 2619.2400, 8606.6400)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (286, N'RMAD', N'OPRT', 0, 0, 0, CAST(N'2021-07-14T12:00:00' AS SmallDateTime), 1846.5600, 3994.5500, 6246.4100)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (287, N'RMAD', N'PASG', 0, 0, 0, CAST(N'2021-03-23T16:00:00' AS SmallDateTime), 3411.2800, 9940.3600, 2887.6900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (288, N'RMAD', N'RBET', 0, 0, 0, CAST(N'2021-05-26T12:00:00' AS SmallDateTime), 1606.7900, 6600.3100, 6547.8800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (289, N'RMAD', N'ROMA', 0, 0, 0, CAST(N'2021-08-16T18:00:00' AS SmallDateTime), 8371.4000, 7216.6500, 4121.8800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (290, N'ROMA', N'AJAX', 0, 0, 0, CAST(N'2021-04-25T12:00:00' AS SmallDateTime), 8057.2300, 1614.5100, 8079.5000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (291, N'ROMA', N'BARC', 0, 0, 0, CAST(N'2021-07-08T19:00:00' AS SmallDateTime), 4267.4900, 7149.6200, 5016.4500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (292, N'ROMA', N'BAYM', 0, 0, 0, CAST(N'2021-02-15T19:00:00' AS SmallDateTime), 7018.8000, 2047.4200, 1866.7700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (293, N'ROMA', N'BENF', 0, 0, 0, CAST(N'2021-05-12T21:00:00' AS SmallDateTime), 6429.0100, 6390.8600, 5474.1700)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (294, N'ROMA', N'BODO', 2, 2, 1, CAST(N'2020-09-22T13:00:00' AS SmallDateTime), 5120.6900, 5361.3700, 6846.0900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (295, N'ROMA', N'CSKM', 0, 2, 1, CAST(N'2021-01-01T14:00:00' AS SmallDateTime), 6102.9900, 7955.3800, 9417.4500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (296, N'ROMA', N'GTFE', 0, 0, 1, CAST(N'2021-01-18T21:00:00' AS SmallDateTime), 9816.1600, 1752.8600, 8788.1000)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (297, N'ROMA', N'INTM', 0, 1, 1, CAST(N'2020-11-25T17:00:00' AS SmallDateTime), 5891.1200, 8544.1500, 7863.6600)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (298, N'ROMA', N'JUVT', 0, 1, 1, CAST(N'2021-01-21T18:00:00' AS SmallDateTime), 9189.8200, 8456.2600, 3842.2800)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (299, N'ROMA', N'LIVL', 3, 0, 1, CAST(N'2020-12-18T13:00:00' AS SmallDateTime), 8684.9500, 5550.3500, 1197.0500)
GO
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (300, N'ROMA', N'MANC', 0, 0, 0, CAST(N'2021-05-29T18:00:00' AS SmallDateTime), 2807.2900, 4227.3600, 7505.7500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (301, N'ROMA', N'MANU', 0, 0, 0, CAST(N'2021-07-17T14:00:00' AS SmallDateTime), 4503.2500, 1407.8300, 3926.9500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (302, N'ROMA', N'OLYL', 0, 0, 0, CAST(N'2021-02-22T17:00:00' AS SmallDateTime), 9666.8000, 6271.9400, 1091.3500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (303, N'ROMA', N'OPRT', 0, 0, 0, CAST(N'2021-03-20T15:00:00' AS SmallDateTime), 9206.5500, 3413.2200, 4474.3500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (304, N'ROMA', N'PASG', 0, 0, 0, CAST(N'2021-04-12T20:00:00' AS SmallDateTime), 8039.4200, 2829.9400, 1007.2500)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (305, N'ROMA', N'RBET', 0, 0, 0, CAST(N'2021-06-22T19:00:00' AS SmallDateTime), 8835.5200, 6517.3800, 3613.9900)
INSERT [dbo].[Partidos] ([ID], [IDLocal], [IDVisitante], [GolesLocal], [GolesVisitante], [Finalizado], [Fecha], [LimiteO/U], [LimiteGP], [LimiteHP]) VALUES (306, N'ROMA', N'RMAD', 0, 0, 0, CAST(N'2021-08-22T18:00:00' AS SmallDateTime), 4887.5900, 9853.5500, 2785.9300)
SET IDENTITY_INSERT [dbo].[Partidos] OFF
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (1, N'rwightman0@linkedin.com', N'86Km5Y', 1467.0700, 0x42C130BA29BBC6424A8FEADFEA18338911993ADC)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (2, N'nstathor1@nhs.uk', N'rx1oKB2', 817.0000, 0xA7F514CE8C5EB0396230B2868A674CDC0B63AA9F)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (3, N'eethridge2@cnn.com', N's9p58eKW7taQ', 1241.8800, 0x1A32956C7EEE8354DC1E2FEE60F0406BDEED0960)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (4, N'bhedderly3@xing.com', N'1wKAdRpi', 895.0000, 0x2AE8979471017FDB1EDA421F63AA557FFEE2C742)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (5, N'lflucks4@kickstarter.com', N'MYYHMT3', 1103.1500, 0xAFC0EF10F34A83F71B330ADD933862C66BE88DAC)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (6, N'fdebiasi5@vkontakte.ru', N'tbXCeMaT', 1783.2000, 0x01DD6B24749D008C798247F6CE8B9F7DABDE1854)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (7, N'mdrogan6@fc2.com', N'yz6P4yW7U', 915.0000, 0xEF3CF62DA5B03C038A42926081351B024842C0E0)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (8, N'lsterte7@list-manage.com', N'yyAUp3mxO', 776.0000, 0x50E9C3DFFD373C58FCFF21A83434F91334A95959)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (9, N'ogohn8@storify.com', N'kloudvI5', 743.0000, 0x083FC12531A4CA67D682EE94E1292E9CD691C0B9)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (10, N'mdehm9@huffingtonpost.com', N'SRenZxDDaP', 866.0000, 0xAB3DD1D3013807B681F49BBE582009016DC1044B)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (11, N'bbarkwortha@goo.gl', N'u1zndoh4X', 1133.8400, 0x0CFA9684AE3FFE0D49FBBFD1F2C875DA3423BCD7)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (12, N'gpeterb@elegantthemes.com', N'HbNcSDdOStH', 1233.8200, 0x022E35BC2365B497D4F612844DF894FF668B634A)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (13, N'sweichc@constantcontact.com', N'dakAekjGz', 622.0000, 0xF66604E96E03ED7606F4086F12537F29B1ED23AC)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (14, N'msmurfittd@exblog.jp', N'mRKhBPBmRtoX', 2077.2700, 0x7D80ACB9270ECB907656DC2D1C9B91BE3FA428F7)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (15, N'dframee@unc.edu', N'PmLp22939ZRn', 1491.5600, 0x565C06D9732C6B56EF03F619EBAC908B4D2D9B2B)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (16, N'sbauldreyf@google.com', N'nwrA1L2T', 847.0000, 0xDFD401D0085AFC549871FB8A2264414F3C6A9E88)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (17, N'mburnsg@columbia.edu', N'G5aAQ92hc0lz', 2472.8400, 0x64AD092DD15CCA7D9054D07E86644D937C353F76)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (18, N'acalcuth@senate.gov', N'Lrb2dy', 3310.2800, 0x6C0EFDEC64031D78276FEF2C85F3C83BC85CE172)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (19, N'fpointeri@flavors.me', N'jKcyeUGI', 1653.1500, 0xC7A493C4B3214B2A6022AF8E1C679BB18F128459)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (20, N'ivedntyevj@paypal.com', N'8jtx7bJ', 459.0000, 0x796B8C63E7E57BB356DA66932116A2F9CC9857F9)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (21, N'wdoublek@over-blog.com', N'7tZfGKG', 1000.0000, 0xDC53FE7132EEAE22CF0D1748D741EF01FC3F1317)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (22, N'kbeurichl@wufoo.com', N'CTC11PuCo', 817.0000, 0x4C1DD2057BF6AE7101EF40797FA5B25909699A5E)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (23, N'bdevittm@businesswire.com', N'A0waz7TvBj', 1604.5800, 0x1472FD29EE9E96822768758F87A54B2041CEE340)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (24, N'cmcginlyn@oracle.com', N'lKjX2n7oW6', 1000.0000, 0xB982B5BAD0A2F6C5121DB0803FFCBC14322DB135)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (25, N'pcolletono@drupal.org', N'BjLPsSFWE', 1733.0000, 0x2760398B3EE894ABAAC53898AC1F7923C468068F)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (26, N'abibbyp@nature.com', N'LVkpcC01', 1437.0000, 0x061C1FF58561BEBA1469DFE305235725DDE4ED04)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (27, N'mczapleq@berkeley.edu', N'LUMQGgw8T8', 1404.8000, 0x4C28AA1DA9FE68CA1132D96A2A28D9A02FEA4699)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (28, N'nvanichkinr@toplist.cz', N'wYZakh', 1300.6800, 0xF79F88104F09FFC805C6FB7AA55586DC25754607)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (29, N'frodriguess@angelfire.com', N'DqIaDDN', 1471.2000, 0x8AEBB50AD7D1010326DAC8D62C18078754DB5053)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (30, N'subankst@reuters.com', N'tnn30AIf', 1549.2600, 0x7223F8AD86D56A8AB0F56E0903373D28EE7B2C53)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (31, N'ioquirku@bandcamp.com', N'5zwBWDj', 717.0000, 0x82D9BAB1022DDED041ED07B1B7AE59EAD57F7E9C)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (32, N'abassingdenv@arstechnica.com', N'YXIBLmX', 1264.3500, 0x90E79A308EFF6BB691EA0A39E9C383ADB1D4FB6B)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (33, N'dtirew@google.it', N'Q8YButWyz', 901.0000, 0xE39FD2FE58AE12A028367BC5F794BCB4E4A71194)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (34, N'hkinkeadx@feedburner.com', N'OdpUueT', 655.0000, 0x877AA067B2BD0D241B4047D6A50900046649D52D)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (35, N'ldarracotty@tamu.edu', N'24HCH11o', 656.0000, 0xB68EE206E4BF243AB81B9BAE9CA93101F95CD3D6)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (36, N'cpoulneyz@1688.com', N'dfHTGDTPg', 702.0000, 0x6352BF683FD245341E13A9B4467BD539DF504E63)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (37, N'cauger10@php.net', N'4IALPlFZ9K9', 1445.9600, 0xA56518D97FC36006E8BF9877CA08DA6277BC8730)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (38, N'clevesley11@wisc.edu', N'YjJtkMUXH', 1501.6000, 0xFF4525CBCFFC2485B92C93B31BD8B73E47DFBF3E)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (39, N'bolder12@ebay.co.uk', N'jc1CCg4qp', 1000.0000, 0x2227B7E74577FAD4C77221F2C46A7C25C5B8DF4E)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (40, N'mcardoe13@abc.net.au', N'EByBj81', 831.0000, 0x5D8A683B7B2B8A80250F51325BD18129C7B5E930)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (41, N'jkovacs14@icio.us', N'sHR5O7J5WhN', 824.0000, 0xE7E6FE2B41FB897313211D904F87C417DB9E2EF8)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (42, N'mbrim15@independent.co.uk', N'iBS8iXh', 1000.0000, 0x22AD3406D80DD7289DFD31AD915AB2AD3BD2952F)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (43, N'acoop16@so-net.ne.jp', N'j0m94w', 976.4300, 0xD7079B87637221C3BA9F88D6B0A98707809D8BDB)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (44, N'blampens17@ehow.com', N'FkSDsALRE8', 1000.0000, 0x7A6392C346A0FA058C35636D43B3E94DC9D7C55E)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (45, N'jverbruggen18@hexun.com', N'VwSEygmwOW', 556.0000, 0x05C0B9BD8F92FF4ABADF2A4D64C35F802EE9EEE5)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (46, N'vbaillie19@goo.gl', N'Yuow6Vn9nWs', 1779.4000, 0x29D2245ACBA8B2696DF782D7DCF374A7CBCE4AF8)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (47, N'ddougan1a@tuttocitta.it', N'm0PdMe', 1445.1200, 0x07DF1F6130D5346AC9D0D12CC7EB9A299DBE7DA0)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (48, N'ccaukill1b@gnu.org', N'a3luMHXFy', 517.0000, 0x815AA3FD1FFA948EB796BA0C12C6C959CC5D7331)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (49, N'dkellough1c@dagondesign.com', N'WbsZOUEwmUXf', 803.0000, 0x71C7B8032CE5CC2C6A1E1DBA9892B89CC1658BB5)
INSERT [dbo].[Usuarios] ([ID], [Correo], [Password], [Saldo], [PasswordCodificada]) VALUES (50, N'tshermore1d@prlog.org', N'OXcksW9', 1782.6600, 0xC52D479EA223CABFC265D6B78DD44C4B113A03D9)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
ALTER TABLE [dbo].[Apuestas] ADD  DEFAULT ((0)) FOR [Comprobada]
GO
ALTER TABLE [dbo].[Partidos] ADD  DEFAULT ((0)) FOR [GolesLocal]
GO
ALTER TABLE [dbo].[Partidos] ADD  DEFAULT ((0)) FOR [GolesVisitante]
GO
ALTER TABLE [dbo].[Partidos] ADD  DEFAULT ((0)) FOR [Finalizado]
GO
ALTER TABLE [dbo].[Partidos] ADD  DEFAULT ((0)) FOR [LimiteO/U]
GO
ALTER TABLE [dbo].[Partidos] ADD  DEFAULT ((0)) FOR [LimiteGP]
GO
ALTER TABLE [dbo].[Partidos] ADD  DEFAULT ((0)) FOR [LimiteHP]
GO
ALTER TABLE [dbo].[Apuestas]  WITH CHECK ADD  CONSTRAINT [FKApuesta_Partido] FOREIGN KEY([ID_partido])
REFERENCES [dbo].[Partidos] ([ID])
GO
ALTER TABLE [dbo].[Apuestas] CHECK CONSTRAINT [FKApuesta_Partido]
GO
ALTER TABLE [dbo].[Apuestas]  WITH CHECK ADD  CONSTRAINT [FKUsuario_Apuesta] FOREIGN KEY([ID_usuario])
REFERENCES [dbo].[Usuarios] ([ID])
GO
ALTER TABLE [dbo].[Apuestas] CHECK CONSTRAINT [FKUsuario_Apuesta]
GO
ALTER TABLE [dbo].[GanadoresPartidos]  WITH CHECK ADD  CONSTRAINT [FKApuestasGanadoresPartidos] FOREIGN KEY([IDApuesta])
REFERENCES [dbo].[Apuestas] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GanadoresPartidos] CHECK CONSTRAINT [FKApuestasGanadoresPartidos]
GO
ALTER TABLE [dbo].[Handicaps]  WITH CHECK ADD  CONSTRAINT [FKApuestasHandicaps] FOREIGN KEY([IDApuesta])
REFERENCES [dbo].[Apuestas] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Handicaps] CHECK CONSTRAINT [FKApuestasHandicaps]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD  CONSTRAINT [FKUsuario_Movimiento] FOREIGN KEY([ID_usuario])
REFERENCES [dbo].[Usuarios] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FKUsuario_Movimiento]
GO
ALTER TABLE [dbo].[OversUnders]  WITH CHECK ADD  CONSTRAINT [FKApuestaOversUnders] FOREIGN KEY([IDApuesta])
REFERENCES [dbo].[Apuestas] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OversUnders] CHECK CONSTRAINT [FKApuestaOversUnders]
GO
ALTER TABLE [dbo].[Partidos]  WITH CHECK ADD  CONSTRAINT [FKPartidoLocal] FOREIGN KEY([IDLocal])
REFERENCES [dbo].[Equipos] ([ID])
GO
ALTER TABLE [dbo].[Partidos] CHECK CONSTRAINT [FKPartidoLocal]
GO
ALTER TABLE [dbo].[Partidos]  WITH CHECK ADD  CONSTRAINT [FKPartidoVisitante] FOREIGN KEY([IDVisitante])
REFERENCES [dbo].[Equipos] ([ID])
GO
ALTER TABLE [dbo].[Partidos] CHECK CONSTRAINT [FKPartidoVisitante]
GO
ALTER TABLE [dbo].[GanadoresPartidos]  WITH CHECK ADD  CONSTRAINT [CKResultado] CHECK  (([Resultado]='2' OR [Resultado]='X' OR [Resultado]='1'))
GO
ALTER TABLE [dbo].[GanadoresPartidos] CHECK CONSTRAINT [CKResultado]
GO
ALTER TABLE [dbo].[Handicaps]  WITH CHECK ADD  CONSTRAINT [CKHandicap] CHECK  (([Handicap]>=(-3) AND [Handicap]<=(3) AND [Handicap]<>(0)))
GO
ALTER TABLE [dbo].[Handicaps] CHECK CONSTRAINT [CKHandicap]
GO
ALTER TABLE [dbo].[OversUnders]  WITH CHECK ADD  CONSTRAINT [CKNumero] CHECK  (([Numero]>=(0) AND [Numero]<=(6) AND [Numero]%(0.5)=(0)))
GO
ALTER TABLE [dbo].[OversUnders] CHECK CONSTRAINT [CKNumero]
GO
/****** Object:  StoredProcedure [dbo].[ComprobarApuestaGanadorPartido]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedimiento que comprueba una apuesta GanadorPartido, en caso de ganar aumentará el saldo del usuario
CREATE   PROCEDURE [dbo].[ComprobarApuestaGanadorPartido] @IDApuesta Int, @Fecha SmallDateTime
AS
	BEGIN
		
		DECLARE @IDPartido char(4)
		DECLARE @IDUsuario Int
		DECLARE @EquipoApostado char(1)
		DECLARE @ApuestaComprobada Bit
		DECLARE @ApuestaGanada Bit = 0
		DECLARE @GolesLocal Int
		DECLARE @GolesVisitante Int
		DECLARE @Cuota DECIMAL(4,2)
		DECLARE @DineroApostado SmallMoney

		--Comprobamos si existe la apuesta
		IF EXISTS (SELECT * FROM GanadoresPartidos WHERE IDApuesta = @IDApuesta)
		BEGIN

			SELECT @IDPartido = A.ID_partido, 
			@EquipoApostado = GP.Resultado, 
			@ApuestaComprobada = A.Comprobada, 
			@Cuota = A.Cuota,
			@DineroApostado = A.Dinero_apostado,
			@IDusuario = A.ID_usuario FROM GanadoresPartidos AS GP
			INNER JOIN Apuestas AS A ON GP.IDApuesta = A.ID AND GP.IDApuesta = @IDApuesta

			--Comprobamos que la apuesta no haya sido ya comprobada
			IF(@ApuestaComprobada = 0)
			BEGIN
				
				--Comprobamos que el partido ha finalizado
				IF (SELECT Finalizado FROM Partidos WHERE ID = @IDPartido) = 1
				BEGIN

					SELECT @GolesLocal = GolesLocal, @GolesVisitante = GolesVisitante FROM Partidos WHERE ID = @IDPartido

					--Comprobamos si ha apostado a equipo local, empate o visitante
					IF @EquipoApostado LIKE '1' --Se ha apostado a victoria del equipo local
					BEGIN
						--Si el equipo local ha ganado
						IF @GolesLocal > @GolesVisitante
						BEGIN
							SET @ApuestaGanada = 1
						END
					END
					ELSE IF @EquipoApostado LIKE '2' --Se ha apostado a victoria del equipo visitante
					BEGIN
						--Si el equipo visitante ha ganado
						IF @GolesVisitante > @GolesLocal
						BEGIN
							SET @ApuestaGanada = 1
						END
					END
					ELSE --Se ha apostado a empate
					BEGIN
						--Si se ha quedado en empate
						IF @GolesVisitante = @GolesLocal
						BEGIN
							SET @ApuestaGanada = 1
						END
					END

					--Si ha ganado la apuesta le añadimos al usuario los ingresos a su saldo
					IF(@ApuestaGanada = 1)
					BEGIN

						INSERT Movimientos (ID_usuario, Dinero, Fecha)
						VALUES (@IDUsuario, @DineroApostado * @Cuota, @Fecha)
						
					END

					--Actualizamos la apuesta a comprobada
					UPDATE Apuestas
					SET Comprobada = 1
					WHERE ID = @IDApuesta

				END
			END	
		END
	END
GO
/****** Object:  StoredProcedure [dbo].[ComprobarApuestaHandicap]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedimiento que comprueba una apuesta Handicap, en caso de ganar aumentará el saldo del usuario
CREATE   PROCEDURE [dbo].[ComprobarApuestaHandicap] @IDApuesta Int, @Fecha SmallDateTime
AS
	BEGIN
		
		DECLARE @IDPartido char(4)
		DECLARE @IDUsuario Int
		DECLARE @NumeroGolesApostados SmallInt
		DECLARE @ApuestaComprobada Bit
		DECLARE @ApuestaGanada Bit = 0
		DECLARE @GolesLocal Int
		DECLARE @GolesVisitante Int
		DECLARE @Cuota DECIMAL(4,2)
		DECLARE @DineroApostado SmallMoney

		--Comprobamos si existe la apuesta
		IF EXISTS (SELECT * FROM Handicaps WHERE IDApuesta = @IDApuesta)
		BEGIN

			SELECT @IDPartido = A.ID_partido, 
			@NumeroGolesApostados = H.Handicap, 
			@ApuestaComprobada = A.Comprobada, 
			@Cuota = A.Cuota,
			@DineroApostado = A.Dinero_apostado,
			@IDusuario = A.ID_usuario FROM Handicaps AS H 
			INNER JOIN Apuestas AS A ON H.IDApuesta = A.ID AND H.IDApuesta = @IDApuesta

			--Comprobamos que la apuesta no haya sido ya comprobada
			IF(@ApuestaComprobada = 0)
			BEGIN
				
				--Comprobamos que el partido ha finalizado
				IF (SELECT Finalizado FROM Partidos WHERE ID = @IDPartido) = 1
				BEGIN

					SELECT @GolesLocal = GolesLocal, @GolesVisitante = GolesVisitante FROM Partidos WHERE ID = @IDPartido

					--Comprobamos si ha apostado a equipo local o visitante
					IF @NumeroGolesApostados < 0 --El Hándicap se hace hacia el equipo local
					BEGIN
						--Si el equipo local gana aún con su Hándicap
						IF(@GolesLocal + @NumeroGolesApostados) > @GolesVisitante
						BEGIN
							SET @ApuestaGanada = 1
						END
					END
					ELSE
					BEGIN
						--Si el equipo visitante gana aún con su Hándicap
						IF (@GolesVisitante - @NumeroGolesApostados) > @GolesLocal --El Hándicap se hace hacia el equipo visitante
						BEGIN
							SET @ApuestaGanada = 1
						END
					END
					--Si ha ganado la apuesta le añadimos al usuario los ingresos a su saldo
					IF(@ApuestaGanada = 1)
					BEGIN

						INSERT Movimientos (ID_usuario, Dinero, Fecha)
						VALUES (@IDUsuario, @DineroApostado * @Cuota, @Fecha)
						
					END

					--Actualizamos la apuesta a comprobada
					UPDATE Apuestas
					SET Comprobada = 1
					WHERE ID = @IDApuesta

				END
			END	
		END
	END
GO
/****** Object:  StoredProcedure [dbo].[ComprobarApuestaOverUnder]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Procedimiento que comprueba una apuesta Over/Under, en caso de ganar aumentará el saldo del usuario
CREATE   PROCEDURE [dbo].[ComprobarApuestaOverUnder] @IDApuesta Int, @Fecha SmallDateTime
AS
	BEGIN
		
		DECLARE @IDPartido char(4)
		DECLARE @OU bit
		DECLARE @IDUsuario Int
		DECLARE @NumeroGolesApostados Decimal (2,1)
		DECLARE @ApuestaComprobada Bit
		DECLARE @ApuestaGanada Bit = 0
		DECLARE @GolesTotales Int
		DECLARE @Cuota DECIMAL(4,2)
		DECLARE @DineroApostado SmallMoney

		--Comprobamos si existe la apuesta
		IF EXISTS (SELECT * FROM OversUnders WHERE IDApuesta = @IDApuesta)
		BEGIN

			SELECT @IDPartido = A.ID_partido, 
			@OU = OU.[Over/Under], 
			@NumeroGolesApostados = OU.Numero, 
			@ApuestaComprobada = A.Comprobada, 
			@Cuota = A.Cuota,
			@DineroApostado = A.Dinero_apostado,
			@IDusuario = A.ID_usuario FROM OversUnders AS OU 
			INNER JOIN Apuestas AS A ON OU.IDApuesta = A.ID AND OU.IDApuesta = @IDApuesta

			--Comprobamos que la apuesta no haya sido ya comprobada
			IF(@ApuestaComprobada = 0)
			BEGIN
				
				--Comprobamos que el partido ha finalizado
				IF (SELECT Finalizado FROM Partidos WHERE ID = @IDPartido) = 1
				BEGIN

					SELECT @GolesTotales = (GolesLocal + GolesVisitante) FROM Partidos WHERE ID = @IDPartido

					--Comprobamos si ha apostado a over o a under
					IF @OU = 0
					BEGIN
						--Si los numeros de goles totales son menores a los apostados ha ganado
						IF(@NumeroGolesApostados > @GolesTotales)
						BEGIN
							SET @ApuestaGanada = 1
						END
					END
					ELSE
					BEGIN
						--Si los numeros de goles totales son mayores a los apostados ha ganado
						IF(@NumeroGolesApostados < @GolesTotales)
						BEGIN
							SET @ApuestaGanada = 1
						END
					END
					--Si ha ganado la apuesta le añadimos al usuario los ingresos a su saldo
					IF(@ApuestaGanada = 1)
					BEGIN

						INSERT Movimientos (ID_usuario, Dinero, Fecha)
						VALUES (@IDUsuario, @DineroApostado * @Cuota, @Fecha)
						
					END

					--Actualizamos la apuesta a comprobada
					UPDATE Apuestas
					SET Comprobada = 1
					WHERE ID = @IDApuesta

				END
			END	
		END
	END
GO
/****** Object:  StoredProcedure [dbo].[GenerarCuota]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedimiento en resguardo que genera la cuota de un partido
CREATE   PROCEDURE [dbo].[GenerarCuota] @ID_Usuario int, @ID_Partido int, @DineroApostado smallmoney, @Fecha smalldatetime, @Cuota Decimal(4,2) OUTPUT
AS

	SET @Cuota = (ROUND(((10 - 1) * RAND() + 1), 2))

   RETURN
GO
/****** Object:  StoredProcedure [dbo].[GrabarApuestaGanadoresPartidos]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedimiento que graba una apuesta de tipo GanadoresPartidos
CREATE   PROCEDURE [dbo].[GrabarApuestaGanadoresPartidos] @IDUsuario Int, @IDPartido Int, @DineroApostado SmallMoney, @Fecha SmallDateTime, @Resultado Char(1), @IDApuesta Int OUTPUT
AS
	BEGIN
		BEGIN TRANSACTION
			
			DECLARE @Cuota Decimal(4,2)

			EXECUTE dbo.GenerarCuota  @IDUsuario, @IDPartido, @DineroApostado, @Fecha,  @Cuota OUTPUT;

			IF (SELECT Saldo FROM Usuarios WHERE ID = @IDUsuario) >= @DineroApostado
			BEGIN
				INSERT Apuestas (ID_usuario, ID_partido, Dinero_apostado, Fecha, Cuota)
				VALUES(@IDUsuario, @IDPartido, @DineroApostado, @Fecha, @Cuota)

				SET @IDApuesta = @@IDENTITY

				INSERT Movimientos (ID_usuario, Fecha, Dinero)
				VALUES (@IDUsuario, @Fecha, -@DineroApostado)

				BEGIN TRANSACTION

					INSERT GanadoresPartidos (IDApuesta, Resultado)
					VALUES (@IDApuesta, @Resultado)	

					COMMIT TRANSACTION
			END
						
			COMMIT TRANSACTION

			RETURN
	END

GO
/****** Object:  StoredProcedure [dbo].[GrabarApuestaHandicap]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedimiento que graba una apuesta de tipo Handicap
CREATE   PROCEDURE [dbo].[GrabarApuestaHandicap] @IDUsuario Int, @IDPartido Int, @DineroApostado SmallMoney, @Fecha SmallDateTime, @Handicap SmallInt, @IDApuesta Int OUTPUT
AS
	BEGIN
		BEGIN TRANSACTION
			
			DECLARE @Cuota Decimal(4,2)

			EXECUTE dbo.GenerarCuota  @IDUsuario, @IDPartido, @DineroApostado, @Fecha,  @Cuota OUTPUT;

			IF (SELECT Saldo FROM Usuarios WHERE ID = @IDUsuario) >= @DineroApostado
			BEGIN
				INSERT Apuestas (ID_usuario, ID_partido, Dinero_apostado, Fecha, Cuota)
				VALUES(@IDUsuario, @IDPartido, @DineroApostado, @Fecha, @Cuota)

				SET @IDApuesta = @@IDENTITY

				INSERT Movimientos (ID_usuario, Fecha, Dinero)
				VALUES (@IDUsuario, @Fecha, -@DineroApostado)

				BEGIN TRANSACTION

					INSERT Handicaps(IDApuesta, Handicap)
					VALUES (@IDApuesta, @Handicap)	

					COMMIT TRANSACTION
			END
						
			COMMIT TRANSACTION

			RETURN
	END

GO
/****** Object:  StoredProcedure [dbo].[GrabarApuestaOverUnder]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedimiento que graba una apuesta de tipo Over-under
CREATE   PROCEDURE [dbo].[GrabarApuestaOverUnder] @IDUsuario Int, @IDPartido Int, @DineroApostado SmallMoney, @Fecha SmallDateTime, @OverUnder BIT, @Numero Decimal(2,1), @IDApuesta Int OUTPUT
AS
	BEGIN
		BEGIN TRANSACTION
			
			DECLARE @Cuota Decimal(4,2)

			EXECUTE dbo.GenerarCuota  @IDUsuario, @IDPartido, @DineroApostado, @Fecha,  @Cuota OUTPUT;

			IF (SELECT Saldo FROM Usuarios WHERE ID = @IDUsuario) >= @DineroApostado
			BEGIN
				INSERT Apuestas (ID_usuario, ID_partido, Dinero_apostado, Fecha, Cuota)
				VALUES(@IDUsuario, @IDPartido, @DineroApostado, @Fecha, @Cuota)

				SET @IDApuesta = @@IDENTITY

				INSERT Movimientos (ID_usuario, Fecha, Dinero)
				VALUES (@IDUsuario, @Fecha, -@DineroApostado)

				BEGIN TRANSACTION

					INSERT OversUnders(IDApuesta, [Over/Under], Numero)
					VALUES (@IDApuesta, @OverUnder,@Numero)	

					COMMIT TRANSACTION
			END
						
			COMMIT TRANSACTION

			RETURN
	END

GO
/****** Object:  StoredProcedure [dbo].[PoblarApuestas]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Por último poblamos la tabla Apuestas

--BEGIN TRANSACTION

CREATE   PROCEDURE [dbo].[PoblarApuestas]
AS	
	BEGIN 

		DECLARE @Apuestas Int = Floor(rand()*200) + 50
		DECLARE @DineroApostado Int
		DECLARE @IDApuesta Int
		DECLARE @Partido Int
		DECLARE @Cont SmallInt = 1
		DECLARE @Comprobada Bit = 0
		DECLARE @Handicap SmallInt
		DECLARE @OverUnder Bit
		DECLARE @Numero Decimal(2,1)
		DECLARE @Cuota Decimal (4,2)
		DECLARE @Fecha SmallDateTime
		DECLARE @FechaInicioApuesta SmallDateTime
		DECLARE @FechaFinApuesta SmallDateTime
		DECLARE @IDUsuario Varchar(20)
		DECLARE @TipoApuesta TinyInt
		DECLARE @AleatorioAux TinyInt
		DECLARE @Resultado Char(1)


		WHILE @Cont <= @Apuestas
			BEGIN

				SET @Handicap = 0
		
				SET @DineroApostado = Floor(rand() * 150) + 50
				SET @TipoApuesta = Floor(rand() * 3) + 1

				SELECT TOP 1 @IDUsuario = ID FROM Usuarios
				ORDER BY NEWID()

				SELECT TOP 1 @Partido = ID FROM Partidos
				ORDER BY NEWID()
				
				--Comprobamos que el partido sea anterior a la fecha actual
				IF ((SELECT Fecha FROM Partidos WHERE ID = @Partido) < GETDATE())
					BEGIN
						--Comprobamos si el usuario no ha realizado una apuesta en el mismo partido
						IF(NOT EXISTS (SELECT * FROM Apuestas WHERE ID_usuario = @IDUsuario AND ID_partido = @Partido))
							BEGIN

								--Generamos la fecha de la apuesta
								SELECT @FechaInicioApuesta = AperturaApuestas, @FechaFinApuesta = CierreApuestas FROM Partidos WHERE ID = @Partido

								SELECT @Fecha = DATEADD(day, DATEDIFF(DAY, @FechaInicioApuesta, @FechaFinApuesta) * seed, @FechaInicioApuesta) FROM (SELECT RAND(CONVERT(VARBINARY, NEWID())) seed) AS S



								--Generamos la Cuota
								EXECUTE dbo.GenerarCuota  @IDUsuario, @Partido, @DineroApostado, @Fecha,  @Cuota OUTPUT;

								IF @TipoApuesta = 1 --Apuesta GanadoresPartidos
									BEGIN
										SET @AleatorioAux = Floor(rand() * 3) + 1

										SELECT @Resultado = CASE @AleatorioAux WHEN 1 THEN '1'
															   WHEN 2 THEN 'X'
															   ELSE '2'
															   END

										EXECUTE dbo.GrabarApuestaGanadoresPartidos @IDUsuario, @Partido, @DineroApostado, @Fecha, @Resultado, @IDApuesta OUTPUT
										EXECUTE dbo.ComprobarApuestaGanadorPartido @IDApuesta , @Fecha 
									END
								ELSE IF @TipoApuesta = 2
									BEGIN
										WHILE @Handicap = 0
											SET @Handicap = Floor(rand() * 7) - 3

										EXECUTE dbo.GrabarApuestaHandicap @IDUsuario, @Partido, @DineroApostado, @Fecha, @Handicap, @IDApuesta OUTPUT
										EXECUTE dbo.ComprobarApuestaHandicap @IDApuesta , @Fecha 
										
									END
								ELSE
									BEGIN
										SET @OverUnder = Floor(rand() * 2)
										SET @Numero = Floor(rand() * 6) + 0.5

										EXECUTE dbo.GrabarApuestaOverUnder @IDUsuario, @Partido, @DineroApostado, @Fecha, @OverUnder, @Numero, @IDApuesta OUTPUT
										EXECUTE dbo.ComprobarApuestaOverUnder @IDApuesta , @Fecha 
									END

								SET @Cont += 1
							END
					
					END
		
				
			

			END

	END

GO
/****** Object:  StoredProcedure [dbo].[PoblarEquipos]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Poblamos la tabla equipos 
CREATE   PROCEDURE [dbo].[PoblarEquipos]
AS
	BEGIN
		INSERT INTO Equipos (ID,Nombre,Ciudad,Pais)
			VALUES ('RBET','Real Betis','Sevilla','España'),('LIVL','Liverpool FC','Liverpool','Reino Unido'),('GTFE','Getafe CF','Getafe','España'),
			('AJAX','Ajax','Amsterdam','Holanda'),('MANC','Manchester City','Manchester','Reino Unido'),('OPRT','FC Oporto','Oporto','Portugal'),
			('BODO','Borussia Dortmund','Dortmund','Alemania'),('BARC','FC Barcelona','Barcelona','España'),('PASG','Paris Saint Germain','Paris','Francia'),
			('ROMA','AS Roma','Roma','Italia'),('MANU','Manchester United','Manchester','Reino Unido'),('OLYL','Olympique de Lion','Lion','Francia'),
			('INTM','Inter','Milan','Italia'),('BENF','Benfica','Lisboa','Portugal'),('BAYM','Bayern','Munich','Alemania'),('JUVT','Juventus','Turin','Italia'),
			('CSKM','PFC CSKA Moscu','Moscú','Rusia'), ('RMAD','Real Madrid','Madrid','España')
	END
GO
/****** Object:  StoredProcedure [dbo].[PoblarPartidos]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Poblamos la tabla Partidos

CREATE   PROCEDURE [dbo].[PoblarPartidos] 
AS
	BEGIN
		INSERT INTO Partidos (IDLocal ,IDVisitante)
		SELECT L.ID, V.ID FROM Equipos AS L CROSS JOIN Equipos AS V Where L.ID <> V.ID
		
		DECLARE @GolesL TinyInt, @GolesV TinyInt, @Partido SmallInt
		DECLARE CPartidos CURSOR FOR Select ID From Partidos
		DECLARE @DiasAux Int
		DECLARE @Fecha DateTime
		DECLARE @HoraFecha TinyInt

		OPEN Cpartidos

		FETCH NEXT FROM Cpartidos INTO @Partido

		WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @DiasAux = Floor(rand()*365) - 150
				SET @HoraFecha = Floor(rand()*10) + 12
				SET @Fecha = CONVERT(DATE, DATEADD(DAY, @DiasAux, GETDATE()))
				SET @Fecha = DATEADD(HOUR, @HoraFecha, @Fecha)

				UPDATE Partidos
				SET Fecha = @Fecha,
				    [LimiteO/U] = ROUND(((10000 - 1000) * RAND() + 1000), 2),
					LimiteGP = ROUND(((10000 - 1000) * RAND() + 1000), 2),
					LimiteHP = ROUND(((10000 - 1000) * RAND() + 1000), 2)
				WHERE ID = @Partido

				IF(@Fecha <= GETDATE())
					BEGIN
						SET @GolesL = Floor(rand()*4)
						SET @GolesV = Floor(rand()*3)
						UPDATE Partidos Set GolesLocal = @GolesL, GolesVisitante = @GolesV, Finalizado = 1
							WHERE ID = @Partido
					END -- If

				FETCH NEXT FROM Cpartidos INTO @Partido
			END -- While

		CLOSE Cpartidos
		DEALLOCATE CPartidos
	END
GO
/****** Object:  StoredProcedure [dbo].[PoblarUsuarios]    Script Date: 29/01/2021 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[PoblarUsuarios]
AS
	BEGIN
	
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('rwightman0@linkedin.com', '86Km5Y', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('nstathor1@nhs.uk', 'rx1oKB2', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('eethridge2@cnn.com', 's9p58eKW7taQ', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('bhedderly3@xing.com', '1wKAdRpi', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('lflucks4@kickstarter.com', 'MYYHMT3', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('fdebiasi5@vkontakte.ru', 'tbXCeMaT', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('mdrogan6@fc2.com', 'yz6P4yW7U', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('lsterte7@list-manage.com', 'yyAUp3mxO', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('ogohn8@storify.com', 'kloudvI5', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('mdehm9@huffingtonpost.com', 'SRenZxDDaP', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('bbarkwortha@goo.gl', 'u1zndoh4X', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('gpeterb@elegantthemes.com', 'HbNcSDdOStH', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('sweichc@constantcontact.com', 'dakAekjGz', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('msmurfittd@exblog.jp', 'mRKhBPBmRtoX', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('dframee@unc.edu', 'PmLp22939ZRn', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('sbauldreyf@google.com', 'nwrA1L2T', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('mburnsg@columbia.edu', 'G5aAQ92hc0lz', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('acalcuth@senate.gov', 'Lrb2dy', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('fpointeri@flavors.me', 'jKcyeUGI', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('ivedntyevj@paypal.com', '8jtx7bJ', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('wdoublek@over-blog.com', '7tZfGKG', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('kbeurichl@wufoo.com', 'CTC11PuCo', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('bdevittm@businesswire.com', 'A0waz7TvBj', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('cmcginlyn@oracle.com', 'lKjX2n7oW6', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('pcolletono@drupal.org', 'BjLPsSFWE', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('abibbyp@nature.com', 'LVkpcC01', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('mczapleq@berkeley.edu', 'LUMQGgw8T8', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('nvanichkinr@toplist.cz', 'wYZakh', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('frodriguess@angelfire.com', 'DqIaDDN', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('subankst@reuters.com', 'tnn30AIf', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('ioquirku@bandcamp.com', '5zwBWDj', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('abassingdenv@arstechnica.com', 'YXIBLmX', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('dtirew@google.it', 'Q8YButWyz', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('hkinkeadx@feedburner.com', 'OdpUueT', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('ldarracotty@tamu.edu', '24HCH11o', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('cpoulneyz@1688.com', 'dfHTGDTPg', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('cauger10@php.net', '4IALPlFZ9K9', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('clevesley11@wisc.edu', 'YjJtkMUXH', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('bolder12@ebay.co.uk', 'jc1CCg4qp', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('mcardoe13@abc.net.au', 'EByBj81', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('jkovacs14@icio.us', 'sHR5O7J5WhN', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('mbrim15@independent.co.uk', 'iBS8iXh', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('acoop16@so-net.ne.jp', 'j0m94w', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('blampens17@ehow.com', 'FkSDsALRE8', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('jverbruggen18@hexun.com', 'VwSEygmwOW', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('vbaillie19@goo.gl', 'Yuow6Vn9nWs', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('ddougan1a@tuttocitta.it', 'm0PdMe', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('ccaukill1b@gnu.org', 'a3luMHXFy', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('dkellough1c@dagondesign.com', 'WbsZOUEwmUXf', 1000);
		INSERT INTO Usuarios (Correo, Password, Saldo) values ('tshermore1d@prlog.org', 'OXcksW9', 1000);

	END
GO
USE [master]
GO
ALTER DATABASE [azure-javier] SET  READ_WRITE 
GO
