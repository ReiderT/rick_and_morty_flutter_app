import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';
import 'package:rick_and_morty_api/view/theme/text_styles.dart';
import 'package:rick_and_morty_api/view/widgets/card1.dart';
import 'package:rick_and_morty_api/view/widgets/custom_search_delegate.dart';
import 'package:rick_and_morty_api/viewmodel/api_viewmodel.dart';
import 'package:rick_and_morty_api/viewmodel/auth_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    Provider.of<CharacterViewModel>(context, listen: false).fetchCharacters();
    _updateStatusBarStyle(AppDarkTheme.black600);
    super.initState();
  }

  @override
  void dispose() {
    _updateStatusBarStyle(Colors.transparent);
    super.dispose();
  }

  void _updateStatusBarStyle(Color color) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color, // Define el color de la barra de estado
      statusBarIconBrightness: Brightness.light, // Define el brillo de los iconos de la barra de estado
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final characterViewModel = Provider.of<CharacterViewModel>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppDarkTheme.black900,
        //appBar: buildAppBar(screenWidth),
        body: characterViewModel.characters.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : KeyboardDismisser(
              child: CustomScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  // AppBar
                  CustomAppBar(screenWidth: screenWidth),
                  // Search Bar
                  const SearchBar(),
                  // Content
                  CharacterList(characterViewModel: characterViewModel, screenHeight: screenHeight),
                ],
              ),
            ),
      ),
    );
      
  }

}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppDarkTheme.black900,
      surfaceTintColor: AppDarkTheme.black900,
      floating: true,
      elevation: 0,
      //expandedHeight: 60.0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16.0, bottom: 8.0),
              child: Container(
                width: (27 * screenWidth) / 100.0,
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  color: AppDarkTheme.black700,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text('Salir',
                          style: TextStyles.body1(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: IconButton(
                          color: AppDarkTheme.whiteColor,
                          onPressed: () async {
                            try {
                              final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
                              await authViewModel.signOut();
                              Fluttertoast.showToast(msg: 'Sesión finalizada');

                              //if (!context.mounted) return;
                              //context.go('/login_page');
                            } catch (e) {
                              Fluttertoast.showToast(msg: 'Error al cerrar sesión: $e');
                            }
                          }, 
                          icon: const Icon(Icons.exit_to_app),
                        ),
                      ),
                    ),
                  ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppDarkTheme.black900,// Search background color
      surfaceTintColor: AppDarkTheme.black900,
      elevation: 0,
      pinned: true,
      collapsedHeight: 120.0,
      flexibleSpace: Container(
        padding: const EdgeInsets.only(left: 16.0, top: 30.0, right: 16.0, bottom: 40.0),
        color: AppDarkTheme.black900,
        child: GestureDetector(
          onTap: () => showSearch(context: context, delegate: CustomSearchDelegate()),
          child: Container(
            height: 60.0,
            margin: EdgeInsets.zero,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppDarkTheme.black800,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0) ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.search,
                      color: AppDarkTheme.grayColor ,
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(
                    child: Text(
                      'Buscar personaje',
                      style: TextStyle(color: AppDarkTheme.grayColor),
                    ),
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppDarkTheme.black900,// Search background color
      surfaceTintColor: AppDarkTheme.black900,
      elevation: 0,
      pinned: true,
      collapsedHeight: 120.0,
      flexibleSpace: Container(
        padding: const EdgeInsets.only(left: 16.0, top: 30.0, right: 16.0, bottom: 40.0),
        color: AppDarkTheme.black900,
        child: Container(
          height: 60.0,
          margin: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppDarkTheme.black800,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0) ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.search,
                    color: AppDarkTheme.grayColor ,
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: AppDarkTheme.primaryColor,
                    decoration: InputDecoration(
                      hintStyle: TextStyles.body2(color: AppDarkTheme.grayColor),
                      border: InputBorder.none,
                      hintText: 'Buscar personaje',
                    ),
                  ),
                ),
            
              ]
            ),
          ),
        ),
      ),
    );
  }
}
*/

class CharacterList extends StatelessWidget {
  const CharacterList({
    super.key,
    required this.characterViewModel,
    required this.screenHeight,
  });

  final CharacterViewModel characterViewModel;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: characterViewModel.characters.length,
        (BuildContext context, int index) {
          //var character = vm.characters[index];
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, ),
            child: CardStyle1(
              character: characterViewModel.characters[ index ],
              screenHeight: screenHeight,
              isBadges: true,
              originPage: 'home_page',
            ),
          );
        }
      )
    );
  }
}
