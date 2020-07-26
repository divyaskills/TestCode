using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using TestCode.Models;
using TestCode.Services;

namespace TestCode.Controllers
{
  [ApiController]
  [Route("api/vehicles")]
  public class VehiclesController : ControllerBase
  {
    private readonly ILogger<VehiclesController> _logger;
    private readonly IVehicleService _vehicleService;

    public VehiclesController(ILogger<VehiclesController> logger, IVehicleService vehicleService)
    {
      _logger = logger;
      _vehicleService = vehicleService;
    }

    /// <summary>
    /// It returns vehicles data based on condition.
    /// </summary>
    /// <remarks></remarks>
    /// <response code="200">Success</response>
    /// <response code="400">Invalid values</response>
    [HttpPost("list")]
    [ProducesResponseType(typeof(VehicleModel), 200)]
    [ProducesResponseType(typeof(void), 404)]
    public async Task<ActionResult<VehicleModel>> GetList([FromBody] DataFilter<VehicleModel> filter)
    {
      try
      {
        ResponseModel model = new ResponseModel();
        model.Data = await _vehicleService.GetListAsync(filter);
        if (model.Data == null)
        {
          model.ResponseType = "Error";
          model.Message = "Oops! Something went wrong";
        }
        else
        {
          model.ResponseType = "Sucess";
        }

        return Ok(model);
      }
      catch (Exception ex)
      {
        // add serilog here
        return BadRequest();
      }
    }

    /// <summary>
    /// It returns all cities data.
    /// </summary>
    /// <remarks></remarks>
    /// <response code="200">Success</response>
    /// <response code="400">Invalid values</response>
    [HttpGet("cities")]
    public async Task<ActionResult<VehicleModel>> GetCityList()
    {
      try
      {
        ResponseModel model = new ResponseModel();
        model.Data = await _vehicleService.GetListAsync(filter);
        if (model.Data == null)
        {
          model.ResponseType = "Error";
          model.Message = "Oops! Something went wrong";
        }
        else
        {
          model.ResponseType = "Sucess";
        }

        return Ok(model);
      }
      catch (Exception ex)
      {
        // add serilog here
        return BadRequest();
      }
    }



  }
}
