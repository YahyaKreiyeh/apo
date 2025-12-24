import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/routing/route_names.dart';

enum CheckoutType { requestQuote, checkout }

extension CheckoutTypeLabels on CheckoutType {
  String get title {
    switch (this) {
      case CheckoutType.requestQuote:
        return AppStrings.requestCustomQuote;
      case CheckoutType.checkout:
        return AppStrings.checkout;
    }
  }

  String get subtitle {
    switch (this) {
      case CheckoutType.requestQuote:
        return AppStrings.requestQuoteSubtitle;
      case CheckoutType.checkout:
        return AppStrings.checkoutSubtitle;
    }
  }

  String get submitLabel {
    switch (this) {
      case CheckoutType.requestQuote:
        return AppStrings.submitQuoteRequest;
      case CheckoutType.checkout:
        return AppStrings.submitCheckout;
    }
  }

  String get successMessage {
    switch (this) {
      case CheckoutType.requestQuote:
        return AppStrings.requestQuoteSuccess;
      case CheckoutType.checkout:
        return AppStrings.checkoutSuccess;
    }
  }

  String get failureMessage {
    switch (this) {
      case CheckoutType.requestQuote:
        return AppStrings.requestQuoteFailed;
      case CheckoutType.checkout:
        return AppStrings.checkoutFailed;
    }
  }

  String get cartCtaLabel {
    switch (this) {
      case CheckoutType.requestQuote:
        return AppStrings.requestQuote;
      case CheckoutType.checkout:
        return AppStrings.checkout;
    }
  }

  RouteNames get routeName {
    switch (this) {
      case CheckoutType.requestQuote:
        return RouteNames.checkout;
      case CheckoutType.checkout:
        return RouteNames.checkout;
    }
  }
}
