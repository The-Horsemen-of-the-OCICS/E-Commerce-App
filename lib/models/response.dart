class Response {
  String id;
  String questionId;
  String userId;
  String userName;
  String body;
  String createdDate;
  int upvotes;

  Response(
      {required this.id,
      required this.questionId,
      required this.userId,
      required this.userName,
      required this.body,
      required this.createdDate,
      this.upvotes = 1});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      id: json['id'] as String,
      questionId: json['questionId'] as String,
      userId: json['userId'] as String,
      userName: "Loading...",
      body: json['body'] as String,
      createdDate: json['date'] as String,
      upvotes: json['upvotes'] as int,
    );
  }
}
