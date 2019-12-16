// To parse this JSON data, do
//
//     final companies = companiesFromJson(jsonString);

import 'dart:convert';

Companies companiesFromJson(String str) => Companies.fromJson(json.decode(str));

String companiesToJson(Companies data) => json.encode(data.toJson());

class Companies {
  List<Bron> gold;
  List<Bron> silver;
  List<Bron> brons;
  List<Bron> other;

  Companies({
    this.gold,
    this.silver,
    this.brons,
    this.other,
  });

  factory Companies.fromJson(Map<String, dynamic> json) => Companies(
        gold: List<Bron>.from(json["gold"].map((x) => Bron.fromJson(x))),
        silver: List<Bron>.from(json["silver"].map((x) => Bron.fromJson(x))),
        brons: List<Bron>.from(json["brons"].map((x) => Bron.fromJson(x))),
        other: List<Bron>.from(json["other"].map((x) => Bron.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "gold": List<dynamic>.from(gold.map((x) => x.toJson())),
        "silver": List<dynamic>.from(silver.map((x) => x.toJson())),
        "brons": List<dynamic>.from(brons.map((x) => x.toJson())),
        "other": List<dynamic>.from(other.map((x) => x.toJson())),
      };
}

class Bron {
  String name;
  String logo;
  List<String> offer;
  String website;
  String info;

  Bron({
    this.name,
    this.logo,
    this.offer,
    this.website,
    this.info,
  });

  factory Bron.fromJson(Map<String, dynamic> json) => Bron(
        name: json["name"],
        logo: json["logo"],
        offer: List<String>.from(json["offer"].map((x) => x)),
        website: json["website"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "offer": List<dynamic>.from(offer.map((x) => x)),
        "website": website,
        "info": info,
      };
}
