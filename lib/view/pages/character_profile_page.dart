// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_api/model/character_model.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';
import 'package:rick_and_morty_api/view/theme/text_styles.dart';
import 'package:rick_and_morty_api/view/widgets/card1.dart';
import 'package:rick_and_morty_api/view/widgets/custom_badge.dart';
import 'package:rick_and_morty_api/view/widgets/custom_button2.dart';
import 'package:rick_and_morty_api/view/widgets/custom_gradient.dart';
import 'package:rick_and_morty_api/viewmodel/api_viewmodel.dart';
import 'package:rick_and_morty_api/viewmodel/navigation_view_model.dart';

class CharacterProfile extends StatefulWidget {

  const CharacterProfile({
    super.key,
    required this.character,
  });

  final CharacterModel character;

  @override
  State<CharacterProfile> createState() => _CharacterProfileState();
}

class _CharacterProfileState extends State<CharacterProfile> {

  int maxIntems = 3;
  int itemCounter = 0;
  List<CharacterModel> characterSection = [];
  String origin = '';

  @override
  void initState() {
    super.initState();
    Provider.of<CharacterViewModel>(context, listen: false).fetchEpisodes(widget.character);
    origin = Provider.of<NavigationProvider>(context, listen: false).origin;
  }

  @override
  Widget build(BuildContext context) {
    final episodesViewModel = Provider.of<CharacterViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;

    final characterViewModel = Provider.of<CharacterViewModel>(context);
    if (origin == 'home_page' || origin == 'profile_page') {
      characterSection = calculateDynamicIndex(characterViewModel, widget.character.id);
    }

    //for (int i = 0; i < maxIntems; i++) {
    //  log('Character id: ${characterSection[ i ].id}');
    //}

    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          characterInfo(context, episodesViewModel), 

          const SliverToBoxAdapter(child: SizedBox(height: 40.0,),),

          if (origin == 'home_page' || origin == 'profile_page') moreCharacters(screenHeight) 
        ],
      )
    );
  }

  
  SliverPadding characterInfo(BuildContext context, CharacterViewModel episodesViewModel) {
    double containerIDHeight = 72.0;
    double containerIDWidth = 112.0;

    return SliverPadding(
      padding: const EdgeInsets.only(left: 16.0, top: 40.0, right: 16.0,),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Hero(
                    tag: 'character_avatar_${widget.character.id}',
                    child: SizedBox(
                      width: 181.0,
                      height: 181.0,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.character.image),
                          radius: 100.0,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      height: containerIDHeight,
                      width: containerIDWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0), 
                        gradient: LinearGradient (
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppDarkTheme.primaryColor,
                            AppDarkTheme.primaryColor2,
                          ]
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 32.0, top: 9.0, right: 32.0, bottom: 9.0),
                        decoration: BoxDecoration(
                          color: AppDarkTheme.black900,
                          borderRadius: BorderRadius.circular(23.0), 
                        ),  
                        child: CustomGradient(
                          widget: Text(widget.character.id.toString(), style: TextStyles.display3()),
                        ), 
                      ),
                    ),
                  ),
                )
              ],
            ),
                
            const SizedBox(height: 20.0,),
                
            SizedBox(
              width: 266.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.character.name,
                    style: TextStyles.display1(),
                  ),
                
                  const SizedBox(height: 15.0,),
                
                  Text(
                    'Species',
                    style: TextStyles.body1(color: AppDarkTheme.grayColor, fontWeight: TextStyles.fontWeightRegular),
                  ),
                  const SizedBox(height: 5.0,),
                  Text(
                    widget.character.species,
                    style: TextStyles.body1(fontWeight: TextStyles.fontWeightRegular),
                  ),
                
                  const SizedBox(height: 15.0,),
                
                  Text(
                    'Created',
                    style: TextStyles.body1(color: AppDarkTheme.grayColor, fontWeight: TextStyles.fontWeightRegular),
                  ),
                  Text(
                    widget.character.created,
                    style: TextStyles.body1(fontWeight: TextStyles.fontWeightRegular),
                  ),
            
                  const SizedBox(height: 15.0,),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [                  
                      CustomBadge(
                        padding: const EdgeInsets.only(left: 12.0, top: 4.0, right: 12.0, bottom: 4.0),
                        icon: Icon(Icons.location_on, color: AppDarkTheme.pink400,),
                        label: Text(
                          '${widget.character.origin.name}   ',
                          style: TextStyles.body2(color: AppDarkTheme.pink400),
                        ),
                        borderLineColor: AppDarkTheme.pink400,
                        width: widget.character.origin.name.length < 14 ? null : 150.0,
                      ),
                      const SizedBox(width: 10.0,),
                      CustomBadge(
                        padding: const EdgeInsets.only(left: 12.0, top: 4.0, right: 12.0, bottom: 4.0),
                        icon: ImageIcon(
                          const AssetImage('assets/icons/heart.png'),
                          color: widget.character.status == 'Dead' ? AppDarkTheme.red400 : AppDarkTheme.green500,
                        ),
                        label: Text(
                          '${widget.character.status}   ',
                          style: TextStyles.body2(color: widget.character.status == 'Dead' ? AppDarkTheme.red400 : AppDarkTheme.green500),
                        ),
                        borderLineColor: widget.character.status == 'Dead' ? AppDarkTheme.red400 : AppDarkTheme.green500,
                        width: widget.character.status.length < 5 ? null : 100.0,
                      ),
                    ]
                  ),
                ],
              ),
            ),   
                
            const SizedBox(height: 20.0,),
                
            CustomButton2(
              text: 'Ver espisodios',
              onTap: () {
                showListofEpisodes(context, episodesViewModel);
              },
            ), 
                
            const SizedBox(height: 15.0,),       
          ],
        ),
      ), 
    ); 
  }

  SliverPadding moreCharacters(double screenHeight) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0,),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 0.51 * screenHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: maxIntems,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ 
                  SizedBox(
                    width: 327.0,
                    child: CardStyle1(
                      character: characterSection[ index ],
                      screenHeight: screenHeight,
                      originPage: 'profile_page',
                    ),
                  ),
                  (index < (maxIntems - 1)) ? const SizedBox(width: 15.0,) : const SizedBox(width: 0.0,),  
                ]
              );
            }
          ),
        ),
      ),    
    );
  }

  List<CharacterModel> calculateDynamicIndex(CharacterViewModel characterViewModel ,int selectedIndex) {
    List<CharacterModel> collection = [];  
    List<CharacterModel> characters = [];
    int listCharactersLength = -1;

    switch (origin) {
      case 'home_page':
      case 'profile_page':
        listCharactersLength = characterViewModel.characters.length;
        characters = characterViewModel.characters; 
        break;
      case 'search_page':
        listCharactersLength = characterViewModel.filterCharacters.length;
        characters = characterViewModel.filterCharacters; 
        break;
      default:
        return collection;  
    }
    //int listCharactersLength = characterViewModel.characters.length;

    // Intentar añadir primero los ítems siguientes al seleccionado.
    for (int i = selectedIndex; i < listCharactersLength && collection.length < maxIntems; i++) {
      //collection.add(characterViewModel.characters[ i ]);
      collection.add(characters[ i ]);
    }

    // Si no hay suficientes ítems siguientes, añade los ítems anteriores.
    if (collection.length < maxIntems) {
      for (int i = selectedIndex - 2; i >= 0 && collection.length < maxIntems; i--) {
        //collection.insert(0, characterViewModel.characters[ i ]); 
        collection.add(characters[ i ]);
      }
    }

    return collection;
  }

  void showListofEpisodes(BuildContext context, CharacterViewModel episodesModel) {
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
                  "Episodes",
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
            height: size.height * 0.37,//  300,
            width: size.width * 0.84,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: episodesModel.episodes.length,
                    itemBuilder: (context, index) {
                      log('Item: $index');
                      final episode = episodesModel.episodes[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.only(left: 0.0),
                        leading: const SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/portal.png'),
                          ),
                        ),                        
                        title: Text(
                          episode.name!,
                          style: TextStyles.body1(fontWeight: TextStyles.fontWeightRegular),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  } 

}
