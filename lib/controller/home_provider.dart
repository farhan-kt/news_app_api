import 'package:flutter/material.dart';
import 'package:news_app_api/service/news_service.dart';
import 'package:news_app_api/view/home_screen.dart';

class HomeProvider extends ChangeNotifier {
  final NewsService newsViewModel = NewsService();
  FiltereList? selectedItem;
  String name = 'bbc-news';

  selectedItems(item) {
    selectedItem = item;
    notifyListeners();
  }
}
