using System.ComponentModel;

namespace TestCode.Models
{
  public class ResponseModel
  {
    public string Message { get; set; }
    public string ResponseType { get; set; }

    [DefaultValue(null)]
    public object Data { get; set; }
  }
}