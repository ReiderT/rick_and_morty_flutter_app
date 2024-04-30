import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rick_and_morty_api/firebase_options.dart';
import 'package:rick_and_morty_api/main_app.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}



