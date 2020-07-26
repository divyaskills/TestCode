namespace TestCode.Entities
{
  public class SeatAvailability
  {
    public long Id { get; set; }
    public long VehicleId { get; set; }
    public string SeatName { get; set; }
    public bool IsAllocated { get; set; }
  }
}