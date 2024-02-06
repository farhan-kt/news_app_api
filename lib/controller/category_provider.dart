import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  String categoryName = 'General';

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  categoryList(index) {
    categoryName = categoriesList[index];
    notifyListeners();
  }
}
