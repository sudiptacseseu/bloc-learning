import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vanilla_bloc_with_api/model/news.dart';

class ApiCall {
  Future<News> getNews() async {
    var newsModel;
    try {
      var response = await http.get(Uri.parse(
          'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=022c4b1822c54599adf3c36286405c66'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(response.body);
        var jsonMap = json.decode(jsonString);
        newsModel = News.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }
    return newsModel;
  }
}
