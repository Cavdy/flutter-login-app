import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }
  Future<String> currentUser() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    return user.uid;
  }
  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }
}