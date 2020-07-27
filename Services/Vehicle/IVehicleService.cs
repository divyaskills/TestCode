using System.Collections.Generic;
using System.Threading.Tasks;
using TestCode.Entities;
using TestCode.Models;

namespace TestCode.Services
{
  public interface IVehicleService
  {
    Task<IEnumerable<VehicleModel>> GetListAsync(DataFilter<VehicleModel> filter);
    Task<IEnumerable<VehicleDetailModel>> GetVehicleDetailsAsync(long vehicleId);
    Task<IEnumerable<UsreBookingModel>> GetUserBookingsAsync(long userId);
    Task<IEnumerable<CityModel>> GetListAsync();
  }
}