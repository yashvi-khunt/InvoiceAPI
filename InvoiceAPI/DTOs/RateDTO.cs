using System;
namespace InvoiceAPI.DTOs
{
    public class RateDTO
    {
        public int Id { get; set; }
        public float Amount { get; set; }
        public DateTime Date { get; set; }
        public int ProductId { get; set; }
    }
}



