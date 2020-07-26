using System.Collections.Generic;

namespace TestCode.Models
{
  public class DataFilter<T>
  {
    public long TotalCount { get; set; }

    public int PageSize { get; set; }

    public int PageNumber { get; set; }

    public string SearchString { get; set; }

    public Dictionary<string, string> Parameters { get; set; }

    public Dictionary<string, string> SortBy { get; set; }

    public List<T> PageData { get; set; }
  }
}