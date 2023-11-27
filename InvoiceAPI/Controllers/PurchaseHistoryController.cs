using AutoMapper;
using InvoiceAPI.DTOs;
using InvoiceAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace InvoiceAPI.Controllers
{
    [ApiController]
    [Route("api/invoices")]
    public class PurchaseHistoryController : ControllerBase
    {
        private readonly InvoiceAPIContext _context;
        private readonly IMapper mapper;

        public PurchaseHistoryController(InvoiceAPIContext context, IMapper mapper)
        {
            this._context = context;
            this.mapper = mapper;
        }
        [HttpGet]
        public async Task<ActionResult<List<PurchaseHistoryDTO>>> Get()
        {
            var purchaseHistories = await _context.PurchaseHistories.Where(m => m.IsDeleted == false).ToListAsync();
            var purchaseHistoriesDTO = mapper.Map<List<PurchaseHistoryDTO>>(purchaseHistories);
            return purchaseHistoriesDTO;
        }

        [HttpGet("{id}", Name = "getPurchaseHistory")]
        public async Task<ActionResult<List<PurchaseHistoryDTO>>> GetPurchaseHistoryByInvoiceId(int id)
        {
            var purchaseHistory = await _context.PurchaseHistories.Where(m => m.IsDeleted == false && m.InvoiceId == id).ToListAsync();

            if (purchaseHistory == null) { return NotFound(); }
            var purchaseHistoryDTO = mapper.Map<List<PurchaseHistoryDTO>>(purchaseHistory);
            return purchaseHistoryDTO;
        }

        [HttpPost]
        public async Task<ActionResult> Post([FromBody] PurchaseHistoryCreationDTO purchaseHistoryCreation)
        {
            //some code for duplicate entry

            //
            var purchaseHistory = mapper.Map<PurchaseHistory>(purchaseHistoryCreation);
            _context.Add(purchaseHistory);
            await _context.SaveChangesAsync();

            var purchaseHistoryDTO = mapper.Map<PurchaseHistoryDTO>(purchaseHistory);

            return new CreatedAtRouteResult("getPurchaseHistory", new { id = purchaseHistory.Id }, purchaseHistoryDTO);
        }


        [HttpPut("{id}")]
        public async Task<ActionResult> Put(int id, [FromBody] PurchaseHistoryCreationDTO purchaseHistoryCreation)
        {
            var purchaseHistoryDB = await _context.PurchaseHistories.Where(m => m.IsDeleted == false).FirstOrDefaultAsync(m => m.Id == id);

            if (purchaseHistoryDB == null) { return NotFound(); }

            mapper.Map(purchaseHistoryCreation, purchaseHistoryDB);
            _context.Entry(purchaseHistoryDB).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var purchaseHistory = await _context.PurchaseHistories.FirstOrDefaultAsync(m => m.Id == id);
            if (purchaseHistory == null) { return NotFound(); }

            purchaseHistory.IsDeleted = true;
            _context.Entry(purchaseHistory).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
