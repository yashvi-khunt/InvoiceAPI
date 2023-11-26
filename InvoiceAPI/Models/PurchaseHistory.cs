using System;
using System.Collections.Generic;

namespace InvoiceAPI.Models
{
    public partial class PurchaseHistory
    {
        public int Id { get; set; }
        public int InvoiceId { get; set; }
        public int RateId { get; set; }
        public int Quantity { get; set; }
        public DateTime Date { get; set; }
        public bool IsDeleted { get; set; }

        public virtual Rate Rate { get; set; } = null!;
    }
}
