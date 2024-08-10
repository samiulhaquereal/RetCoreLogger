import 'package:retcorelogger/src/config/imports.dart';

class Record {
  Record(
    this.level,
    this.message,
    this.dateTime,
    this.tag,
    this.title,
    this.stackTrace,
  );

  final Level level;
  final dynamic message;
  final DateTime dateTime;

  final String? tag;

  final String? title;

  final StackTrace? stackTrace;

  String _convertStackTrace(StackTrace stackTrace) {
    String stack = stackTrace.toString();
    List<String> lines = stack.split('\n');
    int length = lines.length;
    stack = length <= 10 ? stack : lines.sublist(0, min(length, 10)).join('\n');
    if (stack.endsWith('\n')) {
      stack = stack.substring(0, stack.length - 2); // rm the last empty line.
    }
    return stack;
  }

  String encode() {
    Object msg;
    if (message is String) {
      msg = message;
    } else if (message is Map || message is Iterable) {
      msg = message;
    } else if (message is MessageCallback) {
      msg = message().toString();
    } else if (message is Exception) {
      msg = message.toString();
    } else if (message is StackTrace) {
      msg = _convertStackTrace(message);
    } else {
      msg = message.toString();
    }
    Map<String, dynamic> map = {
      'level': level.name,
      'message': msg,
      'dateTime': dateTime.microsecondsSinceEpoch,
      'tag': tag,
      'title': title,
      'stackTrace': stackTrace?.toString(),
    };
    return jsonEncode(map);
  }

  factory Record.decode(String data) {
    Map map = jsonDecode(data);
    String lv = map['level'].toString().toLowerCase();
    Level level = Level.debug;
    switch (lv) {
      case 'verbose':
        level = Level.verbose;
        break;
      case 'debug':
        level = Level.debug;
        break;
      case 'info':
        level = Level.info;
        break;
      case 'warning':
        level = Level.warning;
        break;
      case 'error':
        level = Level.error;
        break;
    }
    var message = map['message'];
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(map['dateTime']);
    StackTrace? stackTrace;
    if (map['stackTrace'] is String) {
      stackTrace = StackTrace.fromString(map['stackTrace']);
    }
    return Record(
        level, message, dateTime, map['tag'], map['title'], stackTrace);
  }
}
