using System;

namespace TestCode.Entities
{
  public class UserBookings
  {
    public long Id { get; set; }
    public long UserId { get; set; }
    public long VehicleId { get; set; }
    public long RouteId { get; set; }
    public DateTime BookingDate { get; set; }
    public DateTime CancelDate { get; set; }
  }
}