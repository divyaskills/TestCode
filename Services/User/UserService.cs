using System;
using System.Collections.Generic;
using System.Linq;
using NPoco;
using TestCode.Entities;

namespace TestCode.Services
{
  public class UserService : IUserService
  {
    private readonly IDatabase _db;
    // private readonly MyDbContext _dbContext;
    public UserService(DatabaseFactory dbFactory
    // ,MyDbContext dbContext
    )
    {
      // _dbContext = dbContext;
      _db = dbFactory.GetDatabase();
    }

    public IList<Users> GetUserDetails()
    {
      try
      {
        var query = $@"select * from auth.Users";
        var users = _db.Query<Users>(query);
        return users.ToList();
      }
      catch (Exception ex)
      {
        // log error here
        return null;
      }
    }
  }
}