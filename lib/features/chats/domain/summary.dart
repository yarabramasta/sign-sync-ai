import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:signsyncai/services/firebase.dart';

part 'summary.freezed.dart';
part 'summary.g.dart';

@freezed
class Summary with _$Summary {
  const factory Summary({
    required String conversation,
    required String content,
    required int sendAt,
  }) = _Summary;

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);

  static CollectionReference<Summary> get col {
    return db.collection("summaries").withConverter(
          fromFirestore: (snapshot, _) => Summary.fromJson(snapshot.data()!),
          toFirestore: (snapshot, _) => snapshot.toJson(),
        );
  }
}
