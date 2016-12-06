@Tags(const ['vm'])
import 'dart:async';
import 'package:sass/src/ast/sass/statement/stylesheet.dart';
import 'package:sass/src/visitor/perform.dart';
import 'package:sass/src/visitor/serialize.dart';
import 'package:scheduled_test/scheduled_test.dart';

main() {
  group('loud comment parsing', () {
    test("can be close with */", () {
      const String testScss = '/*comment*/';
      final css = _compileScss(testScss);
      css.then((String css) {
        expect(css, testScss);
      });
    }, tags: ['scss']);

    test("can be close with **/", () {
      // tests for sass/dart-sass#58
      const String testScss = '/*comment**/';
      final css = _compileScss(testScss);
      css.then((String css) {
        expect(css, testScss);
      });
    }, tags: ['scss']);
  });
}

Future<String> _compileScss(String scss) {
  return schedule/*<String>*/(expectAsync0(() {
    var sassTree = new Stylesheet.parseScss(scss);
    var cssTree = evaluate(sassTree);
    return toCss(cssTree);
  }), 'compiling scss');
}
