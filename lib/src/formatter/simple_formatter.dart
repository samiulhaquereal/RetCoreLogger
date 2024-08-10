import 'package:retcorelogger/src/config/imports.dart';


class SimpleFormatter extends Formatter {
  final int stackTraceLevel;
  final MessageCallback? callerGetter;

  SimpleFormatter({
    this.stackTraceLevel = 10,
    this.callerGetter = RetCoreUtils.defaultCallerInfo,
  });

  @override
  List<String> format(Record record) {
    List<String> lines = [];
    String? caller = callerGetter?.call().toString();
    lines.add('${record.dateTime.toIso8601String()}'
        ' ${record.tag ?? record.level.name}'
        '${caller == null ? '' : (' (' + caller + ')')}');
    if (record.title != null) {
      lines.add(record.title!);
    }
    String msg = convertMessage(record.message);
    lines.add(msg);
    if (record.stackTrace != null) {
      String st = convertStackTrace(record.stackTrace!);
      lines.add(st);
    }
    return lines;
  }

  String convertMessage(dynamic message) {
    String msg;
    if (message is String) {
      msg = message;
    } else if (message is Map || message is Iterable) {
      try {
        msg = jsonEncode(message);
      } catch (e) {
        // JsonUnsupportedObjectError
        msg = message.toString();
      }
    } else if (message is MessageCallback) {
      msg = message().toString();
    } else if (message is Exception) {
      msg = message.toString();
    } else if (message is StackTrace) {
      msg = convertStackTrace(message);
    } else {
      msg = message.toString();
    }
    return msg;
  }

  /// [stackTraceLevel] lines at most.
  String convertStackTrace(StackTrace stackTrace) {
    String st = stackTrace.toString();
    List<String> lines = st.split('\n');
    int length = lines.length;
    st = length <= stackTraceLevel
        ? st
        : lines.sublist(0, min(length, stackTraceLevel)).join('\n');
    if (st.endsWith('\n')) {
      st = st.substring(0, st.length - 2); // rm the last empty line.
    }
    return st;
  }
}
