
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<User?> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User?> register(String email, String password) {
    return datasource.register(email, password);
  }

  @override
  Future<User?> googleLogin() {
    return datasource.googleLogin();
  }

  @override
  Future<void> forgotPassword(String email) {
    return datasource.forgotPassword(email);
  }
}
