import 'package:db_connection_string/src/Exception/invalid_connection_string.dart';

class StringSplitter {
  static Stream<(String key, String value)> splitAsStream(String str) async* {
    const String pairSplitChar = ';';
    const String keyValueSplitChar = '=';

    if (str.isEmpty) {
      throw InvalidConnectionString(
        message: "The connection string could not be null",
      );
    }

    var strIndex = 0;

    while (str.length > strIndex) {
      var (key, lastCharKeyIndex) = _untilChar(
        str,
        strIndex,
        keyValueSplitChar,
      );

      if (lastCharKeyIndex == -1) {
        throw InvalidConnectionString(
          message:
              "The connection string '$str' is invalid. There is at least one key that does not end",
        );
      }
      var (value, lastCharValueIndex) = _untilChar(
        str,
        lastCharKeyIndex += 1,
        pairSplitChar,
      );

      if (lastCharValueIndex == -1) {
        throw InvalidConnectionString(
          message:
              "The connection string '$str' is invalid. There is at least one key that does not end",
        );
      }

      yield (key, value);

      strIndex = lastCharValueIndex + 1;
    }
  }

  static (String str, int stopCharIndex) _untilChar(
    String str,
    int startIndex,
    String stopChar,
  ) {
    if (stopChar.length != 1) {
      throw Exception(
        "Attention: the stopChar parameter has an invalid value - current value: '$stopChar'",
      );
    }

    int i = startIndex;
    String output = "";

    while (i < str.length && str[i] != stopChar) {
      output += str[i++];
    }

    return (output, i < str.length ? i : -1);
  }
}
