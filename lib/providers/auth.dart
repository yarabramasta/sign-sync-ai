import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signsyncai/models/account.dart';
import 'package:signsyncai/services/auth.dart';
import 'package:signsyncai/services/firebase.dart';
import 'package:signsyncai/services/toast.dart';

part 'auth.g.dart';

@riverpod
Stream<Account?> currentUser(CurrentUserRef ref) {
  return auth.authStateChanges().asyncMap((user) async {
    if (user == null) return null;

    final snapshot = await Account.col.doc(user.uid).get();
    if (snapshot.exists) return snapshot.data();

    final cred = getCredFromEmail(user.email);
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

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<Account?> build() async {
    final user = auth.currentUser;
    return await Account.col
        .doc(user?.uid)
        .get()
        .then((snapshot) => snapshot.data());
  }

  Future<void> signIn() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        return await ref.read(authServiceProvider).signIn().then((account) {
          toast('Welcome ${account.name ?? account.id}!');
          return account;
        });
      },
      (ex) {
        if (ex is FirebaseAuthException) {
          if (ex.code == 'invalid-email') {
            toast(
              'Sign in failed due to invalid Google account email domain.',
            );
          } else if (ex.code == 'user-not-found') {
            toast(
              "You are signing in with lecturer account which isn't registered before.",
            );
          } else {
            debugPrint('$ex');
            toast('Oops! sign in failed, please try again...');
          }
        } else {
          debugPrint('$ex');
          toast('Something went wrong...');
        }

        return ex is FirebaseAuthException;
      },
    );
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        return await ref.read(authServiceProvider).signOut().then((_) => null);
      },
      (ex) {
        debugPrint('$ex');
        return ex is FirebaseAuthException;
      },
    );
  }
}

Map<String, dynamic> getCredFromEmail(String? email) {
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
