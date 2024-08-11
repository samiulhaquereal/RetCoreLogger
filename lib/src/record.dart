import 'package:retcorelogger/src/config/imports.dart';

class Record {
  Record(
    this.tag,
    this.message,
    this.dateTime,
    this.level,
    this.title,
    this.stackTrace,
    this.method,
    this.status,
  );

  final Tag tag;
  final dynamic message;
  final DateTime dateTime;

  final String? level;

  final String? title;
  final String? status;

  final String? method;

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
      'tag': tag.name,
      'message': msg,
      'dateTime': dateTime.microsecondsSinceEpoch,
      'level': level,
      'title': title,
      'stackTrace': stackTrace?.toString(),
      'method': method,
      'status': status,
    };
    return jsonEncode(map);
  }

  factory Record.decode(String data) {
    Map map = jsonDecode(data);
    String tag = map['tag'].toString().toLowerCase();
    Tag tagg = Tag.debug;
    switch (tag) {
      case 'verbose':
        tagg = Tag.verbose;
        break;
      case 'debug':
        tagg = Tag.debug;
        break;
      case 'info':
        tagg = Tag.info;
        break;
      case 'warning':
        tagg = Tag.warning;
        break;
      case 'error':
        tagg = Tag.error;
        break;
    }
    var message = map['message'];
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(map['dateTime']);
    StackTrace? stackTrace;
    String? method = map['method'].toString().toUpperCase();
    String? status = map['status'].toString();
    if (map['stackTrace'] is String) {
      stackTrace = StackTrace.fromString(map['stackTrace']);
    }
    return Record(tagg, message, dateTime, map['level'], map['title'], stackTrace,method,status);
  }
}
