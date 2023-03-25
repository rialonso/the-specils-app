class LikeDislikeFactory {
  int? user_id;
  String type;

  LikeDislikeFactory({
    required this.user_id,
    required this.type
  });
  factory LikeDislikeFactory.fromJson(Map<String, dynamic> json) => LikeDislikeFactory(
    user_id: json["user_id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": user_id,
    "type": type,
  };
}