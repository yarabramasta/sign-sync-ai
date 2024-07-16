import 'package:firebase_auth/firebase_auth.dart';
import 'package:rearch/rearch.dart';

import '../data/auth_repo.dart';
import '../domain/account.dart';

Stream<Account?> fetchCurrentUser(CapsuleHandle use) =>
    use(authRepo).currentUser();

SigninMutation signinAction(CapsuleHandle use) {
  final repo = use(authRepo);
  final (:state, :mutate, clear: _) = use.mutation<void>();

  void signin({
    void Function(Account account)? onData,
    void Function(FirebaseAuthException error)? onError,
  }) {
    mutate(
      repo
          .signIn()
          .then((data) => onData != null ? onData(data) : data)
          .catchError((error) => onError != null ? onError(error) : error),
    );
  }

  return (state, signin);
}

typedef SigninMutation = (
  AsyncValue<void>?,
  void Function({
    void Function(Account)? onData,
    void Function(FirebaseAuthException)? onError,
  })
);

SignoutMutation signoutAction(CapsuleHandle use) {
  final repo = use(authRepo);
  final (:state, :mutate, clear: _) = use.mutation<void>();

  void signout({
    void Function()? onData,
    void Function(Object error)? onError,
  }) {
    mutate(
      repo
          .signOut()
          .then((data) => onData ?? data)
          .catchError((error) => onError != null ? onError(error) : error),
    );
  }

  return (state, signout);
}

typedef SignoutMutation = (
  AsyncValue<void>?,
  void Function({
    void Function()? onData,
    void Function(Object)? onError,
  })
);
