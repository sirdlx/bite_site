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
