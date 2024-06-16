import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signsyncai/models/account.dart';

import 'firebase.dart';

part 'auth.g.dart';

class AuthService {
  Future<Account> signIn() async {
    final googleUser = await GoogleSignIn.standard().signIn();

    if (googleUser == null) {
      throw FirebaseAuthException(code: 'user-not-found');
    }

    final email = googleUser.email.split('@');
    final domain = email[1];

    if (domain == 'unmer.ac.id') {
      final isLecturer = await Account.col
          .where('email', isEqualTo: googleUser.email)
          .limit(1)
          .get();

      if (!isLecturer.docs.first.exists) {
        _revoke();
        throw FirebaseAuthException(code: 'user-not-found');
      }
    }

    if (domain.contains('unmer.ac.id')) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final user = await auth.signInWithCredential(credential).then((data) => data.user);
      final snapshot = await Account.col.doc(user?.uid).get();

      if (snapshot.exists) return snapshot.data()!;
      // skip user creation if empty && is a lecturer
      if (user != null && domain != 'unmer.ac.id') {
        final account = Account(
          id: user.uid,
          email: user.email,
          avatar: user.photoURL,
          name: user.displayName,
          code: email[0],
          role: Role.student,
        );

        await Account.col.doc(user.uid).set(account);
        return account;
      }
    }

    _revoke();
    throw FirebaseAuthException(code: 'invalid-email');
  }

  Future<void> signOut() async {
    await auth.signOut();
    _revoke();
  }

  void _revoke() async {
    await GoogleSignIn.standard().signOut();
  }
}

@riverpod
AuthService authService(AuthServiceRef ref) => AuthService();
