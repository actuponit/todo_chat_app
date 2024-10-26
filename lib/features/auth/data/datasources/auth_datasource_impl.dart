import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';
import 'auth_datasource.dart';

class AuthDatasourceImpl extends AuthDatasource{
  final FirebaseAuth _firebaseAuth;
  final DatabaseReference _dbref;
  AuthDatasourceImpl({FirebaseAuth? firebaseAuth, DatabaseReference? dbref}) : 
    _dbref = dbref ?? FirebaseDatabase.instance.ref().child('users'),
    _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<UserModel> getUser() async {
    final user = _firebaseAuth.currentUser;
    await updateUserPresence(user);
    if(user != null){
      final snapshot = await _dbref.child('${user.uid}/name').get();
      if (snapshot.value != null) {
        return UserModel.fromFirebase(user, name: snapshot.value as String);
      } else {
        throw MyFirebaseDBException('User not found');
      }
    } else {
      throw MyFirebaseAuthException('User not found');
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    await updateUserPresence(credential.user);
    if (credential.user != null) {
      final snapshot = await _dbref.child('${credential.user?.uid}/name').get();
      if (snapshot.value != null) {
        return UserModel.fromFirebase(credential.user!, name: snapshot.value as String);
      } else {
        throw MyFirebaseDBException('User not found');
      }
    } else {
      throw MyFirebaseAuthException('User is null after login');
    }
  }

  @override
  Future<UserModel> register(UserModel user) async {
    UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: user.password);
    await updateUserPresence(credential.user);
    if (credential.user != null) {
      await _dbref.child('${credential.user?.uid}').set({
        'name': user.name,
        'email': user.email,
      });
      return UserModel.fromFirebase(credential.user!, name: user.name);
    } else {
      throw MyFirebaseAuthException('User is null after register');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await updateUserPresence(_firebaseAuth.currentUser, logout: true);
      await _firebaseAuth.signOut();
    } catch (e) {
      throw MyFirebaseAuthException('Error while logging out: $e');
    }
  }


  Future<void> updateUserPresence(User? user, {bool? logout}) async {
    if(user != null){
      await _dbref.child('${user.uid}/online').set(true);
      await _dbref.child('${user.uid}/online').onDisconnect().set(false);
      await _dbref.child('${user.uid}/last_seen').onDisconnect().set(ServerValue.timestamp);
      if(logout != null && logout){
        await _dbref.child('${user.uid}/online').set(false);
        await _dbref.child('${user.uid}/last_seen').set(ServerValue.timestamp);
      }
    }
  }
}