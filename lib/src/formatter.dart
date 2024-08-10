import 'package:retcorelogger/src/record.dart';

abstract class Formatter {
  List<String> format(Record record);
}

typedef MessageCallback = Object? Function();
