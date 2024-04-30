import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_api/view/pages/home_page.dart';
import 'package:rick_and_morty_api/view/pages/login_page.dart';

List<RouteBase> myRoutes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/login_page',
    builder: (context, state) => const LoginPage(),
  ),
];




