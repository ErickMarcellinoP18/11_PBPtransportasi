import 'dart:convert';

class Review {
  final int id;
  final String id_kereta;
  final int id_user;
  final String content;

  const Review({
    required this.id,
    required this.id_kereta,
    required this.id_user,
    required this.content,
  });

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        id_kereta: json["id_kereta"],
        id_user: json["id_user"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_kereta": id_kereta,
        "id_user": id_user,
        "content": content
      };
}
