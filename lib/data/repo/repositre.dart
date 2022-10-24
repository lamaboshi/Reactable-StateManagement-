import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../model/cart.dart';

class DataRepo {
  Future<Cart> getCarts() async {
    var url = Uri.https('dummyjson.com', '/carts');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(jsonResponse);
      return Cart.fromJson(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return Cart();
    }
  }
}
