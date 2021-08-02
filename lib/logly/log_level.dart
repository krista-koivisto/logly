// ignore_for_file: constant_identifier_names

import 'package:logging/logging.dart';

class LogLevel extends Level {
  /// Special key to turn on logging for all levels ([value] = 0).
  static const LogLevel ALL = LogLevel('ALL', 0);

  /// Special key to turn off all logging ([value] = 2000).
  static const LogLevel OFF = LogLevel('OFF', 2000);

  /// Key for highly detailed tracing ([value] = 300).
  static const LogLevel FINEST = LogLevel('FINEST', 300);

  /// Key for fairly detailed tracing ([value] = 400).
  static const LogLevel FINER = LogLevel('FINER', 400);

  /// Key for tracing information ([value] = 500).
  static const LogLevel FINE = LogLevel('FINE', 500);

  /// Key for static configuration messages ([value] = 700).
  static const LogLevel CONFIG = LogLevel('CONFIG', 700);

  /// Key for informational messages ([value] = 800).
  static const LogLevel INFO = LogLevel('INFO', 800);

  /// Key for potential problems ([value] = 900).
  static const LogLevel WARNING = LogLevel('WARNING', 900);

  /// Key for serious failures ([value] = 1000).
  static const LogLevel SEVERE = LogLevel('SEVERE', 1000);

  /// Key for extra debugging loudness ([value] = 1200).
  static const LogLevel SHOUT = LogLevel('SHOUT', 1200);

  static const Map<int, String> ICONS = {
    0:    "🏳", // ALL
    300:  "🏳", // FINEST
    400:  "🏳", // FINER
    500:  "🏳", // FINE
    700:  "🏳", // CONFIG
    800:  " ❕", // INFO
    900:  " ⚠", // WARNING
    1000: " ⛔", // SEVERE
    1200: " ☢", // SHOUT
    2000: "🏳", // OFF
  };

  static const Map<int, String> COLORS = {
    0:    "\x1B[1m\x1B[38;5;30m", // ALL
    300:  "\x1B[1m\x1B[38;5;135m", // FINEST
    400:  "\x1B[1m\x1B[38;5;134m", // FINER
    500:  "\x1B[1m\x1B[38;5;133m", // FINE
    700:  "\x1B[1m\x1B[38;5;105m", // CONFIG
    800:  '\x1B[1m\x1B[38;5;4m', // INFO
    900:  "\x1B[1m\x1B[38;5;220m", // WARNING
    1000: "\x1B[1m\x1B[38;5;1m", // SEVERE
    1200: "\x1B[1m\x1B[38;5;0m\x1B[48;5;1m", // SHOUT
    2000: "\x1B[1m\x1B[38;5;233m", // OFF
  };

  static const List<LogLevel> LEVELS = [
    ALL,
    FINEST,
    FINER,
    FINE,
    CONFIG,
    INFO,
    WARNING,
    SEVERE,
    SHOUT,
    OFF
  ];

  const LogLevel(String name, int value) : super(name, value);

  String get color => COLORS[value]!;
}
