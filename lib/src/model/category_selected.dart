import 'package:flutter_ecommerce_app/src/model/category.dart';

class CategorySelected{
  final  selected_categories = List<Category>();

  add(Category category) {
    this.selected_categories.add(category);
  }

  remove(Category category) {
    this.selected_categories.remove(category);
  }
  //CategoryList({});
}