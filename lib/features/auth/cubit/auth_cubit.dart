import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<String> uploadImage(File imageFile) async {
    final cloudinary = CloudinaryPublic('dozaqzg7q', 'zcaeoqif', cache: false);

    final response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(imageFile.path, folder: 'users'),
    );

    return response.secureUrl;
  }

  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    File? image,
  }) async {
    try {
      emit(AuthLoading());

      /// create firebase user
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      String imageUrl = "";

      /// upload image
      if (image != null) {
        imageUrl = await uploadImage(image);
      }

      /// save firestore user
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "name": name,
        "email": email,
        "phone": phone,
        "image": imageUrl,
      });

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      emit(AuthLoading());

      await _auth.sendPasswordResetEmail(email: email);

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
    emit(AuthLoggedOut());
  }

  Future<void> googleLogin() async {
    try {
      emit(AuthLoading());

      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      final user = FirebaseAuth.instance.currentUser;

      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();

      if (!doc.exists) {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "name": user.displayName ?? "",
          "email": user.email ?? "",
          "phone": "",
          "image": user.photoURL ?? "",
        });
      }

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
