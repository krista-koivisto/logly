A simple logging tool that uses color coding to indicate severity and
offers a clickable link to the printing line.

## Features

* Clickable links to the source of the log entry.
* Logging with several severity levels through the `logging` package.
* ANSI color coding for each severity level.
* Ability to remove Flutter print clutter ("I/flutter (pid): ").
* Automatically adjusts severity level threshold:
  * In `debug` mode sessions everything is printed.
  * In `profile` mode, everything including warnings and above is
    printed.
  * In `release` mode, nothing is printed.
  * This behavior can be overridden by manually setting the level.
* Partially customizable format. You can enable and disable the
  timestamp, icon and link to suit your needs.

## Installing

Add the library to your `pubspec.yaml` and run `flutter pub get` to get
the library:

```yaml
dependencies:
  logly: ^0.3.1+readme2
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
log.shout("This is a shout, the highest possible severity level.");
log.warning("This is a warning.");
log.severe("This is a severe log entry.");
log.fine("This is a fine-level log entry.");
log.finer("This is a finer-level log entry.");
log.finest("This is a finest-level log entry.");
log.config("This is a config log entry.");
log.info("This is the common info-level log entry.");
```

The output from that would look like:

![Output Example](https://raw.githubusercontent.com/krista-koivisto/logly/main/images/example.png)

The link can be clicked to be taken to the source of the log entry.

#### Imitate print

If you just want to use Logly for regular printing, but want to clear
Flutter's printing clutter, you can set `log.imitatePrint` to true.

If you still want the link to the source to be visible, you can then
set `log.addLink` to true as well.

## Known Issues

* Android Studio does not support ANSI output in the Flutter run
  console.
  * A workaround is to use `flutter logs` from a terminal within
    Android Studio instead. `log.clear()` may be called to clear that
    terminal as necessary.
  * It is also possible to disable ANSI output by setting `log.useAnsi`
    to false. This will however disable many main logly features such as
    colors and console and clutter clearing.
