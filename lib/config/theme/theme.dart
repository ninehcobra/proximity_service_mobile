import 'package:proximity_service/common_libs.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor500,
      primaryColorLight: AppColors.primaryColor300,
      primaryColorDark: AppColors.primaryColor700,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryColor500,
        primaryContainer: AppColors.primaryColor700,
        secondary: AppColors.primaryColor400,
        secondaryContainer: AppColors.primaryColor600,
        surface: AppColors.neutralColor100,
        error: AppColors.errorColor500,
        onPrimary: AppColors.neutralColor50,
        onSecondary: AppColors.neutralColor50,
        onSurface: AppColors.neutralColor900,
        onError: AppColors.neutralColor50,
      ),
      scaffoldBackgroundColor: AppColors.neutralColor50,
      textTheme: AppTypography.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor500,
        foregroundColor: AppColors.neutralColor50,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primaryColor500,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
