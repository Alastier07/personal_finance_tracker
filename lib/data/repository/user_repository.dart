import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class UserRepository {
  UserRepository(this.authFirebase);

  final FirebaseAuth authFirebase;

  UserModel userInfo() {
    final user = authFirebase.currentUser!;

    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      avatar: user.photoURL ?? '',
    );
  }
}
