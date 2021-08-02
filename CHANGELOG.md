## 0.3.1+readme2

 * Improve the readme.

## 0.3.1+format

 * Fix image source on pub.dev.
 * Fix the formatting of `log_level.dart` to follow `dartfmt` standards.

## 0.3.1

 * Fix spaces at the end of short lines with `clearClutter` enabled.

## 0.3.0

 * Add `addTimestamp` and `addLink` options.
 * Rename `useIcon` to `addIcon`.
 * Add `imitatePrint` option that sets `addTimestamp`, `addLink`,
   `addIcon` to false. `useAnsi` and `clearClutter` will remain as they
   were.
 * Make links point to the actual log command location within the
   source file.
 * Add support for `clearClutter` with multiline strings.

## 0.2.0

 * Make logly a pure Dart library by dropping dependency on Flutter.

## 0.1.1+hotfix1

 * Fix `useAnsi` ignored by `clearClutter`.

## 0.1.1

 * Add option to remove Flutter debug clutter. (i.e. "I/flutter (pid):"
   from log output.
 * Add option to hide icon.
 * Add getter for `useAnsi`.
 * Improve output format by moving icon immediately after timestamp.

## 0.1.0

Initial release.
