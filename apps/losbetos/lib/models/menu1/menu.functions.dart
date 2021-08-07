import 'package:losbetos/models/menu1/losbetos.menu.01.dart';
import 'package:losbetos/models/models.dart';

List<MenuCatagory> get getMenuCategories {
  return (losbetosMenu['catagories'] as List).map((e) {
    return MenuCatagory(
      id: e['id'],
      description: e['description'],
      title: e['title'],
      imageUrl: (e as Map<String, dynamic>).containsKey('imageUrl')
          ? e['imageUrl']
          : null,
    );
  }).toList();
}

List<Menuitem> get getMenuItems {
  return (losbetosMenu['catalog'] as List).map((e) {
    return Menuitem(
        id: e['id'],
        description: e.containsKey('description') ? e['description'] : '',
        title: e['title'],
        basePrice: e['base_price'],
        imageUrl: (e as Map).containsKey('imageUrl') ? e['imageUrl'] : null,
        categoryId: (e).containsKey('category_id') ? e['category_id'] : null);
  }).toList();
}

MenuCatagory? menuCategorySingle(String id) {
  var cats = getMenuCategories;
  for (var i = 0; i < cats.length; i++) {
    if (cats[i].id == id) {
      return cats[i];
    }
  }
}

List<Menuitem>? menuCategoryItems(String id) {
  List<Menuitem> arr = [];
  for (var i = 0; i < getMenuItems.length; i++) {
    if (getMenuItems[i].categoryId == id) {
      arr.add(getMenuItems[i]);
    }
  }
  return arr;
}
