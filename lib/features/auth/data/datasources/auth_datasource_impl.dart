import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';
import 'auth_datasource.dart';

class AuthDatasourceImpl extends AuthDatasource{
  final FirebaseAuth _firebaseAuth;
  AuthDatasourceImpl({FirebaseAuth? firebaseAuth}): _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<UserModel> getUser() async {
    final user = _firebaseAuth.currentUser;
    if(user != null){
      return UserModel.fromFirebase(user);
    } else {
      throw MyFirebaseException('User not found');
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if (credential.user != null) {
      return UserModel.fromFirebase(credential.user!);
    } else {
      throw MyFirebaseException('User is null after login');
    }
  }

  @override
  Future<UserModel> register(UserModel user) async {
    UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: user.password);
    if (credential.user != null) {
      return UserModel.fromFirebase(credential.user!);
    } else {
      throw MyFirebaseException('User is null after register');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw MyFirebaseException('Error while logging out: $e');
    }
  }
}