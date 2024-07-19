import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news/features/auth/service/firebase_auth_service.dart';
import 'package:news/features/auth/service/firestore_service.dart';
import 'package:news/models/user_model.dart';

class LocalAuthProvider extends ChangeNotifier {
  final FirebaseAuthService _service =
      FirebaseAuthService(FirebaseAuth.instance);
  User? _user;

  User? get user => _user;
  LocalAuthProvider() {
    _authStateChanges();
  }

  void _authStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<String> login(
    String email,
    String password,
  ) async {
    final response = await _service.login(email, password);
    return response.fold(
      (error) {
        debugPrint("Error: $error");
        return error.message;
      },
      (data) {
        return "Login Success";
      },
    );
  }

  Future<String> register(
    String email,
    String password,
    String name,
  ) async {
    final response = await _service.signUp(
      email,
      password,
      name,
    );
    return response.fold(
      (error) => error.message,
      (data) {
        return "Register Success";
      },
    );
  }

  FirestoreService get firestoreService => FirestoreService();

  Future<bool> updateUser({String? name, String? countryCode}) async {
    try {
      await firestoreService.updateUser(
        name: name,
        countryCode: countryCode ?? "in",
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await _service.signOut();
    notifyListeners();
  }
}
