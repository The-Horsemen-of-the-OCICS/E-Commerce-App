using ecommerceapp.models;

namespace ecommerceapp.services;
public class CategoryService {
    // Data placeholder
    private List<Category> categories = new List<Category> () {
        new Category("1", "Gold"),
        new Category("2", "Silver"),
        new Category("3", "Bronze")
    };

    public CategoryService() {
    }

    public async Task CreateAsync(Category newCategory) {
        categories.Add(newCategory);
    }

    public async Task<List<Category>> GetAsync() {
        return categories;
    }

    public async Task<Category> GetAsync(string Id) {
        return categories.Find(x => x.Id == Id);
    }

    public async Task<bool> UpdateAsync(string Id, Category updatedCategory) {
        bool result = false;
        int index = categories.FindIndex(x => x.Id == Id);
        if (index != -1) {
            updatedCategory.Id = Id;
            categories[index] = updatedCategory;
            result = true;
        }
        return result;
    }

    public async Task<bool> DeleteAsync(string Id) {
        bool deleted = false;
        int index = categories.FindIndex(x => x.Id == Id);
        if (index != -1) {
            categories.RemoveAt(index);
            deleted = true;
        }
        return deleted;
    }
}