import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/data/models/user.dart' as userModel;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxService implements AuthServiceType {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  userModel.User? _userFromFirebaseUser(User? user) {
    return user != null ? userModel.User(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;

    print('Result: $result');
    return _userFromFirebaseUser(user);
  }

  Future signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = result.user;

    print('Result: $result');
    return _userFromFirebaseUser(user);
  }

  Future resetPassword({required String email}) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
