using System;

namespace TestCode.Entities
{
  public class Passangers
  {
    public long UserBookingId { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Gender { get; set; }
    public DateTime BirthDate { get; set; }
    public string SeatName { get; set; }
  }
}