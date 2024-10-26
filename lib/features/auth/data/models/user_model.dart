import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.id, required super.email, required super.name, super.password});

  factory UserModel.fromFirebase(firebase_auth.User user, {String name = ''}) {
    return UserModel(id: user.uid, email: user.email!, name: name);
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(id: user.id, email: user.email, name: user.name, password: user.password);
  }
}