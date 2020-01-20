// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

class Article {
  List<ArticleElement> articles;

  Article({
    this.articles,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        articles: List<ArticleElement>.from(
            json["articles"].map((x) => ArticleElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class ArticleElement {
  String title;
  String imagePath;
  String description;
  String time;
  String author;
  String website;

  ArticleElement({
    this.title,
    this.imagePath,
    this.description,
    this.time,
    this.author,
    this.website,
  });

  factory ArticleElement.fromJson(Map<String, dynamic> json) => ArticleElement(
        title: json["title"],
        imagePath: json["imagePath"],
        description: json["description"],
        time: json["time"],
        author: json["author"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "imagePath": imagePath,
        "description": description,
        "time": time,
        "author": author,
        "website": website,
      };
}
