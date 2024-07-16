import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/services/firebase.dart';

import '../domain/account.dart';

class AuthRepository {
  Stream<Account?> currentUser() {
    return auth.authStateChanges().asyncMap((user) async {
      if (user != null) {
        final snapshot = await Account.col.doc(user.uid).get();
        if (snapshot.exists) return snapshot.data();

        final credential = _getCredFromEmail(user.email);
        return Account(
          code: credential['code'] ?? user.uid,
          email: user.email,
          name: user.displayName,
          role: credential['role'],
        );
      }
      return null;
    });
  }

  Future<Account> signIn() async {
    try {
      final googleUser = await GoogleSignIn.standard().signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(code: 'aborted');
      }

      final email = googleUser.email.split('@');
      final domain = email[1];

      if (!domain.contains('unmer.ac.id')) {
        _revoke();
        throw FirebaseAuthException(code: 'invalid-email');
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final user =
          await auth.signInWithCredential(credential).then((data) => data.user);

      final snapshot = await Account.col.doc(user?.uid).get();

      if (user != null && !snapshot.exists) {
        final isStudent = email[1] == 'student.unmer.ac.id';
        final account = Account(
          email: user.email,
          avatar: user.photoURL,
          name: user.displayName,
          code: isStudent ? email[0] : user.uid,
          role: isStudent ? Role.student : Role.lecturer,
        );
        await Account.col.doc(user.uid).set(account);
        return account;
      }

      return snapshot.data()!;
    } catch (ex) {
      debugPrint(ex.toString());
      _revoke();
      rethrow;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    _revoke();
  }

  void _revoke() async {
    await GoogleSignIn.standard().signOut();
  }

  Map<String, dynamic> _getCredFromEmail(String? email) {
    if (email == null) return {"role": Role.student};

    final parts = email.split('@');
    final domain = parts[1] == 'unmer.ac.id';

    if (!domain) {
      return {
        'code': parts[0],
        'role': Role.student,
      };
    }

    return {'role': Role.lecturer};
  }
}

AuthRepository authRepo(CapsuleHandle use) => AuthRepository();
