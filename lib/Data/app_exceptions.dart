class AppExceptions implements Exception {

  final dynamic _message;
  final dynamic statuscode;

  AppExceptions([this._message, this.statuscode]);
  @override
  String toString() {
    return '$statuscode $_message';
  }
}

class FetchDataException extends AppExceptions {  
  FetchDataException([String? messages,int? statusCode])
      : super(messages, statusCode);
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? messages,int? statusCode])
      : super(messages, statusCode);
}

class UnauthorisedException extends AppExceptions {
  UnauthorisedException([String? messages,int? statusCode])
      : super(messages, statusCode);
}

class InavalidInputException extends AppExceptions {
  InavalidInputException([String? messages,int? statusCode])
      : super(messages, statusCode);
}