import 'package:apo/core/constants/app_strings.dart';

class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$',
    caseSensitive: false,
  );
  static final RegExp _passwordUpper = RegExp(r'[A-Z]');
  static final RegExp _passwordLower = RegExp(r'[a-z]');
  static final RegExp _passwordDigit = RegExp(r'\d');
  static final RegExp _passwordSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>_\-\\/\[\]=+;`~]');

  static String? email(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return AppStrings.emailRequired;
    }
    if (!_emailRegex.hasMatch(trimmed)) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  static String? password(String value) {
    if (value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    final hasUpper = _passwordUpper.hasMatch(value);
    final hasLower = _passwordLower.hasMatch(value);
    final hasDigit = _passwordDigit.hasMatch(value);
    final hasSpecial = _passwordSpecial.hasMatch(value);
    if (value.length < 8 || !hasUpper || !hasLower || !hasDigit || !hasSpecial) {
      return AppStrings.passwordRequirements;
    }
    return null;
  }

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }
    return null;
  }
}
