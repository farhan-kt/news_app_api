import 'package:flutter/material.dart';
import 'package:news_app_api/model/categories_news_model.dart';
import 'package:news_app_api/model/news_headline_model.dart';
import 'package:news_app_api/service/news_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _services = NewsService();
  Future<NewsHeadlineModel> fetchNewsHeadlinesFromApi(
      String channelName) async {
    try {
      return await _services.fetchNewsChannelHeadline(channelName);
    } catch (e) {
      throw Exception('Error fetching news channel headlines');
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsFromApi(
      String category) async {
    try {
      return await _services.fetchCategoriesNews(category);
    } catch (e) {
      throw Exception('Error fetching category news');
    }
  }
}
