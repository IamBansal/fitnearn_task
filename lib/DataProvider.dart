import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  late List<dynamic> _dataList = [];

  List<dynamic> get dataList => _dataList;
  String apiKey = dotenv.env['API_KEY'] ?? '';

  Future<void> fetchData() async {
    try {
      if (kDebugMode) {
        print("APi is called");
      }
      final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt&language=en&apiKey=$apiKey'));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _dataList = responseData['articles'];
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }
}

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    Source source = (json['source'])
        .map((article) => Source.fromJson(article));
    return Article(
      source: source,
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }
}

class Source {
  final String id;
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class NewsResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    List<Article> articlesList = (json['articles'] as List)
        .map((article) => Article.fromJson(article))
        .toList();

    return NewsResponse(
      status: json['status'] ?? '',
      totalResults: json['totalResults'] ?? 0,
      articles: articlesList,
    );
  }
}
