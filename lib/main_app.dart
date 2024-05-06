import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_api/view/routes/routes.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';
import 'package:rick_and_morty_api/viewmodel/api_viewmodel.dart';
import 'package:rick_and_morty_api/viewmodel/auth_view_model.dart';
import 'package:rick_and_morty_api/viewmodel/navigation_view_model.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => CharacterViewModel()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],
      child: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {

          final GoRouter router = GoRouter(
            redirect: (BuildContext context, GoRouterState state) {

              final loggedIn = authViewModel.user != null;
              bool loggingIn = state.matchedLocation == '/login';

              if (!loggedIn && !loggingIn) return '/login';
              
              if (loggedIn && loggingIn && authViewModel.user!.emailVerified) return '/';

              return null;
            },
            routes: myRoutes,
          );

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
            title: 'RickAndMorty',
            theme: AppDarkTheme.dark,
          );
        }
      )
    );
  }
}