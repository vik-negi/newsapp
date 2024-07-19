import 'package:dartz/dartz_streaming.dart';

class ArticleModelResponse {
  final List<ArticleModel> articles;

  ArticleModelResponse({required this.articles});

  factory ArticleModelResponse.fromJson(Map<String, dynamic> json) {
    return ArticleModelResponse(
      articles: (json['articles'] as List)
          .map((e) => ArticleModel.fromJson(e))
          .toList(),
    );
  }
}

class ArticleModel {
  final String? author;
  final String title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;
  final SourceModel? source;

  ArticleModel({
    this.author,
    required this.title,
    this.description,
    this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    this.source,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      content: json['content'],
      description: json['description'],
      publishedAt: json['publishedAt'],
      title: json['title'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      author: json['author'],
      source:
          json['source'] == null ? null : SourceModel.fromJson(json['source']),
    );
  }
}

class SourceModel {
  final String? id;
  final String? name;

  SourceModel({this.id, required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
