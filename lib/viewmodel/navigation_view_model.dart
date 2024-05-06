import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  String _origin = '';

  set origin(String origin) {
    _origin = origin;
    notifyListeners();
  }

  String get origin => _origin;
}