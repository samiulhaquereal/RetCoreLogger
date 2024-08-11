import 'package:retcorelogger/src/config/imports.dart';

_RetCoreLogger retcoreLogger = _RetCoreLogger(handler: LogHandler(formatter: PrettyFormatter(), emitter: ConsoleEmitter()));

class _RetCoreLogger {
  Tag level = Tag.all;

  final Set<LogHandler> _handlers = {};

  _RetCoreLogger({LogHandler? handler}) {
    if (handler != null) {
      _handlers.add(handler);
    }
  }

  void verbose(dynamic message, {String? tag, String? title, StackTrace? stackTrace, String? method,String? status}) {
    _log(Tag.verbose, message, tag: tag, title: title, stackTrace: stackTrace,method: method,status:status);
  }

  void debug(dynamic message, {String? tag, String? title, StackTrace? stackTrace, String? method,String? status}) {
    _log(Tag.debug, message, tag: tag, title: title, stackTrace: stackTrace,method: method,status:status);
  }

  void info(dynamic message, {String? tag, String? title, StackTrace? stackTrace, String? method,String? status}) {
    _log(Tag.info, message, tag: tag, title: title, stackTrace: stackTrace,method: method,status:status);
  }

  void warning(dynamic message, {String? tag, String? title, StackTrace? stackTrace, String? method,String? status}) {
    _log(Tag.warning, message, tag: tag, title: title, stackTrace: stackTrace,method: method,status:status);
  }

  void error(dynamic message, {String? tag, String? title, StackTrace? stackTrace, String? method,String? status}) {
    _log(Tag.error, message, tag: tag, title: title, stackTrace: stackTrace,method: method,status:status);
  }

  void _log(
    Tag level,
    dynamic message, {
    String? tag,
    String? title,
    String? method,
    String? status,
    StackTrace? stackTrace,
  }) {
    if (level < this.level) {
      return;
    }
    Record record = Record(level, message, DateTime.now(), tag, title, stackTrace,method,status);
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
