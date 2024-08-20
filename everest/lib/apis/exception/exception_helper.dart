import 'package:everest/apis/exception/alert_message.dart';
import 'custom_exception.dart';
import 'exception_type.dart';

class ExceptionHelper {
  Exception handleExceptions(ExceptionType type) {
    switch (type) {
      case ExceptionType.NetworkException:
        return NetworkException(AlertMessage.noInternet!);
        // ignore: dead_code
        break;
      case ExceptionType.HttpsExction:
        return HttpException(AlertMessage.httpError!);
        // ignore: dead_code
        break;
      default:
        return HttpException(AlertMessage.someThingWrongMag!);
        // ignore: dead_code
        break;
    }
  }
}
