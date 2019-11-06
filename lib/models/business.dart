// To parse this JSON data, do
//
//     final business = businessFromJson(jsonString);
import 'package:flutter/material.dart';
import 'dart:convert';

Business businessFromJson(String str) => Business.fromJson(json.decode(str));

String businessToJson(Business data) => json.encode(data.toJson());

class Business {
  List<Both> samarbetspartners;
  List<Both> both;
  List<Both> onsdag;
  List<Both> torsdag;
  List<Color> colors;

  Business({
    this.samarbetspartners,
    this.both,
    this.onsdag,
    this.torsdag,
    this.colors = const [Colors.orange, Colors.deepOrange],
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        samarbetspartners: List<Both>.from(
            json["samarbetspartners"].map((x) => Both.fromJson(x))),
        both: List<Both>.from(json["both"].map((x) => Both.fromJson(x))),
        onsdag: List<Both>.from(json["onsdag"].map((x) => Both.fromJson(x))),
        torsdag: List<Both>.from(json["torsdag"].map((x) => Both.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "samarbetspartners":
            List<dynamic>.from(samarbetspartners.map((x) => x.toJson())),
        "both": List<dynamic>.from(both.map((x) => x.toJson())),
        "onsdag": List<dynamic>.from(onsdag.map((x) => x.toJson())),
        "torsdag": List<dynamic>.from(torsdag.map((x) => x.toJson())),
      };
}

class Both {
  String name;
  String image;
  String plats;
  String sponsor;
  String erbjudande;
  String hemsida;
  String info;
  String onsdag;
  String torsdag;
  String klimat;
  List<Color> colors;

  Both({
    this.name,
    this.image,
    this.plats,
    this.sponsor,
    this.erbjudande,
    this.hemsida,
    this.info,
    this.onsdag,
    this.torsdag,
    this.klimat,
    this.colors = const [Colors.orange, Colors.deepOrange],
  });

  factory Both.fromJson(Map<String, dynamic> json) => Both(
        name: json["name"],
        image: json["image"],
        plats: json["plats"],
        sponsor: json["sponsor"],
        erbjudande: json["erbjudande"],
        hemsida: json["hemsida"],
        info: json["info"],
        onsdag: json["onsdag"],
        torsdag: json["torsdag"],
        klimat: json["klimat"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "plats": plats,
        "sponsor": sponsor,
        "erbjudande": erbjudande,
        "hemsida": hemsida,
        "info": info,
        "onsdag": onsdag,
        "torsdag": torsdag,
        "klimat": klimat,
      };
}
