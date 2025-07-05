/// Parses a time string in HH:MM format to a 4-digit integer.
/// Example: "10:03" -> 1003, "00:05" -> 5, "23:59" -> 2359
/// 
/// Throws [FormatException] if the input string is invalid.
/// Throws [ArgumentError] if hour or minute values are out of range.
int parseTimeOfDay(String timeOfDay) {
  if (timeOfDay.isEmpty) {
    throw FormatException('Time string cannot be empty');
  }
  
  final parts = timeOfDay.split(':');
  if (parts.length != 2) {
    throw FormatException('Invalid time format. Expected HH:MM, got: $timeOfDay');
  }
  
  final hourStr = parts[0].trim();
  final minuteStr = parts[1].trim();
  
  if (hourStr.isEmpty || minuteStr.isEmpty) {
    throw FormatException('Hour and minute cannot be empty');
  }
  
  int hour;
  int minute;
  
  try {
    hour = int.parse(hourStr);
  } catch (e) {
    throw FormatException('Invalid hour value: $hourStr');
  }
  
  try {
    minute = int.parse(minuteStr);
  } catch (e) {
    throw FormatException('Invalid minute value: $minuteStr');
  }
  
  if (hour < 0 || hour > 23) {
    throw ArgumentError('Hour must be between 0 and 23, got: $hour');
  }
  
  if (minute < 0 || minute > 59) {
    throw ArgumentError('Minute must be between 0 and 59, got: $minute');
  }
  
  return hour * 100 + minute;
}

/// Converts a 4-digit integer to a time string in HH:MM format.
/// Example: 1003 -> "10:03", 5 -> "00:05", 2359 -> "23:59"
/// 
/// Throws [ArgumentError] if the integer represents an invalid time.
String intSelectedTimeToString(int selectedHour) {
  if (selectedHour < 0) {
    throw ArgumentError('Time cannot be negative: $selectedHour');
  }
  
  if (selectedHour > 2359) {
    throw ArgumentError('Time cannot be greater than 23:59 (2359): $selectedHour');
  }
  
  final minute = selectedHour % 100;
  final hour = selectedHour ~/ 100;
  
  if (minute > 59) {
    throw ArgumentError('Invalid minute value: $minute (from $selectedHour)');
  }
  
  if (hour > 23) {
    throw ArgumentError('Invalid hour value: $hour (from $selectedHour)');
  }
  
  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}