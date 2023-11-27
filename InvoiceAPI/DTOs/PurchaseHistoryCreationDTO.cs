using InvoiceAPI.Validations;
using System;
namespace InvoiceAPI.DTOs
{
	public class PurchaseHistoryCreationDTO
	{
        [RestrictNegativeValue]
        public int InvoiceId { get; set; }
        [RestrictNegativeValue]
        public int RateId { get; set; }
        [RestrictNegativeValue]
        public int Quantity { get; set; }
        public DateTime Date { get; set; }
    }
}

