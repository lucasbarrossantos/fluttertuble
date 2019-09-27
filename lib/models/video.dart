class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({this.id, this.title, this.thumb, this.channel});

  factory Video.formJson(Map<String, dynamic> json) {
    if (json.containsKey("id")) {
      return Video(
          id: json["id"]["videoId"],
          title: json["snippet"]["title"],
          thumb: json["snippet"]["thumbnails"]["high"]["url"],
          channel: json["snippet"]["channelTitle"]);
    } else {
      return Video(
          id: json["videoId"],
          title: json["title"],
          thumb: json["thumbnails"]["high"]["url"],
          channel: json["channelTitle"]);
    }
  }

  Map<String, dynamic> toJson() {
    return {"videoId": id, "title": title, "thumb": thumb, "channel": channel};
  }
}
