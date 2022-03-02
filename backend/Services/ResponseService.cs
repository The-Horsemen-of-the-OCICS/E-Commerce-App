using ecommerceapp.models;

namespace ecommerceapp.services;
public class ResponseService {
    // Data placeholder
    private List<Response> responses = new List<Response> () {
        new Response("1", "User1", "Good", "2022-1-13", 1),
        new Response("2", "User2", "Bad", "2022-1-13", 1)
    };

    public ResponseService() {
    }

    public async Task CreateAsync(Response newResponse) {
        responses.Add(newResponse);
    }

    public async Task<List<Response>> GetAsync() {
        return responses;
    }

    public async Task<List<Response>> GetAsync(List<string> IdList) {
        List<Response> list = new List<Response>();
        foreach (Response r in responses) {
            if (IdList.Contains(r.Id))
                list.Add(r);
        }
        return list;
    }

    public async Task<Response> GetAsync(string Id) {
        return responses.Find(x => x.Id == Id);
    }

    public async Task<bool> UpdateAsync(string Id, Response updatedResponse) {
        bool result = false;
        int index = responses.FindIndex(x => x.Id == Id);
        if (index != -1) {
            updatedResponse.Id = Id;
            responses[index] = updatedResponse;
            result = true;
        }
        return result;
    }

    public async Task<bool> DeleteAsync(string Id) {
        bool deleted = false;
        int index = responses.FindIndex(x => x.Id == Id);
        if (index != -1) {
            responses.RemoveAt(index);
            deleted = true;
        }
        return deleted;
    }
}