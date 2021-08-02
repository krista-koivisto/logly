import 'package:test/test.dart';
import 'package:logging/logging.dart';
import 'package:logly/logly.dart';

void main() {
  test('default log level is LogLevel.ALL', () {
    expect(log.level, LogLevel.ALL);
  });
  test('setting level works', () {
    log.level = LogLevel.INFO;
    expect(log.level, LogLevel.INFO);
  });
  test('level minimums are enforced', () {
    log.level = LogLevel.SHOUT;
    log.severe("ERROR: LogLevel.SEVERE should not print! ${LogLevel.WARNING >= Logger.root.level}");
    expect(log.isLoggable(LogLevel.INFO), false);
    expect(log.isLoggable(LogLevel.SHOUT), true);
    log.level = LogLevel.ALL;
    expect(log.isLoggable(LogLevel.INFO), true);
    expect(log.isLoggable(LogLevel.SHOUT), true);
  });
}
