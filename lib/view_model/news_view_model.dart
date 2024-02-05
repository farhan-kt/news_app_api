import 'package:news_app_api/model/categories_news_model.dart';
import 'package:news_app_api/model/news_headline_model.dart';
import 'package:news_app_api/service/news_service.dart';

class NewsViewModel {
  final _ser = NewsService();

  Future<NewsHeadlineModel> fetchNewsChannelHeadline(String channelName) async {
    final response = await _ser.fetchNewsChannelHeadline(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNews(String category) async {
    final response = await _ser.fetchCategoriesNews(category);
    return response;
  }
}
