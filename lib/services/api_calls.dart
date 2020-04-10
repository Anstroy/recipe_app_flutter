import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

final String _baseURL = "api.spoonacular.com";
//const String API_KEY = "e33830a4c39a4837ba390fb050cd284c";
//const String API_KEY = "1f9d617ba13041859ea773423b0e6291";
const String API_KEY = "c412e93b97ca4181a521352987c56254";

Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

Future<dynamic> callIngredients(String hint) async {
  Map<String, String> parameters = {
    'apiKey': API_KEY,
    'query': hint,
    'number': '5'
  };

  Uri uri = Uri.https(
    _baseURL,
    '/food/ingredients/autocomplete',
    parameters,
  );

  var response = await http.get(uri, headers: headers);

  final responseJson = json.decode(response.body);

  return responseJson;
}

/* get recipes by ingredients */
Future<dynamic> callRecipes(dynamic ingredients) async {
  dynamic ingArr = [];

  String query = "";
  ingArr = ingredients.map((x) => x['name']).toList();
  query = ingArr.join(',');

  Map<String, String> parameters = {
    'apiKey': API_KEY,
    'ingredients': query,
  };

  Uri uri = Uri.https(
    _baseURL,
    '/recipes/findByIngredients',
    parameters,
  );

  var response = await http.get(uri, headers: headers);

  final responseJson = json.decode(response.body);
  return responseJson;
}
