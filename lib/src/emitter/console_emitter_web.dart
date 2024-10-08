import 'dart:html';
import 'dart:js';
import 'package:retcorelogger/src/config/imports.dart';



/// Print to browser console.
class ConsoleEmitter extends Emitter {
  ConsoleEmitter({bool? supportsAnsiColor});

  @override
  void emit(Record record, List<String> lines) {
    String output = lines.join('\n');
    if (record.tag == Tag.verbose) {
      jsConsole('debug', ['%c$output', 'color:grey']);
    } else if (record.tag == Tag.debug) {
      jsConsole('debug', ['%c$output', 'color:#00758F']); // MosaicBlue
    } else if (record.tag == Tag.info) {
      window.console.info(output);
    } else if (record.tag == Tag.warning) {
      output = '\n' + output; // chrome
      window.console.warn(output);
    } else if (record.tag == Tag.error) {
      output = '\n' + output; // chrome
      window.console.error(output);
    } else {
      window.console.log(output);
    }
  }

  void jsConsole(String method, [List? args]) {
    JsObject console = JsObject.fromBrowserObject(context['console']);
    if (console.hasProperty(method)) {
      console.callMethod(method, args);
    }
  }
}
