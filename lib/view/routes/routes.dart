import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_api/model/character_model.dart';
import 'package:rick_and_morty_api/view/pages/character_profile_page.dart';
import 'package:rick_and_morty_api/view/pages/home_page.dart';
import 'package:rick_and_morty_api/view/pages/login_page.dart';

List<RouteBase> myRoutes = [
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState  state) => const HomePage(),
  ),
  GoRoute(
    path: '/login',
    builder: (BuildContext context, GoRouterState  state) => const LoginPage(),
  ),
  GoRoute(
    path: '/character_profile',
    builder: (BuildContext context, GoRouterState  state) {
      final character = state.extra as CharacterModel;
      return CharacterProfile(character: character,);
    }
  )
];




