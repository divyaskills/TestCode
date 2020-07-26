using System;

namespace TestCode.Entities
{
  public class Users
  {
    public long Id { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Email { get; set; }
    public string Gender { get; set; }
    public DateTime BirthDate { get; set; }
  }
}