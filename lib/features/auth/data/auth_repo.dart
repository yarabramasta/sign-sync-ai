import 'package:faker_dart/faker_dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/services/firebase.dart';

import '../domain/account.dart';

class AuthRepository {
  Stream<Account?> currentUser() {
    return auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;

      final snapshot = await Account.col.doc(user.uid).get();
      if (snapshot.exists) return snapshot.data();

      final cred = _getCredFromEmail(user.email);
      final account = Account(
        id: user.uid,
        email: user.email,
        name: user.displayName,
        avatar: user.photoURL,
        role: cred['role'],
        code: cred['code'],
      );

      await Account.col.doc(user.uid).set(account);
      return account;
    });
  }

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

      final user =
          await auth.signInWithCredential(credential).then((data) => data.user);
      final snapshot = await Account.col.doc(user?.uid).get();

      if (snapshot.exists) return snapshot.data()!;
      // update user if exists
      if (user != null) {
        final isStudent = email[1] == 'student.unmer.ac.id';

        final account = Account(
          id: user.uid,
          email: user.email,
          avatar: user.photoURL,
          name: user.displayName,
          code: isStudent ? email[0] : Faker.instance.datatype.uuid(),
          role: isStudent ? Role.student : Role.lecturer,
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
