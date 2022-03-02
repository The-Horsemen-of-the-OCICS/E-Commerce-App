namespace ecommerceapp.models;
public class Category {
    public string Id { get; set; }
    public string Name { get; set; }

    public Category(string Id, string Name) {
        this.Id = Id;
        this.Name = Name;
    }
}