// To parse this JSON data, do
//
//     final events = eventsFromJson(jsonString);

import 'dart:convert';

Events eventsFromJson(String str) => Events.fromJson(json.decode(str));

String eventsToJson(Events data) => json.encode(data.toJson());

class Events {
  List<Event> events;

  Events({
    this.events,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class Event {
  String title;
  String host;
  String time;
  String start;
  String end;
  String place;
  String image;
  String description;

  Event({
    this.title,
    this.host,
    this.time,
    this.start,
    this.end,
    this.place,
    this.image,
    this.description,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
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
