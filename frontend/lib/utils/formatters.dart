import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );
  
  static String format(dynamic value) {
    if (value == null) return '\$0.00';
    final numValue = value is String ? double.tryParse(value) ?? 0 : value.toDouble();
    return _currencyFormat.format(numValue);
  }
}

class PercentageFormatter {
  static final NumberFormat _percentFormat = NumberFormat.decimalPattern();
  
  static String format(dynamic value, {int decimals = 2}) {
    if (value == null) return '0.00%';
    final numValue = value is String ? double.tryParse(value) ?? 0 : value.toDouble();
    return '${numValue.toStringAsFixed(decimals)}%';
  }
}

class NumberFormatter {
  static final NumberFormat _numberFormat = NumberFormat.decimalPattern();
  
  static String format(dynamic value, {int decimals = 4}) {
    if (value == null) return '0';
    final numValue = value is String ? double.tryParse(value) ?? 0 : value.toDouble();
    
    if (numValue == numValue.toInt()) {
      return numValue.toInt().toString();
    }
    return numValue.toStringAsFixed(decimals);
  }
}

class DateFormatter {
  static final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');
  static final DateFormat _dateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');
  
  static String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }
  
  static String formatDateTime(DateTime dateTime) {
    return _dateTimeFormat.format(dateTime);
  }
}
