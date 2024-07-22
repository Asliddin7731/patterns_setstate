
class Post{
  int? id;
  String? title;
  String? body;
  int? userId;

  Post({this.id, this.title, this.body, this.userId});

  Post.fromJson(Map<String, dynamic> json)
    : userId = json["userId"],
    id= json["id"],
    title= json["title"],
    body= json["body"];

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}