import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app_api/model/categories_news_model.dart';
import 'package:news_app_api/model/news_headline_model.dart';

class NewsService {
  Future<NewsHeadlineModel> fetchNewsChannelHeadline(String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=ce73eb10f00f411bb246b7835edb6f9e';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsHeadlineModel.fromJson(body);
    }
    throw Exception('Data is not fetched');
  }

  Future<CategoriesNewsModel> fetchCategoriesNews(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=ce73eb10f00f411bb246b7835edb6f9e';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Data is not fetched');
  }
}
