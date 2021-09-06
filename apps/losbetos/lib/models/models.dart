final List cartItems = [];

class CartItem {
  final String title;
  final int basePrice;
  final List? addons;

  CartItem({required this.title, required this.basePrice, this.addons});
}

class Cart {
  Cart();
}

class MenuCatagory {
  final String id;
  final String? title;
  final String? description;
  final String type = 'bitesite.catagory';
  final String? imageUrl;
  final List<Menuitem> items;

  MenuCatagory({
    required this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.items = const [],
  });
}

class Menuitem {
  final String id;
  final String? title;
  final String? description;
  final int basePrice;
  final String type = 'bitesite.catagory';
  final String? imageUrl;
  final String? categoryId;

  Menuitem({
    required this.id,
    this.title,
    this.description,
    this.basePrice = 0,
    this.imageUrl,
    this.categoryId,
  });

  Map toMap() {
    Map _map = {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'basePrice': this.basePrice,
      'imageUrl': this.imageUrl,
      'categoryId': this.categoryId,
    };

    return _map;
  }

  static Menuitem fromMap(Map _map) {
    return Menuitem(
      id: _map.containsKey('id') ? _map['id'] : '',
      title: _map.containsKey('title') ? _map['title'] : null,
      description: _map.containsKey('description') ? _map['description'] : null,
      basePrice: _map.containsKey('basePrice') ? _map['basePrice'] : 0,
      imageUrl: _map.containsKey('imageUrl') ? _map['imageUrl'] : null,
      categoryId: _map.containsKey('categoryId') ? _map['categoryId'] : null,
    );
  }
}

class BSCartMenuItem {
  final Menuitem menuitem;
  Map selectedOptions = {};
  int quanity = 1;
  //
  BSCartMenuItem(this.menuitem);
  //

  //
  Map toMap() {
    // return super.toString();
    Map _map = {
      'selectedOptions': selectedOptions,
      'quanity': quanity,
      'menuitem': menuitem.toMap(),
    };
    return _map;
  }
}

class BSCart {
  BSCart({this.items = const []});
  List<BSCartMenuItem> items;
  // ignore: unused_field
  int _total = 0;

  remove(BSCartMenuItem cartMenuItem) {
    items.remove(cartMenuItem);
  }

  add(BSCartMenuItem cartMenuItem) {
    // items.add(cartMenuItem);
    items = [...items, cartMenuItem];
  }

  int get itemsTotal {
    // print('items.length::${items.length}');
    var __total = 0;
    for (var i = 0; i < items.length; i++) {
      var item = items[i];

      // for (var ii = 1; ii < item.quanity + 1; ii++) {
      //   print(ii);

      //   // _total = __total + __subtotal;
      // }
      __total = __total + (item.menuitem.basePrice * item.quanity);
    }

    return __total;
  }

  static BSCart? fromMap(Map _map) {
    // return BSCart()..items;
  }

  Map toMap() {
    Map _map = {};

    for (var i = 0; i < items.length; i++) {
      _map.putIfAbsent(i, () => items[i].toMap());
    }

    return _map;
  }

  List toList() {
    List _list = [];

    for (var i = 0; i < items.length; i++) {
      _list.add(items[i].toMap());
    }

    return _list;
  }

  static BSCart fromList(List fromList) {
    List<BSCartMenuItem> items = [];
    for (var i = 0; i < fromList.length; i++) {
      var _item = fromList[i] as Map;
      // _list.add();
      // print(_item);
      BSCartMenuItem _bs = BSCartMenuItem(Menuitem.fromMap(_item['menuitem']));
      // print('_bs.menuitem.title');
      // print(_bs.menuitem.title);
      _bs.selectedOptions =
          _item.containsKey('selectedOptions') ? _item['selectedOptions'] : {};
      _bs.quanity = _item['quanity'];
      items.add(_bs);
    }
    return BSCart(items: items);
  }
}
