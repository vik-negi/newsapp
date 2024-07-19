import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.uid).set({
      'name': user.name,
      'email': user.email,
      'countryCode': user.countryCode,
    });
  }

  Future<void> updateUser({String? name, required String countryCode}) async {
    final user = FirebaseAuth.instance.currentUser;
    await _db.collection('users').doc(user!.uid).update({
      'name': name ?? user.displayName,
      'countryCode': countryCode,
    });
  }

  Future<String?> getUserCountryCode() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final response = await _db.collection('users').doc(uid).get();
    return response.data()?['countryCode'];
  }
}
