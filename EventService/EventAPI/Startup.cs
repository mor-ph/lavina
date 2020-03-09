using System.Text;
using AutoMapper;
using EventAPI.Configuration;
using EventAPI.Data.Context;
using EventAPI.Services.Categories;
using EventAPI.Services.EventService;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;

namespace EventAPI
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }
        
        readonly string AllowAnyOrigin = "AllowAnyOrigin";
        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            var jwtSettingsSection = Configuration.GetSection("JwtSettings");
            services.Configure<JwtSettings>(jwtSettingsSection);

            var jwtSettings = jwtSettingsSection.Get<JwtSettings>();

            var key = Encoding.ASCII.GetBytes(jwtSettings.Secret);

            services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(options =>
            {
                options.RequireHttpsMetadata = false;
                options.SaveToken = true;


                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience = false,


                };
            });
            services.AddControllers().AddNewtonsoftJson(x => x.SerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore);
            services.AddDbContext<LetsPlayDbContext>(options =>
            options.UseMySql(Configuration.GetConnectionString("DefaultConnection")));
            services.AddScoped<ICategoryService, CategoryService>();
            services.AddScoped<IEventService, EventService>();
            services.AddAutoMapper(typeof(Startup).Assembly);

            services.AddCors(options =>
            {
                options.AddPolicy(AllowAnyOrigin,
                    builder =>
                    {
                        builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
                    });
            });


        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            //app.UseHttpsRedirection();

            app.UseRouting();

            app.UseCors(AllowAnyOrigin);
            app.UseAuthentication();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
