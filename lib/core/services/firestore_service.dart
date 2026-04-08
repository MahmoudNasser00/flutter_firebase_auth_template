import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
    required String phone,
    required String image,
  }) async {
    await firestore.collection("users").doc(uid).set({
      "name": name,
      "email": email,
      "phone": phone,
      "image": image,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<DocumentSnapshot> getUser(String uid) {
    return firestore.collection("users").doc(uid).get();
  }

  Future<void> updateUser({
    required String uid,
    required String name,
    required String phone,
  }) async {
    await firestore.collection("users").doc(uid).update({
      "name": name,
      "phone": phone,
    });
  }
}
