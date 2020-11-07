import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class DateUtils {
  static final DateFormat _timeFormatWithColon = new DateFormat("HH:mm");
  static final DateFormat _timeFormatWithoutColon = new DateFormat("HHmm");
  // Get locale of context
  static final DateFormat dateFormatter = new DateFormat('dd/MM/yyyy', 'pt_BR');

  static final List<Map<String, String>> daysOfWeek = [
    {"value": 'MONDAY', "text": 'SEGUNDA'},
    {"value": 'TUESDAY', "text": 'TERÇA'},
    {"value": 'WEDNESDAY', "text": 'QUARTA'},
    {"value": 'THURSDAY', "text": 'QUINTA'},
    {"value": 'FRIDAY', "text": 'SEXTA'},
    {"value": 'SATURDAY', "text": 'SÁBADO'},
    {"value": 'SUNDAY', "text": 'DOMINGO'}
  ];

  static translatorWeekDay(String dayOfWeek) {
    String value;
    if (dayOfWeek.toUpperCase() == 'MONDAY') {
      value = 'SEGUNDA';
    } else if (dayOfWeek.toUpperCase() == 'TUESDAY') {
      value = 'TERÇA';
    } else if (dayOfWeek.toUpperCase() == 'WEDNESDAY') {
      value = 'QUARTA';
    } else if (dayOfWeek.toUpperCase() == 'THURSDAY') {
      value = 'QUINTA';
    } else if (dayOfWeek.toUpperCase() == 'FRIDAY') {
      value = 'SEXTA';
    } else if (dayOfWeek.toUpperCase() == 'SATURDAY') {
      value = 'SÁBADO';
    } else if (dayOfWeek.toUpperCase() == 'SUNDAY') {
      value = 'DOMINGO';
    }
    return value;
  }

  static checkDay(String dayOfWeek) {
    String value;
    if (dayOfWeek == 'SEGUNDA' ||
        dayOfWeek == 'TERÇA' ||
        dayOfWeek == 'QUARTA' ||
        dayOfWeek == 'QUINTA' ||
        dayOfWeek == 'SEXTA') {
      value = 'às';
    } else if (dayOfWeek == 'SÁBADO' || dayOfWeek == 'DOMINGO') {
      value = 'aos';
    }
    return value;
  }

  static int getFirstDayMonth() {
    final DateTime now = new DateTime.now();
    final int firstDay =
        DateTime(now.year, now.month, 1).toUtc().millisecondsSinceEpoch ~/ 1000;

    return firstDay;
  }

  static getLastDayMonth({year, month}) {
    final DateTime now = new DateTime.now();
    final lastDay = DateTime(year ?? now.year, (month ?? now.month) + 1, 1)
            .toUtc()
            .millisecondsSinceEpoch ~/
        1000;

    return lastDay;
  }

  static bool isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  static DateTime getLastDayMonthByCalendar(DateTime last) {
    return DateTime(
        last.year,
        DateUtils.isLeapYear(last.year) && last.month == 2
            ? last.month + 1
            : last.month,
        0);
  }

  static DateTime getFirstDayMonthByCalendar(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static String getDayOfMonth(DateTime date) =>
      DateFormat('dd', 'pt_BR').format(date);

  static Map<String, String> dayOfWeekPtBr(String dayOfWeek) {
    return DateUtils.daysOfWeek
        .firstWhere((element) => element['value'] == dayOfWeek);
  }

  static String transformUTCTimeToLocalTime(String time) {
    DateTime utcTime = _timeFormatWithColon
        .parseUTC(time.substring(0, 2) + ':' + time.substring(2, 4));
    return _timeFormatWithColon.format(utcTime.toLocal());
  }

  static String transformLocalTimeToUTCTime(String time) {
    DateTime utcTime = _timeFormatWithColon.parse(time);
    return _timeFormatWithoutColon.format(utcTime.toUtc());
  }

  static int getHourFromTimeString(String timeStr) {
    if (timeStr == null && timeStr.isEmpty) {
      return 0;
    }

    timeStr = timeStr.trim();
    List<String> splitted = timeStr.split(':');
    try {
      return int.parse(splitted[0]);
    } catch (e) {
      return 0;
    }
  }

  static int transformWeekDayToInt(String day) {
    final weekDays = {
      "SUNDAY": 0,
      "MONDAY": 1,
      "TUESDAY": 2,
      "WEDNESDAY": 3,
      "THURSDAY": 4,
      "FRIDAY": 5,
      "SATURDAY": 6,
    };

    return weekDays[day];
  }

  static int getMinuteFromTimeString(String timeStr) {
    if (timeStr == null && timeStr.isEmpty) {
      return 0;
    }

    timeStr = timeStr.trim();
    List<String> splitted = timeStr.split(':');

    if (splitted.length < 2) {
      return 0;
    }

    try {
      return int.parse(splitted[1]);
    } catch (e) {
      return 0;
    }
  }

  static addSecondHoursRange(String value, {String valueToAdd = ''}) {
    value = value.replaceAll(':', '');
    return value += valueToAdd;
  }

  static checkHoursRange(MaskedTextController mask1) {
    if (int.parse(mask1.value.text.substring(0, 1)) > 2 &&
        mask1.value.text.length < 2) {
      mask1.updateText('0${mask1.value.text}');
    }

    if (int.parse(mask1.value.text.substring(0, 1)) == 2 &&
        int.parse(mask1.value.text.substring(1, 2)) > 3) {
      if (int.parse(mask1.value.text.substring(1, 2)) > 4) {
        mask1.updateText('${mask1.value.text.substring(0, 1)}3');
      }

      if (int.parse(mask1.value.text.substring(1, 2)) == 4) {
        mask1.updateText('00');
      }
    }

    if (int.parse(mask1.value.text.substring(2, 3)) > 5) {
      mask1.updateText('${mask1.value.text}59');
    }
    if (int.parse(mask1.value.text.substring(2, 3)) > 5) {
      mask1.updateText('${mask1.value.text.substring(0, 2)}5');
    }
  }

  static DateTime transformConvertedDateToDateTime(String convertedDate) {
    final List<String> splittedDate = convertedDate.split("/");
    if (splittedDate.length > 0) {
      final DateTime dateTime = DateTime(
        int.parse(splittedDate[2]),
        int.parse(splittedDate[1]),
        int.parse(splittedDate[0]),
      );
      return dateTime;
    }

    return DateTime(1, 1, 1);
  }
}
