/*
Note: Not including pricing here due to time limit
tables: Vehicles, Routes, Users, UserBookings, Cities, States, Passangers
requirenments:
1. If user requesting for 4 seats then list of vehicles should appear with 4 or more avalable seats
2. Main route is A to C and one passanger is having registration with route A to B then if another passanger is able to register that route with B to C
*/

--Table creation start

CREATE TABLE [States](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](3500) NOT NULL
 CONSTRAINT [PK_States] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Cities](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](3500) NOT NULL,
	[StateId] [bigint] NOT NULL FOREIGN KEY REFERENCES [States](Id)
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Vehicles](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](3500) NOT NULL,
	[VehicleNumber] [nvarchar](3500) NOT NULL,
	[SourceId] [bigint] NOT NULL FOREIGN KEY REFERENCES [Cities](Id),
	[DestinationId] [bigint] NOT NULL FOREIGN KEY REFERENCES [Cities](Id),
	[JourneyStart] [datetime2](7) NOT NULL,
	[JourneyEnd] [datetime2](7) NOT NULL
 CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [SeatAvailability](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[VehicleId] [bigint] NOT NULL FOREIGN KEY REFERENCES [Vehicles](Id),
	[SeatName] [varchar](10) NOT NULL, -- it could be A1 or 1
	[IsAllocated] [bit] Not Null
 CONSTRAINT [PK_SeatAvailability] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [JourneyRoutes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[VehicleId] [bigint] NOT NULL FOREIGN KEY REFERENCES [Vehicles](Id),
	[ArrivalAt] [datetime2](7),
	[DisplayIndex] [int] NOT NULL,
	[CityId] [bigint] NOT NULL FOREIGN KEY REFERENCES [Cities](Id)
 CONSTRAINT [PK_JourneyRoutes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--mapping with user registered routes
CREATE TABLE [Routes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SourceId] [bigint] NOT NULL FOREIGN KEY REFERENCES [Cities](Id),
	[DestinationId] [bigint] NOT NULL FOREIGN KEY REFERENCES [Cities](Id)
 CONSTRAINT [PK_Routes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](3500) NOT NULL,
	[LastName] [nvarchar](3500) NOT NULL,
	[Email] [nvarchar](3500) NOT NULL,
	[Gender] [varchar](10) NOT NULL,
	[BirthDate] [datetime2](7),
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [UserBookings](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL FOREIGN KEY REFERENCES [Users](Id),
	[VehicleId] [bigint] NOT NULL FOREIGN KEY REFERENCES [Vehicles](Id),
	[RouteId] [bigint] NOT NULL FOREIGN KEY REFERENCES [Routes](Id),
	[BookingDate] [datetime2](7),
	[CancelDate] [datetime2](7)
 CONSTRAINT [PK_UserBookings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Passangers](
	[UserBookingId] [bigint] NOT NULL FOREIGN KEY REFERENCES [UserBookings](Id),
	[FirstName] [nvarchar](3500) NOT NULL,
	[LastName] [nvarchar](3500) NOT NULL,
	[Gender] [varchar](10) NOT NULL,
	[BirthDate] [datetime2](7),
	[SeatName] [varchar](10) NOT NULL)
GO

--Table creation end


--Data Insertion start
SET IDENTITY_INSERT [States] ON 
insert into [States](id, [Name]) values (1, 'Gujarat')
SET IDENTITY_INSERT [States] OFF
GO

SET IDENTITY_INSERT [Cities] ON 
insert into [Cities](id, [Name], [StateId]) values (1, 'Ahmedabad', 1)
insert into [Cities](id, [Name], [StateId]) values (2, 'Surat', 1)
insert into [Cities](id, [Name], [StateId]) values (3, 'Vadodara', 1)
insert into [Cities](id, [Name], [StateId]) values (4, 'Anand', 1)
insert into [Cities](id, [Name], [StateId]) values (5, 'Navsari', 1)
insert into [Cities](id, [Name], [StateId]) values (6, 'Bharuch', 1)
insert into [Cities](id, [Name], [StateId]) values (7, 'Nadiad', 1)
SET IDENTITY_INSERT [Cities] OFF
GO

SET IDENTITY_INSERT [Vehicles] ON 
insert into [Vehicles](id, [Name], [VehicleNumber], SourceId, DestinationId, JourneyStart,JourneyEnd) 
	values (1, 'Gujarat Express', '10115', 1, 2, '20200801 10:30:00 AM', '20200801 10:30:00 PM')
insert into [Vehicles](id, [Name], [VehicleNumber], SourceId, DestinationId, JourneyStart,JourneyEnd) 
	values (2, 'Gujarat Express 1', '10116', 1, 2, '20200802 10:30:00 AM', '20200802 10:30:00 PM')
SET IDENTITY_INSERT [Vehicles] OFF
GO

SET IDENTITY_INSERT [SeatAvailability] ON 
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (1, 1, 'A', 1)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (2, 1, 'B', 1)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (3, 1, 'C', 1)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (4, 1, 'D', 1)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (5, 1, 'E', 0)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (6, 1, 'F', 0)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (7, 1, 'G', 0)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (8, 1, 'H', 0)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (9, 2, 'A', 1)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (10, 2, 'B', 1)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (11, 2, 'C', 1)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (12, 2, 'D', 1)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (13, 2, 'E', 0)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (14, 2, 'F', 0)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (15, 2, 'G', 0)
insert into [SeatAvailability](id, [VehicleId], [SeatName], [IsAllocated]) values (16, 2, 'H', 0)
SET IDENTITY_INSERT [SeatAvailability] OFF
GO

SET IDENTITY_INSERT [JourneyRoutes] ON 
insert into [JourneyRoutes](id, [VehicleId], [ArrivalAt], [DisplayIndex], [CityId]) values (1, 1, '20200801 10:30:00 AM', 0, 1)
insert into [JourneyRoutes](id, [VehicleId], [ArrivalAt], [DisplayIndex], [CityId]) values (2, 1, '20200801 01:30:00 PM', 1, 7)
insert into [JourneyRoutes](id, [VehicleId], [ArrivalAt], [DisplayIndex], [CityId]) values (3, 1, '20200801 06:30:00 PM', 2, 4)
insert into [JourneyRoutes](id, [VehicleId], [ArrivalAt], [DisplayIndex], [CityId]) values (4, 1, '20200801 10:30:00 AM', 3, 3)

insert into [JourneyRoutes](id, [VehicleId], [ArrivalAt], [DisplayIndex], [CityId]) values (5, 2, '20200801 10:30:00 AM', 0, 1)
insert into [JourneyRoutes](id, [VehicleId], [ArrivalAt], [DisplayIndex], [CityId]) values (6, 2, '20200801 01:30:00 PM', 1, 7)
insert into [JourneyRoutes](id, [VehicleId], [ArrivalAt], [DisplayIndex], [CityId]) values (7, 2, '20200801 06:30:00 PM', 2, 4)
insert into [JourneyRoutes](id, [VehicleId], [ArrivalAt], [DisplayIndex], [CityId]) values (8, 2, '20200801 10:30:00 AM', 3, 3)

insert into [JourneyRoutes](id, [VehicleId], [ArrivalAt], [DisplayIndex], [CityId]) values (9, 1, '20200801 10:30:00 AM', 3, 2)
SET IDENTITY_INSERT [JourneyRoutes] OFF
GO

SET IDENTITY_INSERT [Routes] ON 
insert into [Routes](id, SourceId, DestinationId) values (1, 1, 3)
SET IDENTITY_INSERT [Routes] OFF
GO

SET IDENTITY_INSERT [Users] ON 
insert into [Users](id, [FirstName], LastName, Email, Gender, BirthDate) values (1, 'Divya', 'Modi', 'divya.modi36@gmail.com', 'Female', '19930710 10:30:00 AM')
insert into [Users](id, [FirstName], LastName, Email, Gender, BirthDate) values (2, 'Niraj', 'Patel', 'njpatel@gmail.com', 'Male', '19830710 10:30:00 AM')
SET IDENTITY_INSERT [Users] OFF
GO


SET IDENTITY_INSERT [UserBookings] ON 
insert into [UserBookings](id, UserId, RouteId, VehicleId, BookingDate, CancelDate) 
	values (1, 2, 1, 1, '20200726 11:30:00 AM', null)
SET IDENTITY_INSERT [UserBookings] OFF
GO

insert into [Passangers]([UserBookingId], [FirstName], [LastName], [Gender], [BirthDate], [SeatName]) 
	values (1, 'Niraj', 'Patel', 'Male', '19830710 10:30:00 AM', 'A')
insert into [Passangers]([UserBookingId], [FirstName], [LastName], [Gender], [BirthDate], [SeatName]) 
	values (1, 'Kavya', 'Patel', 'Female', '19850710 10:30:00 AM', 'B')
insert into [Passangers]([UserBookingId], [FirstName], [LastName], [Gender], [BirthDate], [SeatName]) 
	values (1, 'Hetal', 'Patel', 'Female', '20010710 10:30:00 AM', 'C')
insert into [Passangers]([UserBookingId], [FirstName], [LastName], [Gender], [BirthDate], [SeatName]) 
	values (1, 'Meet', 'Patel', 'Male', '20010710 10:30:00 AM', 'D')
GO

--Data Insertion end
