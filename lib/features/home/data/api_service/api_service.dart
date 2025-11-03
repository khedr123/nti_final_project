import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nti_final_project/features/home/data/model/product.dart';

class ApiService {
  //
  static const String baseUrl =
      'https://accessories-eshop.runasp.net/api/products';

  //
  static Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        //
        if (data['items'] != null && data['items'] is List) {
          final List items = data['items'];
          return items.map((e) => ProductModel.fromJson(e)).toList();
        } else {
          throw Exception('Invalid API response format: missing items');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print(' Error loading products: $e');
      throw Exception('Error loading products: $e');
    }
  }
}
