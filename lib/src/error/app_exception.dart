import 'package:flutter_portfolio/src/localization/extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
class AppException with _$AppException {
  const factory AppException.userNotFound() = UserNotFound;
}

class AppExceptionData {
  AppExceptionData(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => 'AppExceptionData(code: $code, message: $message)';
}

extension AppExceptionDetails on AppException {
  AppExceptionData get details {
    return when(
      userNotFound: () => AppExceptionData(
        'user-not-found',
        'User not found'.hardcoded,
      ),
    );
  }
}
