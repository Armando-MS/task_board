import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// REGLA DE ORO: Importa tus modelos para que el servicio los reconozca
// Ajusta estas rutas según dónde guardaste los archivos
import '../models/auth_model.dart'; 
import '../models/user_model.dart'; 

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.escuelajs.co/api/v1'));
  
  // CORRECCIÓN 1: El nombre correcto es FlutterSecureStorage (sin guiones bajos)
  final _storage = const FlutterSecureStorage();

  // LOGIN
  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        // CORRECCIÓN 2: Ahora AuthToken será reconocido gracias al import
        final tokens = AuthToken.fromJson(response.data);
        await _storage.write(key: 'token', value: tokens.accessToken);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // OBTENER PERFIL
  // CORRECCIÓN 3: UserModel ahora será reconocido
  Future<UserModel?> getProfile() async {
    try {
      String? token = await _storage.read(key: 'token');
      
      final response = await _dio.get(
        '/auth/profile',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  // REGISTRO
  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await _dio.post('/users/', data: {
        "name": name,
        "email": email,
        "password": password,
        "avatar": "https://picsum.photos/800"
      });
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}