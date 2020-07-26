using System;

namespace TestCode.Entities
{
  public class Vehicles
  {
    public long Id { get; set; }
    public string Name { get; set; }
    public string VehicleNumber { get; set; }
    public long SourceId { get; set; }
    public long DestinationId { get; set; }
    public DateTime JourneyStart { get; set; }
    public DateTime JourneyEnd { get; set; }
  }
}