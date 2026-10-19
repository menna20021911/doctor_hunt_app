class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Server Error']);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  const NetworkException([this.message = 'Network Error']);

  @override
  String toString() => message;
}
