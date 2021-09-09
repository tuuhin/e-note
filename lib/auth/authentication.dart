import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather/auth/dbmanager.dart';
import 'package:weather/model/user.dart';
import 'package:weather/model/model.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CurrentUser userFromCred(User? firebaseUser) {
    return (firebaseUser != null)
        ? CurrentUser(uid: firebaseUser.uid)
        : CurrentUser(uid: null);
  }

  Stream<CurrentUser?> get currentUser {
    return _auth
        .authStateChanges()
        .map((User? firebaseUser) => userFromCred(firebaseUser));
  }

  Future registerWithEmail(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = userCredential.user;
      await DataManager(firebaseUser!.uid.toString())
          .createUserData(name, email);
      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      // print(e.toString());
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return e.code.toString();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = userCredential.user;
      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      // print(e.toString());
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return e.code.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
