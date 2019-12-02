// To parse this JSON data, do
//
//     final events = eventsFromJson(jsonString);

import 'dart:convert';

Events eventsFromJson(String str) => Events.fromJson(json.decode(str));

String eventsToJson(Events data) => json.encode(data.toJson());

class Events {
  List<mtdEvent> events;

  Events({
    this.events,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        events: List<mtdEvent>.from(json["events"].map((x) => mtdEvent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class mtdEvent {
  String title;
  String host;
  String time;
  String start;
  String end;
  String place;
  String image;
  String description;

  mtdEvent({
    this.title,
    this.host,
    this.time,
    this.start,
    this.end,
    this.place,
    this.image,
    this.description,
  });

  factory mtdEvent.fromJson(Map<String, dynamic> json) => mtdEvent(
        title: json["title"],
        host: json["host"],
        time: json["time"],
        start: json["start"],
        end: json["end"],
        place: json["place"],
        image: json["image"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "host": host,
        "time": time,
        "start": start,
        "end": end,
        "place": place,
        "image": image,
        "description": description == null ? null : description,
      };
}
