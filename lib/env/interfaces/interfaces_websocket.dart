class InterfaceWebSocket {
  String? key;
  String? url;
  int? port;
  String? cluster;
  Channels? channels;
  Channels? events;

  InterfaceWebSocket(
      {this.key,
        this.url,
        this.port,
        this.cluster,
        this.channels,
        this.events});

  InterfaceWebSocket.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    url = json['url'];
    port = json['port'];
    cluster = json['cluster'];
    channels = json['channels'] != null
        ? Channels.fromJson(json['channels'])
        : null;
    events =
    json['events'] != null ? Channels.fromJson(json['events']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['url'] = url;
    data['port'] = port;
    data['cluster'] = cluster;
    if (channels != null) {
      data['channels'] = channels!.toJson();
    }
    if (events != null) {
      data['events'] = events!.toJson();
    }
    return data;
  }
}

class Channels {
  String? chat;
  String? matches;

  Channels({this.chat, this.matches});

  Channels.fromJson(Map<String, dynamic> json) {
    chat = json['chat'];
    matches = json['matches'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat'] = chat;
    data['matches'] = matches;

    return data;
  }
}
