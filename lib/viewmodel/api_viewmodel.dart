import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/model/character_episode_model.dart';
import 'package:rick_and_morty_api/model/character_model.dart';
import 'package:rick_and_morty_api/services/restAPI/api_service.dart';

class CharacterViewModel with ChangeNotifier {

  ApiService apiService = ApiService();
  List<CharacterModel> characters = [];
  List<CharacterModel> filterCharacters = [];
  List<CharacterEpisodeModel> episodes = [];

  // Corrected the typo in the function name
  void fetchCharacters() async {
    try {
      final response = await apiService.getCharacters('character');
      if (response.containsKey("results")) {
        List<CharacterModel> fetchedCharacters = (response["results"] as List).map((model) => CharacterModel.fromJson(model as Map<String, dynamic>)).toList();
        characters = fetchedCharacters;
        notifyListeners();
        /*
        // Imprimir la lista de personajes
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

  void fetchEpisodes(CharacterModel character) async {
    try {
      String episodeNumberUrl = '';
      for(int i=0; i<character.episode.length; i++) {
        List<String> parts = character.episode[i].split('/');
        episodeNumberUrl += '${parts.last},';
      }
      /*
      if (episodeNumberUrl.endsWith(",")) {
        episodeNumberUrl = episodeNumberUrl.substring(0, episodeNumberUrl.length - 1);
      }
      */
      final response = await apiService.getEpisodes('/episode/$episodeNumberUrl');
      //log("Response length ${response.length.toString()}");
      List<CharacterEpisodeModel> fetchedEpisodes = response.map<CharacterEpisodeModel>((json) => CharacterEpisodeModel.fromJson(json as Map<String, dynamic>)).toList();
      episodes = fetchedEpisodes;
      notifyListeners();
      /*
      for (var episode in episodes) {
        log('Episode: ${episode.name ?? "Unknown"}, Aired: ${episode.airDate ?? "Unknown date"}');
      }
      */
    } catch (e) {
      log("An error occurred while fetching characters: $e");
      // Optionally, handle the error state in your UI by notifying listeners
      // For example, set an error message state and expose it to the UI
    }
  }

  Future<List<CharacterModel>> fetchFilteredCharacters({String? name, String? status, String? species, String? type, String? gender}) async {
    try {
      if (name == null && status == null && species == null && type == null && gender == null) {
        log("No parameters provided for filtering.");
        return filterCharacters;  // Retornar lista vacía si no hay parámetros
      }

      Map<String, String> params = {
        if (name != null) 'name': name,
        if (status != null) 'status': status,
        if (species != null) 'species': species,
        if (type != null) 'type': type,
        if (gender != null) 'gender': gender,
      };

      final response = await apiService.getFilterCharacters(params);
      if (response.containsKey("results")) {
        List<CharacterModel> fetchedFilterCharacters = (response["results"] as List).map((model) => CharacterModel.fromJson(model as Map<String, dynamic>)).toList();
        
        
        // Imprimir la lista de personajes
        log("Characters fetched: ${fetchedFilterCharacters.length}");
        for (var character in fetchedFilterCharacters) {
          log("Character: ${character.name}");
        }
        
        return filterCharacters = fetchedFilterCharacters;
        //notifyListeners();

      } else {
        // Handle the situation when 'results' is not in the response
        log("No results found in the fetched data.");
        return filterCharacters;  // Retorna lista vacía si no hay 'results'
      }

    } catch (e) {
      log("An error occurred while fetching characters: $e");
      return filterCharacters;  // Retorna lista vacía en caso de error
      // Optionally, handle the error state in your UI by notifying listeners
      // For example, set an error message state and expose it to the UI
    }
  }
}