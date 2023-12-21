using InvoiceAPI.Validations;
using System;
namespace InvoiceAPI.DTOs
{
	public class RateCreationDTO
	{
		[RestrictNegativeValue]
		public float Amount { get; set; }
		public DateTime Date { get; set; }
		[RestrictNegativeValue]
		public int ProductId { get; set; }
	}
}

