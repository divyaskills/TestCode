
  DECLARE @sourceId SMALLINT = 1;
  DECLARE @destinationId SMALLINT = 2;
  DECLARE @seatCount SMALLINT = 2;


 ;with journeyData as (
	select jr.VehicleId, jr.ArrivalAt  as sourceArrival, jr1.ArrivalAt as destinationArrival ,
	(select count(id) from [dbo].[SeatAvailability] where [VehicleId]=jr.vehicleid and [IsAllocated]=0) as seatAvailabilityCount
	from dbo.JourneyRoutes jr inner join dbo.JourneyRoutes jr1 on jr.id = jr.id 
	where jr.CityId=@sourceId and jr1.CityId=@destinationId and jr.VehicleId=jr1.VehicleId and jr.DisplayIndex<jr1.DisplayIndex
 )
 select 
	Id, 
	[Name],
	VehicleNumber, 
	(select [Name] from [dbo].[cities] where id=v.[SourceId]) as VehicleOrigin,
	(select [Name] from [dbo].[cities] where id=v.[DestinationId]) as VehicleEndPoint,
	v.JourneyStart, 
	v.JourneyEnd,

	(select [Name] from [dbo].[cities] where id=@sourceId) as PickupPoint,
	(select [Name] from [dbo].[cities] where id=@destinationId) as [EndPoint],
	jd.sourceArrival as PickupPointArrival,
	jd.destinationArrival as EndPointArrival,
	(select count(id) from [dbo].[SeatAvailability] where [VehicleId]=v.id and [IsAllocated]=0) as seatAvailabilityCount 
	from dbo.Vehicles v right join journeyData jd on v.Id=jd.VehicleId
	where jd.seatAvailabilityCount >= @seatCount