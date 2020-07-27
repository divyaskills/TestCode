using System;

namespace TestCode.Models
{
  public class VehicleModel
  {
    public long Id { get; set; }
    public string Name { get; set; }
    public string VehicleOrigin { get; set; }
    public string VehicleEndPoint { get; set; }
    public string VehicleNumber { get; set; }
    public string PickupPoint { get; set; }
    public string EndPoint { get; set; }
    public DateTime JourneyStart { get; set; }
    public DateTime JourneyEnd { get; set; }
    public DateTime PickupPointArrival { get; set; }
    public DateTime EndPointArrival { get; set; }
    public int SeatAvailabilityCount { get; set; }
  }
}