class Category {
  int id;

  String name;

  // String image ;
  bool isSelected;

  //Category({this.id,this.name,this.isSelected = false,this.image});
  //final List<Category> selected_categories;
  Category({required this.id, required this.name, this.isSelected = true});
}
