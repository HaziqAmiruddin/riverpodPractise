import 'package:river_pod_practise/features/post/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
    'body': body,
  };

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      userId: post.userId,
      id: post.id,
      title: post.title,
      body: post.body,
    );
  }

  Post toEntity() {
    return Post(userId: userId, id: id, title: title, body: body);
  }
}
