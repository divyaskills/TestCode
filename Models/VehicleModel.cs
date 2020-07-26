using System;

namespace TestCode.Models
{
  public class VehicleModel
  {
    public long Id { get; set; }
    public string Name { get; set; }
    public string JourneyOrigin { get; set; }
    public string JourneyEndPoint { get; set; }
    public string VehicleNumber { get; set; }
    public string Source { get; set; }
    public string Destination { get; set; }
    public DateTime JourneyStart { get; set; }
    public DateTime JourneyEnd { get; set; }
  }
}