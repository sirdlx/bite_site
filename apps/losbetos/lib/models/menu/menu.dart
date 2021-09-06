import 'package:losbetos/models/menu/beverages.dart';
import 'package:losbetos/models/menu/breakfestburritos.dart';
import 'package:losbetos/models/menu/burritos.dart';
import 'package:losbetos/models/menu/chimichangadinners.dart';
import 'package:losbetos/models/menu/desserts.dart';
import 'package:losbetos/models/menu/enchiladas.dart';
import 'package:losbetos/models/menu/losbetosspecialties.dart';
import 'package:losbetos/models/menu/mexicandrinksandsodas.dart';
import 'package:losbetos/models/menu/nachos.dart';
import 'package:losbetos/models/menu/quesadillas.dart';
import 'package:losbetos/models/menu/salads.dart';
import 'package:losbetos/models/menu/sideordersandextras.dart';
import 'package:losbetos/models/menu/soups.dart';
import 'package:losbetos/models/menu/tacos.dart';
import 'package:losbetos/models/menu/tortas.dart';

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
