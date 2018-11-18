import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
  Future<FirebaseUser> googleSignedIn();
  Future<FirebaseUser> facebookSignedIn();
  Future<FirebaseUser> twitterSignedIn();
}

class Auth implements BaseAuth {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = new GoogleSignIn();
  FacebookLogin facebookLogin = new FacebookLogin();
  final twitterLoginSecret = new TwitterLogin(
      consumerKey: "waazsqrctZ4zXfmJpff6P2jKH",
      consumerSecret: "D8WQaBjY68obhHoEzwqWwPt7xgWw2GLAA6PVmemNKhwgbuFdwp"
  );

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
      facebookLogin.logOut(),
      twitterLoginSecret.logOut(),
    ];
  }

  // GoogleSignIn Firebase
  Future<FirebaseUser> googleSignedIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication signInAuthentication = await googleSignInAccount.authentication;

    FirebaseUser user = await firebaseAuth.signInWithGoogle(idToken: signInAuthentication.idToken, accessToken: signInAuthentication.accessToken);
    return user;
  }

  // FacebookSignIn Firebase
  Future<FirebaseUser> facebookSignedIn() async {
    FacebookLoginResult result = await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);
    FirebaseUser user = result.status == FacebookLoginStatus.loggedIn ? await firebaseAuth.signInWithFacebook(accessToken: result.accessToken.token) : null;
    return user;
  }

  // TwitterSignIn Firebase
  Future<FirebaseUser> twitterSignedIn() async {
    TwitterLoginResult result = await twitterLoginSecret.authorize();
    FirebaseUser user = result.status == TwitterLoginStatus.loggedIn ? await firebaseAuth.signInWithTwitter(authToken: result.session.token, authTokenSecret: result.session.secret) : null;
    return user;
  }

}