import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  final String className;
  SimpleLogPrinter({required this.className});

  final logger = Logger();

  @override
  List<String> log(LogEvent event) {
    return [className, event.message];
  }
}
