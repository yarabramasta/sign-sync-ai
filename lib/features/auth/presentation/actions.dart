import 'package:flutter/material.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/ui/toast.dart';

import '../data/auth_repo.dart';
import '../domain/account.dart';

Stream<Account?> fetchCurrentUser(CapsuleHandle use) {
  return use(authRepo).currentUser();
}

SigninMutation signinAction(CapsuleHandle use) {
  final repo = use(authRepo);
  final (:state, :mutate, clear: _) = use.mutation<void>();

  void signin(BuildContext context) {
    mutate(
      repo.signIn().then(
        (data) {
          context.toast.success(message: 'Welcome to Sign Sync AI!');
        },
      ).catchError(
        (ex) {
          switch (ex.code) {
            case 'aborted':
              return;
            case 'invalid-email':
              context.toast.error(
                message:
                    'Uh oh! Looks like your email is not under our associated school domain.',
              );
            default:
              nativeToast('Failed to authenticate, please try again...');
          }
        },
      ),
    );
  }

  return (state, signin);
}

typedef SigninMutation = (
  AsyncValue<void>?,
  void Function(BuildContext context)
);

SignoutMutation signoutAction(CapsuleHandle use) {
  final repo = use(authRepo);
  final (:state, :mutate, clear: _) = use.mutation<void>();

  void signout(BuildContext context) {
    mutate(
      repo.signOut().then((_) => Navigator.pop(context)).catchError((_) {
        nativeToast('Something went wrong. Please try again later...');
      }),
    );
  }

  return (state, signout);
}

typedef SignoutMutation = (
  AsyncValue<void>?,
  void Function(BuildContext context)
);
