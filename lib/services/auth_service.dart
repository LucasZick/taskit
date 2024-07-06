import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:taskit/models/user_model.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDatabase = FirebaseFirestore.instance;

  UserModel? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl:
          "https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049_640.png",
    );
  }

  Stream<UserModel?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<auth.User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<auth.User?> createUserWithEmailAndPassword(
    String email,
    String password,
    String username,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    registerUserDetails(credential, username);
    addUserToDatabase(credential, username);
    return credential.user;
  }

  registerUserDetails(auth.UserCredential credential, String username) {
    credential.user?.updateDisplayName(username);
    credential.user?.updatePhotoURL(
        "https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049_640.png");
  }

  addUserToDatabase(auth.UserCredential credential, String username) {
    Map<String, dynamic> userData = {
      "uid": credential.user?.uid,
      "name": username,
      "email": credential.user?.email,
      "photo_url":
          "https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049_640.png",
      "tasks": [],
    };
    var collection = _firebaseDatabase.collection('users');
    var uid = credential.user?.uid;
    collection
        .doc(uid) // Definindo o documento com o UID
        .set(userData) // Define os dados no documento
        .then((_) => print('Document added for $username'))
        .catchError((error) => print('Add failed: $error'));
  }

  changeDisplayName(String newName) async {
    auth.User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(newName);
      await _firebaseDatabase.collection("users").doc(user.uid).update(
        {"name": newName},
      );
    }
  }

  changePhotoUrl(String newPhotoUrl) {
    auth.User? user = _firebaseAuth.currentUser;
    if (user != null) {
      user.updatePhotoURL(newPhotoUrl);
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
