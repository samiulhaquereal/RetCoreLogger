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

  void verbose(dynamic message, {String? level, String? title, StackTrace? stackTrace, String? method,String? status}) {
    _log(Tag.verbose, message, level: level, title: title, stackTrace: stackTrace,method: method,status:status);
  }

  void debug(dynamic message, {String? tag, String? title, StackTrace? stackTrace, String? method,String? status}) {
    _log(Tag.debug, message, level: tag, title: title, stackTrace: stackTrace,method: method,status:status);
  }

  void info(dynamic message, {String? tag, String? title, StackTrace? stackTrace, String? method,String? status}) {
    _log(Tag.info, message, level: tag, title: title, stackTrace: stackTrace,method: method,status:status);
  }

  void warning(dynamic message, {String? tag, String? title, StackTrace? stackTrace, String? method,String? status}) {
    _log(Tag.warning, message, level: tag, title: title, stackTrace: stackTrace,method: method,status:status);
  }

  void error(dynamic message, {String? tag, String? title, StackTrace? stackTrace, String? method,String? status}) {
    _log(Tag.error, message, level: tag, title: title, stackTrace: stackTrace,method: method,status:status);
  }

  void _log(
    Tag tag,
    dynamic message, {
    String? level,
    String? title,
    String? method,
    String? status,
    StackTrace? stackTrace,
  }) {
    if (tag < this.level) {
      return;
    }
    Record record = Record(tag, message, DateTime.now(), level, title, stackTrace,method,status);
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
