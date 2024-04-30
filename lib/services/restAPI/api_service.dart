import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // URL base de la API
  final String baseUrl = "https://rickandmortyapi.com/api";

  // Método para obtener personajes
  Future<Map<String, dynamic>> getCharacters() async {
    try {
      // Realiza la solicitud GET
      final response = await http.get(Uri.parse("$baseUrl/character"));
      
      // Verifica si la solicitud fue exitosa
      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        // Manejo de errores cuando el servidor responde con un código de error
        throw Exception('Failed to load characters. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejo de errores de conexión u otros errores
      throw Exception('Failed to load characters: $e');
    }
  }
}