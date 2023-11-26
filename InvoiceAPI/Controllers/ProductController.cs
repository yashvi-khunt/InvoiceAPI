using AutoMapper;
using InvoiceAPI.DTOs;
using InvoiceAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace InvoiceAPI.Controllers
{
    [ApiController]
    [Route("api/products")]
    public class ProductController : ControllerBase
    {
        private readonly InvoiceAPIContext _context;
        private readonly IMapper mapper;

        public ProductController(InvoiceAPIContext context, IMapper mapper)
        {
            this._context = context;
            this.mapper = mapper;
        }
        [HttpGet]
        public async Task<ActionResult<List<ProductDTO>>> Get()
        {
            var products = await _context.Products.Where(m => m.IsDeleted == false).ToListAsync();
            var productsDTO = mapper.Map<List<ProductDTO>>(products);
            return productsDTO;
        }

        [HttpGet("{id}", Name = "getProduct")]
        public async Task<ActionResult<ProductDTO>> GetProductById(int id)
        {
            var product = await _context.Products.Where(m => m.IsDeleted == false).FirstOrDefaultAsync(m => m.Id == id);

            if (product == null) { return NotFound(); }
            var productDTO = mapper.Map<ProductDTO>(product);
            return productDTO;
        }

        [HttpPost]
        public async Task<ActionResult> Post([FromBody] ProductCreationDTO productCreation)
        {
           //some code for duplicate entry

            //
            var product = mapper.Map<Product>(productCreation);
            _context.Add(product);
            await _context.SaveChangesAsync();
            
            var productDTO = mapper.Map<ProductDTO>(product);

            return new CreatedAtRouteResult("getProduct", new { id = product.Id }, productDTO);
        }


        [HttpPut("{id}")]
        public async Task<ActionResult> Put(int id, [FromBody] ProductCreationDTO productCreation)
        {
            //some code for duplicate entry

            //
            var productDB = await _context.Products.Where(m => m.IsDeleted == false).FirstOrDefaultAsync(m => m.Id == id);

            if (productDB == null) { return NotFound(); }

            var product = mapper.Map<Product>(productCreation);
            productDB.Name = product.Name;
            _context.Entry(productDB).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var product = await _context.Products.FirstOrDefaultAsync(m => m.Id == id);
            if (product == null) { return NotFound(); }

            product.IsDeleted = true;
            _context.Entry(product).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
