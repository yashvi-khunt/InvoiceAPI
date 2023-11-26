using AutoMapper;
using InvoiceAPI.DTOs;
using InvoiceAPI.Models;

namespace InvoiceAPI.Helpers
{
    public class MappingProfile : Profile
    {
        public MappingProfile() 
        {
            CreateMap<Manufacturer, ManufacturerDTO>().ReverseMap();
            CreateMap<ManufacturerCreationDTO, Manufacturer>();
            CreateMap<Product, ProductDTO>().ReverseMap();
            CreateMap<ProductCreationDTO, Product>();
            CreateMap<Rate, RateDTO>().ReverseMap();
            CreateMap<RateCreationDTO, Rate>();
        }
    }
}
