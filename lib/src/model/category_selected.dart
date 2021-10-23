import 'package:crypto_meal/src/model/category.dart';

class CategorySelected {
  final selected_categories = [];

  add(Category category) {
    this.selected_categories.add(category);
  }

  remove(Category category) {
    this.selected_categories.remove(category);
  }
}
