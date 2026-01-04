import 'package:dio/dio.dart';
import 'package:task_board/models/info_product.dart';
import 'package:task_board/models/info_category.dart';

class InfoProductServices {
  final Dio _dio = Dio();
  final String _urlP = 'https://api.escuelajs.co/api/v1/products';
  final String _urlC = 'https://api.escuelajs.co/api/v1/categories';

  // info_product_services.dart

Future<List<InfoProduct>> getProducts({int? categoryId}) async {
  try {
    // Definimos los parámetros de búsqueda
    Map<String, dynamic> queryParameters = {};
    if (categoryId != null) {
      queryParameters['categoryId'] = categoryId;
    }

    final response = await _dio.get(
      'https://api.escuelajs.co/api/v1/products',
      queryParameters: queryParameters, // Dio construye la URL: .../products?categoryId=1
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((json) => InfoProduct.fromJson(json)).toList();
    }
    return [];
  } catch (e) {
    throw Exception('Error al filtrar productos: $e');
  }
}

  // Añade este método a tu clase InfoProductServices
Future<List<InfoCategory>> getCategories() async {
  try {
    final response = await _dio.get('https://api.escuelajs.co/api/v1/categories');
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((json) => InfoCategory.fromJson(json)).toList();
    }
    return [];
  } catch (e) {
    throw Exception('Error al cargar categorías: $e');
  }
}
}