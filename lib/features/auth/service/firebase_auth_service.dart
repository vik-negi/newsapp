import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/features/auth/service/firestore_service.dart';
import 'package:news/models/user_model.dart';
import 'package:news/utils/service/failure.dart';
import 'package:news/utils/service/types.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;
  FirebaseAuthService(this._auth);

  APIResponse<UserCredential> signUp(
      String email, String password, String name) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        await response.user!.updateDisplayName(name);
        UserModel user = UserModel(
          uid: response.user!.uid,
          email: email,
          name: name,
        );
        await FirestoreService().createUser(user);
      }
      return Right(response);
    } on FirebaseAuthException catch (e) {
      throw APIFailure(e.message ?? "Something went wrong");
    }
  }

  APIResponse<UserCredential> login(String email, String password) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(APIFailure(e.message ?? "Something went wrong"));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
