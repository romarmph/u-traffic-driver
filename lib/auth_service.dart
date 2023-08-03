import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart';

import 'model/driver_model.dart';
import 'model/user_model.dart' as model;

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final firestore.FirebaseFirestore _db = firestore.FirebaseFirestore.instance;

  

  model.User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      
      return null;
    }

    return model.User(
      id: user.uid,
      email: user.email!,
    );
  }

  model.User? get currentuser => _userFromFirebase(_firebaseAuth.currentUser);

  Stream<model.User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<Driver?> getDriver(String email) async {
    const String collection = "driver";
    const String field = "email";

    final firestore.QuerySnapshot<Map<String, dynamic>> result =
        await _db.collection(collection).where(field, isEqualTo: email).get();

    if (result.docs.isEmpty) {
      return null;
    }

    Driver driver = Driver.fromJson(
      result.docs.first.data(),
    );

    return driver;
  }

  Future<model.User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (await getDriver(email) == null) {
      print("Account is not a driver");
      return null;
    }

    final auth.UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    return _userFromFirebase(userCredential.user);
  }

  Future<model.User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final auth.UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    return _userFromFirebase(userCredential.user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}