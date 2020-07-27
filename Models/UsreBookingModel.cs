namespace TestCode.Models
{
  public class UsreBookingModel
  {
    public long Id { get; set; }
    public string VehicleName { get; set; }
    public string SourceCity { get; set; }
    public string DestinationCity { get; set; }
    public string OriginalRouteFrom { get; set; }
    public string OriginalRouteTo { get; set; }
  }
}