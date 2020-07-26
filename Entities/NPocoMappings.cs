
using NPoco.FluentMappings;

namespace TestCode.Entities
{
  public class NpocoMappings : Mappings
  {
    private const string lang = "dbo";

    public NpocoMappings()
    {
      For<States>().TableName($"[{lang}].[States]");

      For<Cities>().TableName($"[{lang}].[Cities]");

      For<Vehicles>().TableName($"[{lang}].[Vehicles]");

      For<SeatAvailability>().TableName($"[{lang}].[SeatAvailability]");

      For<Routes>().TableName($"[{lang}].[Routes]");

      For<Users>().TableName($"[{lang}].[Users]");

      For<UserBookings>().TableName($"[{lang}].[UserBookings]");

      For<Passangers>().TableName($"[{lang}].[Passangers]");
    }
  }
}