import 'package:db_connection_string/src/Exception/invalid_connection_string.dart';
import 'package:db_connection_string/src/utilities/string_splitter.dart';
import 'package:test/test.dart';

void main() {
  group('String Splitter - Expected Ok ', () {
    test('Ok', () async {
      const String key = "key";
      const String value = "value";
      final String input = "$key=$value;";

      final Stream<(String, String)> outputStream =
          StringSplitter.splitAsStream(input);

      expect(outputStream, emitsInOrder([(key, value), emitsDone]));
    });
  });

  group('String Splitter - Expected Exception', () {
    test('Connection String is empty', () async {
      const input = "";
      expectLater(
        StringSplitter.splitAsStream(input),
        emitsError(isA<InvalidConnectionString>()),
      );
    });

    test('Connection String does not contains KeyValueSplitChar', () async {
      const input = "keyvalue;";
      expectLater(
        StringSplitter.splitAsStream(input),
        emitsError(isA<InvalidConnectionString>()),
      );
    });

    test('Connection String does not contains PairSplitChar', () async {
      const input = "key=value";
      expectLater(
        StringSplitter.splitAsStream(input),
        emitsError(isA<InvalidConnectionString>()),
      );
    });

    test(
      'Connection String contains multiple times KeyValueSplitChar',
      () async {
        const input = "key==value";
        expectLater(
          StringSplitter.splitAsStream(input),
          emitsError(isA<InvalidConnectionString>()),
        );
      },
    );

    test('Connection String contains multiple times PairSplitChar', () async {
      const String key = "key";
      const String value = "value";
      final String input = "$key=$value;;";
      expectLater(
        StringSplitter.splitAsStream(input),
        emitsInOrder([
          (key, value),
          emitsError(isA<InvalidConnectionString>()),
        ]),
      );
    });

    test('Connection String has no end', () async {
      const String key = "key";
      const String value = "value";
      final String input = "$key=$value;$key=$value";
      expectLater(
        StringSplitter.splitAsStream(input),
        emitsInOrder([
          (key, value),
          emitsError(isA<InvalidConnectionString>()),
        ]),
      );
    });
  });
}
