

import 'package:retcorelogger/src/config/imports.dart';

class LogHandler {
  final Formatter formatter;
  final Emitter emitter;

  LogHandler({
    required this.formatter,
    required this.emitter,
  });

  void handle(Record record) {
    List<String> lines = formatter.format(record);
    emitter.emit(record, lines);
  }

  void destroy() {
    emitter.destroy();
  }
}
