import 'package:retcorelogger/src/config/imports.dart';

/// Unsupported
class FileEmitter extends Emitter {
  final dynamic file;
  final bool append;

  FileEmitter({
    this.file,
    this.append = true,
  }) {
    throw UnsupportedError('FileEmitter does not support web platform.');
  }

  @override
  void emit(Record record, List<String> lines) {}
}
