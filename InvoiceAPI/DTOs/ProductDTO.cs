namespace InvoiceAPI.DTOs
{
    public class ProductDTO
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public int ManufacturerId { get; set; }
    }
}
