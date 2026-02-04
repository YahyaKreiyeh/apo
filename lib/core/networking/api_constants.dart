class ApiConstants {
  ApiConstants._();
  static const String baseUrl = 'https://apolloemb.runasp.net/api/v1/';

  static const String login = 'auth/login';
  static const String products = 'products';
  static const String quoteRequests = 'quote-requests';
  static const String checkout = 'jobs/checkout';
  static const String jobs = 'jobs';
  static const String shipViaDetails = 'masters/SHIP_VIA/details';
  static const String transfers = 'transfers';
  static const String transferTypeDetails = 'masters/TRANSFER_TYPE/details';
  static const String sheetTypeDetails = 'masters/SHEET_TYPE/details';
  static const String decorationTypeDetails =
      'masters/DECORATION_TYPE/details';
  static const String heatTransferTypeDetails =
      'masters/HEAT_TRANSFER_TYPE/details';
  static const String screenPrintColorsDetails =
      'masters/SCREEN_PRINT_COLORS/details';
  static const String screenPrintGarmentDetails =
      'masters/SCREEN_PRINT_GARMENT/details';
  static const String screenPrintLocationDetails =
      'masters/SCREEN_PRINT_LOCATION/details';
  static const String leatherColorDetails =
      'masters/LEATHER_COLOR/details';
  static const String patchTypeDetails =
      'masters/PATCHES_TYPE/details';
  static const String labelTypeDetails =
      'masters/LABELS_TYPE/details';
  static const String embOptionsDetails = 'masters/EMB_OPTIONS/details';
  static const String embTypeDetails = 'masters/EMB_TYPE/details';
  static const String cartItems = 'cart/items';
  static const String cart = 'cart';
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
