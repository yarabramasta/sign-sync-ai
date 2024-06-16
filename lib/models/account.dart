import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:signsyncai/services/firebase.dart';

part 'account.freezed.dart';
part 'account.g.dart';

enum Role { student, lecturer }

@freezed
class Account with _$Account {
  const factory Account({
    required String id,
    String? code,
    String? name,
    String? avatar,
    String? email,
    @Default(Role.student) Role role,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  static CollectionReference<Account> get col {
    return db.collection('users').withConverter<Account>(
          fromFirestore: (snapshot, _) => Account.fromJson(snapshot.data()!),
          toFirestore: (account, _) => account.toJson(),
        );
  }
}
