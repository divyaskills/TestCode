using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using TestCode.Services;
using NPoco;
using NPoco.FluentMappings;
using TestCode.Entities;
using Microsoft.Extensions.Configuration;

namespace TestCode
{
  public class Startup
  {
    public Startup(IConfiguration configuration)
    {
      Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    // This method gets called by the runtime. Use this method to add services to the container.
    public void ConfigureServices(IServiceCollection services)
    {
      var connection = Configuration.GetConnectionString("DefaultConnection");
      var dbFactory = DatabaseFactory.Config(x =>
            {
              x.UsingDatabase(() => new Database(connection, DatabaseType.SqlServer2012, System.Data.SqlClient.SqlClientFactory.Instance));
              x.WithFluentConfig(FluentMappingConfiguration.Configure(new NpocoMappings()));
            });
      services.AddSingleton(dbFactory);

      services.AddControllers();
      services.AddScoped<IUserService, UserService>();
      services.AddScoped<IVehicleService, VehicleService>();

      //   services.AddSwaggerGen(c =>
      //   {
      //     c.SwaggerDoc("v1", new Info { Title = "API", Version = "v1" });
      //   });
    }

    // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
      if (env.IsDevelopment())
      {
        app.UseDeveloperExceptionPage();
      }

      app.UseHttpsRedirection();

      app.UseRouting();

      app.UseAuthorization();

      app.UseEndpoints(endpoints =>
      {
        endpoints.MapControllers();
      });

      //   app.UseSwagger();
      //   app.UseSwaggerUI(c =>
      //   {
      //     c.SwaggerEndpoint("/swagger/v1/swagger.json", "v1");
      //   });
    }
  }
}