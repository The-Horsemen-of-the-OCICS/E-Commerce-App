namespace ecommerceapp.models;
public class Question {
    public string Id { get; set; }
    public string User { get; set; }
    public string Title { get; set; }
    public string Body { get; set; }
    public string createdDate { get; set; }
    public List<Response> Responses { get; set; }
    public int Upvotes;

    public Question(string Id, string User, string Title, string Body, string createdDate, List<Response> Responses, int Upvotes) {
        this.Id = Id;
        this.User = User;
        this.Title = Title;
        this.Body = Body;
        this.createdDate = createdDate;
        this.Responses = Responses.ToList();
        this.Upvotes = Upvotes;
    }
}
