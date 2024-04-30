import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/model/character_model.dart';
import 'package:rick_and_morty_api/services/restAPI/api_service.dart';

class CharacterViewModel with ChangeNotifier {

  ApiService apiService = ApiService();
  List<CharacterModel> characters = [];

  // Corrected the typo in the function name
  void fetchCharacters() async {
    try {
      final response = await apiService.getCharacters();
      if (response.containsKey("results")) {
        List<CharacterModel> fetchedCharacters = (response["results"] as List)
            .map((model) => CharacterModel.fromJson(model as Map<String, dynamic>))
            .toList();
        characters = fetchedCharacters;
        notifyListeners();
        // Imprimir la lista de personajes
        /*
        log("Characters fetched: ${characters.length}");
        for (var character in characters) {
          log("Character: ${character.location.name}");
        }
        */
      } else {
        // Handle the situation when 'results' is not in the response
        log("No results found in the fetched data.");
      }
    } catch (e) {
      log("An error occurred while fetching characters: $e");
      // Optionally, handle the error state in your UI by notifying listeners
      // For example, set an error message state and expose it to the UI
    }
  }
}