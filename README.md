A simple logging tool that uses color coding to indicate severity and
offers a clickable link to the printing line.

## Features

* Logging with several severity levels.
* Color coding for each severity level.
* Clickable links to the source of the log entry.

## Installing

Add the library to your `pubspec.yaml` and run `flutter pub get` to get
the library:

```yaml
dependencies:
  logly: ^0.1.0
```

## Usage

The only thing that needs to be done to use it, is to import the library
(`import 'package:logly/logly.dart';`) and call the `log` function:

```dart
// By default the level `LogLevel.INFO` is used. To use that, just call
// `log` on its own.
log("This is a log entry.");

// All levels may also be called explicitly using their respective
// functions:
log.warning("This is a warning level entry");
```

The output from that would look like:

![Output Example](/images/example.png)

The link can be clicked to be taken to the source of the log entry.

## Known Issues

* Android Studio does not support ANSI output in the Flutter run
  console. A workaround is to use `flutter logs` from a terminal within
  Android Studio instead. `log.clear()` may be called to clear that
  terminal as necessary.
