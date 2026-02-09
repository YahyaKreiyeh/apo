class JobCheckoutDto {
  final int customerId;
  final bool isApolloProducts;
  final JobCheckoutShippingDetailsDto shippingDetails;
  final String jobDescription;
  final String jobComment;
  final List<int> additionalServiceIds;
  final String customerNotes;
  final String orderDate;
  final String orderType;
  final String customerNumber;
  final String customerPO;
  final bool isBillingSameAsShipping;

  const JobCheckoutDto({
    required this.customerId,
    required this.isApolloProducts,
    required this.shippingDetails,
    required this.jobDescription,
    required this.jobComment,
    required this.additionalServiceIds,
    required this.customerNotes,
    required this.orderDate,
    required this.orderType,
    required this.customerNumber,
    required this.customerPO,
    required this.isBillingSameAsShipping,
  });

  Map<String, dynamic> toJson() => {
    'customerId': customerId,
    'isApolloProducts': isApolloProducts,
    'shippingDetails': shippingDetails.toJson(),
    'jobDescription': jobDescription,
    'jobComment': jobComment,
    'additionalServiceIds': additionalServiceIds,
    'customerNotes': customerNotes,
    'orderDate': orderDate,
    'orderType': orderType,
    'customerNumber': customerNumber,
    'customerPO': customerPO,
    'isBillingSameAsShipping': isBillingSameAsShipping,
  };
}

class JobCheckoutShippingDetailsDto {
  final String shipViaCode;
  final String streetAddress;
  final String aptBuildingSuite;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String shippingInstructions;

  const JobCheckoutShippingDetailsDto({
    required this.shipViaCode,
    required this.streetAddress,
    required this.aptBuildingSuite,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.shippingInstructions,
  });

  Map<String, dynamic> toJson() => {
    'shipViaCode': shipViaCode,
    'streetAddress': streetAddress,
    'aptBuildingSuite': aptBuildingSuite,
    'city': city,
    'state': state,
    'postalCode': postalCode,
    'country': country,
    'shippingInstructions': shippingInstructions,
  };
}
