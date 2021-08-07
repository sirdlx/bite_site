import 'package:losbetos/models/menu02/beverages.dart';
import 'package:losbetos/models/menu02/breakfestburritos.dart';
import 'package:losbetos/models/menu02/burritos.dart';
import 'package:losbetos/models/menu02/chimichangadinners.dart';
import 'package:losbetos/models/menu02/desserts.dart';
import 'package:losbetos/models/menu02/enchiladas.dart';
import 'package:losbetos/models/menu02/losbetosspecialties.dart';
import 'package:losbetos/models/menu02/mexicandrinksandsodas.dart';
import 'package:losbetos/models/menu02/nachos.dart';
import 'package:losbetos/models/menu02/quesadillas.dart';
import 'package:losbetos/models/menu02/salads.dart';
import 'package:losbetos/models/menu02/sideordersandextras.dart';
import 'package:losbetos/models/menu02/soups.dart';
import 'package:losbetos/models/menu02/tacos.dart';
import 'package:losbetos/models/menu02/tortas.dart';
import 'package:losbetos/models/models.dart';

List catagories = [
  beverages,
  breakfestburritos,
  burritos,
  chimichangadinners,
  desserts,
  enchiladas,
  losbetosspecialties,
  mexicandrinksandsodas,
  nachos,
  quesadillas,
  salads,
  sideordersandextras,
  soups,
  tacos,
  tortas,
];

List get _getMenuItems => [
      ...beverages['items'],
      ...breakfestburritos['items'],
      ...burritos['items'],
      ...chimichangadinners['items'],
      ...desserts['items'],
      ...enchiladas['items'],
      ...losbetosspecialties['items'],
      ...mexicandrinksandsodas['items'],
      ...nachos['items'],
      ...quesadillas['items'],
      ...salads['items'],
      ...sideordersandextras['items'],
      ...soups['items'],
      ...tacos['items'],
      ...tortas['items'],
    ];

List<Menuitem> get getMenuItems {
  return (_getMenuItems).map((e) {
    return Menuitem(
      id: e['id'],
      description: e.containsKey('description') ? e['description'] : '',
      title: e['title'],
      basePrice: e['base_price'],
      imageUrl: (e as Map).containsKey('imageUrl') ? e['imageUrl'] : null,
      categoryId: (e).containsKey('category_id') ? e['category_id'] : null,
    );
  }).toList();
}
