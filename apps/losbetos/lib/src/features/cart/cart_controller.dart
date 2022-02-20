import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:losbetosapp/src/features/menu_item/menu_item_model.dart';
import 'package:losbetosapp/src/features/orders/order_model.dart';

class CartController extends ChangeNotifier {
  final String baseUrl = '/apps/bitesite.losbetos';

  final Function onUpdate;
  CartController({
    required this.onUpdate,
  });

  String get ordersUrl => '$baseUrl/orders';
  CollectionReference get ordersRef => FirebaseFirestore.instance
      .collection(ordersUrl)
      .withConverter<OrderModel>(
        fromFirestore: (snapshot, _) => OrderModel.fromMap(snapshot.data()!),
        toFirestore: (model, _) => model.toMap(),
      );

  OrderModel _cart = OrderModel();
  OrderModel get cart => _cart;

  int get total => _itemsTotal;

  removeFromCart(CartMenuItem cartMenuItem) {
    _cart.items!.remove(cartMenuItem);
    onUpdate != null ? onUpdate() : null;
    notifyListeners();
  }

  addToCart(CartMenuItem cartMenuItem) {
    _cart.items!.add(cartMenuItem);
    onUpdate != null ? onUpdate() : null;
    notifyListeners();
  }

  int get _itemsTotal {
    var __total = 0;

    if (_cart.items == null) {
      return __total;
    }
    for (var i = 0; i < cart.items!.length; i++) {
      var item = cart.items![i];
      __total += (item.menuItem.basePrice * item.quanity);
    }
    return __total;
  }

  updateQuanity(CartMenuItem cartMenuItem, int quanity) {
    cart.items = cart.items!.map((e) {
      e.internalId == cartMenuItem.internalId ? e.quanity = quanity : e;
      return e;
    }).toList();

    onUpdate != null ? onUpdate() : null;
    notifyListeners();
  }

  void loadFromJson(String cart) {
    _cart = OrderModel.fromJson(cart);
    notifyListeners();
  }
}
