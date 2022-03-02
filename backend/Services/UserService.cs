using ecommerceapp.models;

namespace ecommerceapp.services;
public class UserService {
    // Data placeholder
    private List<User> users = new List<User> () {
        new User("1", "User1", "User1@email.com", "hash"),
        new User("2", "User2", "User2@email.com", "hash"),
        new User("3", "User3", "User3@email.com", "hash")
    };

    public UserService() {
    }

    public async Task CreateAsync(User newUser) {
        users.Add(newUser);
    }

    public async Task<List<User>> GetAsync() {
        return users;
    }

    public async Task<User?> GetAsync(string Id) {
        return users.Find(x => x.Id == Id);
    }

    public async Task<bool> UpdateAsync(string Id, User updatedUser) {
        bool result = false;
        int index = users.FindIndex(x => x.Id == Id);
        if (index != -1) {
            updatedUser.Id = Id;
            users[index] = updatedUser;
            result = true;
        }
        return result;
    }

    public async Task<bool> DeleteAsync(string Id) {
        bool deleted = false;
        int index = users.FindIndex(x => x.Id == Id);
        if (index != -1) {
            users.RemoveAt(index);
            deleted = true;
        }
        return deleted;
    }
}