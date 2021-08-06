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

  MenuCatagory({
    required this.id,
    this.title,
    this.description,
    this.imageUrl,
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
}
