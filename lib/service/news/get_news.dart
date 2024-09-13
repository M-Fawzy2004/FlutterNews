import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/article_model.dart';

class GetNews {
  List<ArticleModel> news = [];

  Future<List<ArticleModel>> getNews({required String q}) async {
    String url =
        'https://newsapi.org/v2/everything?q=$q&sortBy=publishedAt&apiKey=c2ef68fb9506471a81d09f6a94064ba7';
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'ok') {
          if (jsonData['articles'] != null) {
            jsonData['articles'].forEach((element) {
              if (element['urlToImage'] != null &&
                  element['urlToImage'] != '' &&
                  element['title'] != null &&
                  element['title'] != '') {
                ArticleModel articleModel = ArticleModel(
                  author: element['author'] ?? 'Unknown',
                  title: element['title'] ?? 'No Title',
                  description: element['description'] ?? 'No Description',
                  url: element['url'] ?? '',
                  urlToImage: element['urlToImage'] ?? '',
                  content: element['content'] ?? 'No Content',
                );
                news.add(articleModel);
              }
            });
          }
        }
      } else {
        print('Response status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return news;
  }
}
