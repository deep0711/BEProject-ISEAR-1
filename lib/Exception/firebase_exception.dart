class FireBaseException implements Exception {
  final String _exceptionMessage;
  FireBaseException(this._exceptionMessage);

  @override
  String toString() {
    return _exceptionMessage;
  }
}