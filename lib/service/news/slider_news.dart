// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/model/slider_model.dart';

class GetNewsSlider {
  List<SliderModel> slider = [];

  Future<List<SliderModel>> getNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=c2ef68fb9506471a81d09f6a94064ba7';

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
                SliderModel articleModel = SliderModel(
                  author: element['author'] ?? 'Unknown',
                  title: element['title'] ?? 'No Title',
                  description: element['description'] ?? 'No Description',
                  url: element['url'] ?? '',
                  urlToImage: element['urlToImage'] ?? '',
                  content: element['content'] ?? 'No Content',
                );
                slider.add(articleModel);
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
    return slider;
  }
}
