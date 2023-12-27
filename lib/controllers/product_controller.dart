import 'dart:convert';
import 'package:shopifye_e_commerce/controllers/function.dart';
import 'package:shopifye_e_commerce/models/product.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> getProducts() async {
  final response = await http.get(Uri.parse('$url/products'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body)['data'];
    List<Product> products =
        data.map((json) => Product.fromJson(json)).toList();
    return products;
  } else {
    throw Exception('Unable to load data');
  }
}
