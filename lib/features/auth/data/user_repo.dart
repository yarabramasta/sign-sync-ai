import 'package:rearch/rearch.dart';
import 'package:signsyncai/features/auth/domain/account.dart';

class UserRepository {
  Future<List<Account>> getUsers(String query) async {
    try {
      final documents = await Account.col.where("name", isEqualTo: query).get();
      return documents.docs.map((it) => it.data()).toList();
    } catch (e) {
      return [];
    }
  }
}

UserRepository userRepo(CapsuleHandle use) => UserRepository();
