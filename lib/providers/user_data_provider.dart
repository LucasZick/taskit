import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskit/models/user_model.dart';

class UserDataProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDatabase = FirebaseFirestore.instance;

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  List get chats => currentUser?.tasks ?? [];

  List get contacts => currentUser?.tasks ?? [];

  UserDataProvider() {
    _firebaseAuth.authStateChanges().listen(
      (user) {
        if (user != null) {
          updateUser();
          _firebaseDatabase
              .collection('users')
              .doc(user.uid)
              .snapshots()
              .listen(
            (snapshot) {
              if (snapshot.exists) {
                updateUser();
              }
            },
          );
        } else {
          _currentUser = null;
          notifyListeners();
        }
      },
    );
  }

  void updateUser() async {
    User? authenticatedUser = _firebaseAuth.currentUser;
    if (authenticatedUser != null) {
      DocumentSnapshot<Map<String, dynamic>> userFromDatabase =
          await _firebaseDatabase
              .collection("users")
              .doc(authenticatedUser.uid)
              .get();
      _currentUser = UserModel(
        uid: userFromDatabase.get("uid"),
        email: userFromDatabase.get("email"),
        displayName: userFromDatabase.get("name"),
        photoUrl: userFromDatabase.get("photo_url"),
        tasks: userFromDatabase.get("tasks"),
      );
    }
    notifyListeners();
  }

  updateUserName(String name) async {
    User? authenticatedUser = _firebaseAuth.currentUser;
    if (authenticatedUser != null) {
      await _firebaseDatabase
          .collection("users")
          .doc(authenticatedUser.uid)
          .update({'name': name});
    }
  }
}
