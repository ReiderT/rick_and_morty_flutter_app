import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Stream<User?> get authStateChanges {
    return _auth.authStateChanges();
  }

  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createWithEmailAndPassword({required String email, required String password}) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  /*
  Future<void> sendEmailVerification() {
    return _auth.currentUser!.sendEmailVerification();
  }
  */

  Future<void> signOut() async {
    await _auth.signOut();
  }
}