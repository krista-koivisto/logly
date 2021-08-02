// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'log_level.dart';

/// Adds a log record for a [message] at a particular [logLevel] if
/// `isLoggable(logLevel)` is true.
///
/// Use this method to create log entries for user-defined levels. To record a
/// message at a predefined level (e.g. [LogLevel.INFO], [LogLevel.WARNING],
/// etc) you can use their specialized methods instead (e.g. [info], [warning],
/// etc).
///
/// If [message] is a [Function], it will be lazy evaluated. Additionally, if
/// [message] or its evaluated value is not a [String], then 'toString()' will
/// be called on the object and the result will be logged.
///
/// All messages will be printed when in debug mode. In profile mode, all
/// messages [LogLevel.WARNING] and more severe will be printed. In release
/// mode, no messages will be printed. This can be overridden by setting a
/// different [log.level].
const log = _Log();

bool _isInitialized = false;
bool _useAnsi = true;
bool _useIcon = true;
bool _clearClutter = true;
bool _levelWasChanged = false;
LogLevel __level = LogLevel.ALL;
LogLevel get _level => __level;
set _level(LogLevel level) {
  Logger.root.level = level;
  __level = level;
  if (!_levelWasChanged) {
    _levelWasChanged = true;
  }
}

class _Log {
  const _Log();

  /// Whether a message for [value]'s level is loggable in this logger.
  bool isLoggable(LogLevel value) => Logger.root.isLoggable(value);

  /// Adds a log record for a [message] at a particular [logLevel] if
  /// `isLoggable(logLevel)` is true.
  ///
  /// Use this method to create log entries for user-defined levels. To record a
  /// message at a predefined level (e.g. [Level.INFO], [Level.WARNING], etc)
  /// you can use their specialized methods instead (e.g. [info], [warning],
  /// etc).
  ///
  /// If [message] is a [Function], it will be lazy evaluated. Additionally, if
  /// [message] or its evaluated value is not a [String], then 'toString()' will
  /// be called on the object and the result will be logged.
  // Override the [call] function so an instance of [_Log] can be called as if
  // it were a function.
  void call(Object? message, [LogLevel level = LogLevel.INFO]) {
    _log(message, level);
  }

  /// Whether or not to allow ANSI characters in the output.
  ///
  /// Android Studio currently fails to print colors using ANSI. This issue can
  /// be sidestepped by looking at the output of `flutter logs` in the terminal
  /// instead.
  ///
  /// Defaults to true.
  bool get useAnsi => _useAnsi;
  set useAnsi(bool useAnsi) => _useAnsi = useAnsi;

  /// Whether or not to show emoji-based icon in the output.
  ///
  /// Defaults to true.
  bool get useIcon => _useIcon;
  set useIcon(bool useIcon) => _useIcon = useIcon;

  /// Whether or not to clear Flutter's prefix to the log when printing.
  ///
  /// Uses the ANSI cursor back command to step back over the printed output and
  /// overwrites it.
  ///
  /// Android Studio currently fails to print colors using ANSI. This issue can
  /// be sidestepped by looking at the output of `flutter logs` in the terminal
  /// instead.
  ///
  /// Defaults to true.
  bool get clearClutter => _clearClutter;
  set clearClutter(bool clearClutter) => _clearClutter = clearClutter;

  /// The level of severity that is considered the minimum for logging.
  LogLevel get level => _level;

  /// Set a new minimum severity level.
  ///
  /// This will override the default minimum level. Overriding the default level
  /// allows printing in release mode.
  set level(LogLevel level) {
    Logger.root.level = level;
    _level = level;
  }

  /// Log message at level [Level.FINEST].
  ///
  /// See [log] for information on how non-String [message] arguments are
  /// handled.
  finest(Object? message) {
    _log(message, LogLevel.FINEST);
  }

  /// Log message at level [Level.FINER].
  ///
  /// See [log] for information on how non-String [message] arguments are
  /// handled.
  finer(Object? message) {
    _log(message, LogLevel.FINER);
  }

  /// Log message at level [Level.FINE].
  ///
  /// See [log] for information on how non-String [message] arguments are
  /// handled.
  fine(Object? message) {
    _log(message, LogLevel.FINE);
  }

  /// Log message at level [Level.CONFIG].
  ///
  /// See [log] for information on how non-String [message] arguments are
  /// handled.
  config(Object? message) {
    _log(message, LogLevel.CONFIG);
  }

  /// Log message at level [Level.INFO].
  ///
  /// See [log] for information on how non-String [message] arguments are
  /// handled.
  info(Object? message) {
    _log(message, LogLevel.INFO);
  }

  /// Log message at level [Level.WARNING].
  ///
  /// See [log] for information on how non-String [message] arguments are
  /// handled.
  warning(Object? message) {
    _log(message, LogLevel.WARNING);
  }

  /// Log message at level [Level.SEVERE].
  ///
  /// See [log] for information on how non-String [message] arguments are
  /// handled.
  severe(Object? message) {
    _log(message, LogLevel.SEVERE);
  }

  /// Log message at level [Level.SHOUT].
  ///
  /// See [log] for information on how non-String [message] arguments are
  /// handled.
  shout(Object? message) {
    _log(message, LogLevel.SHOUT);
  }

  /// Send ANSI clear and return-to-home signals to the terminal.
  ///
  /// This function is specifically designed for use with terminals. It will
  /// not have the desired effect in Android Studio as ANSI codes are not
  /// supported on that platform.
  ///
  /// When ANSI is disabled [clear] ceases to function.
  clear() {
    _clear();
  }

  static String _getTime(LogRecord record) {
    final time = record.time;
    return "${time.hour.toString().padLeft(2,'0')}:"
        "${time.minute.toString().padLeft(2,'0')}:"
        "${time.second.toString().padLeft(2,'0')}:"
        "${time.millisecond.toString().padLeft(3,'0')}";
  }

  static String _formatMessage(LogRecord record) {
    String color = "";
    String icon = "";
    String stackColor = "";
    String endColor = "";
    String clearClutter = "";
    if (_useAnsi) {
      color = LogLevel.COLORS[record.level.value]!;
      icon = _useIcon ? LogLevel.ICONS[record.level.value]! : "";
      stackColor = "\x1B[38;5;242m";
      endColor = "\x1B[0m";
      clearClutter = _clearClutter ? "\x1B[21D" : "";
    }
    final time = "[$color${_getTime(record)}$endColor]";
    final _stackTrace = '$stackColor${_parseStackTrace(record)}$endColor';
    return '$clearClutter$time $icon $_stackTrace: ${record.message}';
  }

  static void _setDefaultLevel() {
    if (!_levelWasChanged) {
      if (kDebugMode) {
        _level = LogLevel.ALL;
      } else if (kProfileMode) {
        _level = LogLevel.WARNING;
      } else {
        _level = LogLevel.OFF;
      }
    }
  }

  static void _initialize() {
    if (!_isInitialized) {
      _clear();
      _setDefaultLevel();
      Logger.root.onRecord.listen((record) {
        print(_formatMessage(record));
      });
      _isInitialized = true;
    }
  }

  void _log(Object? message, [LogLevel level = LogLevel.INFO]) {
    if (!_isInitialized) {
      _initialize();
    }
    Logger.root.log(level, message, null, StackTrace.current);
  }

  static String _parseStackTrace(LogRecord record) {
    if (record.stackTrace != null) {
      final _vmFrame = RegExp(r'^#\d+\s+(\S.*) \((.+?)((?::\d+){0,2})\)$');
      final _lines = record.stackTrace.toString().split('\n');
      final match = _vmFrame.firstMatch(_lines[2]);
      if (match != null && match.groupCount == 3) {
        return match.group(2)!;
      }
    }
    return "<source unknown>";
  }

  static _clear() {
    if (_useAnsi) {
      print("\x1B[2J\x1B[H");
    }
  }
}
