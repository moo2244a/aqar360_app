import 'package:aqar360/app/core/errors/auth_exception.dart' show AuthException;
import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<UserCredential> signInWithEmailAndPassword(
    UserModel user,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    }
  }

  static Future<UserCredential> createUserWithEmailAndPassword(
    UserModel user,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      await userCredential.user?.updateDisplayName(user.name);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    }
  }

  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    }
  }

  static Exception _mapFirebaseException(FirebaseAuthException e) {
    return switch (e.code) {
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' => AuthException.invalidCredentials(),
      'email-already-in-use' => AuthException.emailAlreadyInUse(),
      'weak-password' => AuthException.weakPassword(),
      'network-request-failed' => AuthException.networkError(),
      'too-many-requests' => AuthException.tooManyRequests(),
      _ => AuthException.unknown(e.message),
    };
  }
}
