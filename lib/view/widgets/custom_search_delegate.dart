import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_api/model/character_model.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';
import 'package:rick_and_morty_api/view/theme/text_styles.dart';
import 'package:rick_and_morty_api/viewmodel/api_viewmodel.dart';
import 'package:rick_and_morty_api/viewmodel/navigation_view_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  Timer? _debounce;
  final List<String> categories = ['Nombre', 'Estatus', 'Especie', 'Tipo', 'Genero'];
  final List<String> backgroundText = ['el nombre', 'el estatus', 'la especie', 'el tipo', 'el genero'];
  String selectedCategory = 'Nombre';
  int indexOfSelectedCategory = 0;
  String? name, status, species, type, gender;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = AppDarkTheme.dark;
    return theme.copyWith(
      textTheme: TextTheme(
        titleLarge: TextStyle(color: AppDarkTheme.whiteColor),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppDarkTheme.black600,
        iconTheme: IconThemeData(color: AppDarkTheme.whiteColor),
        actionsIconTheme: IconThemeData(color: AppDarkTheme.whiteColor),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: AppDarkTheme.grayColor),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppDarkTheme.primaryColor,  // Cambia el color del cursor solo en la búsqueda
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          name = status = species = type = gender = '';
        },
        icon: const Icon(Icons.clear),
        color: AppDarkTheme.primaryColor
      ),
      IconButton(
        onPressed: () => _selectCategory(context), 
        icon: const Icon(Icons.filter_list),
        color: AppDarkTheme.primaryColor
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        name = status = species = type = gender = '';
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
      color: AppDarkTheme.primaryColor
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    /*
    _createQuery(selectedCategory);
    Provider.of<CharacterViewModel>(context, listen: false)
      .fetchFilteredCharacters(name: name, status: status, species: species, type: type, gender: gender);
    name = status = species = type = gender = null;
    return buildSuggestions(context);
    */
    //return _buildBackgroundImage();
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
  
    log('Query: $query');
    if (query.isEmpty) return _buildBackgroundImage();

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      //showResults(context);
    });

    log('Aqui 1');
    _createQuery(selectedCategory);
    final filteredCharactersViewModel = Provider.of<CharacterViewModel>(context);
    return FutureBuilder(
      future: filteredCharactersViewModel.fetchFilteredCharacters(name: name, status: status, species: species, type: type, gender: gender),
      builder: (context, AsyncSnapshot<List<CharacterModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }  

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final character = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Provider.of<NavigationProvider>(context, listen: false).origin = 'search_page';
                    context.push('/character_profile', extra: character,);
                  },
                  leading: SizedBox(
                    height: 60.0,
                    width: 60.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(character.image),
                      radius: 100.0,
                    ),
                  ),
                  title: Text(
                    character.name,
                    style: TextStyles.body1(),
                  ),
                  subtitle: Text(
                    character.species.toUpperCase(),
                    style: TextStyles.body2(color: AppDarkTheme.grayColor, fontWeight: TextStyles.fontWeightRegular),
                  ),
                  minVerticalPadding: 20.0,
                  minLeadingWidth: 16.0,
                );
              },
            ),
          );
        }
        return _buildBackgroundImage();
      }
    );
  }

  Widget _buildBackgroundImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40.0,),
          const Center(
            child: SizedBox(
              width: 114.0,
              height: 114.0,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/search_img.png'),
                  radius: 203.0,
              ),
            ),
          ),
          const SizedBox(height: 20.0,),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              'Escribe ${backgroundText[ indexOfSelectedCategory ]} del personaje para empezar a buscar',
              style: TextStyles.body1(color: AppDarkTheme.grayColor, fontWeight: TextStyles.fontWeightRegular),
            ),
          )
        ],
      ),
    );
  }

  @override
  void close(BuildContext context, result) {
    _debounce?.cancel(); 
    super.close(context, result);
  }

  void _createQuery(String category) {
    name = status = species = type = gender = null;  // Reset all to null
    switch (category) {
      case 'Nombre': name = query; break;
      case 'Estatus': status = query; break;
      case 'Especie': species = query; break;
      case 'Tipo': type = query; break;
      case 'Genero': gender = query; break;
      default: break;
    }
  }

  void _selectCategory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;
        return AlertDialog(
          backgroundColor: AppDarkTheme.black800,
          title: Row(
            children: [
              Expanded(
                child: Text(
                  "Selecciona una categoría",
                  style: TextStyles.body1(color: AppDarkTheme.grayColor, fontWeight: TextStyles.fontWeightRegular),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.close, color: AppDarkTheme.whiteColor,)
                  ),
                ),
              )
            ]
          ),
          content: SizedBox(
            height: size.height * 0.22,
            width: size.width * 0.84,
            child: SingleChildScrollView(
              child: ListBody(
                children: categories.asMap().entries.map((entry) {
                  int indexCategory = entry.key;
                  String category = entry.value;

                  return GestureDetector(
                    onTap: () {
                      indexOfSelectedCategory = indexCategory;
                      selectedCategory = category;
                      //log("Categoría seleccionada: $category, index: $indexOfSelectedCategory");
                      query = '';
                      context.pop(context);  // Cierra el diálogo
                      showSuggestions(context);  // Update UI based on the selected category
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: TextStyles.body1(fontWeight: TextStyles.fontWeightRegular),
                        ),
                        const SizedBox(height: 15.0,)
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}