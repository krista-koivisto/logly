import 'package:logly/logly.dart';

void main() {
  // By default the level `LogLevel.INFO` is used. To use that, just call
  // `log` on its own.
  log("This is a log entry.");

  // All levels may also be called explicitly using their respective
  // functions:
  log.shout("This is a shout, the highest possible severity level.");
  log.warning("This is a warning.");
  log.severe("This is a severe log entry.");
  log.fine("This is a fine-level log entry.");
  log.finer("This is a finer-level log entry.");
  log.finest("This is a finest-level log entry.");
  log.config("This is a config log entry.");
  log.info("This is the common info-level log entry.");
}
