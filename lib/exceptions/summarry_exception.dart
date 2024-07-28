class SummarryException implements Exception {
  final String message;

  SummarryException(this.message);

  @override
  String toString() {
    return 'SummarryException: $message';
  }
}
