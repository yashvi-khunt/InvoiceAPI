using InvoiceAPI.Validations;
using System.ComponentModel.DataAnnotations;

namespace InvoiceAPI.DTOs
{
    public class ManufacturerCreationDTO
    {
        [Required]
        [StringLength(50)]
        [FirstLetterCapital]
        public string Name {  get; set; }
    }
}
