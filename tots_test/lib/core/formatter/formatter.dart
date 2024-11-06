import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tots_test/constant/localization.dart';

class Formatter {
  static String ucFirst(String str) {
    return str.substring(0, 1).toUpperCase() + str.substring(1);
  }

  static Future<void> initializeFormatter() {
    return initializeDateFormatting(LocalizationConstants.localCurrency);
  }

  static String phoneFormatter(String phone) {
    final newText = phone.trim();

    final listChars = newText.split('');

    if (newText.length >= 4) {
      listChars.insert(3, ' ');
    }
    if (newText.length >= 7) {
      listChars.insert(7, ' ');
    }
    return listChars.join().trim();
  }

  static String members(int members) {
    String value = '';
    if (members < 1000) {
      value = members.toString();
    } else if (members >= 1000 && members < 1000000) {
      final result = (members / 1000).toStringAsPrecision(3);
      value = '$result K';
    } else if (members >= 1000000) {
      final result = (members / 1000000).toStringAsPrecision(3);
      value = '$result M';
    }
    return value.trim();
  }

  static String dateFormatter(DateTime date) {
    final dateFormatter = DateFormat(
      "dd 'd'e MMMM 'd'e yyyy",
      LocalizationConstants.localCurrency,
    );
    return dateFormatter.format(date);
  }

  static String dateFormatterShort(DateTime date) {
    final dateFormatter = DateFormat(
      'dd/MM/yyyy',
      LocalizationConstants.localCurrency,
    );
    return dateFormatter.format(date);
  }

  static String dateFormatterShortCurrency(String date) {
    final dateFormatter = DateFormat(
      'dd/MM/yyyy',
      LocalizationConstants.localCurrency,
    );
    final dateTimeParse = DateTime.parse(date);
    final dateTimeNow = DateTime.now();
    final int daysToGenerate =
        (-1 * (dateTimeParse.difference(dateTimeNow).inDays + 1));
    final int hourToGenerate =
        (-1 * (dateTimeParse.difference(dateTimeNow).inHours));
    final int minToGenerate =
        (-1 * (dateTimeParse.difference(dateTimeNow).inMinutes));
    if (minToGenerate == 0) {
      return 'Ahora mismo';
    } else if (minToGenerate < 60) {
      return minToGenerate == 1
          ? 'hace una minuto'
          : 'hace ${hourToGenerate.toString().replaceAll('-', '')} minutos';
    } else if (hourToGenerate <= 24) {
      return hourToGenerate == 1
          ? 'hace una hora'
          : 'hace ${hourToGenerate.toString().replaceAll('-', '')} horas';
    } else if (daysToGenerate <= 6) {
      return daysToGenerate == 1 ? 'hace un dia' : 'hace $daysToGenerate dias';
    } else if (daysToGenerate <= 30) {
      final result = (daysToGenerate / 7).toStringAsPrecision(1);
      return result == '1'
          ? 'hace ${result.toString().replaceAll('-', '')} semanas'
          : 'hace ${result.toString().replaceAll('-', '')} semanas';
    } else if (daysToGenerate <= 356) {
      final result = (daysToGenerate / 12).toStringAsPrecision(1);
      return result == '1'
          ? 'hace ${result.toString().replaceAll('-', '')} mes'
          : 'hace ${result.toString().replaceAll('-', '')} meses';
    }
    return 'el ${dateFormatter.format(dateTimeParse)}';
  }

  static String dateFormatterString(String date) {
    final dateFormatter = DateFormat(
      "dd 'd'e MMMM 'd'e yyyy",
      LocalizationConstants.localCurrency,
    );
    return dateFormatter.format(DateTime.parse(date));
  }

  static String timestampFormatter(String date) {
    final rawDate = DateTime.parse(date).toLocal();
    return DateFormat(
      'dd - MMMM - yyyy hh:mm a',
      LocalizationConstants.localCurrency,
    ).format(rawDate);
  }

  static String dateMessageFormatter(DateTime date) {
    final DateFormat formatter = DateFormat.MMMMd('ES-CO');
    return formatter.format(date);
  }

  static String timeFormatter(DateTime date) {
    final timeFormatter =
        DateFormat('HH:mm', LocalizationConstants.localCurrency);
    return timeFormatter.format(date);
  }
}
