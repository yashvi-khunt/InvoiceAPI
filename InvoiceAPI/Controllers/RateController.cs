using System;
using AutoMapper;
using InvoiceAPI.DTOs;
using InvoiceAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace InvoiceAPI.Controllers
{
	[ApiController]
	[Route("api/rates")]
	public class RateController: ControllerBase
	{
        private readonly InvoiceAPIContext _context;
        private readonly IMapper mapper;

        public RateController(InvoiceAPIContext context, IMapper mapper)
        {
            this._context = context;
            this.mapper = mapper;
        }
        [HttpGet]
        public async Task<ActionResult<List<RateDTO>>> Get()
        {
            var rates = await _context.Rates.Where(m => m.IsDeleted == false).ToListAsync();
            var ratesDTO = mapper.Map<List<RateDTO>>(rates);
            return ratesDTO;
        }

        [HttpGet("{id}", Name = "getRate")]
        public async Task<ActionResult<RateDTO>> GetRateById(int id)
        {
            var rate = await _context.Rates.Where(m => m.IsDeleted == false).FirstOrDefaultAsync(m => m.Id == id);

            if (rate == null) { return NotFound(); }
            var rateDTO = mapper.Map<RateDTO>(rate);
            return rateDTO;
        }

        [HttpPost]
        public async Task<ActionResult> Post([FromBody] RateCreationDTO rateCreation)
        {
            //some code for duplicate entry

            //
            var rate = mapper.Map<Rate>(rateCreation);
            _context.Add(rate);
            await _context.SaveChangesAsync();

            var rateDTO = mapper.Map<RateDTO>(rate);

            return new CreatedAtRouteResult("getRate", new { id = rate.Id }, rateDTO);
        }


        [HttpPut("{id}")]
        public async Task<ActionResult> Put(int id, [FromBody] RateCreationDTO rateCreation)
        {
            var isDuplicate = await _context.Rates
        .AnyAsync(p => p.Amount == rateCreation.Amount && p.ProductId == rateCreation.ProductId && p.IsDeleted == false);

            if (isDuplicate)
            {
                return Conflict("Rate with the same amount already exists.");
            }

            var rateDB = await _context.Rates.Where(m => m.IsDeleted == false).FirstOrDefaultAsync(m => m.Id == id);

            if (rateDB == null) { return NotFound(); }

            mapper.Map(rateCreation, rateDB);
            _context.Entry(rateDB).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var rate = await _context.Rates.FirstOrDefaultAsync(m => m.Id == id);
            if (rate == null) { return NotFound(); }

            rate.IsDeleted = true;
            _context.Entry(rate).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}

