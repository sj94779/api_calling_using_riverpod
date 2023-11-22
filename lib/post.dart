import 'dart:convert';

class Post{

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
});

  final int userId;
  final int id;
  final String title;
  final String body;

  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
}){
    return Post(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'userId' : userId,
      'id': id,
      'title':title,
      'body': body,
    };

  }

  factory Post.fromMap(Map<String, dynamic> map){
    return Post(userId: map['userId'] as int,
        id: map['id'] as int,
        title: map['title'] as String,
        body: map['body'] as String,
    );
  }

  String toJson()  => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);
}