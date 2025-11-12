
class AppConstants {
  static const String appName = 'Investment Holdings';
  
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration refreshDuration = Duration(seconds: 2);
}

class AppStrings {
  static const String errorTitle = 'Error';
  static const String errorMessage = 'Something went wrong. Please try again.';
  static const String noDataTitle = 'No Holdings';
  static const String noDataMessage = 'You don\'t have any investment holdings yet.';
  static const String pullToRefresh = 'Pull to refresh';
  static const String loading = 'Loading...';
  static const String retry = 'Retry';
  static const String refresh = 'Refresh';
}
