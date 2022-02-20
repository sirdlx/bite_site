import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:losbetosapp/src/features/menu_item/menu_item_model.dart';

class OrderModel {
  String? id;
  final String? status;
  final double? timePlaced;
  final double? timefinished;
  final String? orderedBy;
  final String? paymentId;

  List<CartMenuItem>? items;

  OrderModel({
    String? orderId,
    this.id,
    this.status,
    this.timePlaced,
    this.timefinished,
    this.orderedBy,
    this.paymentId,
    this.items,
  }) {
    id = orderId ?? const Uuid().v4();
    items ??= [];
  }

  OrderModel copyWith({
    String? id,
    String? status,
    double? timePlaced,
    double? timefinished,
    String? orderedBy,
    String? paymentId,
    List<CartMenuItem>? items,
  }) {
    return OrderModel(
      id: id ?? this.id,
      status: status ?? this.status,
      timePlaced: timePlaced ?? this.timePlaced,
      timefinished: timefinished ?? this.timefinished,
      orderedBy: orderedBy ?? this.orderedBy,
      paymentId: paymentId ?? this.paymentId,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'timePlaced': timePlaced,
      'timefinished': timefinished,
      'orderedBy': orderedBy,
      'paymentId': paymentId,
      'items': items?.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      status: map['status'],
      timePlaced: map['timePlaced'],
      timefinished: map['timefinished'],
      orderedBy: map['orderedBy'],
      paymentId: map['paymentId'],
      items: List<CartMenuItem>.from(
          map['items']?.map((x) => CartMenuItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) {
    return OrderModel.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, status: $status, timePlaced: $timePlaced, timefinished: $timefinished, orderedBy: $orderedBy, paymentId: $paymentId, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        other.status == status &&
        other.timePlaced == timePlaced &&
        other.timefinished == timefinished &&
        other.orderedBy == orderedBy &&
        other.paymentId == paymentId &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        timePlaced.hashCode ^
        timefinished.hashCode ^
        orderedBy.hashCode ^
        paymentId.hashCode ^
        items.hashCode;
  }
}

enum OrderStatus { wating, preparing, ready, canceled, complete }
