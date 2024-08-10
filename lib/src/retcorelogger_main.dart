import 'package:retcorelogger/src/config/imports.dart';

RetCoreLogger retCoreLogger = RetCoreLogger(handler: LogHandler(formatter: PrettyFormatter(), emitter: ConsoleEmitter()));


class RetCoreLogger {
  Level level = Level.all;

  final Set<LogHandler> _handlers = {};

  RetCoreLogger({LogHandler? handler}) {
    if (handler != null) {
      _handlers.add(handler);
    }
  }

  void v(dynamic message, {String? tag, String? title, StackTrace? stackTrace}) {
    _log(Level.verbose, message, tag: tag, title: title, stackTrace: stackTrace);
  }

  void d(dynamic message, {String? tag, String? title, StackTrace? stackTrace}) {
    _log(Level.debug, message, tag: tag, title: title, stackTrace: stackTrace);
  }

  void i(dynamic message, {String? tag, String? title, StackTrace? stackTrace}) {
    _log(Level.info, message, tag: tag, title: title, stackTrace: stackTrace);
  }

  void w(dynamic message, {String? tag, String? title, StackTrace? stackTrace}) {
    _log(Level.warning, message, tag: tag, title: title, stackTrace: stackTrace);
  }

  void e(dynamic message, {String? tag, String? title, StackTrace? stackTrace}) {
    _log(Level.error, message, tag: tag, title: title, stackTrace: stackTrace);
  }

  void _log(
    Level level,
    dynamic message, {
    String? tag,
    String? title,
    StackTrace? stackTrace,
  }) {
    if (level < this.level) {
      return;
    }
    Record record = Record(level, message, DateTime.now(), tag, title, stackTrace);
    for (LogHandler handler in _handlers) {
      handler.handle(record);
    }
  }

  void registerHandler(LogHandler handler) {
    _handlers.add(handler);
  }

  void unregisterHandler(LogHandler handler) {
    _handlers.remove(handler);
  }

  void destroy() {
    for (LogHandler handler in _handlers) {
      handler.destroy();
    }
    _handlers.clear();
  }
}
