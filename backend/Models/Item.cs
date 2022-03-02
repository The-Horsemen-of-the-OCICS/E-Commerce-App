namespace ecommerceapp.models;
public class Item {
    public string Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public double Price { get; set; }
    public string Image { get; set; }

    public Item(string Id, string Name, string Description, double Price, string Image) {
        this.Id = Id;
        this.Name = Name;
        this.Description = Description;
        this.Price = Price;
        this.Image = Image;
    }
}