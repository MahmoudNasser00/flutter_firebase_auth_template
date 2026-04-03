
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/services/firebase_auth_service.dart';

class AuthRemoteDatasource {
  final FirebaseAuthService service;

  AuthRemoteDatasource(this.service);

  Future<User?> login(String email, String password) {
    return service.login(email, password);
  }

  Future<User?> register(String email, String password) {
    return service.register(email, password);
  }

  Future<User?> googleLogin() {
    return service.googleLogin();
  }

  Future<void> forgotPassword(String email) {
    return service.resetPassword(email);
  }
}
