import 'package:losbetosapp/src/features/menu/beverages.dart';
import 'package:losbetosapp/src/features/menu/breakfestburritos.dart';
import 'package:losbetosapp/src/features/menu/burritos.dart';
import 'package:losbetosapp/src/features/menu/chimichangadinners.dart';
import 'package:losbetosapp/src/features/menu/desserts.dart';
import 'package:losbetosapp/src/features/menu/enchiladas.dart';
import 'package:losbetosapp/src/features/menu/losbetosspecialties.dart';
import 'package:losbetosapp/src/features/menu/mexicandrinksandsodas.dart';
import 'package:losbetosapp/src/features/menu/nachos.dart';
import 'package:losbetosapp/src/features/menu/quesadillas.dart';
import 'package:losbetosapp/src/features/menu/salads.dart';
import 'package:losbetosapp/src/features/menu/sideordersandextras.dart';
import 'package:losbetosapp/src/features/menu/soups.dart';
import 'package:losbetosapp/src/features/menu/tacos.dart';
import 'package:losbetosapp/src/features/menu/tortas.dart';

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

List<Map<String, dynamic>> menuItems = [
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
