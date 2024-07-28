import 'dart:async';

import 'package:algoliasearch/algoliasearch_lite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:signsyncai/features/auth/domain/account.dart';

Future<List<Account>> searchLecture(String? query) async {
  final client = SearchClient(
    appId: dotenv.env['ALGOLIA_APP_ID']!,
    apiKey: dotenv.env['ALGOLIA_API_KEY']!,
  );

  var searchMethodParams = SearchForHits(
    indexName: 'users_index',
    query: 'lecturer',
    similarQuery: query,
    hitsPerPage: 10,
  );
  try {
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
  } catch (e) {
    // Handle errors appropriately
    print('Error during search: $e');
    return [];
  } finally {
    client.dispose();
  }
}
