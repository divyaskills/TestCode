using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using NPoco;
using TestCode.Entities;
using TestCode.Models;

namespace TestCode.Services
{
  public class VehicleService : IVehicleService
  {
    private readonly IDatabase _db;
    public VehicleService(DatabaseFactory dbFactory)
    {
      _db = dbFactory.GetDatabase();
    }

    public async Task<IEnumerable<VehicleModel>> GetListAsync(DataFilter<VehicleModel> filter)
    {
      try
      {
        var paging = "OFFSET @0 ROWS FETCH NEXT @1 ROWS ONLY";
        long sourceId = 0;
        long destinationId = 0;
        var seatCountSubQuery = string.Empty;

        var searchString = string.Empty;

        if (!string.IsNullOrWhiteSpace(filter.SearchString))
        {
          searchString = $@"where v.Name like '%{filter.SearchString}%'";
        }

        if (filter.Parameters != null && filter.Parameters.Any(o => o.Key == "sourceId"))
        {
          sourceId = long.Parse(filter.Parameters["sourceId"].ToString());
        }

        if (filter.Parameters != null && filter.Parameters.Any(o => o.Key == "destinationId"))
        {
          destinationId = long.Parse(filter.Parameters["destinationId"].ToString());
        }

        if (filter.Parameters != null && filter.Parameters.Any(o => o.Key == "seatCount"))
        {
          seatCountSubQuery = "where jd.seatAvailabilityCount >= " + filter.Parameters["seatCount"].ToString();
        }

        // sorting is in pending

        // NOTE: In case you don't get expected result, you can check at this location DatabaseScripts>queries.sql
        var query = $@";with journeyData as (
                        select jr.VehicleId, jr.ArrivalAt  as sourceArrival, jr1.ArrivalAt as destinationArrival ,
                        (select count(id) from [dbo].[SeatAvailability] where [VehicleId]=jr.vehicleid and [IsAllocated]=0) as seatAvailabilityCount
                        from dbo.JourneyRoutes jr inner join dbo.JourneyRoutes jr1 on jr.id = jr.id 
                        where jr.CityId={sourceId} and jr1.CityId={destinationId} and jr.VehicleId=jr1.VehicleId and jr.DisplayIndex<jr1.DisplayIndex
                      )
                      select 
                        Id, 
                        [Name],
                        VehicleNumber, 
                        (select [Name] from [dbo].[cities] where id=v.[SourceId]) as VehicleOrigin,
                        (select [Name] from [dbo].[cities] where id=v.[DestinationId]) as VehicleEndPoint,
                        v.JourneyStart, 
                        v.JourneyEnd,

                        (select [Name] from [dbo].[cities] where id={sourceId}) as PickupPoint,
                        (select [Name] from [dbo].[cities] where id={destinationId}) as [EndPoint],
                        jd.sourceArrival as PickupPointArrival,
                        jd.destinationArrival as EndPointArrival,
                        (select count(id) from [dbo].[SeatAvailability] where [VehicleId]=v.id and [IsAllocated]=0) as seatAvailabilityCount 
                        from dbo.Vehicles v right join journeyData jd on v.Id=jd.VehicleId";

        var result = await _db.QueryAsync<VehicleModel>(
                  $"{query} {paging}",
                  filter.PageNumber == 1 ? 0 : filter.PageSize * (filter.PageNumber - 1),
                  filter.PageSize
                );

        return result;
      }
      catch (Exception ex)
      {
        // log here
        return null;
      }
    }

    public async Task<IEnumerable<CityModel>> GetListAsync()
    {
      try
      {
        var query = $@"select * from dbo.cities";
        var result = await _db.QueryAsync<CityModel>(query);
        return result;
      }
      catch (Exception ex)
      {
        return null;
      }
    }
  }
}