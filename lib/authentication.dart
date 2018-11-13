import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
  Future<FirebaseUser> googleSignedIn();
}

class Auth implements BaseAuth {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = new GoogleSignIn();

  // Firebase with email address and password login
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
    return [
      firebaseAuth.signOut(),
      googleSignIn.signOut(),
    ];
  }

  // GoogleSignIn Firebase
  Future<FirebaseUser> googleSignedIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication signInAuthentication = await googleSignInAccount.authentication;

    FirebaseUser user = await firebaseAuth.signInWithGoogle(idToken: signInAuthentication.idToken, accessToken: signInAuthentication.accessToken);
    return user;
  }
}