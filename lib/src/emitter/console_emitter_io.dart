import 'package:retcorelogger/src/config/imports.dart';

/// Print to console.
class ConsoleEmitter extends Emitter {
  final Map levelColors = {
    Tag.verbose: 008, // gray
    Tag.debug: 006, // cyan
    Tag.info: 007, // white
    Tag.warning: 003, // yellow
    Tag.error: 001, // red
  };

  final AnsiPen pen = AnsiPen();

  ConsoleEmitter({bool? supportsAnsiColor}) {
    if (supportsAnsiColor != null) {
      ansiColorDisabled = !supportsAnsiColor;
    }
  }

  @override
  void emit(Record record, List<String> lines) {
    pen.reset();
    if (levelColors[record.tag] != null) {
      pen.xterm(levelColors[record.tag]);
    }
    for (String line in lines) {
      print(pen(line));
    }
  }
}
