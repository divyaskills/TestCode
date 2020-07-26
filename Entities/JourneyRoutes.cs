using System;

namespace TestCode.Entities
{
  public class JourneyRoutes
  {
    public long Id { get; set; }
    public long VehicleId { get; set; }
    public DateTime ArrivalAt { get; set; }
    public int DisplayIndex { get; set; }
    public long CityId { get; set; }
  }
}