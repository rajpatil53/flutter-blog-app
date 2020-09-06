import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int id;
  final int postId;
  final String email;
  final String name;
  final String body;
  // final String name;
  Comment({this.id, this.email, this.name, this.postId, this.body});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
