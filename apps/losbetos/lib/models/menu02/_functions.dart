import 'package:losbetos/models/menu02/menu.dart';
import 'package:losbetos/models/models.dart';

List<MenuCatagory> get getMenuCategories {
  return catagories.map((e) {
    Map<String, dynamic> map = (e as Map<String, dynamic>);
    return MenuCatagory(
      id: map.containsKey('id')
          ? (e['id'] as String).toLowerCase()
          : e['title'].toString().split(' ').join('').toString().toLowerCase(),
      description: e['description'],
      title: e['title'],
      imageUrl: map.containsKey('imageUrl') ? e['imageUrl'] : null,
      items: parseItems(e),
    );
  }).toList();
}

List<Menuitem> parseItems(Map<String, dynamic> e) {
  // print(e['items']);
  if (!e.containsKey('items')) {
    return [];
  }
  List<Menuitem> arr = [];
  List items = e['items'];

  if (items.isEmpty) {
    return [];
  }
  for (var i = 0; i < items.length; i++) {
    arr.add(Menuitem(
      id: items[i]['id'],
      description:
          items[i].containsKey('description') ? items[i]['description'] : '',
      title: items[i]['title'],
      basePrice: items[i]['base_price'],
      imageUrl: (items[i] as Map).containsKey('imageUrl')
          ? items[i]['imageUrl']
          : null,
      categoryId: e['id'].toString(),
    ));
  }

  return arr;
  // return e['items'].map((mi) {

  //   // return Menuitem(
  //   //     id: mi['id'],
  //   //     description: mi.containsKey('description') ? mi['description'] : '',
  //   //     title: mi['title'],
  //   //     basePrice: e['base_price'],
  //   //     imageUrl:
  //   //         (mi as Map).containsKey('imageUrl') ? mi['imageUrl'] : null,
  //   //     categoryId:
  //   //         (mi).containsKey('category_id') ? mi['category_id'] : null,
  //   //   );
  // }).toList();
}

MenuCatagory? menuCategorySingle(String id) {
  // print('menuCategorySingle::$id');
  return getMenuCategories.where((element) => element.id == id).first;
  // 002
  // Map map = catagories.where((element) => element['id'] == id).first;
  // print(map);
  // 001
  // for (var i = 0; i < catagories.length; i++) {
  //   print(catagories[i].id == id);
  //   if (catagories[i].id == id) {
  //     // return catagories[i];
  //   }
  // }
}

// List<Menuitem> menuCategoryItems(String id) {
//   print('menuCategoryItems::$menuCategoryItems');
//   MenuCatagory? cat = menuCategorySingle(id);
//   if (cat == null) {
//     return [];
//   }
//   return cat.items!.map((e) {
//     return Menuitem(
//       id: e['id'],
//       description: e.containsKey('description') ? e['description'] : '',
//       title: e['title'],
//       basePrice: e['base_price'],
//       imageUrl: (e as Map).containsKey('imageUrl') ? e['imageUrl'] : null,
//       categoryId: (e).containsKey('category_id') ? e['category_id'] : null,
//     );
//   }).toList();
// }
