class ApiConstants {
  ApiConstants._();
  static const String baseUrl = 'http://92.205.111.2:6565/';

  static const String login = 'api/Token/SendOtp';
  static const String verifyCustomerOtp = 'api/Token/VerifyCustomerOtp';
  static const String verifyChangingNumberForCustomer =
      'api/Token/VerifyChangingNumberForCustomer';
  static const String completeCustomerInfo = 'api/Token/CompleteCustomerInfo';
  static const String updateFcmToken = 'api/Token/UpdateFcmToken';
  static const String toggleActiveCustomerAccount =
      'api/Token/ToggleActiveCustomerAccountAsync?isActive=true';
  static const String editCustomerInfo = 'api/Token/EditCustomerInfo';
  static const String generalSearch = 'api/Customer/Restaurants/GeneralSearch';
  static const String restaurantsByLocation =
      'api/Customer/Restaurants/GetRestaurantsByCurrentLocation';
  static const String ads = 'api/Admin/Ads/GetAll';
  static const String notifications = 'api/Notifications/GetAll';
  static const String unreadNotificationsCount =
      'api/Notifications/GetUnReadNotificationCount';
  static const String restaurantProfilePath =
      'api/Customer/Restaurants/GetRestaurantProfileForCustomer/{restaurantId}';
  static const String restaurantCategories = 'api/Owner/Category/GetAll';
  static const String restaurantMeals = 'api/Owner/Meal/GetAll';
  static const String favoriteRestaurants =
      'api/Customer/Restaurants/GetAllFavoriteRestaurants';
  static const String toggleFavoriteRestaurant =
      'api/Customer/Restaurants/AddOrDeleteFavoriteRestaurant';
  static const String restaurantAvailability =
      'api/Customer/Restaurants/GetAvailabilityRestaurant/{restaurantId}';
  static const String createReservation = 'api/Owner/Reservations/Create';
  static const String reservations = 'api/Owner/Reservations/GetAll';
  static const String changeReservationStatus =
      'api/Owner/Reservations/ChangeStatus/{reservationId}';
  static const String reservationDetails =
      'api/Owner/Reservations/Get/{reservationId}';
  static const String updateReservation =
      'api/Customer/Reservations/Update/{reservationId}';

  static const String restoProfile = 'api/Owner/Restaurants/GetRestoProfile';
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
