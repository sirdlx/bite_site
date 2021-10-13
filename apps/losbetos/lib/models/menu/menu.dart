import 'package:losbetosapp/models/menu/beverages.dart';
import 'package:losbetosapp/models/menu/breakfestburritos.dart';
import 'package:losbetosapp/models/menu/burritos.dart';
import 'package:losbetosapp/models/menu/chimichangadinners.dart';
import 'package:losbetosapp/models/menu/desserts.dart';
import 'package:losbetosapp/models/menu/enchiladas.dart';
import 'package:losbetosapp/models/menu/losbetosspecialties.dart';
import 'package:losbetosapp/models/menu/mexicandrinksandsodas.dart';
import 'package:losbetosapp/models/menu/nachos.dart';
import 'package:losbetosapp/models/menu/quesadillas.dart';
import 'package:losbetosapp/models/menu/salads.dart';
import 'package:losbetosapp/models/menu/sideordersandextras.dart';
import 'package:losbetosapp/models/menu/soups.dart';
import 'package:losbetosapp/models/menu/tacos.dart';
import 'package:losbetosapp/models/menu/tortas.dart';

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
