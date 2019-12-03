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
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_leader.png",
      role: "Projektledare",
      email: "philip.ngo@medieteknikdagarna.se",
      number: "+46725799874",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Iris Kotsinas",
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_kassor.png",
      role: "Kassör",
      email: "iris.kotsinas@medieteknikdagarna.se",
      number: "+46735108508",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Emma Segolsson",
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_foretag.png",
      role: "Bankettansvarig",
      email: "emma.segolsson@medieteknikdagarna.se",
      number: "+46703540555",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Simon Brefält",
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_massa.png",
      role: "Mässansvarig",
      email: "simon.brefält@medieteknikdagarna.se",
      number: "+46723510683",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "August Kroon",
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_assistent.png",
      role: "Projektassistent",
      email: "august.kroon@medieteknikdagarna.se",
      number: "+46738200077",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Marcus Gladh",
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_forelasning.png",
      role: "Föreläsningsansvarig",
      email: "marcus.gladh@medieteknikdagarna.se",
      number: "+46704216246",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Ebba Nilsson",
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_bankett.png",
      role: "Bankettansvarig",
      email: "ebba.nilsson@medieteknikdagarna.se",
      number: "+46707739902",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Max Skanvik",
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_teknik.png",
      role: "Teknikansvarig",
      email: "max.skanvik@medieteknikdagarna.se",
      number: "+46703101620",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "William Uddmyr",
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_pr.png",
      role: "PR-ansvarig",
      email: "william.uddmyr@medieteknikdagarna.se",
      number: "+46760165455",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Isak Engström",
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_koordinator.png",
      role: "Koordinator",
      email: "isak.engstrom@medieteknikdagarna.se",
      number: "+46761358900",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Victor Lindquist",
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_webb.png",
      role: "Webbansvarig",
      email: "victor.lindquist@medieteknikdagarna.se",
      number: "+46707755138",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Henrik Rosander",
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_tryck.png",
      role: "Tryckansvarig",
      email: "henrik.rosander@medieteknikdagarna.se",
      number: "+46760637811",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Thomas Indrias",
      imagePath:
          "https://thomasindrias.github.io/mtd/assets/images/profile_app.png",
      role: "Appansvarig",
      email: "thomas.indrias@medieteknikdagarna.se",
      number: "+46739882609",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
];
