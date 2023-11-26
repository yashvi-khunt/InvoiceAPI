using System;
using System.Collections.Generic;

namespace InvoiceAPI.Models
{
    public partial class Product
    {
        public Product()
        {
            Rates = new HashSet<Rate>();
        }

        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public int ManufacturerId { get; set; }
        public bool IsDeleted { get; set; }

        public virtual Manufacturer Manufacturer { get; set; } = null!;
        public virtual ICollection<Rate> Rates { get; set; }
    }
}
