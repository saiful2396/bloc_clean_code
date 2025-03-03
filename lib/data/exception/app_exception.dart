class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message'; // Return the formatted error message
  }
}

class NoInternetConnections extends AppExceptions{
  NoInternetConnections([String? message]): super(message, 'No Internet Connections: ');
}

class UnAuthorizeExceptions extends AppExceptions{
  UnAuthorizeExceptions([String? message]): super(message, 'Not able to process. Please contact 24/7 Contact Centre!');
}

class RequestTimeOut extends AppExceptions{
  RequestTimeOut([String? message]): super(message, 'Request time out!');
}

class EmptyResponse extends AppExceptions{
  EmptyResponse([String? message]): super(message, 'No data found!');
}

class F5Exceptions extends AppExceptions{
  F5Exceptions([String? message]): super(message, 'Not able to connect to the server. Please try again or contact our 24/7 contact centre. Sorry for sudden inconvenience.');
}