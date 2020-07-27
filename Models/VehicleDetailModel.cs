using System;

namespace TestCode.Models
{
  public class VehicleDetailModel
  {
    public long Id { get; set; }
    public string VehicleName { get; set; }
    public DateTime ArrivalTime { get; set; }
    public int ArrivalIndex { get; set; }
    public long CityId { get; set; }
    public string CityName { get; set; }
  }
}