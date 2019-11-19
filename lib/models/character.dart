import 'package:flutter/material.dart';

class Character {
  final String name;
  final String imagePath;
  final String role;
  final String email;
  final String number;
  final List<Color> colors;

  Character({
    this.name,
    this.imagePath,
    this.role,
    this.email,
    this.number,
    this.colors,
  });
}

List characters = [
  Character(
      name: "Philip Ngo",
      imagePath: "assets/images/profile_leader.png",
      role: "Projektledare",
      email: "philip.ngo@medieteknikdagarna.se",
      number: "07x-xxxxxxx",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "August Kroon",
      imagePath: "assets/images/profile_assistent.png",
      role: "Projektassistent",
      email: "august.kroon@medieteknikdagarna.se",
      number: "07x-xxxxxxx",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Emma Segolsson",
      imagePath: "assets/images/profile_foretag.png",
      role: "Bankettansvarig",
      email: "emma.segolsson@medieteknikdagarna.se",
      number: "07x-xxxxxxx",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Thomas Indrias",
      imagePath: "assets/images/profile_app.png",
      role: "Appansvarig",
      email: "thomas.indrias@medieteknikdagarna.se",
      number: "073-9882609",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Ebba Nilsson",
      imagePath: "assets/images/profile_bankett.png",
      role: "Bankettansvarig",
      email: "ebba.nilsson@medieteknikdagarna.se",
      number: "07x-xxxxxxx",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Simon Brefält",
      imagePath: "assets/images/profile_massa.png",
      role: "Mässansvarig",
      email: "simon.brefält@medieteknikdagarna.se",
      number: "07x-xxxxxxx",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "William Uddmyr",
      imagePath: "assets/images/profile_pr.png",
      role: "PR-ansvarig",
      email: "william.uddmyr@medieteknikdagarna.se",
      number: "07x-xxxxxxx",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Henrik Rosander",
      imagePath: "assets/images/profile_tryck.png",
      role: "Tryckansvarig",
      email: "henrik.rosander@medieteknikdagarna.se",
      number: "07x-xxxxxxx",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Marcus Gladh",
      imagePath: "assets/images/profile_forelasning.png",
      role: "Föreläsningsansvarig",
      email: "marcus.gladh@medieteknikdagarna.se",
      number: "07x-xxxxxxx",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Isak Engström",
      imagePath: "assets/images/profile_koordinator.png",
      role: "Koordinator",
      email: "isak.engstrom@medieteknikdagarna.se",
      number: "07x-xxxxxxx",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
];
