using System.Collections.Generic;
using TestCode.Entities;

namespace TestCode.Services
{
  public interface IUserService
  {
    IList<Users> GetUserDetails();
  }
}