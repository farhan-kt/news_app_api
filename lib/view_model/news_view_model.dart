import 'package:news_app_api/model/news_headline_model.dart';
import 'package:news_app_api/service/news_service.dart';

class NewsViewModel {
  final _ser = NewsService();

  Future<NewsHeadlineModel> fetchNewsChannelHeadline() async {
    final response = await _ser.fetchNewsChannelHeadline();
    return response;
  }
}
