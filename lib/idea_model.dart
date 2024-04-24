//     final idea = ideaFromJson(jsonString);
import 'dart:convert';

Idea ideaFromJson(String str) => Idea.fromJson(json.decode(str));

String ideaToJson(Idea data) => json.encode(data.toJson());

class Idea {
  String activity;
  String type;
  double participants;
  double price;
  String link;
  String key;
  double accessibility;

  Idea({
    this.activity="",
    this.type="",
    this.participants=0,
    this.price=0,
    this.link="",
    this.key="",
    this.accessibility=0,
  });

  factory Idea.fromJson(Map<String, dynamic> json) => Idea(
    activity: json["activity"],
    type: json["type"],
    participants: json["participants"],
    price: json["price"],
    link: json["link"],
    key: json["key"],
    accessibility: json["accessibility"],
  );

  Map<String, dynamic> toJson() => {
    "activity": activity,
    "type": type,
    "participants": participants,
    "price": price,
    "link": link,
    "key": key,
    "accessibility": accessibility,
  };
}
