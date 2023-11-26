using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace InvoiceAPI.DTOs
{
    public class ProductCreationDTO
    {
        [Required]
        [StringLength(50)]
        public string Name { get; set; } = null!;

        [Required]
        public int ManufacturerId { get; set; }
      
        public bool isDeleted = false;
    }
}
 