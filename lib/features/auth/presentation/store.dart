import 'package:rearch/rearch.dart';

import '../domain/account.dart';
import 'actions.dart';

AsyncValue<Account?> account$(CapsuleHandle use) {
  final stream = use(fetchCurrentUser);
  return use.stream<Account?>(stream);
}

(AsyncValue<Account?>, void Function()) refreshableAccount(CapsuleHandle use) {
  final future = use(fetchCurrentUser).last;
  return use.refreshableFuture(() => future);
}

(String?, String) role$(CapsuleHandle use) {
  final cred = use(account$);
  return (
    switch (cred) {
      AsyncData(:final data) => data?.role.name,
      _ => null,
    },
    'Loading'
  );
}

(String?, String) email$(CapsuleHandle use) {
  final cred = use(account$);
  return (
    switch (cred) {
      AsyncData(:final data) => data?.email,
      _ => null,
    },
    'Loading'
  );
}

(String?, String) name$(CapsuleHandle use) {
  final cred = use(account$);
  return (
    switch (cred) {
      AsyncData(:final data) => data?.name,
      _ => null,
    },
    'Loading'
  );
}

(String?, String) avatar$(CapsuleHandle use) {
  final profile = use(account$);
  const url = 'https://api.dicebear.com/8.x/notionists/svg?seed=';
  return (
    switch (profile) {
      AsyncData(:final data) =>
        data != null ? data.avatar ?? url + data.code : null,
      _ => null,
    },
    '${url}johndoe'
  );
}
