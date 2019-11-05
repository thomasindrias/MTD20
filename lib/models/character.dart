import 'package:flutter/material.dart';

class Character {
  final String name;
  final String imagePath;
  final String description;
  final List<Color> colors;

  Character({this.name, this.imagePath, this.description, this.colors});
}

List characters = [
  Character(
    name: "Cygni",
    imagePath: "assets/images/cygni_logo.png",
    description:
        "Cygni grundades med visionen att skapa den bästa arbetsplatsen för en skicklig och ambitiös systemutvecklare. Vi har vunnit titeln Sveriges Bästa Arbetsplats 5 år i rad och dessutom vunnit titeln Europas Bästa Arbetsplats 4 gånger i Great Place To Works världsledande medarbetarundersökning som genomförs i över 50 länder: ett fint kvitto på våra ambitioner. \n\nLäs mer på medieteknikdagarna.se",
    colors: [Colors.orange.shade200, Colors.deepOrange.shade400]
  ),
  Character(
    name: "Gaia",
    imagePath: "assets/images/gaia_logo.png",
    description:
    "Välkommen till Gaia! Vi är en digitaliseringsbyrå som hjälper företag att digitaliseras. Vi utvecklar deras tjänster eller produkter med nya digitala lösningar, smart strategi och avancerad analys. Själva tanken är att det ska vara superenkelt och roligt att använda de nya lösningarna, så att våra kunder blir mer attraktiva hos sina kunder, medarbetare eller medborgare.\n\nLäs mer på medieteknikdagarna.se",
      colors: [Colors.blue.shade200, Colors.blueAccent.shade400]
  ),
];
