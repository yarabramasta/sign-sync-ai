import 'dart:async';

import 'package:algoliasearch/algoliasearch_lite.dart';
import 'package:signsyncai/features/auth/domain/account.dart';

Future<List<Account>> searchLecture(String? query) async {
  final client = SearchClient(
    appId: 'WJ636HPOTV',
    apiKey: '457068778f317d016fe598dfc69d99df',
  );

  var searchMethodParams = SearchForHits(
    indexName: 'users_index',
    query: 'lecturer',
    similarQuery: query,
    hitsPerPage: 10,
  );

  var response = await client.searchIndex(request: searchMethodParams);
  client.dispose();

  return response.hits.map((e) {
    final rawData = e.toJson();
    return Account(
      code: e.objectID,
      name: rawData['name'],
      avatar: rawData['avatar'],
    );
  }).toList();
}
