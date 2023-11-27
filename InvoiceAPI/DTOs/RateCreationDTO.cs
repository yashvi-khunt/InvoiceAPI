using System;
namespace InvoiceAPI.DTOs
{
	public class RateCreationDTO
	{
		public float Amount { get; set; }
		public DateTime Date { get; set; }
		public int ProductId { get; set; }
	}
}

