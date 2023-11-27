using InvoiceAPI.Validations;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace InvoiceAPI.DTOs
{
    public class ProductCreationDTO
    {
        [Required]
        [StringLength(50)]
        [FirstLetterCapital]
        public string Name { get; set; } = null!;

        [Required]
        [RestrictNegativeValue]
        public int ManufacturerId { get; set; }
     
    }
}
 