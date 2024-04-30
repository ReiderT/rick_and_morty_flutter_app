import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/services/firebase/auth_service.dart';

class AuthViewModel extends ChangeNotifier {

  final AuthService _authService = AuthService();

  User? _user; 
  User? get user => _user;

  AuthViewModel() {
    _authService.authStateChanges.listen((User? user) {
      /*
      if (user != null) {
        _user = getCurrentUser();
        notifyListeners();
      }
      */
      _user = user;
      notifyListeners();  
    });
  }

  User? getCurrentUser() {
    return _authService.getCurrentUser();  
  }

  Stream<User?> getAuthStateChanges() {
    return _authService.authStateChanges;
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    return await _authService.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createWithEmailAndPassword({required String email, required String password}) async {
    return await _authService.createWithEmailAndPassword(email: email, password: password);
  }

  Future<void> sendEmailVerification() {
    return _authService.getCurrentUser()!.sendEmailVerification();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners(); 
  }
}
