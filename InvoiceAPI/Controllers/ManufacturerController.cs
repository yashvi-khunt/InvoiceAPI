﻿using AutoMapper;
using InvoiceAPI.DTOs;
using InvoiceAPI.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Security.Cryptography.X509Certificates;

namespace InvoiceAPI.Controllers
{
    [ApiController]
    [Route("api/manufacturers")]
    public class ManufacturerController : ControllerBase
    {
        private readonly InvoiceAPIContext _context;
        private readonly IMapper mapper;

        public ManufacturerController(InvoiceAPIContext context, IMapper mapper)
        {
            this._context = context;
            this.mapper = mapper;
        }
        [HttpGet]
        public async Task<ActionResult<List<ManufacturerDTO>>> Get()
        {
            var manufacturers = await _context.Manufacturers.Where(m => m.IsDeleted == false).ToListAsync();
            var manufacturesDTO = mapper.Map<List<ManufacturerDTO>>(manufacturers);
            return manufacturesDTO;
        }

        [HttpGet("{id}", Name = "getManufacturer")]
        public async Task<ActionResult<ManufacturerDTO>> GetManufacturerById(int id)
        {
            var manufacturer = await _context.Manufacturers.Where(m => m.IsDeleted == false).FirstOrDefaultAsync(m => m.Id == id);

            if(manufacturer == null) { return NotFound(); }
            var manufacturerDTO = mapper.Map<ManufacturerDTO>(manufacturer);
            return manufacturerDTO;
        }

        [HttpPost]
        public async Task<ActionResult> Post([FromBody] ManufacturerCreationDTO manufacturerCreation)
        {
            //duplicate entry
            var isDuplicate = await _context.Manufacturers
        .AnyAsync(p => p.Name == manufacturerCreation.Name);
            var isDeleted = await _context.Manufacturers
        .AnyAsync(p => p.Name == manufacturerCreation.Name && p.IsDeleted == true);
            if (isDuplicate)
            {
                // Handle duplicate entry, for example, return a conflict response
                return Conflict("Product with the same name already exists.");
            }
            //
            var manufacturer = mapper.Map<Manufacturer>(manufacturerCreation);
            _context.Add(manufacturer);
            await _context.SaveChangesAsync();
            var manufacturerDTO = mapper.Map<ManufacturerDTO>(manufacturer);

            return new CreatedAtRouteResult("getManufacturer", new { id = manufacturer.Id }, manufacturerDTO);
        }


        [HttpPut("{id}")]
        public async Task<ActionResult> Put(int id, [FromBody] ManufacturerCreationDTO manufacturerCreation)
        {
            //duplicate entry

            var isDuplicate = await _context.Manufacturers
        .AnyAsync(p =>  p.Name == manufacturerCreation.Name && p.IsDeleted == false);
            if (isDuplicate)
            {
                // Handle duplicate entry, for example, return a conflict response
                return Conflict("Product with the same name already exists.");
            }
            //
            var manufacturerDB = await _context.Manufacturers.Where(m => m.IsDeleted == false).FirstOrDefaultAsync(m => m.Id == id);

            if (manufacturerDB == null) { return NotFound(); }

              //manufacturerDB = mapper.Map<Manufacturer>(manufacturerCreation);
            //manufacturerDB.Id = id;
            //manufacturerDB.IsDeleted = false;
            mapper.Map(manufacturerCreation,manufacturerDB);
            _context.Entry(manufacturerDB).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var manufacturer = await _context.Manufacturers.FirstOrDefaultAsync(m => m.Id == id);
            if (manufacturer == null) { return NotFound();}
            
            manufacturer.IsDeleted = true;
            _context.Entry(manufacturer).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
