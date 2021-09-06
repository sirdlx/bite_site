import 'package:cloud_functions/cloud_functions.dart';

Future<dynamic> getFruit(String function) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(function);
  final results = await callable();
  return results.data;
}
