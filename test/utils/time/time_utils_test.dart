import 'package:flutter_test/flutter_test.dart';
import 'package:ecotrip/utils/time/time_utils.dart';

void main() {
  group('parseTimeOfDay', () {
    group('valid inputs', () {
      test('should parse "00:00" to 0', () {
        expect(parseTimeOfDay('00:00'), equals(0));
      });

      test('should parse "00:05" to 5', () {
        expect(parseTimeOfDay('00:05'), equals(5));
      });

      test('should parse "10:03" to 1003', () {
        expect(parseTimeOfDay('10:03'), equals(1003));
      });

      test('should parse "23:59" to 2359', () {
        expect(parseTimeOfDay('23:59'), equals(2359));
      });

      test('should parse "12:00" to 1200', () {
        expect(parseTimeOfDay('12:00'), equals(1200));
      });

      test('should parse "01:30" to 130', () {
        expect(parseTimeOfDay('01:30'), equals(130));
      });

      test('should parse "9:5" to 905', () {
        expect(parseTimeOfDay('9:5'), equals(905));
      });

      test('should handle whitespace around time parts', () {
        expect(parseTimeOfDay(' 10 : 03 '), equals(1003));
      });
    });

    group('invalid format', () {
      test('should throw FormatException for empty string', () {
        expect(() => parseTimeOfDay(''), throwsA(isA<FormatException>()));
      });

      test('should throw FormatException for missing colon', () {
        expect(() => parseTimeOfDay('1003'), throwsA(isA<FormatException>()));
      });

      test('should throw FormatException for multiple colons', () {
        expect(() => parseTimeOfDay('10:03:45'), throwsA(isA<FormatException>()));
      });

      test('should throw FormatException for non-numeric hour', () {
        expect(() => parseTimeOfDay('abc:03'), throwsA(isA<FormatException>()));
      });

      test('should throw FormatException for non-numeric minute', () {
        expect(() => parseTimeOfDay('10:abc'), throwsA(isA<FormatException>()));
      });

      test('should throw FormatException for empty hour', () {
        expect(() => parseTimeOfDay(':03'), throwsA(isA<FormatException>()));
      });

      test('should throw FormatException for empty minute', () {
        expect(() => parseTimeOfDay('10:'), throwsA(isA<FormatException>()));
      });

      test('should throw FormatException for only whitespace parts', () {
        expect(() => parseTimeOfDay('   :   '), throwsA(isA<FormatException>()));
      });
    });

    group('out of range values', () {
      test('should throw ArgumentError for hour > 23', () {
        expect(() => parseTimeOfDay('24:00'), throwsA(isA<ArgumentError>()));
      });

      test('should throw ArgumentError for hour < 0', () {
        expect(() => parseTimeOfDay('-1:00'), throwsA(isA<ArgumentError>()));
      });

      test('should throw ArgumentError for minute > 59', () {
        expect(() => parseTimeOfDay('10:60'), throwsA(isA<ArgumentError>()));
      });

      test('should throw ArgumentError for minute < 0', () {
        expect(() => parseTimeOfDay('10:-1'), throwsA(isA<ArgumentError>()));
      });

      test('should throw ArgumentError for both hour and minute out of range', () {
        expect(() => parseTimeOfDay('25:70'), throwsA(isA<ArgumentError>()));
      });
    });

    group('boundary values', () {
      test('should accept hour 0', () {
        expect(parseTimeOfDay('0:00'), equals(0));
      });

      test('should accept hour 23', () {
        expect(parseTimeOfDay('23:00'), equals(2300));
      });

      test('should accept minute 0', () {
        expect(parseTimeOfDay('10:0'), equals(1000));
      });

      test('should accept minute 59', () {
        expect(parseTimeOfDay('10:59'), equals(1059));
      });
    });
  });

  group('intSelectedTimeToString', () {
    group('valid inputs', () {
      test('should convert 0 to "00:00"', () {
        expect(intSelectedTimeToString(0), equals('00:00'));
      });

      test('should convert 5 to "00:05"', () {
        expect(intSelectedTimeToString(5), equals('00:05'));
      });

      test('should convert 1003 to "10:03"', () {
        expect(intSelectedTimeToString(1003), equals('10:03'));
      });

      test('should convert 2359 to "23:59"', () {
        expect(intSelectedTimeToString(2359), equals('23:59'));
      });

      test('should convert 1200 to "12:00"', () {
        expect(intSelectedTimeToString(1200), equals('12:00'));
      });

      test('should convert 130 to "01:30"', () {
        expect(intSelectedTimeToString(130), equals('01:30'));
      });

      test('should convert 905 to "09:05"', () {
        expect(intSelectedTimeToString(905), equals('09:05'));
      });

      test('should convert 100 to "01:00"', () {
        expect(intSelectedTimeToString(100), equals('01:00'));
      });

      test('should convert 1 to "00:01"', () {
        expect(intSelectedTimeToString(1), equals('00:01'));
      });

      test('should convert 59 to "00:59"', () {
        expect(intSelectedTimeToString(59), equals('00:59'));
      });
    });

    group('invalid inputs', () {
      test('should throw ArgumentError for negative values', () {
        expect(() => intSelectedTimeToString(-1), throwsA(isA<ArgumentError>()));
      });

      test('should throw ArgumentError for values > 2359', () {
        expect(() => intSelectedTimeToString(2400), throwsA(isA<ArgumentError>()));
      });

      test('should throw ArgumentError for invalid minute > 59', () {
        expect(() => intSelectedTimeToString(1065), throwsA(isA<ArgumentError>()));
      });

      test('should throw ArgumentError for invalid minute in middle range', () {
        expect(() => intSelectedTimeToString(1560), throwsA(isA<ArgumentError>()));
      });

      test('should throw ArgumentError for hour > 23', () {
        expect(() => intSelectedTimeToString(2400), throwsA(isA<ArgumentError>()));
      });
    });

    group('boundary values', () {
      test('should accept 0 (00:00)', () {
        expect(intSelectedTimeToString(0), equals('00:00'));
      });

      test('should accept 2359 (23:59)', () {
        expect(intSelectedTimeToString(2359), equals('23:59'));
      });

      test('should accept 59 (00:59)', () {
        expect(intSelectedTimeToString(59), equals('00:59'));
      });

      test('should accept 2300 (23:00)', () {
        expect(intSelectedTimeToString(2300), equals('23:00'));
      });

      test('should accept 100 (01:00)', () {
        expect(intSelectedTimeToString(100), equals('01:00'));
      });

      test('should accept 1 (00:01)', () {
        expect(intSelectedTimeToString(1), equals('00:01'));
      });
    });
  });

  group('round trip conversion', () {
    test('should maintain consistency between both functions', () {
      final testCases = [
        '00:00', '00:01', '00:59', '01:00', '09:05', '10:03', 
        '12:00', '12:30', '23:00', '23:59'
      ];

      for (final timeStr in testCases) {
        final timeInt = parseTimeOfDay(timeStr);
        final convertedBack = intSelectedTimeToString(timeInt);
        expect(convertedBack, equals(timeStr),
            reason: 'Round trip failed for $timeStr -> $timeInt -> $convertedBack');
      }
    });

    test('should maintain consistency for integer inputs', () {
      final testCases = [
        0, 1, 59, 100, 130, 905, 1003, 1200, 1230, 2300, 2359
      ];

      for (final timeInt in testCases) {
        final timeStr = intSelectedTimeToString(timeInt);
        final convertedBack = parseTimeOfDay(timeStr);
        expect(convertedBack, equals(timeInt),
            reason: 'Round trip failed for $timeInt -> $timeStr -> $convertedBack');
      }
    });
  });
} 