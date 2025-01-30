import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class UserRepository {
  UserRepository({this.authFirebase});

  FirebaseAuth? authFirebase;

  String _userName = '';
  String get userName => _userName;

  UserModel userInfo() {
    authFirebase ??= FirebaseAuth.instance;

    final user = authFirebase!.currentUser!;

    _userName = user.displayName ?? '';

    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      avatar: user.photoURL ?? '',
    );
  }
}
