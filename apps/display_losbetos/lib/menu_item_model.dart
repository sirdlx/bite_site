import 'dart:convert';

import 'package:flutter/foundation.dart';

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

enum MenuOptionType {
  single,
  multi,
}

mMenuOptionTypeFromString(String typeString) {
  switch (typeString) {
    case 'MenuOptionType.single':
      return MenuOptionType.single;

    case 'MenuOptionType.multi':
      return MenuOptionType.multi;
  }
}

class MenuOptionModel {
  bool? mustSelect;
  MenuOptionType? type;

  List<Menuitem>? items;

  MenuOptionModel({this.mustSelect, this.type, this.items});

  Map<String, dynamic> toMap() {
    return {
      'mustSelect': mustSelect,
      'type': type?.toString(),
      'items': items?.map((x) => x.toMap()).toList(),
    };
  }

  factory MenuOptionModel.fromMap(Map<String, dynamic> map) {
    return MenuOptionModel(
      mustSelect: map['mustSelect'],
      type: map['type'] != null ? mMenuOptionTypeFromString(map['type']) : null,
      items: map['items'] != null
          ? List<Menuitem>.from(map['items']?.map((x) => Menuitem.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuOptionModel.fromJson(String source) =>
      MenuOptionModel.fromMap(json.decode(source));
}

class Menuitem {
  final String id;
  final String? title;
  final String? description;
  final int basePrice;
  final String type = 'bitesite.menu.item';
  final String? imageUrl;
  final String? categoryId;
  final List<MenuOptionModel>? options;

  Menuitem({
    required this.id,
    this.title,
    this.description,
    this.basePrice = 0,
    this.imageUrl,
    this.categoryId,
    this.options,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'basePrice': basePrice,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'options': options?.map((x) => x.toMap()).toList(),
    };
  }

  factory Menuitem.fromMap(Map<String, dynamic> map) {
    return Menuitem(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      basePrice: map['basePrice'],
      imageUrl: map['imageUrl'],
      categoryId: map['categoryId'],
      options: map['options'] != null
          ? List<MenuOptionModel>.from(
              map['options']?.map((x) => MenuOptionModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Menuitem.fromJson(String source) =>
      Menuitem.fromMap(json.decode(source));

  Menuitem copyWith({
    String? id,
    String? title,
    String? description,
    int? basePrice,
    String? imageUrl,
    String? categoryId,
    List<MenuOptionModel>? options,
  }) {
    return Menuitem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      basePrice: basePrice ?? this.basePrice,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      options: options ?? this.options,
    );
  }

  @override
  String toString() {
    return 'Menuitem(id: $id, title: $title, description: $description, basePrice: $basePrice, imageUrl: $imageUrl, categoryId: $categoryId, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Menuitem &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.basePrice == basePrice &&
        other.imageUrl == imageUrl &&
        other.categoryId == categoryId &&
        listEquals(other.options, options);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        basePrice.hashCode ^
        imageUrl.hashCode ^
        categoryId.hashCode ^
        options.hashCode;
  }
}

class CartMenuItem {
  final Menuitem menuItem;
  final List<Menuitem>? selectedOptions;
  int quanity;

  CartMenuItem({
    required this.menuItem,
    this.selectedOptions,
    this.quanity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'menuItem': menuItem.toMap(),
      'quanity': quanity,
      'selectedOptions': selectedOptions?.map((x) => x.toMap()).toList(),
    };
  }

  factory CartMenuItem.fromMap(Map<String, dynamic> map) {
    return CartMenuItem(
      menuItem: Menuitem.fromMap(map['menuItem']),
      quanity: map['quanity'],
      selectedOptions: map['selectedOptions'] != null
          ? List<Menuitem>.from(
              map['selectedOptions']?.map((x) => Menuitem.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartMenuItem.fromJson(String source) =>
      CartMenuItem.fromMap(json.decode(source));

  CartMenuItem copyWith({
    Menuitem? menuItem,
    List<Menuitem>? options,
    int? quanity,
    List<Menuitem>? selectedOptions,
  }) {
    return CartMenuItem(
      menuItem: menuItem ?? this.menuItem,
      quanity: quanity ?? this.quanity,
      selectedOptions: selectedOptions ?? this.selectedOptions,
    );
  }

  @override
  String toString() {
    return 'CartMenuItem(menuItem: $menuItem,  quanity: $quanity, selectedOptions: $selectedOptions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartMenuItem &&
        other.menuItem == menuItem &&
        other.quanity == quanity &&
        listEquals(other.selectedOptions, selectedOptions);
  }

  @override
  int get hashCode {
    return menuItem.hashCode ^ quanity.hashCode ^ selectedOptions.hashCode;
  }
}
