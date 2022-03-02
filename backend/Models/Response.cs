namespace ecommerceapp.models;
public class Response {
    public string Id { get; set; }
    public string User { get; set; }
    public string Body { get; set; }
    public string createdDate { get; set; }
    public int Upvotes;

    public Response(string Id, string User, string Body, string createdDate, int Upvotes) {
        this.Id = Id;
        this.User = User;
        this.Body = Body;
        this.createdDate = createdDate;
        this.Upvotes = Upvotes;
    }
}
