class FactorySendMessage {
  int? matchId;
  String? content;
  String? type;

  FactorySendMessage({this.matchId, this.content, this.type});

  FactorySendMessage.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    content = json['content'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['match_id'] = matchId;
    data['content'] = content;
    data['type'] = type;
    return data;
  }
}