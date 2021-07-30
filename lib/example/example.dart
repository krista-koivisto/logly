import 'package:logly/logly.dart';

void main() {
  // By default the level `LogLevel.INFO` is used. To use that, just call
  // `log` on its own.
  log("This is a log entry.");

  // All levels may also be called explicitly using their respective
  // functions:
  log.warning("This is a warning level entry");
}
