using System;
namespace InvoiceAPI.DTOs
{
	public class PurchaseHistoryDTO
	{
        public int Id { get; set; }
        public int InvoiceId { get; set; }
        public int RateId { get; set; }
        public int Quantity { get; set; }
        public DateTime Date { get; set; }
    }
}

