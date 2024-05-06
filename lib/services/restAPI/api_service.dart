import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  // URL base de la API
  final String baseUrl = "https://rickandmortyapi.com/api";

  // Método para obtener personajes
  Future<Map<String, dynamic>> getCharacters(String endpoint) async {
    try {
      // Realiza la solicitud GET
      //log("$baseUrl$endpoint");
      final uri = Uri.parse("$baseUrl/$endpoint"); 
      final response = await http.get(uri);
      
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

  // Método para obtener múltiples episodios
  Future<List<dynamic>> getEpisodes(String episodeIds) async {
    try {
      Uri uri = Uri.parse("$baseUrl$episodeIds");
      log("Request URL: $uri");

      final response = await http.get(uri);
      log("Status code: ${response.statusCode.toString()}");  // Conversión correcta a String
      if (response.statusCode == 200) {
        // Verifica si la solicitud fue exitosa
        return json.decode(response.body) as List<dynamic>;
      } else {
        // Manejo de errores cuando el servidor responde con un código de error
        throw Exception('Failed to load episodes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejo de errores de conexión u otros errores
      throw Exception('Failed to load episodes: $e');
    }
  }

  Future<Map<String, dynamic>> getFilterCharacters(Map<String, String> params) async {  
    try {
      final uri = Uri.parse("$baseUrl/character/").replace(queryParameters: params);    
      log("Request URL: $uri");

      final response = await http.get(uri);
      log("Status code: ${response.statusCode.toString()}");  // Conversión correcta a String
      if (response.statusCode == 200) {
        //log(response.body);
        // Verifica si la solicitud fue exitosa
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        // Manejo de errores cuando el servidor responde con un código de error
        throw Exception('Failed to load episodes. Status code: ${response.statusCode}');
      }

    } catch (e) {
      // Manejo de errores de conexión u otros errores
      throw Exception('Failed to load characters: $e');
    }

  }
}