using ecommerceapp.models;

namespace ecommerceapp.services;
public class ItemService {
    // Data placeholder
    private List<Item> items = new List<Item> () {
        new Item("1", "Gold 1", "metal", 25 ,"placeholder"),
        new Item("2", "Silver 1", "metal", 15, "placeholder"),
        new Item("3", "Bronze 1", "metal", 5, "placeholder")
    };

    public ItemService() {
    }

    public async Task CreateAsync(Item newItem) {
        items.Add(newItem);
    }

    public async Task<List<Item>> GetAsync() {
        return items;
    }

    public async Task<Item?> GetAsync(string Id) {
        return items.Find(x => x.Id == Id);
    }

    public async Task<bool> UpdateAsync(string Id, Item updatedItem) {
        bool result = false;
        int index = items.FindIndex(x => x.Id == Id);
        if (index != -1) {
            updatedItem.Id = Id;
            items[index] = updatedItem;
            result = true;
        }
        return result;
    }

    public async Task<bool> DeleteAsync(string Id) {
        bool deleted = false;
        int index = items.FindIndex(x => x.Id == Id);
        if (index != -1) {
            items.RemoveAt(index);
            deleted = true;
        }
        return deleted;
    }
}