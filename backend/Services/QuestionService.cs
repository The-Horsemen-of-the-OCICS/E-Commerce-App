using ecommerceapp.models;

namespace ecommerceapp.services;
public class QuestionService {
    // Data placeholder
    private List<Question> questions = new List<Question> () {
        new Question("1", "User1", "Good", "What", "2022-1-12", new List<Response>(), 1),
        new Question("2", "User2", "Bad", "Where", "2022-1-12", new List<Response>(), 1)
    };

    public QuestionService() {
        
    }

    public async Task CreateAsync(Question newQuestion) {
        questions.Add(newQuestion);
    }

    public async Task<List<Question>> GetAsync() {
        return questions;
    }

    public async Task<Question?> GetAsync(string Id) {
        return questions.Find(x => x.Id == Id);
    }

    public async Task<bool> UpdateAsync(string Id, Question updatedQuestion) {
        bool result = false;
        int index = questions.FindIndex(x => x.Id == Id);
        if (index != -1) {
            updatedQuestion.Id = Id;
            questions[index] = updatedQuestion;
            result = true;
        }
        return result;
    }

    public async Task<bool> DeleteAsync(string Id) {
        bool deleted = false;
        int index = questions.FindIndex(x => x.Id == Id);
        if (index != -1) {
            questions.RemoveAt(index);
            deleted = true;
        }
        return deleted;
    }
}