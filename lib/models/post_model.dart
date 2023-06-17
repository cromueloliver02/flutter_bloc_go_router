import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object> get props => [userId, id, title, body];

  @override
  String toString() {
    return 'Post(userId: $userId, id: $id, title: $title, body: $body)';
  }

  Post copyWith({
    int Function()? userId,
    int Function()? id,
    String Function()? title,
    String Function()? body,
  }) {
    return Post(
      userId: userId != null ? userId() : this.userId,
      id: id != null ? id() : this.id,
      title: title != null ? title() : this.title,
      body: body != null ? body() : this.body,
    );
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userId: map['userId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }
}
