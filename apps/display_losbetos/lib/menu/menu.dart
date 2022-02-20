import 'package:display_losbetos/menu/beverages.dart';
import 'package:display_losbetos/menu/breakfestburritos.dart';
import 'package:display_losbetos/menu/burritos.dart';
import 'package:display_losbetos/menu/chimichangadinners.dart';
import 'package:display_losbetos/menu/desserts.dart';
import 'package:display_losbetos/menu/enchiladas.dart';
import 'package:display_losbetos/menu/losbetosspecialties.dart';
import 'package:display_losbetos/menu/mexicandrinksandsodas.dart';
import 'package:display_losbetos/menu/nachos.dart';
import 'package:display_losbetos/menu/sideordersandextras.dart';
import 'package:display_losbetos/menu/soups.dart';
import 'package:display_losbetos/menu/tacos.dart';
import 'package:display_losbetos/menu/tortas.dart';

import 'quesadillas.dart';
import 'salads.dart';

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
